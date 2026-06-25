-- show all customers
SELECT * FROM customers;

-- add a new customer
INSERT INTO customers (first_name, last_name, email, phone, date_of_birth)
VALUES ('Sara', 'Klein', 'sara.klein@example.com', '+49 30 7777777', '1993-06-25');

-- freeze an account
UPDATE accounts SET status = 'frozen' WHERE account_id = 7;

-- delete that test customer
DELETE FROM customers WHERE email = 'sara.klein@example.com';

-- joins

-- every account with its owner and the branch city
SELECT a.account_id, a.account_type, a.balance, ah.role, c.first_name, c.last_name, b.city
FROM accounts a
JOIN account_holders ah ON a.account_id = ah.account_id
JOIN customers c ON ah.customer_id = c.customer_id
JOIN branches b ON a.branch_id = b.branch_id
ORDER BY a.account_id;

-- Anna's accounts
SELECT c.first_name, c.last_name, a.account_id, a.account_type, a.balance
FROM customers c
JOIN account_holders ah ON c.customer_id = ah.customer_id
JOIN accounts a ON ah.account_id = a.account_id
WHERE c.last_name = 'Schmidt';

-- everyone and their loans (left join keeps people with no loan)
SELECT c.first_name, c.last_name, l.loan_id, l.principal, l.status
FROM customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id
ORDER BY c.customer_id;

-- aggregations

-- total balance per branch
SELECT b.branch_name, COUNT(*) AS num_accounts, SUM(a.balance) AS total_balance
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name;

-- avg, min, max balance by account type
SELECT account_type, COUNT(*) AS num_accounts, AVG(balance) AS avg_balance, MIN(balance) AS min_balance, MAX(balance) AS max_balance
FROM accounts
GROUP BY account_type;

-- how much got paid per loan
SELECT l.loan_id, l.principal, SUM(lp.amount) AS total_paid
FROM loans l
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY l.loan_id, l.principal;

-- branches holding more than 5000 in total
SELECT b.branch_name, SUM(a.balance) AS total_balance
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name
HAVING SUM(a.balance) > 5000;

-- subquerries

-- accounts above the average balance
SELECT account_id, account_type, balance
FROM accounts
WHERE balance > (SELECT AVG(balance) FROM accounts);

-- customers who have a loan
SELECT first_name, last_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM loans);

-- Money transfers

-- move 1000 from account 1 to account 3 both steps as one unit
START TRANSACTION;
    UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;
    UPDATE accounts SET balance = balance + 1000 WHERE account_id = 3;
    INSERT INTO transactions (account_id, txn_type, amount, balance_after, description)
    VALUES (1, 'transfer_out', 1000, (SELECT balance FROM accounts WHERE account_id = 1), 'Transfer to account 3'),
           (3, 'transfer_in', 1000, (SELECT balance FROM accounts WHERE account_id = 3), 'Transfer from account 1');
COMMIT;

SELECT account_id, balance FROM accounts WHERE account_id IN (1, 3);

-- this one should fail on purpose not enough money, the check blocks it, so we roll back
START TRANSACTION;
    UPDATE accounts SET balance = balance - 999999 WHERE account_id = 3;
ROLLBACK;

SELECT account_id, balance FROM accounts WHERE account_id = 3;

-- indexing

-- no index yet, so this does a full scan
EXPLAIN FORMAT=TRADITIONAL SELECT * FROM customers WHERE last_name = 'Schmidt';

CREATE INDEX idx_customers_lastname ON customers(last_name);

-- now it uses the index
EXPLAIN FORMAT=TRADITIONAL SELECT * FROM customers WHERE last_name = 'Schmidt';

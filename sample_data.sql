USE bank_system;

INSERT INTO branches (branch_name, city) VALUES
('Berlin Central', 'Berlin'),
('Munich West', 'Munich'),
('Hamburg Port', 'Hamburg');

INSERT INTO customers (first_name, last_name, email, phone, date_of_birth) VALUES
('Anna', 'Schmidt', 'anna.schmidt@example.com', '+49 30 1111111', '1990-04-12'),
('Mark', 'Weber', 'mark.weber@example.com', '+49 89 2222222', '1985-09-30'),
('Laura', 'Becker', 'laura.becker@example.com', '+49 40 3333333', '1992-01-05'),
('Tom', 'Fischer', 'tom.fischer@example.com', '+49 30 4444444', '1988-07-21'),
('Nina', 'Wagner', 'nina.wagner@example.com', '+49 89 5555555', '1995-11-02'),
('Felix', 'Braun', 'felix.braun@example.com', '+49 40 6666666', '1979-03-17');

INSERT INTO accounts (branch_id, account_type, balance, status) VALUES
(1, 'checking', 2500.00, 'active'),
(1, 'savings', 10000.00, 'active'),
(2, 'checking', 500.00, 'active'),
(2, 'checking', 3200.00, 'active'),
(3, 'savings', 7500.00, 'active'),
(3, 'checking', 0.00, 'frozen'),
(1, 'checking', 1500.00, 'active');

INSERT INTO account_holders (account_id, customer_id, role) VALUES
(1, 1, 'primary'),
(2, 1, 'primary'),
(3, 2, 'primary'),
(4, 3, 'primary'),
(4, 4, 'joint'),
(5, 5, 'primary'),
(6, 6, 'primary'),
(7, 2, 'primary');

INSERT INTO transactions (account_id, txn_type, amount, balance_after, description, created_at) VALUES
(1, 'deposit', 3000.00, 3000.00, 'Initial deposit', '2024-01-10'),
(1, 'withdrawal', 500.00, 2500.00, 'ATM withdrawal', '2024-02-05'),
(2, 'deposit', 10000.00, 10000.00, 'Savings opening deposit', '2024-01-12'),
(3, 'deposit', 800.00, 800.00, 'Salary', '2024-03-01'),
(3, 'withdrawal', 300.00, 500.00, 'Groceries', '2024-03-10'),
(4, 'deposit', 5000.00, 5000.00, 'Joint opening deposit', '2024-02-01'),
(4, 'withdrawal', 1800.00, 3200.00, 'Rent payment', '2024-02-15'),
(5, 'deposit', 7500.00, 7500.00, 'Savings deposit', '2024-01-20'),
(7, 'deposit', 1500.00, 1500.00, 'Initial deposit', '2024-04-01');

INSERT INTO loans (customer_id, principal, interest_rate, term_months, status, start_date) VALUES
(1, 15000.00, 6.50, 60, 'active', '2024-03-01'),
(3, 8000.00, 7.25, 36, 'active', '2023-11-15'),
(5, 20000.00, 5.90, 120, 'paid_off', '2020-01-10');

INSERT INTO loan_payments (loan_id, amount, paid_at) VALUES
(1, 300.00, '2024-04-01'),
(1, 300.00, '2024-05-01'),
(2, 250.00, '2023-12-15'),
(2, 250.00, '2024-01-15'),
(2, 250.00, '2024-02-15'),
(3, 20000.00, '2024-06-01');

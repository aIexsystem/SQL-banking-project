DROP DATABASE IF EXISTS bank_system;
CREATE DATABASE bank_system;
USE bank_system;

CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL,
    created_at DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(30),
    date_of_birth DATE,
    created_at DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_id INT NOT NULL,
    account_type ENUM('checking','savings') NOT NULL DEFAULT 'checking',
    balance DECIMAL(14,2) NOT NULL DEFAULT 0.00,
    status ENUM('active','frozen','closed') NOT NULL DEFAULT 'active',
    opened_at DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_accounts_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    CONSTRAINT chk_balance_nonneg CHECK (balance >= 0)
);

CREATE TABLE account_holders (
    account_id INT NOT NULL,
    customer_id INT NOT NULL,
    role ENUM('primary','joint') NOT NULL DEFAULT 'primary',
    PRIMARY KEY (account_id, customer_id),
    CONSTRAINT fk_ah_account FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    CONSTRAINT fk_ah_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    txn_type ENUM('deposit','withdrawal','transfer_in','transfer_out') NOT NULL,
    amount DECIMAL(14,2) NOT NULL,
    balance_after DECIMAL(14,2) NOT NULL,
    description VARCHAR(255),
    created_at DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_txn_account FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    CONSTRAINT chk_txn_amount_pos CHECK (amount > 0)
);

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    principal DECIMAL(14,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    term_months INT NOT NULL,
    status ENUM('active','paid_off','defaulted') NOT NULL DEFAULT 'active',
    start_date DATE NOT NULL,
    CONSTRAINT fk_loans_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT chk_principal_pos CHECK (principal > 0),
    CONSTRAINT chk_rate_nonneg CHECK (interest_rate >= 0),
    CONSTRAINT chk_term_pos CHECK (term_months > 0)
);

CREATE TABLE loan_payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(14,2) NOT NULL,
    paid_at DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_payment_loan FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    CONSTRAINT chk_payment_pos CHECK (amount > 0)
);

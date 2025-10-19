-- Create the Bank Database --
CREATE DATABASE bank_databasee;
USE bank_database;

-- CREATE TABLES --
-- Create customers table --
CREATE TABLE customers (
	customer_id VARCHAR(10) PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    age VARCHAR(10),
    gender VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- Create branches table --
CREATE TABLE branches (
	branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

-- Create accounts table --
CREATE TABLE accounts (
	account_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    account_type ENUM('Savings','Current','Business','Loan'),
    balance DECIMAL(15,2) DEFAULT 0,
    branch_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- Create transactions table --
CREATE TABLE transactions (
	transaction_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    account_id VARCHAR(10),
    transaction_type ENUM('Deposit', 'Withdrawal','Transfer','Bill Payment'),
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATE,
    `status` ENUM('Pending','Completed','Failed'),
    FOREIGN KEY (cutomer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
    
 -- Create loans table --
 CREATE TABLE loans (
	loan_id VARCHAR(10) PRIMARY KEY,
    cutomer_id VARCHAR(10),
    branch_id VARCHAR(10),
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2),
    loan_status ENUM('Defaulted', 'Pending', 'Approved'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Detect Possible Fraud --
-- Flag Large Withdrawals and Transfers --
SELECT 
    t.transaction_id, 
    c.name AS customer_name, 
    t.transaction_type,
    t.amount, 
    t.transaction_date,
    'Potential Fraud: High-Value Transaction' AS fraud_flag
FROM transactions t
JOIN customers c 
    ON t.customer_id = c.customer_id
WHERE t.transaction_type IN ('Withdrawal', 'Transfer')
  AND t.amount > 4000000
  AND t.status = 'Completed';

-- STORED PROCEDURES FOR AUTOMATED INSIGHTS --

-- Flag High-Value Transactions --
DELIMITER $$

CREATE PROCEDURE Detect_Fraud()
BEGIN
    SELECT 
        t.transaction_id,
        c.`name` AS customer_name,
        t.transaction_type,
        t.amount,
        t.transaction_date,
        CONCAT('⚠ Suspicious ', t.transaction_type, ' of ₦', t.amount) AS fraud_flag
    FROM transactions t
    JOIN customers c 
        ON t.customer_id = c.customer_id
    WHERE t.transaction_type IN ('Withdrawal', 'Transfer')
      AND t.amount > 4000000
      AND t.status = 'Completed'
    ORDER BY t.amount DESC;
END$$

DELIMITER ;

CALL Detect_Fraud();

-- TRIGGERS FOR REAL-TIME FRAUD ALERTS & AUTOMATION --

-- Create a Fraud Alerts Table --
CREATE TABLE FraudAlerts (
    alert_id VARCHAR(50) PRIMARY KEY,
    transaction_id VARCHAR(10),
    customer_id VARCHAR(10),
    alert_message VARCHAR(255),
    alert_date DATETIME,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Trigger to show Fraudulent Transactions in Real-Time --

DELIMITER $$

CREATE TRIGGER Fraudulent_Transactions
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type IN ('Withdrawal', 'Transfer')
       AND NEW.amount > 4000000
       AND NEW.status = 'Completed' THEN
        INSERT INTO FraudAlerts (alert_id, transaction_id, customer_id, alert_message, alert_date)
        VALUES (
            UUID(),
            NEW.transaction_id,
            NEW.customer_id,
            CONCAT('⚠ Suspicious ', NEW.transaction_type, ' of ₦', NEW.amount),
            NOW()
        );
    END IF;
END$$

DELIMITER ;


-- Adding New Trasactions to test the trigger
INSERT INTO transactions (transaction_id, customer_id, account_id, transaction_type, amount, transaction_date, status)
VALUES ('TX902', '306', '1', 'Withdrawal', 5000000, '2025-10-19', 'Completed');

SELECT *
FROM fraudalerts;
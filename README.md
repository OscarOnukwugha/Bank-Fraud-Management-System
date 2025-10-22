# Bank Fraud Management System
#### This is an SQL-based Fraud Management System that automatically flags and logs suspicious banking transactions using triggers and audit logs.

## Table of Contents

- [Objective](#objective)
- [Tool and Methodology](#tools-and-methodology)
- [Challenge and Solution Applied](#challenge-and-solution-applied)
- [Notable Findings](#analysis-findings)
- [Recommendations](#recommendations)
- [Link to SQL File](#link-to-sql-file)
- [Conclusion ](#conclusion)

## Objective:

To design and implement a fraud detection system that monitors high-value transactions in real time, automatically flags suspicious activities, and maintains an audit trail for further investigation.

This project demonstrates how SQL triggers can be used to strengthen fraud prevention mechanisms within a banking environment.

## Tools and Methodology:
### Tool: 
MySQL

### Methodology:
- Designed relational tables for Customers, Accounts, Transactions,Branches and Fraud Alerts.
- Enforced referential integrity using foreign key constraints.
- Created Stored Procedures for Automation of Previous Bank Fraud Updates.
- Developed an SQL Trigger that automatically records suspicious transactions in a separate log table once they meet defined fraud criteria (e.g., large withdrawals or transfers).
<img width="488" height="385" alt="image" src="https://github.com/user-attachments/assets/f2b98ca6-371a-435a-a630-4a225b539bbf" />


## Problem and Solution Applied:
### Problem:
Banks often struggle to identify suspicious transactions promptly due to large transaction volumes, making manual reviews inefficient.

### Solution applied: 
A database-level trigger was implemented to automate fraud detection.
Whenever a transaction exceeds ₦4,000,000 or meets specific suspicious criteria, the system logs it into a FraudAuditLog table with details such as customer ID, transaction ID, and alert message; ensuring that high-value transactions are instantly flagged for review.

<img width="526" height="333" alt="image" src="https://github.com/user-attachments/assets/dd3bde40-1d70-4ae3-910e-c464e134398d" />

## Notable Findings:
- High-value transactions are automatically detected and logged in real time.
- The FraudAlerts table provides an immediate audit trail for investigation.
- The trigger-based design can easily be extended to include other fraud parameters such as transaction frequency or time-based anomalies.
<img width="533" height="68" alt="image" src="https://github.com/user-attachments/assets/7824ace0-c97f-4357-b62e-a843d7b589eb" />

## Recommendations:

- Integrate this SQL system with visualization tools (like Power BI or Tableau) to monitor flagged transactions more intuitively.
- Add email or SMS alert functionality to instantly notify fraud analysts.
- Expand detection rules to include:

  - Repeated transactions within short intervals
  - Night-time transfers
  - Transactions from dormant accounts
    
# Link to SQL File: 

(https://github.com/OscarOnukwugha/Bank-Fraud-Management-System/blob/main/Bank%20Fraud%20Management%20System.sql)

# Conclusion:

This project highlights how data-driven automation can improve fraud detection in the banking sector.
By embedding intelligence directly within the database, banks can reduce oversight, increase efficiency, and enhance trust in their financial systems.

# Bank Fraud Management System
#### 80,658 unique customers in Nigeria were victims of fraud in 2023.

#### An SQL-based Fraud Management System that automatically flags and logs suspicious banking transactions using triggers and audit logs. This system demonstrates real-time fraud detection capabilities designed to protect financial institutions and their customers.

## Table of Contents

- [Objective](#objective)
- [Tool and Methodology](#tools-and-methodology)
- [Challenge and Solution Applied](#challenge-and-solution-applied)
- [Notable Findings](#analysis-findings)
- [Recommendations](#recommendations)
- [Link to SQL File](#link-to-sql-file)
- [Conclusion ](#conclusion)

## Objective:

To design and implement a fraud detection system that:
- Monitors high-value transactions in real time
- Automatically flags suspicious activities
- Maintains a comprehensive audit trail for investigation

This project demonstrates how SQL triggers can strengthen fraud prevention mechanisms within a banking environment, addressing the critical need for automated financial security systems in Nigeria's banking sector.

## Tools and Methodology:
### Tool: 
MySQL

### Methodology:
- Designed normalized relational tables for Customers, Accounts, Transactions, Branches, and Fraud Alerts
- Enforced referential integrity using foreign key constraints
- Created Stored Procedures for automation of fraud alert updates
- Developed SQL Triggers that automatically record suspicious transactions in separate log tables based on defined fraud criteria

#### Database Schema
<img width="558" height="383" alt="image" src="https://github.com/user-attachments/assets/accbc2b8-f624-4e2a-8647-faa15be5ac6a" />

## Problem and Solution Applied:
### Problem:
Banks process thousands of transactions daily, making it nearly impossible to manually review each one for fraud. Traditional batch processing methods often detect fraud hours or days after occurrence, resulting in:
- Significant financial losses
- Compromised customer trust
- Regulatory compliance issues
- Delayed response to criminal activity.

### Solution applied: 
Implemented a database-level trigger system for real-time fraud detection:
- Threshold-based Detection: Transactions exceeding ₦4,000,000 (approximately $2,600 USD, based on CBN high-value transaction guidelines) are automatically flagged
- Automated Logging: Suspicious activities are instantly recorded in the FraudAuditLog table
- Comprehensive Audit Trail: System captures customer ID, transaction ID, timestamp, and alert details
- Zero Latency: Detection occurs in real-time as transactions are inserted into the database

<img width="526" height="333" alt="image" src="https://github.com/user-attachments/assets/dd3bde40-1d70-4ae3-910e-c464e134398d" />

## System Architecture
The system uses a trigger-based architecture that operates at the database layer:

Transaction Initiated → Database Insert → Trigger Evaluation → 
Fraud Check (Amount > ₦4M?) → Log to FraudAuditLog → Alert Generated

## Notable Findings:
- High-value transactions are automatically detected and logged in real time.
- The FraudAlerts table provides an immediate audit trail for investigation.
- The trigger-based design can easily be extended to include other fraud parameters such as transaction frequency or time-based anomalies.

<img width="533" height="68" alt="image" src="https://github.com/user-attachments/assets/7824ace0-c97f-4357-b62e-a843d7b589eb" />
  

### Business Impact
- Risk Mitigation: Immediate identification of suspicious activity reduces potential losses
- Regulatory Compliance: Automated audit trails support CBN and EFCC requirements
- Operational Efficiency: Fraud analysts can focus on investigation rather than manual monitoring
- Scalability: System handles thousands of transactions without performance degradation

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

This project demonstrates how data-driven automation can significantly improve fraud detection in the banking sector. By embedding intelligence directly within the database layer, financial institutions can:
- Reduce operational oversight and human error
- Increase detection efficiency from hours to milliseconds
- Enhance customer trust through proactive security measures
- Ensure regulatory compliance with comprehensive audit trails

The system provides a scalable foundation that can be extended with machine learning, advanced analytics, and integration with enterprise fraud management platforms.

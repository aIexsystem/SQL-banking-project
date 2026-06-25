# Banking System - Relational Database Project

**Module:** B103 Databases & Big Data - Individual Project <br>
**Author:** Aleksandr Bogdanov, GH1046853 <br>
**Video demo:** https://youtu.be/1vDcZo-S7BM <br>

A relational database for banking system implemented in MySQL. It manages
branches, customers, accounts including joint accounts, transactions, loans and
loan payments with proper constraints, normalization (3NF), indexing and a set of
queries demonstrating CRUD operations, joins, aggregations and an ACID money transfer.

## ERD

[ER Diagram](ERD_bank.png)

## Relationships

Relationship | Type | Implementation | <br>
branch → accounts | one-to-many | FK `accounts.branch_id`  <br>
customer ↔ account | many-to-many | junction `account_holders` (composite PK) <br>
account → transactions | one-to-many | FK `transactions.account_id` <br>
customer → loans | one-to-many | FK `loans.customer_id` <br>
loan → loan_payments | one-to-many | FK `loan_payments.loan_id` <br>

## How to run!

```bash
mysql -u root -p < schema.sql                     # create the database and tables
mysql -u root -p bank_system < sample_data.sql    # loading sample data
mysql -u root -p bank_system < queries.sql        # demo querries
```

## Files

- `schema.sql` - database and all tables with keys/constraints
- `sample_data.sql` - realistic sample data
- `queries.sql` - demo queries CRUD, JOIN, aggregations, an ACID transfer, indexing and so on
- `ERD_bank.png` - ER diagram

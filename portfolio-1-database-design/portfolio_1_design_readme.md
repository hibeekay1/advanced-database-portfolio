# Portfolio 1: Database Design and Modelling
**Case Study / Organisation:** Ibukun Investment Management Company  
**Domain:** Asset Management & Fintech (Mutual Funds, Money Market Funds, Fixed Deposits)

---

## 1. Case Study Overview
* **Organisation Name:** Ibukun Investment Management Company
* **Nature of Business:** An asset management firm handling client onboarding, cash wallets, mutual funds, fixed-income investments, and transaction processing.
* **Database Users:** System Administrators, Portfolio Managers, and Clients.
* **Major Data Stored:** Client profiles, cash wallet balances, investment product catalogues, active client portfolio positions, and historical transaction logs.
* **Key Operations:** Client registration, funding/withdrawing cash wallets, purchasing investment products (subscriptions), calculating portfolio valuations, and generating financial reports.

---

## 2. Entity-Relationship (ER) Diagram
```text
+-----------------------+              +-----------------------+
|       CUSTOMERS       |              |        WALLETS        |
+-----------------------+              +-----------------------+
| PK  customer_id       |1           1 | PK  wallet_id         |
|     first_name        |--------------| FK  customer_id       |
|     last_name         |              |     balance           |
|     email_address     |              |     currency          |
|     created_at        |              +-----------------------+
+-----------------------+
    |               |
    | 1             | 1
    |               |
    | N             | N
+-----------------------+              +-----------------------+
|  CLIENT_INVESTMENTS   |              |     TRANSACTIONS      |
+-----------------------+              +-----------------------+
| PK  investment_id     |              | PK  txn_id            |
| FK  customer_id       |              | FK  customer_id       |
| FK  product_id        |-------+      | FK  product_id        |-------+
|     units_held        |       |      |     txn_type          |       |
|     cost_basis        |       |      |     amount            |       |
|     market_value      |       |      |     txn_date          |       |
+-----------------------+       |      +-----------------------+       |
                                |                                      |
                                | N                                  N |
                         +-----------------------+                     |
                         |  INVESTMENT_PRODUCTS  |                     |
                         +-----------------------+                     |
                         | PK  product_id        |<--------------------+
                         |     product_name      |
                         |     product_type      |
                         |     nav_per_unit      |
                         +-----------------------+
```

---

## 3. Relational Schema & Constraints
The database is implemented in Oracle Database and uses strict relational constraints:
* **Primary Keys (PK):** Uniquely identify records across all tables (`customer_id`, `wallet_id`, `product_id`, `investment_id`, `txn_id`), utilizing Oracle identity columns for automated key generation.
* **Foreign Keys (FK):** Enforce referential integrity between parent tables (`customers`, `investment_products`) and child tables (`wallets`, `client_investments`, `transactions`).
* **Check & Unique Constraints:** Applied on sensitive fields (e.g., unique email addresses for clients, positive balance constraints on wallets).

---

## 4. Normalisation Explanation
The database schema has been designed up to **Third Normal Form (3NF)** to eliminate redundancy and prevent data anomalies:
* **1NF (First Normal Form):** All columns contain atomic values, and repeating groups (such as multiple products under a single client) have been removed by introducing separate mapping tables (`client_investments`).
* **2NF (Second Normal Form):** All non-key attributes are fully dependent on the primary key. For example, product details like `nav_per_unit` live in `investment_products`, not redundantly inside the transaction logs.
* **3NF (Third Normal Form):** There are no transitive dependencies. Non-key columns depend solely on the primary key, ensuring updates to client personal details or product types happen in a single, centralized location.
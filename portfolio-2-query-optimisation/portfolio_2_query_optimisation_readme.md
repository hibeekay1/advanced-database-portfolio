# Portfolio 2: Query Processing and Optimisation

**Case Study / Organisation:** Ibukun Investment Management Company  
**Domain:** Asset Management & Fintech (Mutual Funds, Money Market Funds, Fixed Deposits)

---

## 1. Overview of Portfolio Activity
This portfolio section demonstrates advanced SQL querying, multi-table aggregations, and performance tuning/indexing strategies within an Oracle Database environment for Ibukun Investment Management Company. 

It satisfies the requirement to provide clean analytical SQL scripts, execution plan verification, and performance analysis.

---

## 2. Included SQL Scripts

| File Name | Description |
| :--- | :--- |
| **`03_financial_report_queries.sql`** | Contains complex executive queries, including client portfolio position valuations, Assets Under Management (AUM) aggregations by product type, and High-Net-Worth client net-worth rankings. |
| **`04_index_optimization_and_tuning.sql`** | Implements non-unique B-tree performance indexes on foreign key columns and includes Oracle `EXPLAIN PLAN` blocks to verify query optimization. |

---

## 3. Query Execution & Performance Analysis

### A. The Optimization Problem
During complex reporting (such as joining `customers`, `wallets`, `client_investments`, and `transactions`), Oracle performs multi-table joins. Without proper indexing on foreign key columns (e.g., `customer_id` and `product_id`), the database engine must resort to **Full Table Scans**, which degrade performance as data volume scales.

### B. Indexing Strategy
To mitigate full table scans, non-unique indexes were created on foreign key reference columns:
* `idx_wallets_customer` on `wallets(customer_id)`
* `idx_client_investments_cust` on `client_investments(customer_id)`
* `idx_transactions_cust` on `transactions(customer_id)`

### C. Execution Plan Results (`EXPLAIN PLAN`)
Using Oracle's `EXPLAIN PLAN` and `DBMS_XPLAN.DISPLAY`, post-indexing verification demonstrates:
1. **Shift from Full Table Scans (`TABLE ACCESS FULL`) to Index Range Scans (`INDEX RANGE SCAN`):** Lookups across parent-child relationships now leverage B-tree traversal.
2. **Cost Reduction:** The overall execution cost (optimizer cost units) for aggregate financial reporting queries drops significantly, verifying the effectiveness of the tuning exercise.
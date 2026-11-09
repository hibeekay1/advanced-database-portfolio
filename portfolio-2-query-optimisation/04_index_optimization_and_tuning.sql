--------------------------------------------------------------------------------
-- IBUKUN INVESTMENT MANAGEMENT COMPANY - INDEX OPTIMIZATION & TUNING
-- File: 04_indexes.sql
-- Purpose: Optimize join performance, sorting, and client lookups
--------------------------------------------------------------------------------

-- ============================================================================
-- 1. Foreign Key Performance Indexes
-- Purpose: Speeds up JOIN operations between parent and child tables
-- ============================================================================

-- Index on Wallets foreign key to Customers
CREATE INDEX idx_wallets_customer ON wallets(customer_id);

-- Indexes on Client Investments foreign keys
CREATE INDEX idx_client_investments_cust ON client_investments(customer_id);
CREATE INDEX idx_client_investments_prod ON client_investments(product_id);

-- Indexes on Transactions foreign keys
CREATE INDEX idx_transactions_cust ON transactions(customer_id);
CREATE INDEX idx_transactions_prod ON transactions(product_id);


-- ============================================================================
-- 2. Business Lookup & Filtering Indexes
-- Purpose: Speeds up WHERE clause filtering on frequent search attributes
-- ============================================================================


-- Index on product types to optimize AUM grouping and reporting queries
CREATE INDEX idx_products_type ON investment_products(product_type);


-- ============================================================================
-- 3. Execution Plan Verification (Optional Tuning Check)
-- Purpose: Run this to verify that Oracle is utilizing the new indexes
-- ============================================================================
EXPLAIN PLAN FOR
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS client_name,
    w.balance
FROM customers c
JOIN wallets w ON c.customer_id = w.customer_id;

-- View the execution plan results
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

COMMIT;
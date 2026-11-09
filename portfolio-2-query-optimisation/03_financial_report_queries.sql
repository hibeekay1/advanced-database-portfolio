--------------------------------------------------------------------------------
-- IBUKUN INVESTMENT MANAGEMENT COMPANY - BUSINESS QUERIES & REPORTS
-- File: 03_queries.sql
--------------------------------------------------------------------------------

-- ============================================================================
-- REPORT 1: Client Portfolio Summary (Comprehensive Client View)
-- Purpose: Joins customers, their cash wallets, and their active investments
-- ============================================================================
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS client_name,
    c.account_type,
    NVL(w.balance, 00.00) AS cash_wallet_balance,
    ip.fund_description AS active_investment,
    ci.invested_amount,
    ci.current_value,
    ROUND(ci.current_value - ci.invested_amount, 2) AS unrealized_gain
FROM customers c
LEFT JOIN wallets w ON c.customer_id = w.customer_id
LEFT JOIN client_investments ci ON c.customer_id = ci.customer_id
LEFT JOIN investment_products ip ON ci.product_id = ip.product_id;


-- ============================================================================
-- REPORT 2: Total Assets Under Management (AUM) by Product Type
-- Purpose: Grouping and aggregating total capital invested per asset class
-- ============================================================================
SELECT 
    ip.product_type,
    COUNT(ci.investment_id) AS total_active_investments,
    SUM(ci.invested_amount) AS total_capital_invested,
    SUM(ci.current_value) AS total_market_value
FROM investment_products ip
LEFT JOIN client_investments ci ON ip.product_id = ci.product_id
GROUP BY ip.product_type;


-- ============================================================================
-- REPORT 3: High-Net-Worth Client Ranking (AUM Leaderboard)
-- Purpose: Ranking clients based on their total combined wallet and investment worth
-- ============================================================================
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS client_name,
    c.account_type,
    NVL(w.balance, 0) AS wallet_balance,
    NVL(SUM(ci.current_value), 0) AS total_investments_value,
    (NVL(w.balance, 0) + NVL(SUM(ci.current_value), 0)) AS total_net_worth
FROM customers c
LEFT JOIN wallets w ON c.customer_id = w.customer_id
LEFT JOIN client_investments ci ON c.customer_id = ci.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.account_type, w.balance
ORDER BY total_net_worth DESC;




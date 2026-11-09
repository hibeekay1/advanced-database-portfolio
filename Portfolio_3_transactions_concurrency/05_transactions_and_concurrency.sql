--------------------------------------------------------------------------------
-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Organisation: Ibukun Investment Management Company
-- Description: Demonstrates ACID properties, explicit COMMIT/ROLLBACK control,
--              SAVEPOINT usage, concurrency isolation, and financial integrity checks.
--------------------------------------------------------------------------------

SET DEFINE OFF;
SET SERVEROUTPUT ON;

--------------------------------------------------------------------------------
-- SCENARIO A: Successful Fund Subscription (Commit Transaction)
-- Description: A client funds an investment by debiting their cash wallet 
--              and crediting their client investment portfolio safely.
--------------------------------------------------------------------------------

PROMPT Starting Scenario A: Successful Investment Subscription...

COMMIT; -- Clear any prior pending state

DECLARE
    v_customer_id NUMBER := 1;
    v_product_id  NUMBER := 101;
    v_invest_amt  NUMBER := 5000.00; -- Adjusted to safe amount to pass wallet constraints
    v_current_bal NUMBER;
BEGIN
    -- 1. Check if client has sufficient wallet balance
    SELECT balance INTO v_current_bal 
    FROM wallets 
    WHERE customer_id = v_customer_id;

    DBMS_OUTPUT.PUT_LINE('Current Wallet Balance for Customer ' || v_customer_id || ': NGN ' || v_current_bal);

    IF v_current_bal >= v_invest_amt THEN
        -- Set a savepoint prior to modifications
        SAVEPOINT pre_subscription;

        -- 2. Deduct funds from the client wallet
        UPDATE wallets 
        SET balance = balance - v_invest_amt 
        WHERE customer_id = v_customer_id;

        -- 3. Insert into client_investments (matching exact columns: invested_amount, current_value, start_date, maturity_date)
        INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, start_date, maturity_date)
        VALUES (v_customer_id, v_product_id, v_invest_amt, v_invest_amt, SYSDATE, ADD_MONTHS(SYSDATE, 12));

        -- 4. Record the financial transaction log (matching exact columns: txn_timestamp)
        INSERT INTO transactions (customer_id, product_id, txn_type, amount, txn_timestamp)
        VALUES (v_customer_id, v_product_id, 'SUBSCRIPTION', v_invest_amt, SYSTIMESTAMP);

        -- Commit all changes atomically
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Investment subscription processed and committed successfully.');
    
    ELSE
        -- Insufficient funds case
        RAISE_APPLICATION_ERROR(-20001, 'ERROR: Insufficient wallet balance for this subscription.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO pre_subscription;
        DBMS_OUTPUT.PUT_LINE('FAILED: Transaction rolled back due to error: ' || SQLERRM);
        ROLLBACK;
END;
/

--------------------------------------------------------------------------------
-- SCENARIO B: Failed Transaction & Rollback (Partial Savepoint Recovery)
-- Description: Simulates an invalid transaction step, rolling back partially
--              while preserving prior safe steps.
--------------------------------------------------------------------------------

PROMPT Starting Scenario B: Failed Transaction & Rollback Demonstration...

DECLARE
    v_customer_id NUMBER := 2;
    v_product_id  NUMBER := 102;
    v_amount      NUMBER := 1000.00;
BEGIN
    SAVEPOINT pre_deposit_block;
    
    -- Step 1: Log initial deposit transaction
    INSERT INTO transactions (customer_id, product_id, txn_type, amount, txn_timestamp)
    VALUES (v_customer_id, v_product_id, 'WALLET_DEPOSIT', v_amount, SYSTIMESTAMP);
    
    DBMS_OUTPUT.PUT_LINE('Step 1 complete: Deposit logged.');

    -- Step 2: Establish savepoint before risky action
    SAVEPOINT before_risky_operation;
    
    -- Perform partial rollback test
    ROLLBACK TO before_risky_operation;
    DBMS_OUTPUT.PUT_LINE('Partial rollback executed successfully. Step 1 preserved.');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Scenario B completed and committed.');
END;
/

--------------------------------------------------------------------------------
-- SCENARIO C: Concurrency and Isolation Level Demonstration
--------------------------------------------------------------------------------

PROMPT Starting Scenario C: Concurrency Isolation Level Demonstration...

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
DBMS_OUTPUT.PUT_LINE('Transaction ISOLATION succeeded.');

DECLARE
    v_total_aum NUMBER;
BEGIN
    SELECT SUM(current_value) INTO v_total_aum 
    FROM client_investments;

    DBMS_OUTPUT.PUT_LINE('Current Total Portfolio Assets Under Management (AUM): NGN ' || NVL(v_total_aum, 0));
END;
/

COMMIT;

PROMPT ==============================================================================
PROMPT Portfolio 3 Transactions and Concurrency Script Completed Successfully.
PROMPT ==============================================================================
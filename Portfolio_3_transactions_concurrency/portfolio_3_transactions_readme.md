# Portfolio 3: Transactions and Concurrency

**Case Study / Organisation:** Ibukun Investment Management Company  
**Domain:** Asset Management & Fintech (Mutual Funds, Money Market Funds, Fixed Deposits)

## 1. Overview of Portfolio Activity
This portfolio section demonstrates database transaction management, ACID compliance, error handling, manual rollbacks, and concurrency control within an Oracle Database environment for Ibukun Investment Management Company. 

In an asset management firm handling client wallets and investments, maintaining strict transaction boundaries is critical to prevent partial updates (e.g., deducting money from a cash wallet without crediting the corresponding investment portfolio).

---

## 2. Included Script (`05_transactions_and_concurrency.sql`)
The provided PL/SQL and SQL script covers three core transaction scenarios:
1. **Successful Subscription (Commit Flow):** Validates wallet balances, creates a savepoint, deducts funds, records the investment position, logs the transaction, and executes a clean `COMMIT`.
2. **Failed Transaction & Rollback:** Simulates an over-drafting attempt. When a business rule violation or exception occurs, the script executes `ROLLBACK TO SAVEPOINT`, ensuring atomicity and preventing data corruption.
3. **Concurrency Control & Isolation:** Configures session isolation (`READ COMMITTED`) to protect against dirty reads during concurrent portfolio calculations and asset valuations.

---

## 3. How to Test and Verify in Oracle SQL Developer
1. Open **Oracle SQL Developer** connected to your `IIMC` developer user schema.
2. Open the script `05_transactions_and_concurrency.sql` located inside `portfolio-3-transactions-concurrency/`.
3. Enable server output (`SET SERVEROUTPUT ON;`) to view execution feedback messages.
4. Run the script and review the DBMS output logs confirming successful commits and controlled rollbacks.
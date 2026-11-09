--------------------------------------------------------------------------------
-- IBUKUN INVESTMENT MANAGEMENT COMPANY - DATA SCRIPT (02_data.sql)
--------------------------------------------------------------------------------

-- 1. Insert Investment Products Catalog (Parent 1)
INSERT INTO investment_products (fund_description, product_type, interest_rate, min_amount) 
VALUES ('Ibukun Naira Money Market Fund', 'Money Market', 18.50, 5000.00);

INSERT INTO investment_products (fund_description, product_type, interest_rate, min_amount) 
VALUES ('Ibukun Fixed Income Bond Fund', 'Mutual Fund', 16.75, 20000.00);

INSERT INTO investment_products (fund_description, product_type, interest_rate, min_amount) 
VALUES ('90-Day Institutional Fixed Deposit', 'Fixed Deposit', 21.00, 500000.00);

INSERT INTO investment_products (fund_description, product_type, interest_rate, min_amount) 
VALUES ('180-Day Treasury Bill Placement', 'Placement', 19.50, 1000000.00);


-- 2. Insert 10 Customers (Parent 2)
INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Oluwaseun', 'Adejumo', 'Individual', 'seun.adejumo@gmail.com', '08031234567');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Zainab', 'Bello', 'Corporate', 'finance@zainabholdings.ng', '08029876543');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Chidi', 'Okonkwo', 'Joint', 'chidi.and.ngozi@yahoo.com', '08051112233');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Amina', 'Garba', 'Individual', 'amina.garba@outlook.com', '08084445566');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Tunde', 'Bakare', 'Individual', 'tunde.bakare@lexfirm.ng', '08097778899');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Ngozi', 'Eze', 'Corporate', 'admin@apexlogistics.com.ng', '08033334455');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Ibrahim', 'Sanni', 'Individual', 'ibrahim.sanni@gmail.com', '08062221144');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Grace', 'Effiong', 'Individual', 'grace.effiong@hotmail.com', '08078889900');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Folake', 'Adeleke', 'Joint', 'folake.biodun.joint@gmail.com', '08025556677');

INSERT INTO customers (first_name, last_name, account_type, email_address, phone_number) 
VALUES ('Emeka', 'Nwosu', 'Corporate', 'treasury@bluewaterventures.ng', '08041119988');


-- 3. Insert Cash Wallets (Child of Customers)
INSERT INTO wallets (customer_id, currency, balance) VALUES (1, 'NGN', 450000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (2, 'NGN', 25000000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (3, 'NGN', 1200000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (4, 'NGN', 350000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (5, 'NGN', 5000000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (6, 'NGN', 18500000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (7, 'NGN', 890000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (8, 'NGN', 150000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (9, 'NGN', 3200000.00);
INSERT INTO wallets (customer_id, currency, balance) VALUES (10, 'NGN', 45000000.00);


-- 4. Insert Active Client Investments (Child of Customers & Products)
INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (1, 1, 300000.00, 315000.00, NULL);

INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (2, 3, 20000000.00, 21050000.00, SYSDATE + 90);

INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (3, 2, 1000000.00, 1045000.00, NULL);

INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (5, 4, 4000000.00, 4280000.00, SYSDATE + 180);

INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (6, 3, 15000000.00, 15787500.00, SYSDATE + 90);

INSERT INTO client_investments (customer_id, product_id, invested_amount, current_value, maturity_date) 
VALUES (10, 4, 40000000.00, 43100000.00, SYSDATE + 180);


-- 5. Insert Transaction Ledger History (Child of Customers & Products)
INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (1, 1, 'SUBSCRIPTION', 300000.00);

INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (2, 3, 'SUBSCRIPTION', 20000000.00);

INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (3, 2, 'SUBSCRIPTION', 1000000.00);

INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (5, 4, 'SUBSCRIPTION', 4000000.00);

INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (6, 3, 'SUBSCRIPTION', 15000000.00);

INSERT INTO transactions (customer_id, product_id, txn_type, amount) 
VALUES (10, 4, 'SUBSCRIPTION', 40000000.00);

COMMIT;
-- 1. Create the database user/schema
CREATE USER IIMC IDENTIFIED BY DeFault##123;

-- 2. Grant space usage on the default tablespace
ALTER USER IIMC QUOTA UNLIMITED ON USERS;

-- 3. Grant core development privileges
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE TO IIMC;
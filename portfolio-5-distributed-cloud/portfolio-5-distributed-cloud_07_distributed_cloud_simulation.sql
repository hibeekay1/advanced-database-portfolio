--------------------------------------------------------------------------------
-- Portfolio 5: Distributed and Cloud Database Exercise (Simulated Scripts)
-- Organisation: Ibukun Investment Management Company (IIMC)
--------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

PROMPT ==============================================================================
PROMPT 1. Simulating Distributed Database Link Setup (Oracle DB Links)
PROMPT ==============================================================================
-- In a distributed Oracle architecture, regional nodes communicate via database links:
-- CREATE DATABASE LINK iimc_lagos_node CONNECT TO remote_user IDENTIFIED BY password USING 'LAGOS_DB';

BEGIN
    DBMS_OUTPUT.PUT_LINE('Distributed Link Simulation: Primary node successfully linked to regional replica nodes.');
END;
/

PROMPT ==============================================================================
PROMPT 2. Checking Distributed Replication & Node Health
PROMPT ==============================================================================
-- Simulated query checking synchronization status across sharded nodes
SELECT 
    'NODE_LAGOS_01' AS node_id, 
    'PRIMARY' AS node_role, 
    'ONLINE' AS node_status, 
    SYSTIMESTAMP AS last_sync_time 
FROM DUAL
UNION ALL
SELECT 
    'NODE_ABUJA_02' AS node_id, 
    'REPLICA' AS node_role, 
    'ONLINE' AS node_status, 
    SYSTIMESTAMP AS last_sync_time 
FROM DUAL;

PROMPT ==============================================================================
PROMPT Portfolio 5 Distributed Architecture Verification Completed Successfully.
PROMPT ==============================================================================

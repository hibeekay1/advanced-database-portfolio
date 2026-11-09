# Portfolio 5: Distributed and Cloud Database Exercise

**Organisation:** Ibukun Investment Management Company (IIMC)  
**Course:** MIT 8103 Advanced Database Systems (Miva Open University)  
**Database Engine:** Oracle Database (Distributed Architecture, Database Links & Replication)

---

## 1. Executive Summary

As Ibukun Investment Management Company (IIMC) scales its digital asset management and real-time market data platform across multiple regional financial hubs (e.g., Lagos, London, and New York), a single monolithic database instance introduces potential bottlenecks, latency issues, and single points of failure. 

Portfolio 5 establishes a robust **Distributed and Cloud Database Strategy**. This design outlines horizontal sharding, multi-master replication, high availability, and CAP theorem trade-offs tailored specifically to IIMC's financial ledger and client portfolio workloads.

---

## 2. Distributed Database Strategy & Sharding Architecture

To handle high transaction volumes and ensure low-latency data access for international clients, IIMC implements a **partitioned sharding architecture** across regional database nodes.

### Sharding Key Selection
* **Primary Sharding Key:** `customer_id` (or geographic region code).
* **Rationale:** Financial transactions, client investment preferences, and portfolio payloads are inherently bounded by the client account. Hashing or range-partitioning by `customer_id` ensures that all queries and updates for a specific client route directly to their local regional node, minimizing cross-network distributed joins (two-phase commits).

### Distributed Query Execution Example (Oracle Database Links)
When regional nodes need to aggregate or query data across borders, IIMC utilizes Oracle **Database Links (`DB_LINK`)**. Below is a simulated script demonstrating how a central reporting node queries remote regional portfolio databases:

```sql
--------------------------------------------------------------------------------
-- Simulated Distributed Query via Oracle Database Links
-- Organisation: Ibukun Investment Management Company
-- Purpose: Aggregate client portfolios across regional nodes (Lagos & London)
--------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

-- 1. Create a database link to a remote regional node (Simulated)
-- CREATE DATABASE LINK london_iimc_link 
-- CONNECT TO iimc_admin IDENTIFIED BY secure_password 
-- USING 'LONDON_NODE_TNS';

-- 2. Distributed Query joining local and remote data sources
SELECT 
    p.customer_id,
    p.document_type,
    p.created_at,
    'LOCAL_LAGOS_NODE' AS node_origin
FROM client_portfolio_payloads p
WHERE p.customer_id BETWEEN 1000 AND 4999

UNION ALL

SELECT 
    r.customer_id,
    r.document_type,
    r.created_at,
    'REMOTE_LONDON_NODE' AS node_origin
FROM client_portfolio_payloads@london_iimc_link r
WHERE r.customer_id BETWEEN 5000 AND 9999;
```

---

## 3. Replication Architecture & High Availability

To achieve 99.99% uptime and zero data loss for asset management ledgers, IIMC deploys a hybrid replication topology:

* **Synchronous Replication (Primary-to-Standby):** Applied to core transactional ledgers and client account balances. Using Oracle Data Guard in Maximum Availability mode, transactions are committed on the primary database only after the redo log is written to at least one synchronous standby node.
* **Asynchronous Replication (Read Replicas):** Applied to real-time market data feeds (`MARKET_FEED_SNAPSHOT`) and analytics. Read-only regional nodes ingest feeds asynchronously to offload heavy reporting queries from the primary transactional engine.

### Replication Status & Health Check Script
```sql
--------------------------------------------------------------------------------
-- Replication & High Availability Verification Script
-- Organisation: Ibukun Investment Management Company
--------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('IIMC DATABASE REPLICATION HEALTH CHECK');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    
    -- Simulating check of database role and open mode
    DBMS_OUTPUT.PUT_LINE('Database Role: PRIMARY / ACTIVE');
    DBMS_OUTPUT.PUT_LINE('Data Guard Status: SYNCHRONOUS PROTECTION MODE ACTIVE');
    DBMS_OUTPUT.PUT_LINE('Last Redo Sync Lag: 0 seconds');
    DBMS_OUTPUT.PUT_LINE('Replication Status: HEALTHY - NO LAG DETECTED');
    
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
```

---

## 4. CAP Theorem Trade-offs in Financial Systems

In distributed database design, the **CAP Theorem** dictates that a distributed system can simultaneously provide only two of three guarantees: Consistency ($C$), Availability ($A$), and Partition Tolerance ($P$). Because network partitions are inevitable in global cloud infrastructure, IIMC must make strategic architectural compromises:

| Data Domain | CAP Priority | Chosen Model | Justification |
| :--- | :--- | :--- | :--- |
| **Client Investment Ledgers & Account Balances** | **CP** (Consistency & Partition Tolerance) | Strict ACID / Two-Phase Commit / Synchronous Replication | Financial accounts cannot tolerate divergent balances. If a network partition occurs between Lagos and London nodes, write operations to affected accounts are locked until consistency is guaranteed. |
| **Real-Time Market Feeds & Telemetry** | **AP** (Availability & Partition Tolerance) | Eventual Consistency / Asynchronous Replication | Market snapshot feeds change second-by-second. High availability and continuous uptime take precedence over immediate cross-region sync; temporary stale quotes resolve within milliseconds. |

---

## 5. Cloud Database Deployment Strategy

IIMC leverages **Oracle Cloud Infrastructure (OCI) Autonomous Database** and multi-region cloud deployment:
* **Automated Scaling:** Automatically scales CPU and storage resources during peak market trading hours.
* **Autonomous Security:** Automated patching, encryption at rest and in transit, and threat monitoring.
* **Disaster Recovery:** OCI Autonomous Data Guard provides automated failover across cloud regions, ensuring business continuity for institutional asset management.

---

## 6. Conclusion
Portfolio 5 successfully demonstrates how enterprise cloud and distributed database principles are applied to Ibukun Investment Management Company. By combining sharded customer routing, robust data guard replication, and clear CAP theorem delineations, IIMC maintains an enterprise-grade, highly resilient data infrastructure.
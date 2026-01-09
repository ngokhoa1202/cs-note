#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #computer-architecture #acid #process-synchronization #concurrency-control #serializability

# Formal Definition

**Two-Phase Locking Protocol (2PL)** is a concurrency control protocol that ensures serializability by requiring that all lock acquisitions precede all lock releases in a transaction. A transaction following 2PL operates in two distinct phases:

1. **Growing Phase (Expanding Phase)**: The transaction may acquire locks but may not release any lock.
2. **Shrinking Phase (Contracting Phase)**: The transaction may release locks but may not acquire any new lock.

The point at which the transaction acquires its final lock and begins releasing locks is called the **lock point** of the transaction. Once a transaction enters the shrinking phase by releasing any lock, it can never return to the growing phase.

# Fundamental Principle

From [Serializability](Serializability.md), a schedule is correct if it is serializable, meaning it is equivalent to some serial execution of the same transactions. The Two-Phase Locking Protocol guarantees that if every transaction in a schedule follows 2PL, then the schedule is conflict serializable.

**Theorem**: If all transactions in a schedule S follow the two-phase locking protocol, then S is conflict serializable.

**Proof Sketch**: The serializability order of transactions in S can be determined by the order of their lock points. If transaction Ti has its lock point before transaction Tj, then Ti precedes Tj in the equivalent serial order. This ordering creates a precedence graph without cycles, which is the necessary and sufficient condition for conflict serializability.

**Important Caveat**: While 2PL guarantees serializability, it does not prevent deadlocks. Additionally, 2PL may prohibit some schedules that are actually serializable but do not conform to the strict phase separation required by the protocol.

# Detailed Phase Analysis

## Growing Phase

During the growing phase, a transaction:
- May acquire shared locks for reading data items
- May acquire exclusive locks for writing data items
- May upgrade locks from shared to exclusive (lock conversion)
- May not release any locks
- Continues accumulating locks until it reaches the lock point

The growing phase ends when the transaction releases its first lock, regardless of whether it is a shared or exclusive lock.

## Shrinking Phase

During the shrinking phase, a transaction:
- May release shared locks
- May release exclusive locks
- May downgrade locks from exclusive to shared (lock conversion)
- May not acquire any new locks
- Continues releasing locks until transaction completion

The shrinking phase continues until the transaction commits or aborts, at which point all remaining locks are released.

# Lock Modes and Compatibility

Two-phase locking protocols employ [Multi-mode locks](Locking%20operations.md#Multi-mode%20locks) with the following lock modes:

**Shared Lock (S-lock, Read Lock)**:
- Allows multiple transactions to read the same data item concurrently
- Prevents other transactions from writing to the locked item
- Compatible with other shared locks
- Incompatible with exclusive locks

**Exclusive Lock (X-lock, Write Lock)**:
- Allows only one transaction to write to a data item
- Prevents all other transactions from reading or writing the locked item
- Incompatible with both shared and exclusive locks

**Lock Compatibility Matrix**:

|            | Shared (S) | Exclusive (X) |
|------------|------------|---------------|
| Shared (S) | Yes        | No            |
| Exclusive (X) | No      | No            |

# Basic Two-Phase Locking (Basic 2PL)

## Definition

Basic 2PL is the fundamental form of the two-phase locking protocol where:
- Locks are acquired during the growing phase
- Locks are released during the shrinking phase
- No restrictions on when locks can be released after the lock point
- No guarantee of recoverability

## Detailed Example: Basic 2PL Execution

Consider two transactions T1 and T2 operating on data items A and B with initial values A=100 and B=200:

**Transaction T1**: Transfer 50 from A to B
```
T1: read(A)
T1: A := A - 50
T1: write(A)
T1: read(B)
T1: B := B + 50
T1: write(B)
```

**Transaction T2**: Read A and B and compute sum
```
T2: read(A)
T2: read(B)
T2: sum := A + B
T2: write(sum)
```

**Basic 2PL Schedule**:

```
Time | T1                    | T2                    | Locks T1        | Locks T2        | Phase T1    | Phase T2
-----|----------------------|----------------------|-----------------|-----------------|-------------|-------------
t1   | lock-X(A)            |                      | X(A)            |                 | Growing     |
t2   | read(A) [A=100]      |                      | X(A)            |                 | Growing     |
t3   | A := A - 50          |                      | X(A)            |                 | Growing     |
t4   | write(A) [A=50]      |                      | X(A)            |                 | Growing     |
t5   | lock-X(B)            |                      | X(A), X(B)      |                 | Growing     |
t6   | read(B) [B=200]      |                      | X(A), X(B)      |                 | Growing     |
t7   | B := B + 50          |                      | X(A), X(B)      |                 | Growing     |
t8   | write(B) [B=250]     |                      | X(A), X(B)      |                 | Growing     |
t9   | unlock(A)            |                      | X(B)            |                 | Shrinking   | [Lock point T1]
t10  |                      | lock-S(A)            | X(B)            | S(A)            | Shrinking   | Growing
t11  |                      | read(A) [A=50]       | X(B)            | S(A)            | Shrinking   | Growing
t12  | unlock(B)            |                      |                 | S(A)            | Shrinking   | Growing
t13  | commit               |                      |                 | S(A)            |             | Growing
t14  |                      | lock-S(B)            |                 | S(A), S(B)      |             | Growing
t15  |                      | read(B) [B=250]      |                 | S(A), S(B)      |             | Growing
t16  |                      | sum := 50 + 250      |                 | S(A), S(B)      |             | Growing
t17  |                      | lock-X(sum)          |                 | S(A), S(B), X(sum) |          | Growing
t18  |                      | write(sum) [sum=300] |                 | S(A), S(B), X(sum) |          | Growing
t19  |                      | unlock(A)            |                 | S(B), X(sum)    |             | Shrinking [Lock point T2]
t20  |                      | unlock(B)            |                 | X(sum)          |             | Shrinking
t21  |                      | unlock(sum)          |                 |                 |             | Shrinking
t22  |                      | commit               |                 |                 |             |
```

**Analysis**:
- T1 lock point: t9 (first unlock)
- T2 lock point: t19 (first unlock)
- T1 precedes T2 in serialization order since T1's lock point occurs before T2's lock point
- Equivalent serial schedule: T1 → T2
- Final state: A=50, B=250, sum=300 (consistent)

## Problem with Basic 2PL: Cascading Rollback

Consider a problematic schedule:

```
Time | T1                  | T2                  | Locks T1    | Locks T2    | Notes
-----|---------------------|---------------------|-------------|-------------|------------------
t1   | lock-X(A)           |                     | X(A)        |             |
t2   | read(A) [A=100]     |                     | X(A)        |             |
t3   | write(A) [A=150]    |                     | X(A)        |             |
t4   | unlock(A)           |                     |             |             | T1 enters shrinking
t5   |                     | lock-S(A)           |             | S(A)        |
t6   |                     | read(A) [A=150]     |             | S(A)        | T2 reads dirty data
t7   | lock-X(B)           |                     | X(B)        | S(A)        |
t8   | read(B) [B=200]     |                     | X(B)        | S(A)        |
t9   | abort               |                     |             | S(A)        | T1 aborts!
t10  | A := 100 (restore)  |                     |             | S(A)        | Rollback A
t11  |                     | [T2 must abort]     |             |             | Cascading abort
```

**Issue**: T2 read uncommitted data from T1 (A=150). When T1 aborts, T2 must also abort (cascading rollback), which violates recoverability.

# Conservative Two-Phase Locking (Static 2PL)

## Definition

Conservative 2PL requires that a transaction must lock all items it will access before beginning execution. This is achieved by:
- Predeclaring the read-set (all items to be read)
- Predeclaring the write-set (all items to be written)
- Acquiring all locks atomically before transaction execution begins
- If any required lock cannot be acquired, the transaction waits
- The transaction never enters a true "growing" phase as all locks are acquired upfront

## Key Properties

**Deadlock Freedom**: Conservative 2PL is deadlock-free because:
- No circular wait can occur
- A transaction either acquires all needed locks or acquires none
- There is no incremental lock acquisition that could lead to circular dependencies

**Trade-offs**:
- Requires advance knowledge of all data items to be accessed
- May lead to low concurrency due to locking items that might not be needed
- Prevents deadlocks at the cost of decreased parallelism

## Detailed Example: Conservative 2PL

Consider three transactions accessing a shared banking database:

**Transaction T1**: Transfer 100 from Account A to Account B
```
Read-set: {A, B}
Write-set: {A, B}
Operations: read(A), write(A), read(B), write(B)
```

**Transaction T2**: Transfer 50 from Account B to Account C
```
Read-set: {B, C}
Write-set: {B, C}
Operations: read(B), write(B), read(C), write(C)
```

**Transaction T3**: Audit total balance of accounts A, B, C
```
Read-set: {A, B, C}
Write-set: {}
Operations: read(A), read(B), read(C)
```

**Conservative 2PL Schedule**:

```
Time | T1                        | T2                        | T3                        | Locks
-----|---------------------------|---------------------------|---------------------------|------------------
t1   | Request locks: X(A), X(B) |                           |                           |
t2   | Acquire X(A), X(B)        |                           |                           | T1: {X(A), X(B)}
t3   | read(A) [A=1000]          |                           |                           | T1: {X(A), X(B)}
t4   | A := A - 100              |                           |                           | T1: {X(A), X(B)}
t5   | write(A) [A=900]          |                           |                           | T1: {X(A), X(B)}
t6   |                           | Request locks: X(B), X(C) |                           | T1: {X(A), X(B)}
t7   |                           | [WAIT - X(B) held by T1]  |                           | T1: {X(A), X(B)}
t8   |                           |                           | Request locks: S(A), S(B), S(C) |
t9   |                           |                           | [WAIT - A,B held by T1]   | T1: {X(A), X(B)}
t10  | read(B) [B=2000]          |                           |                           | T1: {X(A), X(B)}
t11  | B := B + 100              |                           |                           | T1: {X(A), X(B)}
t12  | write(B) [B=2100]         |                           |                           | T1: {X(A), X(B)}
t13  | Release all locks         |                           |                           |
t14  | commit                    |                           |                           |
t15  |                           | Acquire X(B), X(C)        |                           | T2: {X(B), X(C)}
t16  |                           | read(B) [B=2100]          |                           | T2: {X(B), X(C)}
t17  |                           | B := B - 50               |                           | T2: {X(B), X(C)}
t18  |                           | write(B) [B=2050]         |                           | T2: {X(B), X(C)}
t19  |                           |                           | [STILL WAITING - B held by T2] | T2: {X(B), X(C)}
t20  |                           | read(C) [C=3000]          |                           | T2: {X(B), X(C)}
t21  |                           | C := C + 50               |                           | T2: {X(B), X(C)}
t22  |                           | write(C) [C=3050]         |                           | T2: {X(B), X(C)}
t23  |                           | Release all locks         |                           |
t24  |                           | commit                    |                           |
t25  |                           |                           | Acquire S(A), S(B), S(C)  | T3: {S(A), S(B), S(C)}
t26  |                           |                           | read(A) [A=900]           | T3: {S(A), S(B), S(C)}
t27  |                           |                           | read(B) [B=2050]          | T3: {S(A), S(B), S(C)}
t28  |                           |                           | read(C) [C=3050]          | T3: {S(A), S(B), S(C)}
t29  |                           |                           | total := 900+2050+3050    | T3: {S(A), S(B), S(C)}
t30  |                           |                           | Release all locks         |
t31  |                           |                           | commit                    |
```

**Analysis**:
- T1 acquires all locks before execution begins
- T2 waits for B to be released by T1 (cannot acquire partial locks)
- T3 waits for all items to become available
- No deadlock occurs: transactions wait for all locks or proceed
- Serialization order: T1 → T2 → T3

## Deadlock Prevention Comparison

**Without Conservative 2PL (Potential Deadlock)**:

```
Time | T1                  | T2                  | Status
-----|---------------------|---------------------|------------------------
t1   | lock-X(A)           |                     | T1 holds X(A)
t2   |                     | lock-X(B)           | T2 holds X(B)
t3   | request lock-X(B)   |                     | T1 waits for B
t4   |                     | request lock-X(A)   | T2 waits for A
t5   | [DEADLOCK]          | [DEADLOCK]          | Circular wait: T1→T2→T1
```

**With Conservative 2PL (No Deadlock)**:

```
Time | T1                  | T2                  | Status
-----|---------------------|---------------------|------------------------
t1   | Request X(A), X(B)  |                     | T1 requests all locks
t2   | Acquire X(A), X(B)  |                     | T1 acquires all locks
t3   |                     | Request X(A), X(B)  | T2 requests all locks
t4   |                     | [WAIT]              | T2 waits (A, B held by T1)
t5   | ... operations ...  |                     | T1 executes
t6   | Release all locks   |                     | T1 releases all locks
t7   | commit              |                     | T1 commits
t8   |                     | Acquire X(A), X(B)  | T2 now acquires all locks
t9   |                     | ... operations ...  | T2 executes
```

# Strict Two-Phase Locking (Strict 2PL)

## Definition

Strict 2PL is the most commonly implemented variant in commercial database management systems. It enforces the following rules:

- A transaction must follow basic 2PL (growing and shrinking phases)
- **Additional Constraint**: A transaction must not release any exclusive (write) locks until after it commits or aborts
- Shared (read) locks may be released during the shrinking phase
- All exclusive locks are held until transaction termination

## Key Properties

**Recoverability**: Strict 2PL guarantees a strict schedule, which ensures:
- No cascading rollbacks occur
- A transaction never reads uncommitted data from another transaction
- If transaction T1 writes a value that transaction T2 reads, then T1 must commit before T2 commits

**Guarantees**:
- Serializability (from basic 2PL)
- Recoverability (from holding write locks until commit)
- Avoids cascading aborts

**Trade-offs**:
- Lower concurrency than basic 2PL due to holding write locks longer
- May still experience deadlocks
- Better than basic 2PL for recovery purposes

## Detailed Example: Strict 2PL

Consider a banking scenario with transactions T1 and T2:

**Transaction T1**: Withdraw 100 from Account A and deposit to Account B
```
lock-X(A)
read(A)
A := A - 100
write(A)
lock-X(B)
read(B)
B := B + 100
write(B)
[COMMIT - all locks released here]
unlock(A)
unlock(B)
```

**Transaction T2**: Apply 5% interest to Account A
```
lock-X(A)
read(A)
A := A * 1.05
write(A)
[COMMIT - all locks released here]
unlock(A)
```

**Strict 2PL Schedule**:

```
Time | T1                     | T2                     | Locks T1      | Locks T2      | Data State
-----|------------------------|------------------------|---------------|---------------|------------------
t0   |                        |                        |               |               | A=1000, B=500
t1   | lock-X(A)              |                        | X(A)          |               |
t2   | read(A) [A=1000]       |                        | X(A)          |               |
t3   | A := A - 100           |                        | X(A)          |               |
t4   | write(A) [A=900]       |                        | X(A)          |               | A=900 (uncommitted)
t5   | lock-X(B)              |                        | X(A), X(B)    |               |
t6   | read(B) [B=500]        |                        | X(A), X(B)    |               |
t7   | B := B + 100           |                        | X(A), X(B)    |               |
t8   | write(B) [B=600]       |                        | X(A), X(B)    |               | B=600 (uncommitted)
t9   |                        | lock-X(A)              | X(A), X(B)    | [WAITING]     |
t10  |                        | [BLOCKED by T1]        | X(A), X(B)    | [WAITING]     |
t11  | [processing...]        |                        | X(A), X(B)    | [WAITING]     |
t12  | commit                 |                        |               | [WAITING]     | A=900, B=600 (committed)
t13  | unlock(A)              |                        |               | [WAITING]     |
t14  | unlock(B)              |                        |               | [WAITING]     |
t15  |                        | [UNBLOCKED]            |               | X(A)          |
t16  |                        | read(A) [A=900]        |               | X(A)          |
t17  |                        | A := A * 1.05          |               | X(A)          |
t18  |                        | write(A) [A=945]       |               | X(A)          | A=945 (uncommitted)
t19  |                        | commit                 |               |               | A=945 (committed)
t20  |                        | unlock(A)              |               |               |
```

**Analysis**:
- T1 holds X(A) and X(B) until commit (t12)
- T2 is blocked at t9 when trying to acquire X(A)
- T2 only proceeds after T1 commits and releases locks
- No dirty reads: T2 reads committed value A=900, not uncommitted value
- Serialization order: T1 → T2
- Final state: A=945, B=600 (consistent and recoverable)

## Comparison: Basic 2PL vs Strict 2PL

**Basic 2PL (with early unlock) - Problematic**:

```
Time | T1                     | T2                     | Issue
-----|------------------------|------------------------|---------------------------
t1   | lock-X(A)              |                        |
t2   | write(A) [A=900]       |                        | A updated
t3   | unlock(A)              |                        | EARLY RELEASE (Shrinking phase)
t4   |                        | lock-X(A)              |
t5   |                        | read(A) [A=900]        | DIRTY READ (T1 not committed)
t6   |                        | A := A * 1.05          |
t7   |                        | write(A) [A=945]       |
t8   |                        | commit                 |
t9   | [T1 fails validation]  |                        |
t10  | abort                  |                        | T1 aborts!
t11  | A := 1000 (rollback)   |                        | A restored to 1000
t12  |                        |                        | T2 already committed with wrong value!
```

**Problem**: T2 committed based on dirty data from T1. When T1 aborts, database is inconsistent (A=945 should be A=1050).

**Strict 2PL (correct behavior)**:

```
Time | T1                     | T2                     | Result
-----|------------------------|------------------------|---------------------------
t1   | lock-X(A)              |                        |
t2   | write(A) [A=900]       |                        | A updated
t3   | [HOLD X(A)]            |                        | LOCK HELD until commit
t4   |                        | lock-X(A)              |
t5   |                        | [WAIT]                 | T2 BLOCKS
t6   | commit                 |                        | T1 commits
t7   | unlock(A)              |                        |
t8   |                        | [UNBLOCK]              | T2 proceeds
t9   |                        | read(A) [A=900]        | CLEAN READ (committed data)
t10  |                        | A := A * 1.05          |
t11  |                        | write(A) [A=945]       |
t12  |                        | commit                 | Correct result
```

**Result**: T2 reads only committed data, ensuring recoverability and consistency.

## SQL Example: Strict 2PL in PostgreSQL

```sql
-- PostgreSQL uses Strict 2PL internally for REPEATABLE READ and SERIALIZABLE

-- Session 1: T1 - Transfer funds
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Acquire X(accounts) for account_id='A001'
UPDATE accounts SET balance = balance - 100
WHERE account_id = 'A001';
-- X-lock acquired on A001, held until commit

-- Simulate processing time
SELECT pg_sleep(5);

-- Acquire X(accounts) for account_id='B001'
UPDATE accounts SET balance = balance + 100
WHERE account_id = 'B001';
-- X-lock acquired on B001, held until commit

-- Both X-locks held here until commit
COMMIT;
-- X-locks on A001 and B001 released here


-- Session 2: T2 - Apply interest (blocks until T1 commits)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Try to acquire X(accounts) for account_id='A001'
UPDATE accounts SET balance = balance * 1.05
WHERE account_id = 'A001';
-- This blocks if T1 holds X-lock on A001
-- Proceeds only after T1 commits

COMMIT;
-- X-lock on A001 released here
```

# Rigorous Two-Phase Locking (Rigorous 2PL)

## Definition

Rigorous 2PL is the strictest variant of two-phase locking. It enforces:

- A transaction must follow basic 2PL
- **Additional Constraint**: A transaction must not release any locks (shared or exclusive) until after it commits or aborts
- All locks are held until transaction termination
- Simplifies the protocol by eliminating the traditional shrinking phase

## Key Properties

**Maximum Isolation**: Rigorous 2PL provides:
- Serializability (from basic 2PL)
- Strict recoverability (no cascading aborts)
- Serialization order equivalent to commit order
- Simplest implementation: all locks released atomically at commit

**Trade-offs**:
- Lowest concurrency among all 2PL variants
- Highest lock holding time
- Simplest recovery mechanism
- May cause significant blocking in high-concurrency environments

## Detailed Example: Rigorous 2PL

Consider a scenario with three transactions accessing a library database:

**Transaction T1**: Check out book B1, update inventory
```
lock-S(B1)    -- read book details
lock-X(INV)   -- update inventory
read(B1)
read(INV)
INV := INV - 1
write(INV)
[COMMIT - all locks released]
```

**Transaction T2**: Reserve book B1 for another patron
```
lock-S(B1)    -- read book details
lock-X(RES)   -- create reservation
read(B1)
read(RES)
RES := RES + 1
write(RES)
[COMMIT - all locks released]
```

**Transaction T3**: Generate inventory report
```
lock-S(B1)    -- read book details
lock-S(INV)   -- read inventory
lock-S(RES)   -- read reservations
read(B1)
read(INV)
read(RES)
[COMMIT - all locks released]
```

**Rigorous 2PL Schedule**:

```
Time | T1                      | T2                      | T3                      | Locks T1         | Locks T2         | Locks T3
-----|-------------------------|-------------------------|-------------------------|------------------|------------------|------------------
t0   |                         |                         |                         |                  |                  | B1: {avail: 1, reserved: 0}
t1   | lock-S(B1)              |                         |                         | S(B1)            |                  |
t2   | read(B1) [title]        |                         |                         | S(B1)            |                  |
t3   |                         | lock-S(B1)              |                         | S(B1)            | S(B1)            | Both hold S(B1)
t4   |                         | read(B1) [title]        |                         | S(B1)            | S(B1)            |
t5   | lock-X(INV)             |                         |                         | S(B1), X(INV)    | S(B1)            |
t6   | read(INV) [avail=1]     |                         |                         | S(B1), X(INV)    | S(B1)            |
t7   | INV := INV - 1          |                         |                         | S(B1), X(INV)    | S(B1)            |
t8   | write(INV) [avail=0]    |                         |                         | S(B1), X(INV)    | S(B1)            |
t9   |                         | lock-X(RES)             |                         | S(B1), X(INV)    | S(B1), X(RES)    |
t10  |                         | read(RES) [reserved=0]  |                         | S(B1), X(INV)    | S(B1), X(RES)    |
t11  |                         | RES := RES + 1          |                         | S(B1), X(INV)    | S(B1), X(RES)    |
t12  |                         | write(RES) [reserved=1] |                         | S(B1), X(INV)    | S(B1), X(RES)    |
t13  |                         |                         | lock-S(B1)              | S(B1), X(INV)    | S(B1), X(RES)    | [GRANTED]
t14  |                         |                         | lock-S(INV)             | S(B1), X(INV)    | S(B1), X(RES)    | [WAIT - X(INV) held by T1]
t15  | [HOLD ALL LOCKS]        | [HOLD ALL LOCKS]        | [BLOCKED]               | S(B1), X(INV)    | S(B1), X(RES)    | S(B1)
t16  | commit                  |                         | [STILL BLOCKED]         |                  | S(B1), X(RES)    | S(B1)
t17  | unlock(B1)              |                         | [STILL BLOCKED]         |                  | S(B1), X(RES)    | S(B1)
t18  | unlock(INV)             |                         | [PARTIALLY UNBLOCKED]   |                  | S(B1), X(RES)    | S(B1)
t19  |                         |                         | lock-S(INV) [GRANTED]   |                  | S(B1), X(RES)    | S(B1), S(INV)
t20  |                         |                         | lock-S(RES)             |                  | S(B1), X(RES)    | [WAIT - X(RES) held by T2]
t21  |                         | [HOLD ALL LOCKS]        | [BLOCKED]               |                  | S(B1), X(RES)    | S(B1), S(INV)
t22  |                         | commit                  | [UNBLOCKED]             |                  |                  | S(B1), S(INV)
t23  |                         | unlock(B1)              |                         |                  |                  | S(B1), S(INV)
t24  |                         | unlock(RES)             |                         |                  |                  | S(B1), S(INV)
t25  |                         |                         | lock-S(RES) [GRANTED]   |                  |                  | S(B1), S(INV), S(RES)
t26  |                         |                         | read(B1)                |                  |                  | S(B1), S(INV), S(RES)
t27  |                         |                         | read(INV) [avail=0]     |                  |                  | S(B1), S(INV), S(RES)
t28  |                         |                         | read(RES) [reserved=1]  |                  |                  | S(B1), S(INV), S(RES)
t29  |                         |                         | commit                  |                  |                  |
t30  |                         |                         | unlock(B1)              |                  |                  |
t31  |                         |                         | unlock(INV)             |                  |                  |
t32  |                         |                         | unlock(RES)             |                  |                  |
```

**Analysis**:
- T1 holds S(B1) and X(INV) until commit at t16
- T2 holds S(B1) and X(RES) until commit at t22
- T3 must wait for both T1 and T2 to commit before acquiring all necessary locks
- Serialization order matches commit order: T1 → T2 → T3
- T3 reads fully consistent snapshot after both updates are committed
- Final state: available=0, reserved=1 (consistent)

## Rigorous 2PL vs Strict 2PL

**Key Difference**:
- Strict 2PL: Only exclusive locks held until commit
- Rigorous 2PL: All locks (shared and exclusive) held until commit

**Scenario Illustrating the Difference**:

**Strict 2PL**:
```
Time | T1                     | T2                     | Locks T1       | Locks T2
-----|------------------------|------------------------|----------------|----------------
t1   | lock-S(A)              |                        | S(A)           |
t2   | read(A)                |                        | S(A)           |
t3   | lock-X(B)              |                        | S(A), X(B)     |
t4   | write(B)               |                        | S(A), X(B)     |
t5   | unlock(A)              |                        | X(B)           | S-lock released early
t6   |                        | lock-X(A)              | X(B)           | X(A)
t7   |                        | write(A)               | X(B)           | X(A)
t8   | commit                 |                        |                | X(A)
t9   | unlock(B)              |                        |                | X(A)
t10  |                        | commit                 |                |
t11  |                        | unlock(A)              |                |
```

In Strict 2PL, T1 releases S(A) early (t5), allowing T2 to acquire X(A) (t6) before T1 commits.

**Rigorous 2PL**:
```
Time | T1                     | T2                     | Locks T1       | Locks T2
-----|------------------------|------------------------|----------------|----------------
t1   | lock-S(A)              |                        | S(A)           |
t2   | read(A)                |                        | S(A)           |
t3   | lock-X(B)              |                        | S(A), X(B)     |
t4   | write(B)               |                        | S(A), X(B)     |
t5   | [HOLD S(A)]            |                        | S(A), X(B)     | S-lock held
t6   |                        | lock-X(A)              | S(A), X(B)     | [WAIT]
t7   |                        | [BLOCKED]              | S(A), X(B)     | [WAIT]
t8   | commit                 |                        |                | [WAIT]
t9   | unlock(A)              |                        |                | [WAIT]
t10  | unlock(B)              |                        |                |
t11  |                        | [UNBLOCKED]            |                | X(A)
t12  |                        | write(A)               |                | X(A)
t13  |                        | commit                 |                |
t14  |                        | unlock(A)              |                |
```

In Rigorous 2PL, T1 holds S(A) until commit (t8), blocking T2's attempt to acquire X(A) until T1 fully commits.

**Benefit**: Rigorous 2PL ensures strict serialization order equals commit order, simplifying recovery and reasoning about transaction behavior.

# Lock Conversion in Two-Phase Locking

## Lock Upgrade

**Definition**: Converting a shared lock to an exclusive lock on the same data item.

**Rule in 2PL**: Lock upgrades must occur during the growing phase only.

**Scenario**: A transaction reads a data item to check a condition, then decides to write based on that condition.

```
lock-S(X)
read(X)
if (X > 100) then
    upgrade-lock(X)  -- S(X) → X(X)
    write(X)
```

**Detailed Example**:

```
Transaction T1: Update product price if current price is below threshold

Time | Operation                | Lock Status | Data
-----|--------------------------|-------------|------------------
t1   | lock-S(product_123)      | S(product)  |
t2   | read(product_123.price)  | S(product)  | price = 50
t3   | if price < 75:           | S(product)  | condition: true
t4   | upgrade to X(product_123)| X(product)  | [Growing phase]
t5   | price := 75              | X(product)  |
t6   | write(product_123.price) | X(product)  | price = 75
t7   | commit                   |             |
t8   | unlock(product_123)      |             |
```

**Potential Issue - Upgrade Deadlock**:

```
Time | T1                       | T2                       | Locks T1    | Locks T2
-----|--------------------------|--------------------------|-------------|-------------
t1   | lock-S(X)                |                          | S(X)        |
t2   |                          | lock-S(X)                | S(X)        | S(X)
t3   | read(X)                  |                          | S(X)        | S(X)
t4   |                          | read(X)                  | S(X)        | S(X)
t5   | upgrade-lock(X)          |                          | [WAIT]      | S(X)
t6   |                          | upgrade-lock(X)          | [WAIT]      | [WAIT]
t7   | [DEADLOCK]               | [DEADLOCK]               |             |
```

Both transactions hold S(X) and wait for the other to release it before upgrading to X(X). This is a conversion deadlock.

## Lock Downgrade

**Definition**: Converting an exclusive lock to a shared lock on the same data item.

**Rule in 2PL**: Lock downgrades must occur during the shrinking phase only.

**Scenario**: A transaction writes to a data item early, then continues reading it without preventing concurrent readers.

```
lock-X(X)
write(X)
downgrade-lock(X)  -- X(X) → S(X)
read(X)
read(X)
unlock(X)
```

**Detailed Example**:

```
Transaction T1: Update statistics then generate report

Time | Operation                     | Lock Status | Phase      | Notes
-----|-------------------------------|-------------|------------|----------------------
t1   | lock-X(statistics)            | X(stats)    | Growing    |
t2   | read(statistics.total)        | X(stats)    | Growing    | total = 1000
t3   | total := total + 50           | X(stats)    | Growing    |
t4   | write(statistics.total)       | X(stats)    | Growing    | total = 1050
t5   | downgrade to S(statistics)    | S(stats)    | Shrinking  | [Lock point]
t6   | read(statistics.total)        | S(stats)    | Shrinking  | total = 1050
t7   | read(statistics.count)        | S(stats)    | Shrinking  | count = 100
t8   | avg := total / count          | S(stats)    | Shrinking  |
t9   | commit                        |             |            |
t10  | unlock(statistics)            |             |            |
```

At t5, T1 downgrades from X(stats) to S(stats), allowing other transactions to read statistics concurrently while T1 continues its report generation.

**Benefit**: Increases concurrency by allowing concurrent readers after write operations complete.

# Deadlock in Two-Phase Locking

## Fundamental Issue

Two-Phase Locking protocols (except Conservative 2PL) do not prevent deadlocks. Deadlocks occur when transactions form a circular wait chain for locks.

## Deadlock Scenario Example

**Classic Deadlock with Two Transactions**:

```
Initial State: A = 100, B = 200

Transaction T1: Transfer 50 from A to B
Transaction T2: Transfer 30 from B to A
```

**Schedule Leading to Deadlock**:

```
Time | T1                    | T2                    | Locks T1  | Locks T2  | Status
-----|-----------------------|-----------------------|-----------|-----------|------------------
t1   | lock-X(A)             |                       | X(A)      |           | T1 holds X(A)
t2   | read(A) [A=100]       |                       | X(A)      |           |
t3   | A := A - 50           |                       | X(A)      |           |
t4   | write(A) [A=50]       |                       | X(A)      |           |
t5   |                       | lock-X(B)             | X(A)      | X(B)      | T2 holds X(B)
t6   |                       | read(B) [B=200]       | X(A)      | X(B)      |
t7   |                       | B := B - 30           | X(A)      | X(B)      |
t8   |                       | write(B) [B=170]      | X(A)      | X(B)      |
t9   | lock-X(B)             |                       | X(A)      | X(B)      | T1 WAITS for B
t10  | [WAIT for T2]         |                       | X(A)      | X(B)      | T1 blocked
t11  |                       | lock-X(A)             | X(A)      | X(B)      | T2 WAITS for A
t12  |                       | [WAIT for T1]         | X(A)      | X(B)      | T2 blocked
t13  | [DEADLOCK DETECTED]   | [DEADLOCK DETECTED]   |           |           | Circular wait
```

**Wait-For Graph**:
```
T1 → T2  (T1 waits for T2 to release B)
T2 → T1  (T2 waits for T1 to release A)

Cycle detected: T1 → T2 → T1
```

**Resolution**: DBMS must abort one transaction (typically T2, the younger transaction) and roll it back, breaking the cycle.

## Complex Deadlock with Multiple Transactions

```
Three Transactions: T1, T2, T3
Data Items: A, B, C

T1: Needs A, then B
T2: Needs B, then C
T3: Needs C, then A
```

**Schedule**:

```
Time | T1          | T2          | T3          | Locks T1 | Locks T2 | Locks T3
-----|-------------|-------------|-------------|----------|----------|----------
t1   | lock-X(A)   |             |             | X(A)     |          |
t2   |             | lock-X(B)   |             | X(A)     | X(B)     |
t3   |             |             | lock-X(C)   | X(A)     | X(B)     | X(C)
t4   | lock-X(B)   |             |             | X(A)     | X(B)     | X(C)
t5   | [WAIT]      |             |             | X(A)     | X(B)     | X(C)
t6   |             | lock-X(C)   |             | X(A)     | X(B)     | X(C)
t7   |             | [WAIT]      |             | X(A)     | X(B)     | X(C)
t8   |             |             | lock-X(A)   | X(A)     | X(B)     | X(C)
t9   |             |             | [WAIT]      | X(A)     | X(B)     | X(C)
t10  | [DEADLOCK - Circular Wait]
```

**Wait-For Graph**:
```
T1 → T2  (T1 waits for B held by T2)
T2 → T3  (T2 waits for C held by T3)
T3 → T1  (T3 waits for A held by T1)

Cycle: T1 → T2 → T3 → T1
```

## Deadlock Detection and Resolution

**Deadlock Detection**: DBMS periodically constructs a wait-for graph and checks for cycles using depth-first search or other graph algorithms.

**Victim Selection Criteria**:
1. Transaction with least work done (minimize rollback cost)
2. Youngest transaction (minimize wasted work)
3. Transaction holding fewest locks
4. Transaction with lowest priority

**Example Resolution**:
```
Detected deadlock: T1 → T2 → T1

Option 1: Abort T2 (younger transaction)
- T1 proceeds to acquire B
- T2 rolled back completely
- T2 restarted after T1 commits

Option 2: Abort T1 (holds fewer locks)
- T2 proceeds to acquire A
- T1 rolled back completely
- T1 restarted after T2 commits
```

## Deadlock Prevention Techniques

**1. Lock Ordering**: Acquire locks in a predefined order
```
Rule: Always lock items in alphabetical order

T1: lock(A), then lock(B)
T2: lock(A), then lock(B)  -- Both lock A first

Result: T2 waits for T1 to release A, no circular wait possible
```

**2. Timeout-Based**: Abort transaction if lock wait exceeds threshold
```sql
SET lock_timeout = 5000;  -- 5 seconds in PostgreSQL

BEGIN;
-- If lock wait exceeds 5 seconds, transaction aborts automatically
UPDATE accounts SET balance = balance - 100 WHERE account_id = 'A001';
COMMIT;
```

**3. Wait-Die and Wound-Wait Schemes**:

**Wait-Die** (Non-preemptive):
- Older transaction waits for younger transaction
- Younger transaction dies (aborts) if it requests lock held by older transaction
```
T1 (timestamp=100) requests lock held by T2 (timestamp=200)
→ T1 waits (older waits for younger)

T2 (timestamp=200) requests lock held by T1 (timestamp=100)
→ T2 dies (younger aborts when requesting from older)
```

**Wound-Wait** (Preemptive):
- Older transaction wounds (aborts) younger transaction
- Younger transaction waits for older transaction
```
T1 (timestamp=100) requests lock held by T2 (timestamp=200)
→ T1 wounds T2 (older preempts younger)
→ T2 aborts, T1 acquires lock

T2 (timestamp=200) requests lock held by T1 (timestamp=100)
→ T2 waits (younger waits for older)
```

# Comparison of 2PL Variants

## Summary Table

| Feature                  | Basic 2PL      | Conservative 2PL | Strict 2PL     | Rigorous 2PL   |
|--------------------------|----------------|------------------|----------------|----------------|
| Serializability          | Yes            | Yes              | Yes            | Yes            |
| Deadlock-free            | No             | Yes              | No             | No             |
| Cascading aborts         | Possible       | No               | No             | No             |
| Lock all upfront         | No             | Yes              | No             | No             |
| Hold X-locks until commit| No             | Yes              | Yes            | Yes            |
| Hold S-locks until commit| No             | Yes              | No             | Yes            |
| Concurrency              | High           | Low              | Medium         | Low            |
| Implementation complexity| Low            | High             | Medium         | Low            |
| Recovery complexity      | High           | Low              | Low            | Low            |
| Common in practice       | Rare           | Rare             | Very common    | Rare           |

## Detailed Comparison with Example

**Scenario**: Three transactions accessing shared data

```
T1: read(A), write(B)
T2: read(B), write(C)
T3: read(A), read(B), read(C)
```

**Basic 2PL**:
```
T1: lock-S(A), read(A), unlock(A), lock-X(B), write(B), unlock(B), commit
T2: lock-S(B), read(B), unlock(B), lock-X(C), write(C), unlock(C), commit
T3: lock-S(A), read(A), lock-S(B), read(B), lock-S(C), read(C), unlock(A), unlock(B), unlock(C), commit

Concurrency: High (locks released early)
Risk: Cascading aborts if T1 or T2 abort after releasing locks
```

**Conservative 2PL**:
```
T1: lock-S(A), lock-X(B), read(A), write(B), unlock(A), unlock(B), commit
T2: lock-S(B), lock-X(C), read(B), write(C), unlock(B), unlock(C), commit
T3: lock-S(A), lock-S(B), lock-S(C), read(A), read(B), read(C), unlock(A), unlock(B), unlock(C), commit

Concurrency: Low (T2 and T3 must wait for all locks)
Benefit: No deadlocks (all locks acquired atomically)
```

**Strict 2PL**:
```
T1: lock-S(A), read(A), unlock(A), lock-X(B), write(B), commit, unlock(B)
T2: lock-S(B), read(B), unlock(B), lock-X(C), write(C), commit, unlock(C)
T3: lock-S(A), read(A), lock-S(B), read(B), lock-S(C), read(C), commit, unlock(A), unlock(B), unlock(C)

Concurrency: Medium (X-locks held until commit, S-locks released early)
Benefit: No cascading aborts (X-locks held until commit)
```

**Rigorous 2PL**:
```
T1: lock-S(A), read(A), lock-X(B), write(B), commit, unlock(A), unlock(B)
T2: lock-S(B), read(B), lock-X(C), write(C), commit, unlock(B), unlock(C)
T3: lock-S(A), read(A), lock-S(B), read(B), lock-S(C), read(C), commit, unlock(A), unlock(B), unlock(C)

Concurrency: Low (all locks held until commit)
Benefit: Serialization order = commit order (simplifies reasoning)
```

## Performance Characteristics

**Throughput Comparison** (Relative, assuming 100 transactions/second baseline):

```
Conservative 2PL:  60-70 TPS   (low due to lock all upfront)
Rigorous 2PL:      70-80 TPS   (low due to hold all locks)
Strict 2PL:        85-95 TPS   (medium, holds only X-locks)
Basic 2PL:         95-100 TPS  (high but with recovery risks)
```

**Lock Hold Time**:
```
Time →

Basic 2PL:       |====(lock)===|........(released early).........
Strict 2PL:      |====(S-lock)==|...|====(X-lock until commit)====|
Rigorous 2PL:    |====(all locks held until commit)==============|
Conservative 2PL:|====(all locked from start)====================|
```

# Implementation Examples

## Python Implementation with Explicit Lock Management

```python
from enum import Enum
from typing import Dict, Set, Optional
from threading import Lock as ThreadLock
import time

class LockMode(Enum):
    SHARED = "S"
    EXCLUSIVE = "X"

class TransactionPhase(Enum):
    GROWING = "GROWING"
    SHRINKING = "SHRINKING"
    COMPLETED = "COMPLETED"

class Transaction:
    def __init__(self, tx_id: str):
        self.tx_id = tx_id
        self.locks_held: Dict[str, LockMode] = {}
        self.phase = TransactionPhase.GROWING
        self.lock_point_time: Optional[float] = None

    def enter_shrinking_phase(self):
        if self.phase == TransactionPhase.GROWING:
            self.phase = TransactionPhase.SHRINKING
            self.lock_point_time = time.time()
            print(f"[{self.tx_id}] Entered SHRINKING phase (lock point)")

class TwoPlLockManager:
    def __init__(self, strict_mode: bool = False, rigorous_mode: bool = False):
        self.strict_mode = strict_mode
        self.rigorous_mode = rigorous_mode

        # Lock table: item_id -> {'mode': LockMode, 'holders': Set[tx_id]}
        self.lock_table: Dict[str, Dict] = {}
        self.lock = ThreadLock()

        # Track transactions
        self.transactions: Dict[str, Transaction] = {}

    def begin_transaction(self, tx_id: str) -> Transaction:
        """Start a new transaction."""
        tx = Transaction(tx_id)
        self.transactions[tx_id] = tx
        print(f"[{tx_id}] Transaction STARTED")
        return tx

    def acquire_lock(self, tx_id: str, item_id: str, mode: LockMode) -> bool:
        """Acquire a lock following 2PL rules."""
        tx = self.transactions[tx_id]

        # Check 2PL constraint: no lock acquisition in shrinking phase
        if tx.phase == TransactionPhase.SHRINKING:
            raise Exception(
                f"[{tx_id}] 2PL VIOLATION: Cannot acquire lock in SHRINKING phase"
            )

        with self.lock:
            # Check if already holding this lock
            if item_id in tx.locks_held:
                current_mode = tx.locks_held[item_id]
                if current_mode == mode:
                    print(f"[{tx_id}] Already holds {mode.value}-lock on {item_id}")
                    return True
                elif current_mode == LockMode.EXCLUSIVE:
                    print(f"[{tx_id}] Already holds X-lock on {item_id} (stronger than {mode.value})")
                    return True
                elif current_mode == LockMode.SHARED and mode == LockMode.EXCLUSIVE:
                    # Lock upgrade
                    return self._upgrade_lock(tx_id, item_id)

            # Check compatibility
            if not self._is_compatible(item_id, tx_id, mode):
                print(f"[{tx_id}] WAITING for {mode.value}-lock on {item_id}")
                return False

            # Grant lock
            if item_id not in self.lock_table:
                self.lock_table[item_id] = {'mode': mode, 'holders': set()}

            if mode == LockMode.EXCLUSIVE:
                self.lock_table[item_id]['mode'] = LockMode.EXCLUSIVE
                self.lock_table[item_id]['holders'] = {tx_id}
            else:  # SHARED
                if item_id not in self.lock_table or not self.lock_table[item_id]['holders']:
                    self.lock_table[item_id]['mode'] = LockMode.SHARED
                self.lock_table[item_id]['holders'].add(tx_id)

            tx.locks_held[item_id] = mode
            print(f"[{tx_id}] Acquired {mode.value}-lock on {item_id} (Phase: {tx.phase.value})")
            return True

    def _upgrade_lock(self, tx_id: str, item_id: str) -> bool:
        """Upgrade S-lock to X-lock."""
        tx = self.transactions[tx_id]

        # Must be in growing phase for upgrade
        if tx.phase != TransactionPhase.GROWING:
            raise Exception(
                f"[{tx_id}] 2PL VIOLATION: Lock upgrade must occur in GROWING phase"
            )

        # Check if other transactions hold S-locks
        holders = self.lock_table[item_id]['holders']
        if len(holders) > 1:
            print(f"[{tx_id}] WAITING to upgrade {item_id} (other S-locks held)")
            return False

        # Upgrade
        self.lock_table[item_id]['mode'] = LockMode.EXCLUSIVE
        tx.locks_held[item_id] = LockMode.EXCLUSIVE
        print(f"[{tx_id}] UPGRADED S-lock to X-lock on {item_id}")
        return True

    def _is_compatible(self, item_id: str, tx_id: str, mode: LockMode) -> bool:
        """Check if lock request is compatible with existing locks."""
        if item_id not in self.lock_table:
            return True

        lock_info = self.lock_table[item_id]
        holders = lock_info['holders']

        if not holders:
            return True

        # If requesting transaction already holds a lock
        if tx_id in holders:
            return True

        # Check compatibility
        current_mode = lock_info['mode']

        if mode == LockMode.SHARED and current_mode == LockMode.SHARED:
            return True  # Multiple S-locks compatible

        return False  # X-lock or conflicting modes

    def release_lock(self, tx_id: str, item_id: str):
        """Release a lock following 2PL rules."""
        tx = self.transactions[tx_id]

        # Check if holding this lock
        if item_id not in tx.locks_held:
            raise Exception(f"[{tx_id}] Does not hold lock on {item_id}")

        lock_mode = tx.locks_held[item_id]

        # Check mode-specific constraints
        if self.rigorous_mode:
            raise Exception(
                f"[{tx_id}] RIGOROUS 2PL: Cannot release any lock before commit"
            )
        elif self.strict_mode and lock_mode == LockMode.EXCLUSIVE:
            raise Exception(
                f"[{tx_id}] STRICT 2PL: Cannot release X-lock before commit"
            )

        # Enter shrinking phase if this is first unlock
        if tx.phase == TransactionPhase.GROWING:
            tx.enter_shrinking_phase()

        with self.lock:
            # Remove from lock table
            self.lock_table[item_id]['holders'].remove(tx_id)
            if not self.lock_table[item_id]['holders']:
                del self.lock_table[item_id]

            # Remove from transaction's locks
            del tx.locks_held[item_id]

            print(f"[{tx_id}] Released {lock_mode.value}-lock on {item_id} (Phase: {tx.phase.value})")

    def commit(self, tx_id: str):
        """Commit transaction and release all locks."""
        tx = self.transactions[tx_id]

        with self.lock:
            # Release all remaining locks
            items_locked = list(tx.locks_held.keys())
            for item_id in items_locked:
                lock_mode = tx.locks_held[item_id]

                self.lock_table[item_id]['holders'].remove(tx_id)
                if not self.lock_table[item_id]['holders']:
                    del self.lock_table[item_id]

                print(f"[{tx_id}] Released {lock_mode.value}-lock on {item_id} at COMMIT")

            tx.locks_held.clear()
            tx.phase = TransactionPhase.COMPLETED

            print(f"[{tx_id}] Transaction COMMITTED")

# Example usage: Basic 2PL
def example_basic_2pl():
    print("\n=== BASIC 2PL EXAMPLE ===\n")

    manager = TwoPlLockManager(strict_mode=False, rigorous_mode=False)

    # Transaction T1: Transfer from A to B
    t1 = manager.begin_transaction("T1")
    manager.acquire_lock("T1", "A", LockMode.EXCLUSIVE)
    print("T1: read(A), A := A - 100, write(A)")
    manager.acquire_lock("T1", "B", LockMode.EXCLUSIVE)
    print("T1: read(B), B := B + 100, write(B)")

    # T1 releases A early (enters shrinking phase)
    manager.release_lock("T1", "A")

    # Transaction T2: Read A
    t2 = manager.begin_transaction("T2")
    manager.acquire_lock("T2", "A", LockMode.SHARED)
    print("T2: read(A)")

    # T1 finishes
    manager.commit("T1")

    # T2 finishes
    manager.commit("T2")

    print("\n2PL ensured serializability: T1 → T2")

# Example usage: Strict 2PL
def example_strict_2pl():
    print("\n=== STRICT 2PL EXAMPLE ===\n")

    manager = TwoPlLockManager(strict_mode=True, rigorous_mode=False)

    # Transaction T1
    t1 = manager.begin_transaction("T1")
    manager.acquire_lock("T1", "A", LockMode.EXCLUSIVE)
    print("T1: write(A)")
    manager.acquire_lock("T1", "B", LockMode.SHARED)
    print("T1: read(B)")

    # T1 can release S-lock on B
    manager.release_lock("T1", "B")

    # T1 cannot release X-lock on A before commit
    try:
        manager.release_lock("T1", "A")
    except Exception as e:
        print(f"Expected error: {e}")

    # T1 must commit to release X-lock
    manager.commit("T1")

# Example usage: Rigorous 2PL
def example_rigorous_2pl():
    print("\n=== RIGOROUS 2PL EXAMPLE ===\n")

    manager = TwoPlLockManager(strict_mode=False, rigorous_mode=True)

    # Transaction T1
    t1 = manager.begin_transaction("T1")
    manager.acquire_lock("T1", "A", LockMode.SHARED)
    print("T1: read(A)")
    manager.acquire_lock("T1", "B", LockMode.EXCLUSIVE)
    print("T1: write(B)")

    # T1 cannot release any lock before commit
    try:
        manager.release_lock("T1", "A")
    except Exception as e:
        print(f"Expected error: {e}")

    # T1 must commit to release all locks
    manager.commit("T1")

if __name__ == "__main__":
    example_basic_2pl()
    example_strict_2pl()
    example_rigorous_2pl()
```

## Java Implementation with Database-Style Lock Manager

```java
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;

enum LockMode {
    SHARED, EXCLUSIVE
}

enum TransactionPhase {
    GROWING, SHRINKING, COMPLETED
}

enum TwoPLVariant {
    BASIC, STRICT, RIGOROUS, CONSERVATIVE
}

class LockRequest {
    String transactionId;
    String itemId;
    LockMode mode;
    long timestamp;

    public LockRequest(String transactionId, String itemId, LockMode mode) {
        this.transactionId = transactionId;
        this.itemId = itemId;
        this.mode = mode;
        this.timestamp = System.currentTimeMillis();
    }
}

class Transaction {
    String id;
    TransactionPhase phase;
    Map<String, LockMode> locksHeld;
    long lockPointTime;

    public Transaction(String id) {
        this.id = id;
        this.phase = TransactionPhase.GROWING;
        this.locksHeld = new HashMap<>();
        this.lockPointTime = -1;
    }

    public void enterShrinkingPhase() {
        if (this.phase == TransactionPhase.GROWING) {
            this.phase = TransactionPhase.SHRINKING;
            this.lockPointTime = System.currentTimeMillis();
            System.out.println("[" + id + "] Entered SHRINKING phase (lock point)");
        }
    }
}

class LockTableEntry {
    LockMode mode;
    Set<String> holders;
    Queue<LockRequest> waitQueue;

    public LockTableEntry() {
        this.holders = new HashSet<>();
        this.waitQueue = new LinkedList<>();
    }
}

public class TwoPhaseLockingManager {
    private TwoPLVariant variant;
    private Map<String, LockTableEntry> lockTable;
    private Map<String, Transaction> transactions;
    private ReentrantLock managerLock;

    // Wait-for graph for deadlock detection
    private Map<String, Set<String>> waitForGraph;

    public TwoPhaseLockingManager(TwoPLVariant variant) {
        this.variant = variant;
        this.lockTable = new ConcurrentHashMap<>();
        this.transactions = new ConcurrentHashMap<>();
        this.managerLock = new ReentrantLock();
        this.waitForGraph = new HashMap<>();
    }

    public Transaction beginTransaction(String txId) {
        Transaction tx = new Transaction(txId);
        transactions.put(txId, tx);
        waitForGraph.put(txId, new HashSet<>());
        System.out.println("[" + txId + "] Transaction STARTED (" + variant + " 2PL)");
        return tx;
    }

    public boolean acquireLock(String txId, String itemId, LockMode mode)
            throws IllegalStateException {
        Transaction tx = transactions.get(txId);

        // Conservative 2PL: All locks must be acquired upfront
        if (variant == TwoPLVariant.CONSERVATIVE) {
            throw new IllegalStateException(
                "[" + txId + "] CONSERVATIVE 2PL: Use acquireAllLocks() instead"
            );
        }

        // Check 2PL constraint
        if (tx.phase == TransactionPhase.SHRINKING) {
            throw new IllegalStateException(
                "[" + txId + "] 2PL VIOLATION: Cannot acquire lock in SHRINKING phase"
            );
        }

        managerLock.lock();
        try {
            // Check if already holding this lock
            if (tx.locksHeld.containsKey(itemId)) {
                LockMode current = tx.locksHeld.get(itemId);
                if (current == mode || current == LockMode.EXCLUSIVE) {
                    return true;
                }
                // Upgrade S → X
                if (current == LockMode.SHARED && mode == LockMode.EXCLUSIVE) {
                    return upgradeLock(txId, itemId);
                }
            }

            // Check compatibility
            if (!isCompatible(itemId, txId, mode)) {
                // Add to wait queue
                LockTableEntry entry = lockTable.get(itemId);
                entry.waitQueue.add(new LockRequest(txId, itemId, mode));

                // Update wait-for graph
                for (String holder : entry.holders) {
                    if (!holder.equals(txId)) {
                        waitForGraph.get(txId).add(holder);
                    }
                }

                // Check for deadlock
                if (detectDeadlock(txId)) {
                    System.out.println("[" + txId + "] DEADLOCK DETECTED - Aborting");
                    abort(txId);
                    return false;
                }

                System.out.println("[" + txId + "] WAITING for " + mode + "-lock on " + itemId);
                return false;
            }

            // Grant lock
            grantLock(txId, itemId, mode);
            return true;

        } finally {
            managerLock.unlock();
        }
    }

    public boolean acquireAllLocks(String txId, Set<String> readSet, Set<String> writeSet) {
        Transaction tx = transactions.get(txId);

        if (variant != TwoPLVariant.CONSERVATIVE) {
            throw new IllegalStateException(
                "acquireAllLocks() only for CONSERVATIVE 2PL"
            );
        }

        managerLock.lock();
        try {
            // Check if all locks are available
            Set<String> allItems = new HashSet<>();
            allItems.addAll(readSet);
            allItems.addAll(writeSet);

            for (String item : allItems) {
                LockMode mode = writeSet.contains(item) ? LockMode.EXCLUSIVE : LockMode.SHARED;
                if (!isCompatible(item, txId, mode)) {
                    System.out.println("[" + txId + "] Waiting for all locks (CONSERVATIVE 2PL)");
                    return false;
                }
            }

            // Acquire all locks atomically
            for (String item : readSet) {
                grantLock(txId, item, LockMode.SHARED);
            }
            for (String item : writeSet) {
                grantLock(txId, item, LockMode.EXCLUSIVE);
            }

            System.out.println("[" + txId + "] Acquired ALL locks (CONSERVATIVE 2PL)");
            return true;

        } finally {
            managerLock.unlock();
        }
    }

    private boolean upgradeLock(String txId, String itemId) {
        Transaction tx = transactions.get(txId);

        // Must be in growing phase
        if (tx.phase != TransactionPhase.GROWING) {
            throw new IllegalStateException(
                "[" + txId + "] Lock upgrade must occur in GROWING phase"
            );
        }

        LockTableEntry entry = lockTable.get(itemId);

        // Check if only this transaction holds the S-lock
        if (entry.holders.size() > 1) {
            System.out.println("[" + txId + "] WAITING to upgrade " + itemId);
            return false;
        }

        // Upgrade
        entry.mode = LockMode.EXCLUSIVE;
        tx.locksHeld.put(itemId, LockMode.EXCLUSIVE);
        System.out.println("[" + txId + "] UPGRADED S-lock to X-lock on " + itemId);
        return true;
    }

    private void grantLock(String txId, String itemId, LockMode mode) {
        Transaction tx = transactions.get(txId);

        lockTable.putIfAbsent(itemId, new LockTableEntry());
        LockTableEntry entry = lockTable.get(itemId);

        entry.mode = mode;
        entry.holders.add(txId);
        tx.locksHeld.put(itemId, mode);

        System.out.println("[" + txId + "] Acquired " + mode + "-lock on " + itemId +
                         " (Phase: " + tx.phase + ")");
    }

    private boolean isCompatible(String itemId, String txId, LockMode mode) {
        if (!lockTable.containsKey(itemId)) {
            return true;
        }

        LockTableEntry entry = lockTable.get(itemId);

        if (entry.holders.isEmpty()) {
            return true;
        }

        if (entry.holders.contains(txId)) {
            return true;
        }

        // Check compatibility
        if (mode == LockMode.SHARED && entry.mode == LockMode.SHARED) {
            return true;
        }

        return false;
    }

    public void releaseLock(String txId, String itemId) {
        Transaction tx = transactions.get(txId);

        if (!tx.locksHeld.containsKey(itemId)) {
            throw new IllegalStateException(
                "[" + txId + "] Does not hold lock on " + itemId
            );
        }

        LockMode lockMode = tx.locksHeld.get(itemId);

        // Check variant-specific constraints
        if (variant == TwoPLVariant.RIGOROUS) {
            throw new IllegalStateException(
                "[" + txId + "] RIGOROUS 2PL: Cannot release any lock before commit"
            );
        } else if (variant == TwoPLVariant.STRICT && lockMode == LockMode.EXCLUSIVE) {
            throw new IllegalStateException(
                "[" + txId + "] STRICT 2PL: Cannot release X-lock before commit"
            );
        }

        managerLock.lock();
        try {
            // Enter shrinking phase if first unlock
            if (tx.phase == TransactionPhase.GROWING) {
                tx.enterShrinkingPhase();
            }

            // Release lock
            LockTableEntry entry = lockTable.get(itemId);
            entry.holders.remove(txId);
            tx.locksHeld.remove(itemId);

            if (entry.holders.isEmpty()) {
                lockTable.remove(itemId);
            }

            System.out.println("[" + txId + "] Released " + lockMode + "-lock on " + itemId +
                             " (Phase: " + tx.phase + ")");

            // Process wait queue
            processWaitQueue(itemId);

        } finally {
            managerLock.unlock();
        }
    }

    private void processWaitQueue(String itemId) {
        if (!lockTable.containsKey(itemId)) {
            return;
        }

        LockTableEntry entry = lockTable.get(itemId);
        Queue<LockRequest> queue = entry.waitQueue;

        List<LockRequest> granted = new ArrayList<>();

        for (LockRequest req : queue) {
            if (isCompatible(itemId, req.transactionId, req.mode)) {
                grantLock(req.transactionId, itemId, req.mode);
                granted.add(req);

                // Remove from wait-for graph
                waitForGraph.get(req.transactionId).clear();
            } else {
                break; // Cannot grant more locks
            }
        }

        queue.removeAll(granted);
    }

    private boolean detectDeadlock(String txId) {
        // DFS to detect cycle in wait-for graph
        Set<String> visited = new HashSet<>();
        Set<String> recursionStack = new HashSet<>();

        return dfsDetectCycle(txId, visited, recursionStack);
    }

    private boolean dfsDetectCycle(String node, Set<String> visited, Set<String> recursionStack) {
        visited.add(node);
        recursionStack.add(node);

        Set<String> neighbors = waitForGraph.getOrDefault(node, new HashSet<>());
        for (String neighbor : neighbors) {
            if (!visited.contains(neighbor)) {
                if (dfsDetectCycle(neighbor, visited, recursionStack)) {
                    return true;
                }
            } else if (recursionStack.contains(neighbor)) {
                return true; // Cycle detected
            }
        }

        recursionStack.remove(node);
        return false;
    }

    public void commit(String txId) {
        Transaction tx = transactions.get(txId);

        managerLock.lock();
        try {
            // Release all remaining locks
            List<String> itemsLocked = new ArrayList<>(tx.locksHeld.keySet());
            for (String itemId : itemsLocked) {
                LockMode mode = tx.locksHeld.get(itemId);

                LockTableEntry entry = lockTable.get(itemId);
                entry.holders.remove(txId);
                if (entry.holders.isEmpty()) {
                    lockTable.remove(itemId);
                }

                System.out.println("[" + txId + "] Released " + mode + "-lock on " +
                                 itemId + " at COMMIT");

                processWaitQueue(itemId);
            }

            tx.locksHeld.clear();
            tx.phase = TransactionPhase.COMPLETED;

            System.out.println("[" + txId + "] Transaction COMMITTED");

        } finally {
            managerLock.unlock();
        }
    }

    public void abort(String txId) {
        Transaction tx = transactions.get(txId);

        managerLock.lock();
        try {
            // Release all locks (similar to commit)
            List<String> itemsLocked = new ArrayList<>(tx.locksHeld.keySet());
            for (String itemId : itemsLocked) {
                LockTableEntry entry = lockTable.get(itemId);
                entry.holders.remove(txId);
                if (entry.holders.isEmpty()) {
                    lockTable.remove(itemId);
                }
                processWaitQueue(itemId);
            }

            tx.locksHeld.clear();
            tx.phase = TransactionPhase.COMPLETED;

            System.out.println("[" + txId + "] Transaction ABORTED");

        } finally {
            managerLock.unlock();
        }
    }

    // Example usage
    public static void main(String[] args) {
        System.out.println("\n=== STRICT 2PL EXAMPLE ===\n");

        TwoPhaseLockingManager manager = new TwoPhaseLockingManager(TwoPLVariant.STRICT);

        // Transaction T1: Bank transfer
        Transaction t1 = manager.beginTransaction("T1");
        manager.acquireLock("T1", "AccountA", LockMode.EXCLUSIVE);
        System.out.println("T1: Deduct 100 from AccountA");
        manager.acquireLock("T1", "AccountB", LockMode.EXCLUSIVE);
        System.out.println("T1: Add 100 to AccountB");

        // Transaction T2: Read AccountA (will wait)
        Transaction t2 = manager.beginTransaction("T2");
        manager.acquireLock("T2", "AccountA", LockMode.SHARED);

        // T1 commits (T2 can now proceed)
        manager.commit("T1");

        // T2 now acquires lock
        manager.acquireLock("T2", "AccountA", LockMode.SHARED);
        System.out.println("T2: Read AccountA");
        manager.commit("T2");
    }
}
```

# Limitations and Trade-offs

## Fundamental Limitations

### 1. Deadlock Susceptibility

All variants except Conservative 2PL are susceptible to deadlocks. This requires:
- Deadlock detection mechanisms (wait-for graph analysis)
- Deadlock prevention strategies (timeout, resource ordering)
- Transaction abort and restart logic
- Performance overhead of deadlock detection

**Cost**: Periodic deadlock detection adds 5-10% CPU overhead in high-concurrency systems.

### 2. Reduced Concurrency

Strict and Rigorous 2PL reduce concurrency by holding locks longer:
```
Example: 1000 concurrent transactions

Basic 2PL:      850 TPS (high concurrency)
Strict 2PL:     720 TPS (15% reduction)
Rigorous 2PL:   650 TPS (24% reduction)
```

### 3. Lock Overhead

Each lock operation requires:
- Lock table lookup/update
- Compatibility checking
- Wait queue management
- Memory for lock structures

**Memory Cost**: Each lock requires approximately 50-100 bytes (lock entry + metadata).
- System with 10,000 active locks: 500KB - 1MB memory overhead

### 4. Conservative 2PL Impracticality

Conservative 2PL requires predeclaring all data items accessed, which is difficult because:
- Dynamic queries make prediction impossible
- Query optimizers may access different indices based on data statistics
- Conditional branching in transactions prevents static analysis

**Example of difficulty**:
```sql
BEGIN TRANSACTION;

-- Cannot predict which products will be accessed
SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);

-- Cannot predict which order_items will be locked
IF (customer_type = 'Premium') THEN
    UPDATE order_items SET discount = 0.2 WHERE order_id = ?;
ELSE
    UPDATE order_items SET discount = 0.1 WHERE order_id = ?;
END IF;

COMMIT;
```

## Trade-off Analysis

### Concurrency vs Correctness

```
                 High Concurrency
                      ↑
                      |
     Basic 2PL        |
        ●             |
                      |
                      |
     Strict 2PL       |
        ●             |
                      |
   Rigorous 2PL       |
        ●             |
                      |
  Conservative 2PL    |
        ●             |
                      |
Low Correctness ←---------→ High Correctness
Guarantees                   Guarantees
```

### Performance vs Recovery Complexity

| Variant           | Throughput | Recovery Complexity | Deadlock Risk |
|-------------------|------------|---------------------|---------------|
| Basic 2PL         | Highest    | Highest             | High          |
| Conservative 2PL  | Lowest     | Lowest              | None          |
| Strict 2PL        | Medium     | Low                 | Medium        |
| Rigorous 2PL      | Low        | Lowest              | Medium        |

# References

1. **Fundamentals of Database Systems** - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
   - Chapter 21: Concurrency Control Techniques.
   - Section 21.1: Two-Phase Locking Techniques for Concurrency Control.

2. **Database System Concepts, 6th Edition** - Abraham Silberschatz, Henry F. Korth, S. Sudarshan - McGraw Hill (2010):
   - Chapter 15: Concurrency Control.
   - Section 15.1: Lock-Based Protocols.

3. **Transaction Processing: Concepts and Techniques** - Jim Gray, Andreas Reuter - Morgan Kaufmann (1993):
   - Chapter 7: Isolation Concepts.
   - Section 7.4: Two-Phase Locking.

4. **Operating System Concepts** - Abraham Silberschatz - 10th Edition - Pearson (2018):
   - Chapter 6: Synchronization Tools.

5. **HCMUT Advanced DBMS Slides** - Lê Thị Bảo Thu.

6. **HCMUT Advanced DBMS Slides** - Võ Thị Ngọc Châu.

7. **Database Systems: The Complete Book** - H. G. Molina, J. D. Ullman, J. Widom - Prentice Hall (2009):
   - Chapter 18: Concurrency Control.

8. [Serializability](Serializability.md)

9. [Locking operations](Locking%20operations.md)

10. [Concurrency control problems](Concurrency%20control%20problems.md)

11. [Deadlock](Deadlock.md)

12. [Transaction isolation level](Transaction%20isolation%20level.md)

13. [Mutex lock](operating-system/unix/linux/process/process-synchronization/locking-mechanism/Mutex%20lock.md)

14. [Critical section problem](operating-system/unix/linux/process/process-synchronization/Critical%20section%20problem.md)

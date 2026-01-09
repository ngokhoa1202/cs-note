#acid #transaction #concurrency-control #dbms-architecture #rdbms #isolation #sql #performance #locking
# Definition
- **Transaction Isolation Level** defines the ==degree to which transactions are isolated from one another==, controlling what data a transaction can see when other transactions are running concurrently.
- Isolation levels determine the ==trade-off between consistency and performance== by controlling how locks are acquired and released during transaction execution.
- Defined by SQL standard (SQL-92) with four levels, each preventing specific concurrency anomalies.
- Based on [Two-phase locking protocol](Two-phase%20locking%20protocol.md) and [Locking operations](Locking%20operations.md).
# Isolation Levels Overview

The following isolation levels grow from the lowest to the highest, with increasing consistency guarantees but decreasing performance and scalability:

| Anomaly / Problem       | Read Uncommitted | Read Committed | Repeatable Read | Serializable |
| ----------------------- | ---------------- | -------------- | --------------- | ------------ |
| **Dirty Read**          | Yes              | No             | No              | No           |
| **Non-Repeatable Read** | Yes              | Yes            | No              | No           |
| **Phantom Read**        | Yes              | Yes            | Yes             | No           |
| **Lost Update**         | Yes              | Yes            | No              | No           |

**Key Points:**
- ==Read Committed== is the default isolation level in most DBMSs (PostgreSQL, SQL Server, Oracle).
- Higher isolation levels use more locks and hold them longer, reducing concurrency.
- Performance degrades as isolation level increases due to increased locking overhead.

# Isolation Levels in Detail

## 1. Read Uncommitted

### Definition
- The ==lowest isolation level== with minimal locking overhead.
- Transactions can read data that has been modified by other transactions but ==not yet committed== (dirty reads).
- ==No shared locks== are acquired for read operations.
- ==No exclusive locks== are respected during reads.

### Characteristics
- Highest performance, lowest consistency.
- Rarely used in production due to data integrity risks.
- Useful only for approximate statistics or monitoring where exact accuracy is not critical.

### Real-World Example: Inventory Dashboard

```mermaid
sequenceDiagram
    participant T1 as Transaction 1<br/>(Update)
    participant DB as Database
    participant T2 as Transaction 2<br/>(Read)

    T1->>DB: BEGIN TRANSACTION
    T1->>DB: UPDATE inventory SET quantity = 100
    Note over T1: Not committed yet
    T2->>DB: BEGIN TRANSACTION
    T2->>DB: SELECT quantity FROM inventory
    DB-->>T2: Returns 100 (dirty read)
    T2->>DB: COMMIT
    T1->>DB: ROLLBACK
    Note over DB: Actual quantity is still original value<br/>T2 read uncommitted data
```

**Scenario:** An admin updates product stock from 50 to 100 units, but the transaction fails and rolls back. Meanwhile, a dashboard query reads the uncommitted value (100) and displays incorrect inventory levels.

### SQL Example

```sql
-- Session 1: Update product price
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION;
UPDATE products SET price = 999.99 WHERE product_id = 1;
-- Not committed yet
WAITFOR DELAY '00:00:10'; -- Simulate processing

-- Session 2: Read uncommitted data (dirty read)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT price FROM products WHERE product_id = 1;
-- Returns 999.99 even though Session 1 hasn't committed

-- Session 1 rolls back
ROLLBACK; -- Price reverts to original value
```

### Use Cases
- ✅ **Real-time monitoring dashboards** where approximate data is acceptable
- ✅ **Log analysis** where exact counts don't matter
- ✅ **Performance metrics** for quick estimates
- ❌ **Financial transactions** - NEVER use
- ❌ **Inventory management** - Data accuracy critical
- ❌ **User-facing queries** - Inconsistent results unacceptable

---

## 2. Read Committed

### Definition
- The ==default isolation level== in most database systems.
- Transactions can only read data that has been ==committed== by other transactions.
- ==Shared locks== are acquired for reads and ==released immediately== after the read operation.
- ==Exclusive locks== are held until transaction commits.

### Characteristics
- Prevents dirty reads but allows non-repeatable reads and phantom reads.
- Good balance between consistency and performance.
- Each SELECT statement sees a consistent snapshot at the moment it executes.

### Real-World Example: Banking Transfer

```mermaid
sequenceDiagram
    participant T1 as Transaction 1<br/>(Transfer)
    participant DB as Database
    participant T2 as Transaction 2<br/>(Check Balance)

    T1->>DB: BEGIN TRANSACTION
    T1->>DB: UPDATE accounts SET balance = balance - 1000<br/>WHERE account_id = 'A'
    T2->>DB: BEGIN TRANSACTION
    T2->>DB: SELECT balance FROM accounts<br/>WHERE account_id = 'A'
    DB-->>T2: Returns original balance<br/>(before T1 commit)
    T1->>DB: UPDATE accounts SET balance = balance + 1000<br/>WHERE account_id = 'B'
    T1->>DB: COMMIT
    T2->>DB: SELECT balance FROM accounts<br/>WHERE account_id = 'A'
    DB-->>T2: Returns new balance<br/>(after T1 commit)
    Note over T2: Non-repeatable read:<br/>Same query, different results
    T2->>DB: COMMIT
```

**Scenario:** A customer transfers $1,000 from Account A to Account B. Another transaction checks Account A balance twice within the same transaction and gets different results because the first transaction committed between the two reads.

### SQL Example

```sql
-- PostgreSQL: Read Committed demonstration

-- Session 1: Transfer money
BEGIN;
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 'ACC001';
-- Not committed yet

-- Session 2: Read committed data only
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM accounts WHERE account_id = 'ACC001';
-- Returns original balance (T1 hasn't committed)

-- Session 1 commits
COMMIT;

-- Session 2: Read again in same transaction
SELECT balance FROM accounts WHERE account_id = 'ACC001';
-- Returns updated balance (non-repeatable read)
-- Different result from previous SELECT in same transaction
COMMIT;
```

### Non-Repeatable Read Example: Booking System

```sql
-- Session 1: User booking flight
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Check available seats
SELECT available_seats FROM flights WHERE flight_id = 'FL123';
-- Returns: 10 seats

-- User decides to book after 5 seconds...

-- Session 2: Another user books 5 seats (meanwhile)
BEGIN;
UPDATE flights SET available_seats = available_seats - 5
WHERE flight_id = 'FL123';
COMMIT;

-- Session 1: Try to book 8 seats
SELECT available_seats FROM flights WHERE flight_id = 'FL123';
-- Returns: 5 seats (non-repeatable read!)
-- First read: 10, Second read: 5 in same transaction

UPDATE flights SET available_seats = available_seats - 8
WHERE flight_id = 'FL123';
-- May cause negative seats or booking failure
COMMIT;
```

### Use Cases
- ✅ **Web applications** - Most HTTP requests are short-lived
- ✅ **RESTful APIs** - Stateless operations
- ✅ **CRUD operations** - Single-record updates
- ✅ **Reporting queries** - Point-in-time snapshots acceptable
- ⚠️ **Financial calculations** - May need Repeatable Read
- ⚠️ **Multi-step workflows** - Risk of non-repeatable reads

---

## 3. Repeatable Read

### Definition
- Ensures that if a transaction reads a row, ==subsequent reads of the same row will return the same data==.
- ==Shared locks== are held until transaction commits (not just during read).
- ==Exclusive locks== are held until transaction commits.
- Prevents dirty reads and non-repeatable reads, but may allow phantom reads.

### Characteristics
- Provides snapshot isolation in many databases (PostgreSQL, MySQL InnoDB).
- Protects against lost updates through implicit locking.
- Higher locking overhead than Read Committed.

### Real-World Example: E-commerce Order Processing

```mermaid
sequenceDiagram
    participant T1 as Transaction 1<br/>(Calculate Total)
    participant DB as Database
    participant T2 as Transaction 2<br/>(Update Price)

    T1->>DB: BEGIN TRANSACTION<br/>REPEATABLE READ
    T1->>DB: SELECT price FROM products<br/>WHERE product_id = 101
    DB-->>T1: Returns $100
    T2->>DB: BEGIN TRANSACTION
    T2->>DB: UPDATE products SET price = 150<br/>WHERE product_id = 101
    T2->>DB: COMMIT
    Note over DB: Price updated to $150
    T1->>DB: SELECT price FROM products<br/>WHERE product_id = 101
    DB-->>T1: Returns $100 (same as first read)
    Note over T1: Repeatable read guaranteed
    T1->>DB: INSERT INTO orders (product_id, price)<br/>VALUES (101, 100)
    T1->>DB: COMMIT
```

**Scenario:** An order calculation transaction reads product prices multiple times. Even if another transaction updates the price, the first transaction continues to see the original price, ensuring consistent order total calculation.

### SQL Example: Preventing Non-Repeatable Reads

```sql
-- MySQL/InnoDB: Repeatable Read demonstration

-- Session 1: Process order
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;

-- Read product price for order calculation
SELECT price, quantity FROM products WHERE product_id = 101;
-- Returns: price = 100, quantity = 50

-- Calculate shipping, tax, etc. (takes time)
-- ... business logic ...

-- Session 2: Update product price (meanwhile)
BEGIN;
UPDATE products SET price = 150 WHERE product_id = 101;
COMMIT;

-- Session 1: Read price again to confirm
SELECT price FROM products WHERE product_id = 101;
-- Still returns: price = 100 (repeatable read)
-- Session 1 sees consistent snapshot

-- Create order with consistent price
INSERT INTO orders (product_id, unit_price, quantity)
VALUES (101, 100, 2);
COMMIT;
```

### Phantom Read Example

```sql
-- PostgreSQL: Phantom read demonstration

-- Session 1: Calculate total inventory value
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;

-- First count
SELECT COUNT(*), SUM(price * quantity) as total_value
FROM inventory WHERE category = 'Electronics';
-- Returns: count = 100, total_value = 50000

-- Session 2: Insert new product (meanwhile)
BEGIN;
INSERT INTO inventory (product_id, category, price, quantity)
VALUES (201, 'Electronics', 500, 10);
COMMIT;

-- Session 1: Recount
SELECT COUNT(*), SUM(price * quantity) as total_value
FROM inventory WHERE category = 'Electronics';
-- PostgreSQL: Returns same (100, 50000) - no phantom
-- MySQL: Returns same (100, 50000) - no phantom
-- SQL Server/Oracle: May return (101, 55000) - phantom read
```

**Note:** PostgreSQL and MySQL InnoDB implement ==Snapshot Isolation== for Repeatable Read, which also prevents phantom reads. SQL Server and Oracle may exhibit phantom reads at this level.

### Lost Update Prevention

```sql
-- MySQL: Preventing lost updates with Repeatable Read

-- Session 1: Withdraw $100
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
SELECT balance FROM accounts WHERE account_id = 'ACC001' FOR UPDATE;
-- Returns 1000, acquires exclusive lock

-- Session 2: Withdraw $200 (blocked)
BEGIN;
SELECT balance FROM accounts WHERE account_id = 'ACC001' FOR UPDATE;
-- Waits for Session 1 to complete

-- Session 1: Complete withdrawal
UPDATE accounts SET balance = balance - 100 WHERE account_id = 'ACC001';
COMMIT; -- balance = 900

-- Session 2: Now proceeds
-- Reads balance = 900 (after Session 1 committed)
UPDATE accounts SET balance = balance - 200 WHERE account_id = 'ACC001';
COMMIT; -- balance = 700 (correct result, no lost update)
```

### Use Cases
- ✅ **Financial transactions** - Consistent balance calculations
- ✅ **Order processing** - Multi-step order creation
- ✅ **Inventory management** - Prevent race conditions
- ✅ **Report generation** - Consistent snapshots across multiple queries
- ✅ **Multi-step workflows** - Data consistency across steps
- ⚠️ **High-concurrency writes** - May cause performance bottlenecks
- ❌ **Read-mostly workloads** - Overkill, use Read Committed

---

## 4. Serializable

### Definition
- The ==highest isolation level== providing complete isolation.
- Transactions are executed as if they were ==serialized== (one after another).
- Prevents all concurrency anomalies: dirty reads, non-repeatable reads, phantom reads, and lost updates.
- Uses ==range locks== or ==predicate locks== to prevent phantom reads.

### Characteristics
- Guarantees complete serializability but with significant performance cost.
- May use locking (traditional) or optimistic concurrency control (SSI).
- Highest lock contention and potential for deadlocks.

### Real-World Example: Seat Booking System

```mermaid
sequenceDiagram
    participant T1 as Transaction 1<br/>(Book Seat)
    participant DB as Database
    participant T2 as Transaction 2<br/>(Book Seat)

    T1->>DB: BEGIN TRANSACTION<br/>SERIALIZABLE
    T1->>DB: SELECT COUNT(*) FROM bookings<br/>WHERE flight_id = 'FL123'
    DB-->>T1: Returns 98 (2 seats available)
    Note over T1: Acquires range lock
    T2->>DB: BEGIN TRANSACTION<br/>SERIALIZABLE
    T2->>DB: SELECT COUNT(*) FROM bookings<br/>WHERE flight_id = 'FL123'
    Note over T2: Blocked by T1's range lock
    T1->>DB: INSERT INTO bookings<br/>(flight_id, seat_number)
    T1->>DB: COMMIT
    Note over T2: Now can proceed
    T2->>DB: SELECT query proceeds
    DB-->>T2: Returns 99 (1 seat available)
    T2->>DB: INSERT INTO bookings<br/>(flight_id, seat_number)
    T2->>DB: COMMIT
```

**Scenario:** Two users try to book the last seats on a flight. Serializable isolation ensures that the second transaction sees the updated seat count after the first transaction commits, preventing overbooking.

### SQL Example: Preventing Phantom Reads

```sql
-- PostgreSQL: Serializable Snapshot Isolation (SSI)

-- Session 1: Count and insert
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;

-- Check seat availability
SELECT COUNT(*) as booked_seats FROM bookings
WHERE flight_id = 'FL123';
-- Returns: 98 (flight capacity is 100)

-- Business logic: Calculate available seats
-- If available > 0, proceed with booking

-- Session 2: Concurrent booking attempt
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;

SELECT COUNT(*) as booked_seats FROM bookings
WHERE flight_id = 'FL123';
-- Returns: 98 (same snapshot)

-- Session 1: Insert booking
INSERT INTO bookings (flight_id, passenger_id, seat_number)
VALUES ('FL123', 'P001', '12A');
COMMIT; -- Success

-- Session 2: Try to insert
INSERT INTO bookings (flight_id, passenger_id, seat_number)
VALUES ('FL123', 'P002', '12B');
COMMIT;
-- PostgreSQL may abort with serialization failure:
-- ERROR: could not serialize access due to read/write dependencies
```

### Write Skew Prevention

```sql
-- Write skew example: On-call doctor scheduling

-- Business rule: At least 1 doctor must be on-call at all times

-- Session 1: Dr. Alice goes off-call
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;

SELECT COUNT(*) FROM on_call WHERE on_duty = true;
-- Returns: 2 (Alice and Bob)

-- Alice: "Since Bob is on-call, I can go off-call"
UPDATE on_call SET on_duty = false WHERE doctor_id = 'Alice';

-- Session 2: Dr. Bob goes off-call (concurrent)
BEGIN;

SELECT COUNT(*) FROM on_call WHERE on_duty = true;
-- Returns: 2 (Alice and Bob) - same snapshot

-- Bob: "Since Alice is on-call, I can go off-call"
UPDATE on_call SET on_duty = false WHERE doctor_id = 'Bob';

-- Session 1 commits
COMMIT; -- Success

-- Session 2 tries to commit
COMMIT;
-- PostgreSQL (SSI): ERROR - serialization failure
-- MySQL/InnoDB: May succeed (write skew occurs!)
-- Result: No doctor on-call - constraint violated
```

### SQL Example: Sum Constraint

```sql
-- Prevent phantom reads in aggregate calculations

-- Session 1: Calculate total salary budget
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;

SELECT SUM(salary) as total_salary FROM employees
WHERE department = 'Engineering';
-- Returns: 500000

-- Check if we can afford new hire
-- Budget: 600000, Current: 500000, Available: 100000

-- Session 2: Add new employee (meanwhile)
BEGIN;
INSERT INTO employees (name, department, salary)
VALUES ('New Engineer', 'Engineering', 80000);
COMMIT;

-- Session 1: Recalculate to verify
SELECT SUM(salary) as total_salary FROM employees
WHERE department = 'Engineering';
-- Serializable: Returns 500000 (no phantom)
-- Repeatable Read: May return 580000 (phantom read in some DBs)

-- Session 1: Add another employee
INSERT INTO employees (name, department, salary)
VALUES ('Another Engineer', 'Engineering', 90000);
-- Total would be 670000, exceeding budget

COMMIT;
-- With Serializable: Properly prevents phantom reads
-- Without: Budget constraint violated
```

### Use Cases
- ✅ **Financial reconciliation** - Account balance consistency
- ✅ **Booking systems** - Prevent double-booking
- ✅ **Inventory with constraints** - "Last item" scenarios
- ✅ **Regulatory compliance** - Audit trails requiring serializability
- ✅ **Banking transactions** - Multi-account transfers
- ⚠️ **High-volume OLTP** - Performance impact significant
- ❌ **Read-heavy workloads** - Unnecessary overhead

---

# Database-Specific Configuration

## PostgreSQL

```sql
-- Set session isolation level
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Set transaction isolation level
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- or
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Check current isolation level
SHOW transaction_isolation;

-- Default: READ COMMITTED
```

**PostgreSQL Specifics:**
- Implements ==Snapshot Isolation (SI)== for Repeatable Read, preventing phantom reads.
- Implements ==Serializable Snapshot Isolation (SSI)== for Serializable, using SIREAD locks.
- SSI is optimistic: transactions may abort with serialization failures.

```sql
-- Example: Handle serialization failure in application
DO $$
DECLARE
    max_retries INT := 3;
    retry_count INT := 0;
BEGIN
    LOOP
        BEGIN
            -- Your transaction logic
            BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
            -- ... business logic ...
            COMMIT;
            EXIT; -- Success, exit loop
        EXCEPTION
            WHEN serialization_failure THEN
                retry_count := retry_count + 1;
                IF retry_count >= max_retries THEN
                    RAISE; -- Give up after max retries
                END IF;
                -- Retry transaction
        END;
    END LOOP;
END $$;
```

## MySQL/InnoDB

```sql
-- Set global isolation level
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Set session isolation level
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Set transaction isolation level
START TRANSACTION WITH CONSISTENT SNAPSHOT;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Check isolation level
SELECT @@transaction_isolation;
-- or
SELECT @@tx_isolation; -- MySQL < 8.0

-- Default: REPEATABLE READ
```

**MySQL InnoDB Specifics:**
- Uses ==MVCC (Multi-Version Concurrency Control)== for Repeatable Read.
- Repeatable Read prevents phantom reads through next-key locking.
- Locking reads (`SELECT ... FOR UPDATE`) acquire stricter locks.

```sql
-- MySQL: Locking reads
BEGIN;

-- Shared lock (S)
SELECT * FROM products WHERE product_id = 101 LOCK IN SHARE MODE;
-- or MySQL 8.0+
SELECT * FROM products WHERE product_id = 101 FOR SHARE;

-- Exclusive lock (X)
SELECT * FROM products WHERE product_id = 101 FOR UPDATE;

COMMIT;
```

## Microsoft SQL Server

```sql
-- Set session isolation level
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

-- Check isolation level
DBCC USEROPTIONS;

-- Enable snapshot isolation (database level)
ALTER DATABASE YourDatabase
SET ALLOW_SNAPSHOT_ISOLATION ON;

ALTER DATABASE YourDatabase
SET READ_COMMITTED_SNAPSHOT ON;

-- Default: READ COMMITTED
```

**SQL Server Specifics:**
- Offers ==Snapshot Isolation== as a separate level (MVCC-based).
- `READ_COMMITTED_SNAPSHOT` database option changes Read Committed behavior to use row versioning.
- Traditional levels use locking; Snapshot uses versioning.

```sql
-- SQL Server: Snapshot Isolation example
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRANSACTION;

-- Reads data as of transaction start time
SELECT * FROM accounts WHERE account_id = 'ACC001';
-- Sees snapshot, not current data

-- Another transaction can modify data without blocking
-- This transaction sees consistent snapshot

COMMIT;
```

## Oracle Database

```sql
-- Set transaction isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Oracle doesn't support Read Uncommitted or Repeatable Read
-- Default: READ COMMITTED
```

**Oracle Specifics:**
- Uses ==Automatic Undo Management== for MVCC.
- Read Committed is default and most common.
- Serializable provides snapshot isolation, not true serializability.
- No dirty reads possible by design.

```sql
-- Oracle: FOR UPDATE locking
BEGIN
    -- Lock rows for update
    SELECT * FROM accounts WHERE account_id = 'ACC001' FOR UPDATE;

    -- Perform update
    UPDATE accounts SET balance = balance - 100 WHERE account_id = 'ACC001';

    COMMIT;
END;
```

---

# Programming Examples

## Java with Hibernate/JPA

```java
// Entity class
@Entity
@Table(name = "accounts")
public class Account {
    @Id
    private String accountId;

    private BigDecimal balance;

    @Version
    private Long version; // Optimistic locking

    // Getters and setters
}

// Service class with isolation levels
@Service
@Transactional
public class BankingService {

    @Autowired
    private EntityManager entityManager;

    @Autowired
    private AccountRepository accountRepository;

    // Read Committed (default)
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public Account getAccountBalance(String accountId) {
        return accountRepository.findById(accountId)
            .orElseThrow(() -> new AccountNotFoundException(accountId));
    }

    // Repeatable Read for consistent order processing
    @Transactional(isolation = Isolation.REPEATABLE_READ)
    public Order processOrder(OrderRequest request) {
        // Read product price
        Product product = entityManager.find(Product.class, request.getProductId());

        // Calculate total (may take time)
        BigDecimal total = product.getPrice()
            .multiply(BigDecimal.valueOf(request.getQuantity()));

        // Re-read product to verify (repeatable read ensures same price)
        product = entityManager.find(Product.class, request.getProductId());

        // Create order with consistent price
        Order order = new Order();
        order.setProduct(product);
        order.setUnitPrice(product.getPrice());
        order.setQuantity(request.getQuantity());
        order.setTotal(total);

        return entityManager.merge(order);
    }

    // Serializable for critical financial operations
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public void transferFunds(String fromAccountId, String toAccountId,
                              BigDecimal amount) {
        // Lock accounts in consistent order to prevent deadlock
        List<String> sortedIds = Arrays.asList(fromAccountId, toAccountId).stream()
            .sorted()
            .collect(Collectors.toList());

        Account fromAccount = entityManager.find(Account.class, sortedIds.get(0),
            LockModeType.PESSIMISTIC_WRITE);
        Account toAccount = entityManager.find(Account.class, sortedIds.get(1),
            LockModeType.PESSIMISTIC_WRITE);

        // Swap if necessary
        if (!fromAccount.getAccountId().equals(fromAccountId)) {
            Account temp = fromAccount;
            fromAccount = toAccount;
            toAccount = temp;
        }

        // Validate balance
        if (fromAccount.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException();
        }

        // Transfer
        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        toAccount.setBalance(toAccount.getBalance().add(amount));

        entityManager.merge(fromAccount);
        entityManager.merge(toAccount);
    }

    // Pessimistic locking
    @Transactional(isolation = Isolation.REPEATABLE_READ)
    public void withdrawWithPessimisticLock(String accountId, BigDecimal amount) {
        Account account = entityManager.find(Account.class, accountId,
            LockModeType.PESSIMISTIC_WRITE);

        if (account.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException();
        }

        account.setBalance(account.getBalance().subtract(amount));
        entityManager.merge(account);
    }

    // Optimistic locking with @Version
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void withdrawWithOptimisticLock(String accountId, BigDecimal amount) {
        try {
            Account account = accountRepository.findById(accountId)
                .orElseThrow(() -> new AccountNotFoundException(accountId));

            if (account.getBalance().compareTo(amount) < 0) {
                throw new InsufficientFundsException();
            }

            account.setBalance(account.getBalance().subtract(amount));
            accountRepository.save(account); // Version check happens here

        } catch (OptimisticLockException e) {
            // Handle concurrent modification
            throw new ConcurrentModificationException(
                "Account was modified by another transaction", e);
        }
    }

    // Retry logic for serialization failures
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public void bookSeatWithRetry(String flightId, String passengerId) {
        int maxRetries = 3;
        int attempt = 0;

        while (attempt < maxRetries) {
            try {
                bookSeat(flightId, passengerId);
                return; // Success
            } catch (Exception e) {
                attempt++;
                if (e.getCause() instanceof SQLException) {
                    SQLException sqlEx = (SQLException) e.getCause();
                    // PostgreSQL serialization failure: 40001
                    // MySQL deadlock: 1213
                    if ("40001".equals(sqlEx.getSQLState()) ||
                        sqlEx.getErrorCode() == 1213) {
                        if (attempt >= maxRetries) {
                            throw new MaxRetriesExceededException(
                                "Failed after " + maxRetries + " attempts", e);
                        }
                        // Wait and retry
                        try {
                            Thread.sleep(100 * attempt); // Exponential backoff
                        } catch (InterruptedException ie) {
                            Thread.currentThread().interrupt();
                            throw new RuntimeException(ie);
                        }
                        continue;
                    }
                }
                throw e; // Not a serialization failure
            }
        }
    }

    private void bookSeat(String flightId, String passengerId) {
        // Check capacity
        long bookedSeats = entityManager.createQuery(
            "SELECT COUNT(b) FROM Booking b WHERE b.flightId = :flightId",
            Long.class)
            .setParameter("flightId", flightId)
            .getSingleResult();

        Flight flight = entityManager.find(Flight.class, flightId);

        if (bookedSeats >= flight.getCapacity()) {
            throw new NoSeatsAvailableException();
        }

        // Create booking
        Booking booking = new Booking();
        booking.setFlightId(flightId);
        booking.setPassengerId(passengerId);
        entityManager.persist(booking);
    }
}
```

## Python with SQLAlchemy

```python
from sqlalchemy import create_engine, Column, String, Numeric, Integer
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy.exc import OperationalError
from decimal import Decimal
import time

Base = declarative_base()

class Account(Base):
    __tablename__ = 'accounts'

    account_id = Column(String(50), primary_key=True)
    balance = Column(Numeric(15, 2), nullable=False)
    version = Column(Integer, default=0)  # Optimistic locking

engine = create_engine('postgresql://user:password@localhost/banking')
Session = sessionmaker(bind=engine)

# Read Committed (default)
def get_account_balance(account_id):
    session = Session()
    try:
        # Default isolation level
        account = session.query(Account).filter_by(
            account_id=account_id
        ).first()
        return account.balance if account else None
    finally:
        session.close()

# Repeatable Read
def process_order_repeatable_read(product_id, quantity):
    session = Session()
    try:
        # Set isolation level
        session.connection(execution_options={
            'isolation_level': 'REPEATABLE_READ'
        })

        # Read product price
        product = session.query(Product).filter_by(
            product_id=product_id
        ).with_for_update().first()  # Pessimistic lock

        # Calculate total
        total = product.price * Decimal(quantity)

        # Create order (product price won't change in this transaction)
        order = Order(
            product_id=product_id,
            unit_price=product.price,
            quantity=quantity,
            total=total
        )
        session.add(order)
        session.commit()

        return order
    except Exception as e:
        session.rollback()
        raise
    finally:
        session.close()

# Serializable with retry logic
def transfer_funds_serializable(from_account_id, to_account_id, amount,
                                max_retries=3):
    for attempt in range(max_retries):
        session = Session()
        try:
            # Set serializable isolation
            session.connection(execution_options={
                'isolation_level': 'SERIALIZABLE'
            })

            # Lock accounts in sorted order to prevent deadlock
            sorted_ids = sorted([from_account_id, to_account_id])
            accounts = {}

            for acc_id in sorted_ids:
                account = session.query(Account).filter_by(
                    account_id=acc_id
                ).with_for_update().first()
                accounts[acc_id] = account

            from_account = accounts[from_account_id]
            to_account = accounts[to_account_id]

            # Validate balance
            if from_account.balance < amount:
                raise ValueError("Insufficient funds")

            # Transfer
            from_account.balance -= amount
            to_account.balance += amount

            session.commit()
            return True

        except OperationalError as e:
            session.rollback()
            # PostgreSQL: 40001 (serialization_failure)
            # MySQL: 1213 (deadlock)
            if e.orig.pgcode == '40001' or e.orig.args[0] == 1213:
                if attempt < max_retries - 1:
                    time.sleep(0.1 * (attempt + 1))  # Exponential backoff
                    continue
                else:
                    raise Exception(f"Failed after {max_retries} attempts")
            raise
        except Exception as e:
            session.rollback()
            raise
        finally:
            session.close()

    return False

# Optimistic locking with version
def withdraw_optimistic_lock(account_id, amount):
    session = Session()
    try:
        account = session.query(Account).filter_by(
            account_id=account_id
        ).first()

        if not account:
            raise ValueError("Account not found")

        if account.balance < amount:
            raise ValueError("Insufficient funds")

        original_version = account.version

        # Update balance and increment version
        result = session.query(Account).filter_by(
            account_id=account_id,
            version=original_version
        ).update({
            'balance': Account.balance - amount,
            'version': Account.version + 1
        }, synchronize_session=False)

        if result == 0:
            # Version mismatch - concurrent modification
            raise Exception("Concurrent modification detected")

        session.commit()
        return True

    except Exception as e:
        session.rollback()
        raise
    finally:
        session.close()

# Read Uncommitted (for monitoring)
def get_approximate_statistics():
    session = Session()
    try:
        # Set lowest isolation level
        session.connection(execution_options={
            'isolation_level': 'READ_UNCOMMITTED'
        })

        # Get approximate counts (may include uncommitted data)
        total_accounts = session.query(Account).count()
        total_balance = session.query(
            func.sum(Account.balance)
        ).scalar()

        return {
            'total_accounts': total_accounts,
            'total_balance': total_balance
        }
    finally:
        session.close()

# Context manager for isolation level
from contextlib import contextmanager

@contextmanager
def transaction_isolation(isolation_level):
    session = Session()
    try:
        session.connection(execution_options={
            'isolation_level': isolation_level
        })
        yield session
        session.commit()
    except Exception:
        session.rollback()
        raise
    finally:
        session.close()

# Usage
with transaction_isolation('REPEATABLE_READ') as session:
    account = session.query(Account).filter_by(
        account_id='ACC001'
    ).first()
    # ... business logic ...
```

## Node.js with TypeORM

```typescript
import {
    Entity, PrimaryColumn, Column, DataSource,
    IsolationLevel, QueryRunner
} from 'typeorm';

@Entity('accounts')
class Account {
    @PrimaryColumn()
    accountId: string;

    @Column('decimal', { precision: 15, scale: 2 })
    balance: number;

    @Column({ default: 0 })
    version: number; // For optimistic locking
}

const dataSource = new DataSource({
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'user',
    password: 'password',
    database: 'banking',
    entities: [Account],
});

// Read Committed (default)
async function getAccountBalance(accountId: string): Promise<number | null> {
    const accountRepo = dataSource.getRepository(Account);
    const account = await accountRepo.findOne({
        where: { accountId }
    });
    return account?.balance ?? null;
}

// Repeatable Read with transaction
async function processOrderRepeatableRead(
    productId: string,
    quantity: number
): Promise<Order> {
    const queryRunner = dataSource.createQueryRunner();
    await queryRunner.connect();

    try {
        // Start transaction with Repeatable Read
        await queryRunner.startTransaction('REPEATABLE READ');

        // Read product price (will remain consistent)
        const product = await queryRunner.manager.findOne(Product, {
            where: { productId },
            lock: { mode: 'pessimistic_write' }
        });

        if (!product) {
            throw new Error('Product not found');
        }

        // Calculate total
        const total = product.price * quantity;

        // Create order with consistent price
        const order = queryRunner.manager.create(Order, {
            productId,
            unitPrice: product.price,
            quantity,
            total
        });

        await queryRunner.manager.save(order);
        await queryRunner.commitTransaction();

        return order;

    } catch (error) {
        await queryRunner.rollbackTransaction();
        throw error;
    } finally {
        await queryRunner.release();
    }
}

// Serializable with retry logic
async function transferFundsSerializable(
    fromAccountId: string,
    toAccountId: string,
    amount: number,
    maxRetries: number = 3
): Promise<boolean> {
    for (let attempt = 0; attempt < maxRetries; attempt++) {
        const queryRunner = dataSource.createQueryRunner();
        await queryRunner.connect();

        try {
            // Start serializable transaction
            await queryRunner.startTransaction('SERIALIZABLE');

            // Lock accounts in sorted order (prevent deadlock)
            const sortedIds = [fromAccountId, toAccountId].sort();
            const accounts: { [key: string]: Account } = {};

            for (const accId of sortedIds) {
                const account = await queryRunner.manager.findOne(Account, {
                    where: { accountId: accId },
                    lock: { mode: 'pessimistic_write' }
                });

                if (!account) {
                    throw new Error(`Account ${accId} not found`);
                }

                accounts[accId] = account;
            }

            const fromAccount = accounts[fromAccountId];
            const toAccount = accounts[toAccountId];

            // Validate balance
            if (fromAccount.balance < amount) {
                throw new Error('Insufficient funds');
            }

            // Transfer
            fromAccount.balance -= amount;
            toAccount.balance += amount;

            await queryRunner.manager.save([fromAccount, toAccount]);
            await queryRunner.commitTransaction();

            return true;

        } catch (error: any) {
            await queryRunner.rollbackTransaction();

            // Check for serialization failure
            const isSerializationError =
                error.code === '40001' || // PostgreSQL
                error.errno === 1213;     // MySQL deadlock

            if (isSerializationError && attempt < maxRetries - 1) {
                // Exponential backoff
                await new Promise(resolve =>
                    setTimeout(resolve, 100 * (attempt + 1))
                );
                continue;
            }

            throw new Error(
                `Transfer failed after ${attempt + 1} attempts: ${error.message}`
            );

        } finally {
            await queryRunner.release();
        }
    }

    return false;
}

// Optimistic locking
async function withdrawOptimisticLock(
    accountId: string,
    amount: number
): Promise<boolean> {
    const accountRepo = dataSource.getRepository(Account);

    return await dataSource.transaction(async (manager) => {
        const account = await manager.findOne(Account, {
            where: { accountId }
        });

        if (!account) {
            throw new Error('Account not found');
        }

        if (account.balance < amount) {
            throw new Error('Insufficient funds');
        }

        const originalVersion = account.version;

        // Update with version check
        const result = await manager
            .createQueryBuilder()
            .update(Account)
            .set({
                balance: () => `balance - ${amount}`,
                version: () => 'version + 1'
            })
            .where('account_id = :accountId', { accountId })
            .andWhere('version = :version', { version: originalVersion })
            .execute();

        if (result.affected === 0) {
            throw new Error('Concurrent modification detected');
        }

        return true;
    });
}

// Generic transaction wrapper with isolation level
async function withTransaction<T>(
    isolationLevel: IsolationLevel,
    work: (queryRunner: QueryRunner) => Promise<T>
): Promise<T> {
    const queryRunner = dataSource.createQueryRunner();
    await queryRunner.connect();

    try {
        await queryRunner.startTransaction(isolationLevel);
        const result = await work(queryRunner);
        await queryRunner.commitTransaction();
        return result;
    } catch (error) {
        await queryRunner.rollbackTransaction();
        throw error;
    } finally {
        await queryRunner.release();
    }
}

// Usage examples
async function examples() {
    // Read Committed
    const balance = await getAccountBalance('ACC001');
    console.log(`Balance: ${balance}`);

    // Repeatable Read
    const order = await processOrderRepeatableRead('PROD123', 2);
    console.log(`Order created: ${order.orderId}`);

    // Serializable with retry
    const transferred = await transferFundsSerializable(
        'ACC001', 'ACC002', 1000
    );
    console.log(`Transfer successful: ${transferred}`);

    // Custom transaction
    await withTransaction('REPEATABLE_READ', async (queryRunner) => {
        // Your business logic here
        const accounts = await queryRunner.manager.find(Account);
        // ...
    });
}
```

---

# Performance Considerations

## Lock Overhead Comparison

```mermaid
graph LR
    A[Read Uncommitted] -->|Lowest| B[Performance]
    C[Read Committed] -->|Low-Medium| B
    D[Repeatable Read] -->|Medium-High| B
    E[Serializable] -->|Highest| B

    A -->|None| F[Lock Overhead]
    C -->|Minimal| F
    D -->|Moderate| F
    E -->|Maximum| F

    style A fill:#90EE90
    style C fill:#FFD700
    style D fill:#FFA500
    style E fill:#FF6347
```

## Throughput vs Isolation Level

| Isolation Level  | Avg Throughput | Lock Duration | Deadlock Risk | Use Case Fit          |
| ---------------- | -------------- | ------------- | ------------- | --------------------- |
| Read Uncommitted | 10,000 TPS     | None          | Very Low      | Monitoring            |
| Read Committed   | 8,000 TPS      | Short         | Low           | Web apps, APIs        |
| Repeatable Read  | 4,000 TPS      | Medium        | Medium        | Financial operations  |
| Serializable     | 1,000 TPS      | Long          | High          | Critical transactions |

*Note: Throughput numbers are approximate and vary by workload and database system.*

## Concurrency Impact

```mermaid
sequenceDiagram
    participant T1 as Transaction 1
    participant T2 as Transaction 2
    participant T3 as Transaction 3
    participant DB as Database

    Note over DB: Read Committed: High Concurrency
    T1->>DB: BEGIN + SELECT
    T2->>DB: BEGIN + SELECT
    T3->>DB: BEGIN + SELECT
    T1->>DB: UPDATE + COMMIT
    T2->>DB: UPDATE + COMMIT
    T3->>DB: UPDATE + COMMIT

    Note over DB: Serializable: Low Concurrency
    T1->>DB: BEGIN + SELECT (acquires locks)
    T2->>DB: BEGIN + SELECT (blocked)
    T3->>DB: BEGIN + SELECT (blocked)
    T1->>DB: UPDATE + COMMIT (releases locks)
    T2->>DB: SELECT proceeds
    T2->>DB: UPDATE + COMMIT
    T3->>DB: SELECT proceeds
    T3->>DB: UPDATE + COMMIT
```

---

# Best Practices and Decision Guide

## Choosing Isolation Level

```mermaid
graph TD
    A[Transaction Requirements] --> B{Dirty reads acceptable?}
    B -->|Yes| C[Read Uncommitted<br/>Monitoring only]
    B -->|No| D{Same data read multiple times?}
    D -->|No| E[Read Committed<br/>Default choice]
    D -->|Yes| F{Phantom reads acceptable?}
    F -->|Yes| G[Repeatable Read<br/>Financial operations]
    F -->|No| H[Serializable<br/>Critical constraints]

    style C fill:#90EE90
    style E fill:#FFD700
    style G fill:#FFA500
    style H fill:#FF6347
```

## Decision Matrix

| Requirement                           | Recommended Level       | Alternative          |
| ------------------------------------- | ----------------------- | -------------------- |
| High-volume web requests              | Read Committed          | -                    |
| Financial balance calculations        | Repeatable Read         | Serializable         |
| Seat/inventory booking                | Serializable            | Repeatable Read + FOR UPDATE |
| Reporting (point-in-time snapshot)    | Repeatable Read         | Read Committed       |
| Monitoring dashboards (approx. data)  | Read Uncommitted        | Read Committed       |
| Order processing with pricing         | Repeatable Read         | -                    |
| Multi-account transfers               | Serializable            | Repeatable Read + careful locking |
| Read-mostly operations                | Read Committed          | -                    |
| Constraint enforcement (e.g., capacity) | Serializable         | Application-level checks |

## Best Practices

### 1. Use Default (Read Committed) Unless Necessary
```java
// Don't do this everywhere
@Transactional(isolation = Isolation.SERIALIZABLE) // Overkill for most operations
public User getUser(Long id) {
    return userRepository.findById(id);
}

// Do this instead
@Transactional(readOnly = true) // Read Committed is sufficient
public User getUser(Long id) {
    return userRepository.findById(id);
}
```

### 2. Handle Serialization Failures
```python
def critical_operation_with_retry():
    max_retries = 3
    for attempt in range(max_retries):
        try:
            with transaction_isolation('SERIALIZABLE'):
                # Critical business logic
                pass
            return  # Success
        except SerializationFailure:
            if attempt == max_retries - 1:
                raise  # Give up
            time.sleep(0.1 * (attempt + 1))  # Backoff
```

### 3. Minimize Transaction Scope
```typescript
// Bad: Long transaction holding locks
async function processOrder(orderId: string) {
    await dataSource.transaction('SERIALIZABLE', async (manager) => {
        const order = await manager.findOne(Order, { where: { orderId } });

        // External API call inside transaction - BAD!
        await externalPaymentAPI.charge(order.total);

        // Email sending inside transaction - BAD!
        await emailService.sendConfirmation(order.customerEmail);

        order.status = 'completed';
        await manager.save(order);
    });
}

// Good: Minimal transaction scope
async function processOrder(orderId: string) {
    // Read order outside transaction
    const order = await orderRepository.findOne({ where: { orderId } });

    // External operations outside transaction
    await externalPaymentAPI.charge(order.total);

    // Minimal transaction for database update only
    await dataSource.transaction('READ_COMMITTED', async (manager) => {
        order.status = 'completed';
        await manager.save(order);
    });

    // Email after transaction
    await emailService.sendConfirmation(order.customerEmail);
}
```

### 4. Use Appropriate Locking Strategy
```sql
-- Pessimistic: Lock immediately
BEGIN;
SELECT * FROM accounts WHERE account_id = 'ACC001' FOR UPDATE;
-- Account is locked, do work
UPDATE accounts SET balance = balance - 100 WHERE account_id = 'ACC001';
COMMIT;

-- Optimistic: Check version at end
BEGIN;
SELECT balance, version FROM accounts WHERE account_id = 'ACC001';
-- Do calculations
UPDATE accounts
SET balance = balance - 100, version = version + 1
WHERE account_id = 'ACC001' AND version = 5;
-- If no rows updated, version changed (conflict)
COMMIT;
```

### 5. Prevent Deadlocks
```java
// Bad: Random lock order causes deadlocks
public void transfer(String fromId, String toId, BigDecimal amount) {
    Account from = accountRepo.findById(fromId).lock(); // Lock 1
    Account to = accountRepo.findById(toId).lock();     // Lock 2
    // If another transaction locks in opposite order -> DEADLOCK
}

// Good: Consistent lock order prevents deadlocks
public void transfer(String fromId, String toId, BigDecimal amount) {
    List<String> sortedIds = Stream.of(fromId, toId).sorted().toList();
    Account first = accountRepo.findById(sortedIds.get(0)).lock();
    Account second = accountRepo.findById(sortedIds.get(1)).lock();
    // Always lock in sorted order -> No circular wait
}
```

### 6. Monitor and Tune
```sql
-- PostgreSQL: Monitor lock waits
SELECT
    blocked_locks.pid AS blocked_pid,
    blocked_activity.usename AS blocked_user,
    blocking_locks.pid AS blocking_pid,
    blocking_activity.usename AS blocking_user,
    blocked_activity.query AS blocked_statement,
    blocking_activity.query AS blocking_statement,
    blocked_activity.application_name AS blocked_application
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
JOIN pg_catalog.pg_locks blocking_locks
    ON blocking_locks.locktype = blocked_locks.locktype
    AND blocking_locks.database IS NOT DISTINCT FROM blocked_locks.database
    AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
    AND blocking_locks.pid != blocked_locks.pid
JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.granted;

-- MySQL: Check InnoDB status
SHOW ENGINE INNODB STATUS;

-- Check for deadlocks
SELECT * FROM information_schema.innodb_trx;
SELECT * FROM information_schema.innodb_locks;
SELECT * FROM information_schema.innodb_lock_waits;
```

---

# Common Pitfalls and Solutions

## Pitfall 1: Over-isolation

**Problem:** Using Serializable for everything kills performance.

```java
// WRONG: Serializable for simple read
@Transactional(isolation = Isolation.SERIALIZABLE)
public User getUserProfile(Long userId) {
    return userRepository.findById(userId);
}

// CORRECT: Read Committed sufficient
@Transactional(readOnly = true)
public User getUserProfile(Long userId) {
    return userRepository.findById(userId);
}
```

## Pitfall 2: Write Skew in Repeatable Read

**Problem:** Some databases (MySQL) don't prevent all anomalies at Repeatable Read.

```sql
-- Problem: Two doctors go off-call simultaneously
-- MySQL Repeatable Read may allow write skew

-- Solution: Use Serializable or explicit locking
BEGIN;
SELECT COUNT(*) FROM on_call WHERE on_duty = true FOR UPDATE;
-- Lock prevents concurrent modifications
UPDATE on_call SET on_duty = false WHERE doctor_id = 'Alice';
COMMIT;
```

## Pitfall 3: Long Transactions

**Problem:** Holding locks too long causes contention.

```python
# WRONG: Long-running transaction
with transaction('REPEATABLE_READ'):
    data = query_data()
    processed = complex_calculation(data)  # Takes 10 seconds
    send_email(processed)  # External API call
    save_result(processed)

# CORRECT: Minimize transaction scope
data = query_data()
processed = complex_calculation(data)  # Outside transaction
send_email(processed)  # Outside transaction
with transaction('READ_COMMITTED'):
    save_result(processed)  # Only DB operation in transaction
```

## Pitfall 4: Not Handling Serialization Failures

**Problem:** Serializable transactions can abort; must retry.

```typescript
// WRONG: No retry logic
async function bookSeat(flightId: string, passengerId: string) {
    await dataSource.transaction('SERIALIZABLE', async (manager) => {
        // ... booking logic ...
    });
    // If serialization failure occurs, user sees error
}

// CORRECT: Retry logic
async function bookSeat(flightId: string, passengerId: string) {
    const maxRetries = 3;
    for (let i = 0; i < maxRetries; i++) {
        try {
            await dataSource.transaction('SERIALIZABLE', async (manager) => {
                // ... booking logic ...
            });
            return; // Success
        } catch (error) {
            if (isSerializationError(error) && i < maxRetries - 1) {
                await sleep(100 * (i + 1));
                continue;
            }
            throw error;
        }
    }
}
```

---

# Summary

## Quick Reference Table

| Aspect              | Read Uncommitted              | Read Committed                  | Repeatable Read                    | Serializable                    |
| ------------------- | ----------------------------- | ------------------------------- | ---------------------------------- | ------------------------------- |
| **Dirty Reads**     | ✗ Allowed                     | ✓ Prevented                     | ✓ Prevented                        | ✓ Prevented                     |
| **Non-repeatable**  | ✗ Allowed                     | ✗ Allowed                       | ✓ Prevented                        | ✓ Prevented                     |
| **Phantom Reads**   | ✗ Allowed                     | ✗ Allowed                       | ⚠️ Varies by DB                     | ✓ Prevented                     |
| **Performance**     | ★★★★★ Highest                | ★★★★☆ High                      | ★★★☆☆ Medium                       | ★☆☆☆☆ Lowest                    |
| **Consistency**     | ★☆☆☆☆ Lowest                 | ★★★☆☆ Medium                    | ★★★★☆ High                         | ★★★★★ Highest                   |
| **Default in**      | None                          | PostgreSQL, SQL Server, Oracle  | MySQL/InnoDB                       | None                            |
| **Typical Use**     | Monitoring, approximate stats | Web apps, APIs, general purpose | Financial, order processing        | Critical constraints, compliance |
| **Lock Duration**   | None                          | Until statement ends            | Until transaction ends             | Until transaction ends + ranges |

## Key Takeaways

1. **Default is Usually Right**: Read Committed works for 80% of use cases.
2. **Upgrade When Needed**: Use Repeatable Read for financial operations, Serializable for critical constraints.
3. **Performance Trade-off**: Higher isolation = more consistency but less concurrency.
4. **Handle Failures**: Implement retry logic for Serializable transactions.
5. **Minimize Scope**: Keep transactions short and focused on database operations.
6. **Consistent Locking**: Always lock resources in the same order to prevent deadlocks.
7. **Monitor**: Track lock waits, deadlocks, and transaction durations in production.

---

# References

1. **Database System Concepts, 6th Edition** - Abraham Silberschatz, Henry F. Korth, S. Sudarshan - McGraw Hill (2010).
   - Chapter 14: Transactions.
   - Section 14.8: Transaction Isolation Levels.

2. **Fundamentals of Database Systems** - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).
   - Chapter 20: Transaction Processing.
   - Chapter 21: Concurrency Control Techniques.

3. **Designing Data-Intensive Applications** - Martin Kleppmann - O'Reilly (2017).
   - Chapter 7: Transactions.
   - Section: Weak Isolation Levels.

4. **Java Persistence with Hibernate, 2nd Edition** - Christian Bauer, Gavin King, Gary Gregory - Manning (2015).
   - Chapter 11: Transactions and Concurrency.
   - Section 11.2: Controlling Concurrent Access.

5. **SQL Standard (SQL-92)**: ISO/IEC 9075:1992
   - Transaction isolation level definitions.

6. **PostgreSQL Documentation**: https://www.postgresql.org/docs/current/transaction-iso.html
   - Transaction Isolation chapter.
   - Serializable Snapshot Isolation (SSI) implementation.

7. **MySQL Documentation**: https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html
   - InnoDB Transaction Isolation Levels.

8. **Microsoft SQL Server Documentation**: https://docs.microsoft.com/en-us/sql/t-sql/statements/set-transaction-isolation-level-transact-sql
   - SET TRANSACTION ISOLATION LEVEL reference.

9. **Oracle Database Concepts**: https://docs.oracle.com/en/database/oracle/oracle-database/19/cncpt/data-concurrency-and-consistency.html
   - Data Concurrency and Consistency.

10. [Concurrency control problems](Concurrency%20control%20problems.md)
11. [Two-phase locking protocol](Two-phase%20locking%20protocol.md)
12. [Locking operations](Locking%20operations.md)
13. [Deadlock](Deadlock.md)

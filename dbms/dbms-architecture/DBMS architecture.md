#dbms #software-engineering #software-architecture #query #optimization #os #file-system #secondary-storage #abstract-syntax-tree #compilation 

# Query processing
- ![600x700](Pasted%20image%2020240907204757.png)

## DDL commands
- DDL commands are <mark style="background: #e4e62d;">parsed</mark> by a DDL compiler and passed to the execution engine.
- Then it goes through the index/file/record manager to <mark style="background: #e4e62d;">alter metadata</mark> - schema information.
## Answering queries
- The raw query is parsed and <mark style="background: #e4e62d;">optimized</mark> by a query compiler, thereby generating a query plan. The query plan is passed to the execution engine.
- The execution engine issues a sequence of request for small pieces of data (records, tuples,...) to a resource manager, thereby generating <mark style="background: #e4e62d;">page commands</mark>
	- The resource manager is a component that knows about the data files, records and index files.
	- Page is a unit of I/O transfer in an operating system - 1 page = 1 block.
- The page commands are passed to the <mark style="background: #e4e62d;">buffer manager</mark> whose task is transfer blocks of data between secondary storage to main memory buffers.
- The buffer manager interacts with a <mark style="background: #e4e62d;">storage manager</mark> to retrieve disk data.
	- May involve operating system filesystem's commands.
	- Typically directly interact with disk controller.
## Transaction processing
- A transaction must be atomic, isolatedly executed and durable:
	- durable $\equiv$ when completed $\to$ preserve its effect.
- Includes:
	- Concurrency control manager - <mark style="background: #e4e62d;">Scheduler</mark> $\implies$ ensure atomicity and isolation.
	- <mark style="background: #e4e62d;">Logging</mark> and <mark style="background: #e4e62d;">recovery</mark> manager $\implies$ ensure transaction's durability.
# Query processor
- Also known as <mark style="background: #e4e62d;">Query Compiler</mark>.
- Transforms a raw query into a <mark style="background: #e4e62d;">query plan</mark> which is implemented by relational algebra.
- Consists of 3 components
## Query parser
- Builds the <mark style="background: #e4e62d;">AST</mark> from the raw query.
## Query preprocessor
- Performs <mark style="background: #e4e62d;">semantic analysis</mark> which turn AST tree into a tree of algebraic operators - the <mark style="background: #e4e62d;">initial query plan</mark>.
## Query optimizer
- Optimize the initial query plan into the <mark style="background: #e4e62d;">best available query plan</mark> according to the actual data.
# Execution engine
- Execute each step of the given query plan.
- Interacts with most of DBMS components:
	- Gets data from database into buffers to manipulate that data.
	- Works with scheduler to avoid accessing locked data
	- Works with log manager to to ensure appropriate loggings.

# Transaction processing
## Logging - recovery manager
- Whenever the system crashes, the recovery manager <mark style="background: #e4e62d;">examines the log</mark> of changes and <mark style="background: #e4e62d;">restore</mark> the database to a consistent state.
- The log manager initially <mark style="background: #e4e62d;">writes log in buffers</mark> and negotiate with the buffer manager to ensure that buffers will be written to disk at appropriate times.
## Cocurrency control
- Maintain locks to prevent two transactions <mark style="background: #e4e62d;">from accessing the same piece</mark> of data if neccesary.
## Deadlock resolution
- The transaction manager assumes the responsibility to <mark style="background: #e4e62d;">intervene and cancle</mark> one transaction to let other transaction proceed.
# Buffer manager
- [Buffer manager](Disk%20storage.md#Buffer%20manager)
---
# References
1. Database Systems: The Complete Book - H. G. Molina, J. D. Ullman, J. Widom, Prentice-Hall, 2009.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).
3. [ACID properties of Transaction](ACID%20properties%20of%20Transaction.md) 
4. [Buffer manager](Disk%20storage.md#Buffer%20manager)

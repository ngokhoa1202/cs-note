#dbms #dbms-architecture #secondary-storage #os  #virtual-memory 

# Length-based record
- File is a sequence of <mark style="background: #e4e62d;">record</mark>.
## Fixed-length record
- Every record has the same fields and field length are always <mark style="background: #e4e62d;">fixed</mark>.
- Example:
```c
struct employee {
	char name[30]; //30 bytes
	char ssn[9]; //9 bytes
	int salary; //4 bytes
	int job_code; //4 bytes
	char department[20]; //20 bytes
};
```
- ![](Pasted%20image%2020240913165237.png)
## Variable-length record
- Every record has the same fields but the field length are <mark style="background: #e4e62d;">changable</mark>.
- Special separator characters ($, ?, %,...) separates fields and terminates the record.
- ![](Pasted%20image%2020240913165923.png)
## Mixed record
- The record has both fix-length fields and variable-length field.
- Separator characters separate variable-length fields.
- A special character terminates the record.
# Record blocking
## Unspanned record
- A record is <mark style="background: #e4e62d;">not allowed to span</mark> more than one block $\equiv$ never crosses the block boundary.
- There is unused space in a block.
- [Blocking factor](Disk%20storage.md#Blocking%20factor)
- ![](Pasted%20image%2020240913172105.png)
## Spanned record
- A record is able to s<mark style="background: #e4e62d;">pan more than one block</mark>.
- If the record cannot be completely stored in a block, it will be partially stored on a specific block and the rest will be stored on another block. 
- Because the two blocks are not contiguous on the disk, a <mark style="background: #e4e62d;">pointer</mark> on the former block points the remainder on the latter block.
- ![](Pasted%20image%2020240913173348.png)


--- 
# References
1. HCMUT Advanced DBMS slides - Vo Thi Ngoc Chau.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015) - Chapter 16 - Section 4.
3. [Disk storage](Disk%20storage.md).

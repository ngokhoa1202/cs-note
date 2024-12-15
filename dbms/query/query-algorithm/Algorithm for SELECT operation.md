#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm 
#secondary-storage 

- Refers to [Relational Algebra](Relational%20Algebra.md).
- Refers to [Indexing structures](Indexing%20structures.md).
# Search method for Simple Selection
## Linear search
- Also known as brute-force approach.
- Retrieve <mark style="background: #e4e62d;">every record</mark> in the file, and test whether its attribute values satisfy the selection condition.
- Applicable for all cases.
## Binary search on unique attribute
- Only retrieve a <mark style="background: #e4e62d;">single record</mark>.
- If the selection condition involves an <mark style="background: #e4e62d;">equality comparison on a key attribute</mark> on which the file is ordered, binary search (which is more efficient than linear search) can be used.
## Using primary index or hash key
- Only retrieve a single record.
- If the selection condition involves an equality comparison on a key attribute with a primary index (or a hash key), use the primary index (or the hash key) to retrieve the record.
## Using primary index to retrieve multiple records
- Retrieve multiple records.
- If the <mark style="background: #e4e62d;">comparison conditio</mark>n is $>, <, \leq, \geq$ on a key field with a primary index, use the index to find the record satisfying the corresponding equality condition, then retrieve all subsequent records in the (ordered) file.
## Using a clustering index to retrieve multiple records
-  If the selection condition involves an <mark style="background: #e4e62d;">equality comparison on a nonkey attribute</mark> with a clustering index.
## Using a secondary (B+ tree) index on an equality condition
- This search method can be used to:
	- retrieve a single record if the indexing field is a key (has unique values). (1)
	- retrieve multiple records if the indexing field is not a key.
	- retrieve multiple records on the comparison condition $>,<,\leq,\geq$ (range queries).
## Using a bitmap index
- Retrieve multiple records.
- If the selection condition involves <mark style="background: #e4e62d;">a set of limited values</mark> for an attribute, the corresponding bitmaps for each value can be <mark style="background: #e4e62d;">OR-ed</mark> to give the set of record identifiers that qualify.
## Using a functional index
- Retrieve multiple records.
- If there is a functional index defined, this index can be used to retrieve all the records that qualify.
# Search methods for Conjunctive selection
- Conjunctive selection is also known as AND condition.
## Conjunctive selection using an individual index
- If an attribute involved in any <mark style="background: #e4e62d;">single simple condition</mark> in the conjunctive condition has an access path that permits the use of one of the methods S2 to S6:
	- use that condition to <mark style="background: #e4e62d;">retrieve the records</mark>. 
	- then <mark style="background: #e4e62d;">check</mark> whether each retrieved record<mark style="background: #e4e62d;"> satisfies the remaining simple conditions</mark> in the conjunctive condition.
## Conjunctive selection using a composite index
- If two or more attributes are involved in <mark style="background: #e4e62d;">equality conditions</mark> in the conjunctive condition and a composite index (or hash structure) exists on the combined field, the index can be used to access the target record.
## Conjunctive selection by intersection of record pointers
- Only feasible if:
	- <mark style="background: #e4e62d;">secondary indexes</mark> are available on all (or some of) the fields involved in <mark style="background: #e4e62d;">equality comparison</mark> conditions in the conjunctive condition and
	- the indexes include <mark style="background: #e4e62d;">record pointers</mark> (rather than block pointers). $\implies$ each index entry can directly reference to a record. 
- Each index can be used to retrieve the <mark style="background: #e4e62d;">set of record pointers</mark> that satisfy the individual condition.
- The <mark style="background: #e4e62d;">intersection</mark> of these sets of record pointers is then used to retrieve those records directly.
- If only some of the conditions have secondary indexes, each retrieved record is <mark style="background: #e4e62d;">further tested</mark> to determine whether it satisfies the remaining conditions.
# Search methods for Disjunctive selection
- Records satisfying the disjunctive condition are the <mark style="background: #e4e62d;">union</mark> of the records satisfying the individual conditions.
- If any one of the conditions does <mark style="background: #e4e62d;">not</mark> have an access path, <mark style="background: #e4e62d;">linear search</mark> is employed.
- Only if an access path exists on every simple condition in the disjunction can we optimize the selection by retrieving the records satisfying each condition - or their record ids - and then applying the union.
# Examples
## Scenario
- ![](Pasted%20image%2020240921152417.png)
- ![](Pasted%20image%2020241130140229.png)
## Assumptions
### Employee
- A clustering index on SALARY.
- A secondary index on the key attribute SSN.
- A secondary index on the nonkey attribute DNO.
- A secondary index on SEX.
### Department
- A primary index on DNUMBER.
- A secondary index on MGRSSN.
### Work_on
- A composite primary index on (ESSN, PNO)
## Solutions
1. $\sigma_{\text{SSN}=123456789}(\text{Employee})$
	- Equality condition on SSN which has secondary index $\implies$ secondary index search on SSN attribute. (1)
	- Linear search. (2)
2. $\sigma_{\text{Dnumber}>5}(\text{Department})$
	- Linear search (1)
	- Comparison condition on key DNUMBER with primary index $\implies$ use primary index to retrieve multiple records. (2)Conjunctive selection using an individual index
	- Binary search on key DNUMBER (3)
3. $\sigma_{\text{Dno}=5}(\text{Employee})$
	- Linear search. (1)
	- Equality condition on Dno with secondary index $\implies$ use secondary index on Dno to retrieve a single record. (2)
4. $\sigma_{\text{Dno}=5 \space \text{AND} \space \text{Salary}>30000 \space \text{AND} \space \text{Sex}=F}(\text{Employee})$
	- Linear search (1)
	- Conjunctive selection using an individual index (2)
		- Use secondary index on Dno to retrieve a single record and then check if that record satisfies the remaining conditions.
		- Use clustering index on Salary to retrieve multiple records and then check if those records satisfy the remaining conditions.
		- Use secondary index on SEX to retrieve a single record and then check if that record satisfy the remaining conditions.
	- Conjunctive selection using intersection of record pointers (3)
		- Use secondary index on Dno to retrieve a set of record pointers called $S_1$
		- Use clustering index on Salary to retrieve a set of record pointers called $S_2$
		- Use secondary index on SEX to retrieve a set of record pointers called $S_3$
		- Then intersect these three set of pointers $S_I=S_1 \cap S_2 \cap S_3$ and access the result records via the intersection set of pointers.
5. $\sigma_{\text{Dno}=5 \space \text{OR} \space \text{Salary}>30000 \space \text{OR} \space \text{Sex}=F}(\text{Employee})$
	- Linear search. (1)
	- Disjunctive selection by the union of records pointer. (2)
		- Use secondary index on Dno to retrieve a set of record pointers called $S_1$
		- Use clustering index on Salary to retrieve a set of record pointers called $S_2$
		- Use secondary index on SEX to retrieve a set of record pointers called $S_3$
		- Then union these three set of pointers $S_U=S_1 \cap S_2 \cap S_3$ and access the result records via the union set of pointers.
6. $\sigma_{\text{SSN}=123456789 \space \text{AND} \space \text{Pno}=10}(\text{Work\_on})$
	- Linear search (1)
	- Conjunction selection using a composite index. (2)
7. $\sigma_{\text{Dno} \space \text{in} \space \{3,27, 49 \}} (\text{Employee})$
	- Linear search (1)
	- Disjunctive selection by union of secondary index search:
		- Dno = 3.
		- Dno = 27.
		- Dno = 49.
		- The union of the three set of record pointers are used to access the result.
	- Use bitmap index on Dno because the number of values of Dno attribute can be limited.
8. $\sigma_{\text{Salary} \times \text{Commission\_pt} + \text{Salary}} (\text{Employee})$
	- Linear search.
	- Use functional index on $\text{Salary} \times \text{Commission\_pt} + \text{Salary}$ if exists.
---
# References
1. [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 18 - Section 3.
5. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
6. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.
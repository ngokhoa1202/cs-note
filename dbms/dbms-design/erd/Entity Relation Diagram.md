#dbms-design #dbms #erd-diagram 

- Stands for ==Entity-Relationship Diagram==.
- Easily understood by normal user.
- Does not involve any technical implementations.
# Basic notation
- ![](Pasted%20image%2020240614104537.png)
## Note
- An entity is made up of many attributes.
- Degree of a relationship: binary (2), ternary (3), n-ary.
- A relationship may be ==recursive==.
## Constrainsts
### Cardinality ratio
- 1-1.
- M-N.
- 1-N.
### Participation constraint
- Optional participation = Partial participation means that each entity may <mark style="background: #e4e62d;">either join or not join</mark>.
- Mandatory participation = Total pariticipation means that every entity must join.
- ![](Pasted%20image%2020240614105349.png)
## Weak entity
- Does not have its own key. $\implies$ does have ==partial key==.
- Must be ==accompanied with its owner== to identify itself.
- Keep a <mark style="background: #e4e62d;">mandatory participation</mark> constraint with its owner.
- ![](Pasted%20image%2020240614105644.png)
## Naming convention
- Noun for entity.
- Verb for relationship.

# Fan trap
## Problem
- Occurs in 1 - N relationship.
- ==Unambigious mapping==: an entity is ==indirectly mapped== to many distinct entities of the same table.
- ![](Pasted%20image%2020240617152433.png)
## Solution
- Switch entity position.
- ![](Pasted%20image%2020240617152710.png)
- But if still not working (e.g customer wants to know a staff works at which division in a certain branch)? $\implies$ ==add new relationship==.
# Chasm trap
## Problem
- An obvious mapping does not exist.
- ![](Pasted%20image%2020240617153019.png)
## Solution
- Add new relationship to resolve mappping shortage.
- ![](Pasted%20image%2020240617153120.png)


# Physical ERD
- Generated from database schema after executing DDL commands.
- ![](Pasted%20image%2020240912142224.png)

***
# References
1. HCMUT Database slides - Truong Quynh Chi.
2. https://www.lucidchart.com/pages/ER-diagram-symbols-and-meaning
3. 
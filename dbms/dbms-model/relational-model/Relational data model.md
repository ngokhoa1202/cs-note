#dbms #dbms-architecture  #dbms-design #rdbms #sql #microsoft-sql-server #mysql #postgresql #relational-model 

# Concepts
- ==Domain== $D(A_i)$ is a set of possible scalar values of an attribute.
- ==Relation schema== $R(A_1, A_2,..., A_n)$ where $A_i$ is attribute (table record is made up of value of each field). 
- ==Relation== $\tau(R)$ is a set of all possible tuples $\subseteq$ $A_1 \times A_2 \times ... \times A_n$
# Relational model constraints
## Constraints
- Implicit constraints $\equiv$ logical contraints ([Entity Relation Diagram](Entity%20Relation%20Diagram.md)).
- Explicit constraints $\equiv$ expressed in SQL.
- Semantic constraints $\equiv$ business rules.
### Domain constraint
- Described by DDL.
### Key constraint
#### Superkey
- The <mark style="background: #e4e62d;">set of all attributes</mark> which make a tuple unique in a relation schema.
#### Key
- Minimal superkey $\subseteq$ Superkey.
- Can remove any attribute as long as the <mark style="background: #e4e62d;">uniqueness</mark> of tuple is maintained.
- Choose <mark style="background: #e4e62d;">primary key</mark> $PK$ from the set of candidate keys.
#### Foreign key
- $D_{R_1}(FK)=D_{R_2}(PK)$ $\implies$ same domain.
- $t_1.FK =t_2.PK$ or NULL $\implies$ same value.
## Integrity constraint
- A relational schema ==must conform to== two constraints.
### Entity constraint
- Primary key $PK$ is not NULL.
## Referential constraint
- [Foreign key](Relational%20data%20model.md#Foreign%20key)
# Alternative terminology
- Industry prefers informal terminology.
- ![](Pasted%20image%2020240904202213.png)
- relationship relation $\equiv$ lookup table.
# References
1. 
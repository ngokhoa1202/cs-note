#object-oriented-programming #dbms #erd-diagram #sql #software-engineering #software-architecture #relational-model #relational-mapping 

# Mapping generalization & specialization - single inheritance
- There are <mark style="background: #e4e62d;">four approaches</mark>.
## Superclass table & subclass table
### Application
- Applicable for all kinds of specialization (totality, partiality, disjoint, overlap).
### Usage
- Map the superclass entity $E_P$ into a table having primary key $K$.
- Map each of its subclass into a table having primary key $K$ which is inherited from the superclass.
## Only subclass tables
### Application
- Applicable for <mark style="background: #e4e62d;">disjointedness</mark> constraints to avoid redundant records.
### Usage
- Remove the superclass table.
- Map each of its subclass into a table:
	- Having primary key $K$ inherited from the superclass.
	- Including all of the attributes from the superclass.
## Single table with one type attribute
### Application
- Applicable only for <mark style="background: #e4e62d;">disjointedness</mark> constraint to <mark style="background: #ADCCFFA6;">discriminate</mark> the actual type of records.
- Tolerates many NULL values.
### Usage
- Map the superclass and all of its subclasses into a <mark style="background: #e4e62d;">single table</mark>:
	- Having primary key $K$ of the superclass.
	- Including all attribute of the superclass.
	- Including all attribute of the subclasses.
	- Including an additional <mark style="background: #e4e62d;">type attribute</mark> to discriminate the actual subclass.
- Generates many NULL values.
## Single table with multiple type attributes
### Application
- Applicable for both disjointedness constraint and overlap constraint.
- Implies many trivial columns.
### Usage
- Map the superclass and all of its subclasses into a <mark style="background: #e4e62d;">single table</mark>:
	- Having primary key $K$ of the superclass.
	- Including all attribute of the superclass.
	- Including all attribute of the subclasses.
	- Including multiple boolean type attributes as flags to specify the actual subclass to which a record belongs. $\implies$ allows overlap constraints.
- Generates many annoying boolean flags.
# Mapping shared subclasses - multiple inheritance
## Application
- Applicable when all the clasess share the same primary key $K$; otherwise opt for mapping category.
## Usage
- Apply any solutions of [Mapping single inheritance](#Mapping%20generalization%20&%20specialization%20-%20single%20inheritance).
# Mapping category - union type
## Application
- Applicable when the superclasses have <mark style="background: #e4e62d;">distinct primary keys</mark>.
## Usage
- Map the category into a table:
	- Having a <mark style="background: #e4e62d;">surrogate key</mark>  $K_S$ as its primary key.
- Map each of the superclass into a table:
	- Including the <mark style="background: #e4e62d;">surrogate key</mark> $K_S$ as its foreign key.
- There are one table for every superclass and one additional table for category now now:
	- Table 1: $({\bf K_1}, \underline{K_S})$ represents superclass 1 and its category relationship.
	- Table 2: $({\bf K_2}, \underline{K_S})$ represents superclass 2 and its category relationship.
	- ...
	- Category table $({\bf K_S},...)$ represents category.
# Mapping of Strong entities
- Map the strong entity $E$ into a table.
- Map each single-valued attribute of entity into each column of table:
	- Decompose composite attributes.
- Map the primary key of entity into the primary key of table.
# Mapping of Weak entities
- Map the weak entity $W$ into a table.
- Map each single-valued attribute of entity into each column of table:
	- Decompose composite attributes.
- Combine the primary key of the weak entity's owner $PK_{E}$ with its partial key $PK_W$ to create the primary key of the table $(PK_E, PK_W)$.
# Mapping the binary 1:1 relationship
- Depends on the functionality, there are three approaches
## Foreign key
### Application
- Applicable when <mark style="background: #e4e62d;">only one</mark> of the entity is <mark style="background: #e4e62d;">mandatory</mark> in the relationship.
### Usage
- There are two entities $E_1$ and $E_2$ participating in the relationship. Their primary keys are $K_1$ , $K_2$..
- If $E_2$ is <mark style="background: #ADCCFFA6;">mandatory</mark> in the relationship, include the primary key of $E_1$ as a foreign key of $E_2$.
- There are two tables now:
	- Table 1: $({\bf K_1},...)$,  represents $E_1$
	- Table 2: (${\bf K_2}$, ..., $\underline{K_1}$) represents $E_2$ and the relationship.
## Merged table
### Application
- Only feasible when <mark style="background: #e4e62d;">both</mark> of the two entities are <mark style="background: #e4e62d;">mandatory</mark> in the relationship.
### Usage
- Map the relationship by <mark style="background: #e4e62d;">merging</mark> the two entites into a single entity.
## Lookup table
### Application
- Feasible for all cases.
- Applicable when:
	- Both of the two entities are optional.
	- One entity is mandatory and one entity is optional; however, there are too many NULL values.
### Usage
- Map the relationship by creating a new lookup table.

- The lookup table includes both $K_1$ and $K_2$ as its foreign keys:
	- One foreign key is primary key.
		- It must be $K_1$ in case entity $E_1$ is mandatory in the relationship.
		- Otherwise, prefer the entity with less NULL values.
	- One foreign key is unique key.
- There are 3 tables now:
	- Table 1: $({\bf K_1},...)$,  represents $E_1$
	- Table 2: (${\bf K_2}$, ..., $)  represents $E_2$ .
	- Lookup table $({\bf \underline{K_1}}, \underline{K_2})$  represents the relationship.
# Mapping the binary 1:N relationship
- There are two approaches:
## Foreign key
### Application
- Applicable when:
	- The entity <mark style="background: #e4e62d;">on the 1-side is mandatory</mark> and the entity on the N-side is optional.
	- Both of the entities are mandatory.
### Usage
- Assume $E_1$ is <mark style="background: #ADCCFFA6;">on the 1-side</mark> and $E_2$ is on the N-side.
- If $E_1$ is <mark style="background: #ADCCFFA6;">mandatory</mark> in the relationship, include the primary key of $E_1$ as a foreign key of $E_2$.
- There are 2 tables now:
	- Table 1: $({\bf K_1},...)$ represents $E_1$ and the relationship.
	- Table 2: $({\bf K_2},\space {\underline K_1}...)$ represents $E_2$.
## Look up table
### Application
- Feasible in all cases.
- Applicable when:
	- The entity on the N-side is mandatory but the entity on the 1-side is optional.
	- Both of the two entities are optional.
	- The entity on the 1-side is mandatory and the entity on the N-side is optional; however, there are too many NULL values.
### Usage
- The lookup table includes both $K_1$ and $K_2$ as its foreign keys.
	- Its primary key is the tuple of two foreign keys $({\bf \underline{K_1}, \underline{K_2}})$ .
- There are 3 tables now:
	- Table 1: $({\bf K_1},...)$ represents $E_1$.
	- Table 2: $({\bf K_2},...)$ represents $E_2$.
	- Look up table: $({\bf \underline{K_1}, \underline{K_2}},...)$ represents the relationship.
# Mapping the binary M:N relationship
- Always create a new <mark style="background: #e4e62d;">lookup table</mark>.
-  The lookup table includes both $K_1$ and $K_2$ as its foreign keys.
	- Its primary key is the tuple of two foreign keys $({\bf \underline{K_1}, \underline{K_2}})$ .
- There are 3 tables now:
	- Table 1: $({\bf K_1},...)$ represents $E_1$.
	- Table 2: $({\bf K_2},...)$ represents $E_2$.
	- Look up table: $({\bf \underline{K_1}, \underline{K_2}},...)$ represents the relationship.
# Mapping the multivalued attribute
- Always create a new lookup table.
- Assume the entity $E$ having primary key $K$ and a multivalued attribute $A$.
- The lookup table includes both $K$ and $A$ as its foreign keys:
	- Its primary key is the tuple of the two foreign keys $({\bf \underline{K}, \underline{A}})$ .
- There are 2 tables now:
	- Table 1: $({\bf K},...)$ represents $E$ without attribute $A$.
	- Look up table: $({\bf \underline{K}, \underline{A}},...)$ represents the relationship that each $E$ can have many $A$s. 
# Mapping the N-ary relationship
- Always opt for a new lookup table.
- There are 3 tables now:
	- Table 1: $({\bf K_1},...)$ represents $E_1$.
	- Table 2: $({\bf K_2},...)$ represents $E_2$.
	- Table 3: $({\bf K_3},...)$ represents $E_3$ .
	- Look up table: $({\bf \underline{K_1}, \underline{K_2}, \underline{K_3}},A_1,A_2,...)$ represents the relationship with $A_1, A_2,...$ are the attribute of the relationship itself. 

--- 
# References
1. HCMUT Database slides - Truong Quynh Chi.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015): 
	1. Chapter 9.
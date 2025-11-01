#dbms #sql #algebra #relational-algebra #query #relational-model 

- The background for operations in relational model.
- The result of an operation is a new relation $\implies$ <mark style="background: #e4e62d;">closure</mark>.
- Scenario:
	- ![](Pasted%20image%2020240921152417.png)
# Unary relational operation
## Sigma SELECT
- Select a <mark style="background: #e4e62d;">subset of tuples</mark> from a relation according to a specific <mark style="background: #e4e62d;">selection condition</mark> - horizontal partioning.
- Denoted by $\sigma_{\text{condition}}(R)$ where $R$ is a relation.
### Example
- Select the Employee tuples whose salary is greater than $3000:
	- $$\sigma_{\text{salary} > 3000}(\text{Employee})$$
### Characteristics
- Commutative $\equiv$ changing order does not change result.
- The cardinality of select operator $\sigma$ is smaller or equal to the cardinality of the relation $R$.
	- $$|\sigma_{\text{cond}}(R)| \leq |R|$$
## Pi Project
- Keeps specific attributes and discard other attributes - vertical partioning.
- Denoted by $\pi_{\text{attrbutes}}(R)$ 
### Example
- Select each employee's ssn, firstname, lastname and salary.
	- $$\pi_{\text{Fname, Lname, salary}}(\text{Employee})$$
### Characteristics
- Removes any duplicate tuples.
- The cardinality of **project** operator $\pi$ is smaller or equal to the cardinality of the relation $R$.
	- $$|\pi_{\text{attributes}}(R)| \leq |R|$$
	- If the a key of $R$ (primary key or secondary key) is included in the attribute list, the equality occurs.
- Not commutative.
- $$\pi_{l_1}(\pi_{l_2})=\pi_{l_1} \iff l_1 \subseteq l_2$$
## Rename rho
- Changes both relation name and its attribute 's name.
	- $$\rho_{S(a_1,a_2,...,a_n)}(R)$$
- Changes only relation name
	- $$\rho_{S}(R)$$
- Changes only attributes' name
	- $$\rho_{(a_1, a_2,...,a_n)}(R)$$

# Set relational operations

> [!Note]
> - $R$ and $S$ are <mark style="background: #e4e62d;">type compatible</mark>.
> 	- Has the same number of attributes.
> 	- Each pair of attributes must be type compatible - domain compatible:
> 		- `INT` vs `INT` 
> 		- `INT` vs `BIGINT` .
> 		- `CHAR(255)` vs `VARCHAR(255)` .
> 		- ~~`INT` vs `CHAR(255)`~~ 

## Union
- Denoted by $\cup$ 
- $R \cup S$ means that the new relation tuple is either in $R$ or in $S$ or both $R$ and $S$
	- The attribute name is kept.
- $R$ and $S$ must be type compatible.
### Characteristics
- Communicative.
- Associative.
## Intersection
- Denoted by $\cap$
- $R \cup S$ means that the new relation tuple must be in both $R$ and $S$:
	- The attribute name is kept.
- $R$ and $S$ must be type compatible.
### Characteristics
- Communicative.
- Associative.
## Set difference
- Denoted by $-$
- $R-S$ means that the new relation tuple must be in $R$ but not in $S$.
### Characteristics
- Associative.
## Catersian product
- Also known as Cross Join.
- Denoted by $\times$
- $R(a_1,a_2,...,a_m) \times S(b_1, b_2,...,b_n)$ results in the new relation.
	- $$R(a_1,a_2,...,a_m) \times S(b_1, b_2,...,b_n) = Q(a_1,a_2,...,a_m,b_1,b_2,...,b_n)$$
	- $Q$ has $m+n$ attributes.
	- $|R \times S| =|R| \times |S|$
- Type compatibility is not involved.

# Binary relational operation
## Join operation
- General case is also known as <mark style="background: #e4e62d;">Theta join</mark>.
- Denoted by $\bowtie_{\text{join condition}}$:
	- Join condition is any <mark style="background: #ABF7F7A6;">general boolean expression</mark>.
- Join operation is equivalent to a cartesian product followed by a select operation.
- $R(a_1,a_2,...,a_m) \bowtie_{\text{join condition}} S(b_1, b_2,...,b_n)$ means that:
	- Performs catersian product $R \times S$
		- $$R(a_1,a_2,...,a_m) \times S(b_1, b_2,...,b_n) = Q(a_1,a_2,...,a_m,b_1,b_2,...,b_n)$$
	- Performs select operation on $Q$ with respect to the join condition
		- $$R(a_1,a_2,...,a_m) \bowtie_{\text{join condition}} S(b_1, b_2,...,b_n)=\sigma_{\text{join condition}} (Q)=\sigma_{\text{join condition}}(R \times S)$$
### Characteristics
- The result of the new relation is the subset of the catersian product operation on $R$ and $S$
	- $$R \bowtie_{\text{join condition}} S \subseteq R \times S $$
### Equijoin operation
- The join condition must be an <mark style="background: #e4e62d;">equality</mark> condition.
- The name of attributes need not be identical because we can specify them in the join condition.
- $$R \bowtie_{a_i=b_j} S \equiv R \bowtie_{a_i,b_j} R$$
### Natural join operation
- Denoted by $\ast$.
- The join condition must be an equality condition; however, the two attributes must have the <mark style="background: #e4e62d;">same name</mark>.
- The second <mark style="background: #e4e62d;">superfluous join attribute is removed</mark>.
- $$R \ast_{\text{join attribute 1, join attribute 2,...}} S \equiv R \star S$$ 
## Division operation
- Denoted by $\div$
- $T=R \div S$ means that:
	- Assume the <mark style="background: #e4e62d;">sets of attributes</mark> of $R,S,T$ are $X, Y, Z$ respectively. The full form: $$T(Z)=R(X)-S(Y)$$
	- The requirement for the division operation is $Y \subset X$ (strictly). $\implies Z=X-Y \equiv$ $Z$ is composed of the attributes of $X$ which are not the attribute of $Y$ $\implies Y \times Z \subseteq X$ 
	- The new relation $T(Z)$ includes the tuple $t$ $\iff$ That tuple in $R$ called $t_R=t(X)$ and that tuple in $S$ called $t_S=t(Y)$ satisfy:
		- $$t_R(Y)=t_S \space, \forall t_S \in S$$
		- Select the tuple in $R$ which has its mapping to all the tuples of $S$. Then remove all the attributes of $S$ in that tuple.
### Example
- List all of the department manager.
	- Theta join style $$\text{Employee} \bowtie_{\text{ssn} = \text{mgr\_ssn}} \text{Department}$$
- List all department and its location
	- Equijoin style $$\text{Department} \bowtie_{\text{Dnumber, Dnumber}}  \text{Dept\_Locations}$$
	- Natural join style $$\text{Department} \ast \text{Dept\_Locations}$$
- Division operation example:
	 - ![](Pasted%20image%2020240922085640.png)
	- Tuple 123456789 exists in the division operation because its mapping in the Essn relation contains all of the tuple in Smith_Pnos including 1 and 2.
	- Tuple 453453453 exists in the division operation because its mapping in the Essn relation contains all of the tuple in Smith_Pnos including 1 and 2.
	- Tuple 666884444 doesn't exist in the division operation because its mapping in the Essn relation contains only tuple 3.
> [!info]
> The complete set of relational operations is $\{ \sigma, \pi, \cup, -, \times\}$ 

# Additional relational operations
## Aggregate function operations
- Includes sum, average, maximum, minimum and count.
- Denoted by $\mathscr{F}$ (script F),   $$\prescript{}{\text{group attribute}}{\mathscr{F}_{\text{function attribute 1}, \text{ function attribute 2,...}}(R)}$$
### Characteristics
- Count only counts the number of tuples but does not remove duplicate ones.
### Example
- Group employees by their department number, compute the number of employees and the average salary per department $$\prescript{}{\text{Dno}} {\mathscr{F}_{\text{count } Ssn, \space \text{average } Salary}(\text{Employee})}$$
## Recursive closure operations
- Applied to a recursive relationship between tuples of the same relation.
### Example
- For example:
	- The relationship between an employee and his supervisor implies level 1 of recursive closure.
	- Between a supervisor and his head of department $\implies$ level 2.
	- Between a head of department and his director $\implies$ level 3.
	- All of employees are listed in the Employee relation.
- Project ssn of the employees whose first name is Jack $$\text{Jack\_Ssn} \leftarrow \pi_{\text{ssn}}(\sigma_{\text{Fname}=\textquoteleft \text{Jack} \textquoteright}(\text{Employee})) $$
- Project table Employee on ssn and super ssn field$$\text{Supervision(ssn1, ssn2)} \leftarrow \pi_{\text{ssn, super\_ssn}}(\text{Employee})$$
- Find the employees directly supervised by Jack $\to$ level 1 $$\text{Emp}_1 = \pi_{\text{ssn1}}(\text{Supervision} \bowtie_{\text{ssn2}=\text{ssn}} \text{Jack\_Ssn})$$
- Find the employees who are supervised by his supervisor who are directly supervised by the employees whose firstname is Jack $\to$ level 2. $$\text{Emp}_2 = \pi_{\text{ssn1}}(\text{Supervision} \bowtie_{\text{ssn2}=\text{ssn}} \text{Emp}_1)$$
- Find the employees who are supervised at most two levels by the employees whose first name is Jack. $\to$ level 1 + level 2 $$\text{Emp}=\text{Emp}_1 \cup \text{Emp}_2$$
- Find all employees who are supervised by the employees whose first name is Jack $\to$ all levels $\implies$ <mark style="background: #e4e62d;">transitive closure</mark>.
## Outer union operations
- Designed to retrieve the union of the two relations which has the partially <mark style="background: #e4e62d;">compatible attributes</mark>:

- 
## Outer join operations
### Left outer join operation
- Denoted by $\ltimes$    
- $R \ltimes S$ means that:
	- Performs Catersian product on $R$ and $S$: $R \times S$.
	- Keep every attribute on the left operand $R$.
	- If there is no matching attribute in the right operand $S$, then the tuple is <mark style="background: #e4e62d;">padded with NULL value</mark>.
### Right outer join operation
-  Denoted by $\ltimes$    
- $R \rtimes S$ means that:
	- Performs Catersian product on $R$ and $S$: $R \times S$.
	- Keep every attribute on the right operand $S$.
	- If there is no matching attribute in the left operand $R$, then the tuple is padded with NULL value.
### Example
- List all the employee names and the name of the department they are managing $\to$ Left outer join.
	- $$\pi_{\text{fname, minit, lname, dname}}(\text{Employee} \ltimes_{\text{ssn} = \text{mgr\_ssn}} \text{Department})$$
	- ![](Pasted%20image%2020240922101346.png)
- List all project name and its employee collaborators' name (Some project is planned but their tasks have not been assigned to employee) $\to$ right outer join.
	- $$\pi_{\text{pname, fname, lname, hours}}(\text{Employee} \rtimes_{\text{ssn} = \text{essn}} (\text{Project} \Join_{\text{pno} = \text{pnumber}} \text{Work\_on}))$$

# References
1. HCMUT Basic DBMS Slides - Truong Quynh Chi.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Relational algebra concepts.
	2. Relational algebra exercises.
3. [Relational data model](Relational%20data%20model.md) for informal terminologies.
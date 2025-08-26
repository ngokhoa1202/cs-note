#relational-algebra  #relational-model #query #dbms #rdbms #sql 

# Schema
- ![](Pasted%20image%2020240921152417.png)
# Query examples
## Query 1
### Requirement
- Retrieve the name and address of all employees who work for the "Research" development.
### Solution
- First, select department number for "Research" department. $$\text{Research\_dept} \leftarrow \pi_{\text{Dnumber}}(\sigma_{\text{Dname}=\textquoteleft \text{Research} \textquoteright}(\text{Department}))$$
- Then, join the Research_dept with employee and project the name and address of employee. $$\text{Emp} \leftarrow \pi_{\text{Fname, Lname, Address}}(\text{Employee} \bowtie_{\text{Dno}=\text{Dnumber}} \text{Research\_dept})$$
## Query 2
### Requirement
- For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.
### Solution
- First, select Pnumber and Dnum for projects at "Stafford" $$\text{Stafford\_projs} \leftarrow \pi_{\text{Pnumber, Dnum}}(\sigma_{\text{Plocation}=\text{"Stafford"}}(\text{Project}))$$
- Second, join with Department to retrieve Mgr_ssn $$\text{Stafford\_projs\_dept} \leftarrow \pi_{\text{Pnumber, Dnum, Mgr\_ssn}}(\text{Stafford\_projs} \bowtie_{\text{Dnum}=\text{Dnumber}} \text{Department})$$
-  Finally, join the employee and retrieve results. $$\text{Stafford\_projs\_dept\_mgr} \leftarrow \pi_{\text{Pnumber, Dnum, Lname, Address, Bdate}}(\text{Stafford\_projs\_dept} \bowtie_{\text{Mgr\_ssn}=\text{Ssn}}\text{Employee})$$
## Query 3
### Requirement
- Find the names of employees who work on all the projects controlled by department number 5.
### Solution
- First, select project with Dnum being 5. $$\text{Dept5\_projs} \leftarrow \pi_{\text{Pnumber, Dnum}}(\sigma_{\text{Dnum}=5}(\text{Project}))$$
- Second, join with works_on table $$\text{Dept5\_projs\_works\_on} \leftarrow \pi_{\text{Essn, Pno}}(\text{Dept5\_projs} \bowtie_{\text{Pno}=\text{Pnumber}} \text{Works\_on})$$
- Then, project only Pno column to prepare for division. $$\text{Dept5\_projs\_pno} = \pi_{\text{Pno}}(\text{Dept5\_projs\_works\_on})$$
- To retrieve the employees who work on all projects controlled by department whose department number is 5, divide Dept5_projs_works_on by Dept5_projs_pno to receive essn. $$\text{Essn\_works\_on\_dept5\_projs} \leftarrow \text{Dept5\_projs\_works\_on} \div \text{Dept5\_projs\_pno}$$
- Finally, use those essn to join employee table and retrieve result. $$\text{Emp} \leftarrow \pi_{\text{Fname, Lname}}(\text{Essn\_works\_on\_dept5\_projs} \bowtie_{\text{Essn}=\text{Ssn}}\text{Employee})$$
- 
---
# References
1. [Relational Algebra](Relational%20Algebra.md) for concepts and operator definition.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Relational algebra concepts.
	2. Relational algebra exercises.
3. 
#sql #postgresql #ddl 

# Create table
```Postgresql title='Create table DDL'
create table emp_job_titles (
  "id" int primary key,
  emp_id varchar(255) not null,
  title_id int not null,

  constraint fk_employees
    foreign key (emp_id)
	  references employees(employee_id),
  constraint fk_job_titles
    foreign key (title_id)
	  references job_titles("id"),
  unique (emp_id, title_id)
);
```

--- 
# References
1. https://neon.tech/postgresql/postgresql-tutorial/postgresql-unique-constraint
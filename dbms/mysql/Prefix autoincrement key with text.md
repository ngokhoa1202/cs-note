#mysql #dbms #rbdms 

# Method
- Define a new table for auto-increment key.
```SQL
CREATE TABLE employees_seq ( id INT AUTO_INCREMENT PRIMARY KEY );
```

- Define a trigger that inserts into that new table and prefixes its id with known text.
```SQL
DELIMITER $$

CREATE TRIGGER insert_employees
BEFORE INSERT ON employees
FOR EACH ROW

BEGIN
	INSERT INTO employees_seq
	VALUES (NULL);
	SET NEW.employee_id = CONCAT(NEW.employee_id, LPAD(LAST_INSERT_ID(), 4, '0'));
END$$

DELIMITER ;
```

#sql #rdbms #postgresql 

# Sequence
```Sql title='Sequence example in Postgresql'
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;
```
---
# References
1. 
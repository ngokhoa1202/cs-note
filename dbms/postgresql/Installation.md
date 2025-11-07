#operating-system #fedora #ubuntu #windows #postgresql #dbms 

# Installation
## Fedora OS
- Follows https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
# Reset credential
- Run with superuser permission to suppress password requirement and use `postgres` username 
```bash
sudo -u postgres psql
```

- Create a new user.
```sql
CREATE USER <username> with PASSWORD '<password>';
```

- Grant superuser permission to a username.
```postgresql
ALTER USER <username> WITH SUPERUSER;
```
# References
1. https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
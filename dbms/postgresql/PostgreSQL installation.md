#dbms #postgresql #installation #ubuntu #shell #rdbms 

# Download PostgreSQL
- https://www.postgresql.org/download/
# Log into PostgreSQL
- Default username is `postgres`
- Use command: `sudo -u postgres psql`
# Set up new user
- Add new user using command `CREATE ROLE <role_name> LOGIN PASSWORD <'password'>;`
- List user in postgreSQL: `psql` \\ `du` (remember backflash).
- If still errors, create database with `<user>` using cmd: `createdb <user>`.
# Install pgadmin
- https://www.pgadmin.org/download/pgadmin-4-apt/
- Create database in cmd $\implies$ create server in pgadmin.

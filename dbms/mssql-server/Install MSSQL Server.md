#microsoft #dbms #sql #microsoft-sql-server  #cli #ubuntu 

# Install MSSQL 2022
- https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver16&tabs=ubuntu2204

# Start MSSQL Service
## Ubuntu
- Start the `mssql-server` service in the `systemctl` $\implies$ [Systemctl commands](operating-system/linux/Systemctl%20commands.md) 

# Login via command line
```bash title='Login into MSSQL Server via command line'
sqlcmd -S 127.0.0.1 -U sa -P '<password>' -C # Login for the first time


```
# References
1. https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver16&tabs=ubuntu2204 for install MSSQL 2022.
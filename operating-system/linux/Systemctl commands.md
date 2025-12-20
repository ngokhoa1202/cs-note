#ubuntu #cli #operating-system #process #configuration  #debian 

# General syntax
```bash
systemctl subcommand argument
```
- Maybe use the `sudo` command .
# Service management
## List all available service
```bash
systemctl list-units --type=service
```

## List active service
```bash
systemctl list-units --type=service --state=active
```

`active` is one of the states. Other states are `running`, `stopped`, `enabled`, `disabled` and `failed`.

## Start a service
- Equivalent to start a new process  $\implies$ load it into main memory.
```bash
systemctl start {servicename}
```

- For example `mssql-server` service (MSSQL)
```bash
systemctl start mssql-server
```

## Stop a service
- Equivalent to kill a runing process $\implies$ remove it from main memory.
```bash
systemctl stop {servicename}
```

## Restart a service
```bash
systemctl restart {servicename}
```

## Enable a service.
- Allows a service to start during the system is booting.
```bash
systemctl enable {servicename}
```
## Disable a service
- Prevents a service from starting during the system is booting.
```bash
systemctl disable {servicename}
```

## Check the service status
```bash
systemctl status {service-name}
```

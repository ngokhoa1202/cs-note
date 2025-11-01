#docker #ci-cd #cli #ubuntu 

# Docker basic information
- `docker version`: Check docker client and docker engine version on your host.
- `docker info`: Check general information of containers, path of command line, ... on localhost.
- `docker`: Check all available commands.
# Docker image
- List all installed images in the local host.
```bash
docker images
```

# Docker container
## List container
### Syntax
```bash
docker container ls [OPTIONS]
```

or 
```bash
docker ps [OPTIONS]
```

- If not specify anything option, the command shows only ==running containers== by default.
### Options
#### List all already runned container
- `-a` or `--all`: List all containers.

# Docker image
## List image
```bash
docker image ls
```
or 
```bash
docker images
```




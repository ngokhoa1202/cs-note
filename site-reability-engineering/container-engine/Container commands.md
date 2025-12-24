#cli #docker #continuous-integration #operating-system #container #computer-network #application-layer #transport-layer #ubuntu #secondary-storage #network-layer  #file-system #volume 
# General syntax
```bash
docker <cmd> <sub-cmd> (options)
```
# Docker container run
## Behavior
- ==Create and run a new container== for an image. If the specified image is not found, Docker Engine will automagically ==pull== it from Docker Hub.
- If the container name has already existed, docker stops running the new container.
## Syntax
```bash
sudo docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
```
## Options
### Attached mode
- `-a` or `--attach` ==attach container to the terminal== stdin, stdout $\implies$ all logs are shown to the current terminal.
### Detached mode 
- `-d` or `--detach` run container as ==background process==, detach it from stdin, stdout of the current terminal:
	- Return the container id on terminal.
### Publish port - Expose port
- `-p` or `--publish` publish the container ==port== to the host:
	- If the IP address is not specified, broadcast address `0.0.0.0` will be employed.
	- Bind the left host port to the right container port.
```Shell title='Publish port in Docker'
docker run -d -p HOST_PORT:CONTAINER_PORT nginx

docker run -p 127.0.0.1:8080:80/tcp nginx:alpine
```
### Rename container
- `--name` assign a new name for the container.
- Name must be unique per container.
### Environment variable
- `-e` or `--env` indicates environment variable.
- Each variable must be accompanied with a `-e` flag.
### Interactive input
- `-i` or `--interactive`: Keep the `stdin` open while running the container $\implies$ user can enter input to the current terminal.
- `-t` or `--tty`: Connect the input of the current terminal to the I/O stream of the container.
$\implies$ `-it` flag to connect and work with the container's shell, if the type of terminal is not specified, it is `bash`
$\implies$ The container's shell works the same as the Ubuntu shell.
### Connect to a network
- `--network` : Connect the container to a docker virtual network.
### Automatically remove after exiting
- `--rm`: clean up the container after exiting.
### Bind mount a volume
- `-v` or `--volume`: Bind a docker volume to a host's directory. Docker will automagically create a new directory for only Docker files inside that  host's directory.
	- The `-v` follows the pattern `-v [VOLUME_NAME_OR_HOST_PATH]:[CONTAINER_PATH]:[OPTIONS]`
```Shell title='Docker'
docker container run -a=stdout -a=stderr -i -v mysql-db:/var/lib/mysql -p 127.0.0.1:3306:3306/tcp -e \
  MYSQL_ALLOW_EMPTY_PASSWORD=yes --rm mysql:lts
```
# Docker container stop
## Syntax
```bash
docker container stop CONTAINER+
```
- The container id may not be completely specified.
## Behavior
- Return the name / id of the container.
# Docker container start
## Syntax
```bash
docker container start CONTAINER
```
## Behavior
- Start a stopped container.
# Docker container logs
## Behavior
- ==Display all logs== related to a specific container.
## Syntax
```bash
docker container logs [OPTIONS] CONTAINER
```
# Docker container top
## Behavior
- Display the ==running process== of a specific container.
## Syntax
```bash
docker container top CONTAINER
```
# Docker container ls
- List running containers.
```Shell title='List running containers'
docker container ls
```
# Docker container rm
## Behavior
- ==Remove== a or multiple containers.
## Syntax
- Use BNF grammar
```bash
docker container rm [OPTIONS] CONTAINER+
```
## Options
### Remove running container
- `-f` or `--force`: By default, Docker does not remove running container. This flag forces Docker to remove a running container.
	- Or run `docker container stop` to make that container stop running before removing it.
# Docker container inspect
## Behavior
- Display the container's configuration (name, driver, platform, listening port, dns, ip).
## Syntax
```bash
docker container inspect CONTAINER
```

# Docker container stats
## Behavior
- Display container's ==performance statistics==.
## Syntax
```bash
docker container stats [OPTIONS]
```
## Options
- `-a` or `--all`: Display all containers.
- `--no-stream`: Display only the first result. Turn off streaming stats.
# Docker container exec
## Behavior
- <mark style="background: #e4e62d;">Execute a new command</mark> for the running container $\equiv$ start a new process.
## Syntax
```bash
docker container exec [OPTIONS] CONTAINER COMMAND ARG*
```

## Options
### Interactive input
- `-i` or `--interactive`: Keep the stdin open while running the container $\implies$ user can enter input to the current terminal.
- `-t` or `--tty`: Connect the input of the current terminal to the I/O stream of the container.
$\implies$ `-it` flag to connect and work with the container's shell, if the type of terminal is not specified, it is `bash`
$\implies$ The container's shell works the same as the ubuntu shell.

# Docker container port
## Behavior
- List all mapping ports of a container.
## Syntax
```bash
docker container port CONTAINER
```

# Example
## Run container from mysql image
```bash
sudo docker run --publish 127.0.0.1:3306:3306/tcp --env MYSQL_ROOT_PASSWORD=12022002 --detach mysql:latest
```
- Left `3306` is the local host port, right `3306` is the port of the container containing `mysql` image $\implies$ ==route all traffic== coming to left port `3306` on local host to right port `3306` on container.
- Use TCP protocol on transport layer.
## Start and interactively work with the container's shell
```bash
docker container run -it -p 127.0.0.1:8080:80 --name proxy nginx:stable-perl bash
```
- `bash` is the type of shell we want to use.
- If not specified, bash is employed by default.
## Open the running container's shell
```Shell
docker container exec -it nginx bash
```
- Enter `exit` to exit bash.
## Ping between the two containers in the same virtual network
```Shell
docker container exec -it nginx ping another-nginx
```
***
# References
1. https://docs.docker.com/reference/cli/docker/container/run/#ipc for `docker run` command official documentation.
2. https://hub.docker.com/_/mysql
4. https://docs.docker.com/reference/cli/docker/container/ for all docker container command documentaion.
5. [OCI-compliant container](site-reability-engineering/container-engine/OCI-compliant%20container.md) for introduction to docker container.
6. 


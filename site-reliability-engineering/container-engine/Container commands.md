#shell #docker #continuous-integration #operating-system #containerization #computer-network #application-layer #transport-layer #ubuntu #secondary-storage #network-layer  #file-system #volume #podman #linux #fedora #centos-stream #rhel 
# General syntax
```Shell
docker <cmd> <sub-cmd> (options)
```
# Docker container run
## Behavior
- ==Create and run a new container== for an image. If the specified image is not found, Docker Engine will automagically ==pull== it from Docker Hub.
- If the container name has already existed, docker stops running the new container.
## Syntax
```Shell title=''
sudo docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
```
## Options
### Attached mode
- `-a` or `--attach` ==attach container to the terminal== stdin, stdout $\implies$ all logs are shown to the current terminal.
```Shell title='Attach to stdout and stderr only'
docker container run -a stdout -a stderr ubuntu:22.04 echo "Hello from container"

docker container run -a stdout redis:alpine
```
- Useful when you want to see output but not provide input.
- Can selectively attach to `stdin`, `stdout`, or `stderr`.
### Detached mode
- `-d` or `--detach` run container as ==background process==, detach it from stdin, stdout of the current terminal:
	- Return the container id on terminal.
```Shell title='Run web server in background'
docker container run -d -p 8080:80 --name web nginx:alpine

docker container run -d --name redis-cache redis:7-alpine

docker container run -d --name postgres-db -e POSTGRES_PASSWORD=secret postgres:15-alpine
```
- Container runs in background, returning container ID.
- Access logs later with `docker container logs`.
### Publish port - Expose port
- `-p` or `--publish` publish the container ==port== to the host:
	- If the IP address is not specified, broadcast address `0.0.0.0` will be employed.
	- Bind the left host port to the right container port.
```Shell title='Publish port in Docker'
docker run -d -p 8080:80 nginx

docker run -p 127.0.0.1:8080:80/tcp nginx:alpine

docker run -d -p 3000:3000 -p 9229:9229 --name node-app node:18-alpine

docker run -d -p 5432:5432/tcp -p 5432:5432/udp postgres:15
```
- First example: Bind host port $8080$ to container port $80$, accessible from all interfaces.
- Second example: Bind only to localhost `127.0.0.1`, restricting external access.
- Third example: Publish multiple ports for Node.js app (HTTP on $3000$, debugger on $9229$).
- Fourth example: Publish same port for both TCP and UDP protocols.
### Rename container
- `--name` assign a new name for the container.
- Name must be unique per container.
```Shell title='Assign custom container names'
docker run -d --name production-api nginx:alpine

docker run -d --name mysql-primary -e MYSQL_ROOT_PASSWORD=secret mysql:8

docker run --name temp-worker --rm alpine:latest echo "Task completed"
```
- Named containers easier to reference than random names or IDs.
- Useful for scripts and documentation.
### Environment variable
- `-e` or `--env` indicates environment variable.
- Each variable must be accompanied with a `-e` flag.
```Shell title='Set environment variables'
docker run -d --name postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=appdb postgres:15

docker run -d --name app -e NODE_ENV=production -e API_KEY=xyz123 -e PORT=3000 node:18-alpine

docker run -d --name redis -e REDIS_PASSWORD=redispass -e REDIS_MAXMEMORY=256mb redis:alpine
```
- Environment variables configure container runtime behavior.
- Sensitive data like passwords should use secrets instead in production.
### Interactive input
- `-i` or `--interactive`: Keep the `stdin` open while running the container $\implies$ user can enter input to the current terminal.
- `-t` or `--tty`: Connect the input of the current terminal to the I/O stream of the container.
$\implies$ `-it` flag to connect and work with the container's shell, if the type of terminal is not specified, it is `bash`
$\implies$ The container's shell works the same as the Ubuntu shell.
```Shell title='Interactive shell access'
docker run -it ubuntu:22.04 bash

docker run -it --name python-repl python:3.11 python

docker run -it --name mysql-client mysql:8 mysql -h database.example.com -u admin -p

docker run -it --rm alpine:latest sh
```
- First example: Open bash shell in Ubuntu container.
- Second example: Start Python REPL for testing code.
- Third example: Run MySQL client to connect to remote database.
- Fourth example: Temporary Alpine shell that removes itself on exit.
### Connect to a network
- `--network` : Connect the container to a docker virtual network.
```Shell title='Connect to custom network'
docker network create app-network

docker run -d --name backend --network app-network node:18-alpine

docker run -d --name database --network app-network postgres:15

docker run -d --name frontend --network app-network -p 80:3000 react-app:latest
```
- Containers on same network can communicate using container names as hostnames.
- Backend can connect to database using `postgres://database:5432`.
### Automatically remove after exiting
- `--rm`: clean up the container after exiting.
```Shell title='Auto-remove container after exit'
docker run --rm alpine:latest echo "One-time task"

docker run --rm -v $(pwd):/workspace node:18-alpine npm install

docker run -it --rm ubuntu:22.04 bash

docker run --rm --name test-db -e POSTGRES_PASSWORD=test postgres:15-alpine
```
- Useful for one-off commands and testing.
- Container and its writable layer deleted immediately after exit.
- Volumes and networks are preserved.
### Bind mount a volume
- `-v` or `--volume`: Bind a docker volume to a host's directory. Docker will automagically create a new directory for only Docker files inside that  host's directory.
	- The `-v` follows the pattern `-v [VOLUME_NAME_OR_HOST_PATH]:[CONTAINER_PATH]:[OPTIONS]`
```Shell title='Volume mounts'
docker container run -d --name mysql -v mysql-db:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret mysql:8

docker run -d --name nginx -v $(pwd)/html:/usr/share/nginx/html:ro nginx:alpine

docker run -d --name postgres -v pgdata:/var/lib/postgresql/data -v $(pwd)/backups:/backups postgres:15

docker container run -a=stdout -a=stderr -i -v mysql-db:/var/lib/mysql -p 127.0.0.1:3306:3306/tcp -e \
  MYSQL_ALLOW_EMPTY_PASSWORD=yes --rm mysql:lts
```
- First example: Named volume `mysql-db` persists database data.
- Second example: Bind mount local directory as read-only `ro`.
- Third example: Multiple volumes - one for data, one for backups.
- Fourth example: Complex container with volume, port, env vars, and auto-remove.
# Docker container stop
## Syntax
```bash
docker container stop CONTAINER+
```
- The container id may not be completely specified.
## Behavior
- Send `SIGTERM` signal to gracefully stop the container.
- Wait for $10$ seconds before sending `SIGKILL` to force termination.
- Return the name / id of the container.
## Examples
```Shell title='Stop single container'
docker container stop nginx

docker container stop a1b2c3d4

docker container stop web-server
```
```Shell title='Stop multiple containers'
docker container stop web-1 web-2 web-3

docker container stop $(docker container ls -q)
```
- First example: Stop container by name or partial ID `a1b2c3d4`.
- Second example: Stop all running containers using command substitution.
## Options
- `-t` or `--time`: Seconds to wait before killing container, default is $10$.
```Shell title='Stop with custom timeout'
docker container stop -t 30 database

docker container stop --time 5 worker
```
- Useful for databases requiring longer graceful shutdown time.
# Docker container start
## Syntax
```bash
docker container start [OPTIONS] CONTAINER+
```
## Behavior
- Start one or more stopped containers.
- Container resumes with same configuration as when it was stopped.
## Examples
```Shell title='Start stopped containers'
docker container start nginx

docker container start web-1 web-2 db-server

docker container start -a nginx
```
- Third example: `-a` attaches to container output after starting.
## Options
- `-a` or `--attach`: Attach stdout and stderr to terminal.
- `-i` or `--interactive`: Attach stdin to container.
```Shell title='Start with interactive mode'
docker container start -ai ubuntu-container
```
- Useful for restarting stopped interactive containers.
# Docker container logs
## Behavior
- ==Display all logs== related to a specific container.
- Shows stdout and stderr from container's main process.
## Syntax
```bash
docker container logs [OPTIONS] CONTAINER
```
## Options
- `-f` or `--follow`: Follow log output in real-time, similar to `tail -f`.
- `-n` or `--tail`: Number of lines to show from end of logs.
- `-t` or `--timestamps`: Show timestamps for each log entry.
- `--since`: Show logs since timestamp or relative time.
- `--until`: Show logs before timestamp or relative time.
## Examples
```Shell title='View container logs'
docker container logs nginx

docker container logs -f web-app

docker container logs --tail 100 api-server

docker container logs -f --tail 50 backend
```
- Second example: Follow logs in real-time.
- Third example: Show last $100$ lines.
- Fourth example: Show last $50$ lines and follow.
```Shell title='Logs with timestamps and time range'
docker container logs -t nginx

docker container logs --since 2024-01-18T10:00:00 web-app

docker container logs --since 1h api-server

docker container logs --since 30m --until 10m worker
```
- Second example: Logs since specific timestamp.
- Third example: Logs from last hour.
- Fourth example: Logs from $30$ minutes ago until $10$ minutes ago.
# Docker container top
## Behavior
- Display the ==running process== of a specific container.
- Shows PID, user, CPU%, memory%, and command.
## Syntax
```bash
docker container top CONTAINER [ps OPTIONS]
```
## Examples
```Shell title='View container processes'
docker container top nginx

docker container top web-app

docker container top postgres aux
```
- Third example: Pass `aux` flags to underlying `ps` command for detailed output.
```Shell title='Monitor processes in multiple containers'
docker container top nginx | grep nginx

docker container top database -eo pid,comm,etime
```
- Second example: Custom `ps` format showing PID, command, and elapsed time.
# Docker container ls
## Behavior
- List running containers.
- Shows container ID, image, command, status, ports, and names.
## Syntax
```Shell
docker container ls [OPTIONS]
```
## Options
- `-a` or `--all`: Show all containers including stopped ones.
- `-q` or `--quiet`: Only display container IDs.
- `-s` or `--size`: Display total file sizes.
- `-n`: Show last n created containers.
- `--filter` or `-f`: Filter output based on conditions.
- `--format`: Format output using Go template.
## Examples
```Shell title='List containers'
docker container ls

docker container ls -a

docker container ls -q

docker container ls -a -q
```
- First example: List only running containers.
- Second example: List all containers including stopped.
- Third example: Show only IDs of running containers.
- Fourth example: Show only IDs of all containers.
```Shell title='List with size and filter'
docker container ls -s

docker container ls -n 5

docker container ls --filter "status=exited"

docker container ls --filter "name=web"

docker container ls --filter "ancestor=nginx:alpine"
```
- First example: Display container sizes.
- Second example: Show last $5$ created containers.
- Third example: Show only exited containers.
- Fourth example: Filter by name pattern.
- Fifth example: Filter by image.
```Shell title='Custom format output'
docker container ls --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"

docker container ls --format "{{.Names}}: {{.Status}}"

docker container ls -a --format "{{.Names}}\t{{.State}}\t{{.Ports}}"
```
- First example: Table format with ID, image, status.
- Second example: Simple format showing name and status.
- Third example: Show name, state, and port mappings.
# Docker container rm
## Behavior
- ==Remove== a or multiple containers.
- Container must be stopped before removal unless using `-f` flag.
## Syntax
- Use BNF grammar
```bash
docker container rm [OPTIONS] CONTAINER+
```
## Options
### Remove running container
- `-f` or `--force`: By default, Docker does not remove running container. This flag forces Docker to remove a running container.
	- Or run `docker container stop` to make that container stop running before removing it.
- `-v` or `--volumes`: Remove anonymous volumes associated with the container.
## Examples
```Shell title='Remove stopped containers'
docker container rm nginx

docker container rm web-1 web-2 db-server

docker container rm $(docker container ls -aq --filter "status=exited")
```
- First example: Remove single stopped container.
- Second example: Remove multiple stopped containers.
- Third example: Remove all exited containers using filter.
```Shell title='Force remove running container'
docker container rm -f nginx

docker container rm -f $(docker container ls -q --filter "name=temp")

docker container rm -fv test-container
```
- Second example: Force remove all containers with name pattern `temp`.
- Third example: Force remove container and its anonymous volumes.
# Docker container inspect
## Behavior
- Display the container's configuration (name, driver, platform, listening port, dns, ip).
- Returns JSON array with detailed container metadata.
## Syntax
```bash
docker container inspect [OPTIONS] CONTAINER+
```
## Options
- `-f` or `--format`: Format output using Go template.
- `-s` or `--size`: Display total file sizes.
## Examples
```Shell title='Inspect container configuration'
docker container inspect nginx

docker container inspect web-1 web-2

docker container inspect --size nginx
```
- First example: Full JSON output of container configuration.
- Second example: Inspect multiple containers.
- Third example: Include filesystem size information.
```Shell title='Format specific fields'
docker container inspect -f '{{.State.Status}}' nginx

docker container inspect -f '{{.NetworkSettings.IPAddress}}' web-app

docker container inspect -f '{{.Config.Env}}' api-server

docker container inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx

docker container inspect -f '{{json .Mounts}}' database | jq
```
- First example: Get container status.
- Second example: Get container IP address.
- Third example: Get environment variables.
- Fourth example: Get IP from all networks.
- Fifth example: Get mounts in JSON format and pipe to `jq` for formatting.
# Docker container stats
## Behavior
- Display container's ==performance statistics==.
- Shows CPU%, memory usage, memory limit, network I/O, block I/O, PIDs.
- Real-time streaming by default.
## Syntax
```bash
docker container stats [OPTIONS] [CONTAINER+]
```
## Options
- `-a` or `--all`: Display all containers including stopped ones.
- `--no-stream`: Display only the first result. Turn off streaming stats.
- `--no-trunc`: Do not truncate output.
- `--format`: Format output using Go template.
## Examples
```Shell title='View container statistics'
docker container stats

docker container stats nginx

docker container stats web-1 web-2 db-server

docker container stats -a
```
- First example: Show stats for all running containers, live streaming.
- Second example: Show stats for specific container.
- Third example: Show stats for multiple containers.
- Fourth example: Include all containers, even stopped ones.
```Shell title='One-time stats snapshot'
docker container stats --no-stream

docker container stats --no-stream nginx

docker container stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```
- First example: Display stats once and exit.
- Second example: Single snapshot for specific container.
- Third example: Custom format showing name, CPU%, and memory.
# Docker container exec
## Behavior
- <mark style="background: #e4e62d;">Execute a new command</mark> for the running container $\equiv$ start a new process.
- Does not restart the container or affect main process.
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
### Other options
- `-d` or `--detach`: Run command in background.
- `-e` or `--env`: Set environment variables.
- `-u` or `--user`: Run command as specific user.
- `-w` or `--workdir`: Working directory inside container.
## Examples
```Shell title='Execute commands in running container'
docker container exec nginx ls /etc/nginx

docker container exec -it nginx bash

docker container exec web-app cat /var/log/app/error.log

docker container exec -it mysql mysql -u root -p
```
- First example: List directory contents.
- Second example: Open interactive bash shell.
- Third example: Read log file.
- Fourth example: Connect to MySQL client.
```Shell title='Execute with user and environment'
docker container exec -u www-data nginx whoami

docker container exec -e DEBUG=true web-app node debug.js

docker container exec -w /app node-app npm test

docker container exec -d worker python background_task.py
```
- First example: Run command as `www-data` user.
- Second example: Set environment variable for command.
- Third example: Run command in specific working directory.
- Fourth example: Run command in background.
# Docker container port
## Behavior
- List all mapping ports of a container.
- Shows host port to container port mappings.
## Syntax
```Shell
docker container port CONTAINER [PRIVATE_PORT[/PROTO]]
```
## Examples
```Shell title='List all mapping ports of a container'
docker container port nginx

docker container port web-app 80/tcp

docker container port database 5432
```
- First example: Show all port mappings.
- Second example: Show mapping for specific port and protocol.
- Third example: Show mapping for specific port (TCP assumed).
```Text title='Example output'
80/tcp -> 0.0.0.0:8080
443/tcp -> 0.0.0.0:8443
```
# Docker container attach
## Behavior
- Attach the terminal's standard input, output, and error to a running container using the container's ID or name.
- Connects to the ==main process== (PID $1$) of the container.
- Can detach using `Ctrl+P` followed by `Ctrl+Q` without stopping container.
## Syntax
```Shell
docker container attach [OPTIONS] CONTAINER
```
## Options
- `--detach-keys`: Override the key sequence for detaching.
- `--no-stdin`: Do not attach stdin.
- `--sig-proxy`: Proxy all received signals to the process, default is `true`.
## Examples
```Shell title='Attach to running container'
docker container attach nginx

docker container attach --no-stdin web-app

docker container attach --detach-keys="ctrl-e,e" custom-app
```
- First example: Attach to container's main process.
- Second example: Attach without stdin, view output only.
- Third example: Use custom detach keys `Ctrl+E` twice.
```Shell title='Attach vs exec difference'
docker container run -d --name loop alpine sh -c "while true; do date; sleep 2; done"

docker container attach loop

docker container exec -it loop sh
```
- Second example: Attach sees output from main process (`date` loop).
- Third example: Exec starts new shell process, does not see main process output.
# Docker container cp
## Behavior
- ==Copy files or folders== between a container and the local filesystem.
- Works with both running and stopped containers.
## Syntax
```Shell
docker container cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH
docker container cp [OPTIONS] SRC_PATH CONTAINER:DEST_PATH
```
## Options
- `-a` or `--archive`: Archive mode, preserve file attributes like uid, gid, timestamps.
- `-L` or `--follow-link`: Follow symbolic links in `SRC_PATH`.
## Examples
```Shell title='Copy from container to host'
docker container cp nginx:/etc/nginx/nginx.conf ./nginx.conf

docker container cp web-app:/var/log/app/error.log /tmp/debug/

docker container cp database:/var/lib/postgresql/data/backup.sql ./backups/
```
- First example: Copy nginx configuration file to current directory.
- Second example: Extract error log for debugging.
- Third example: Copy database backup to host.
```Shell title='Copy from host to container'
docker container cp ./config.json nginx:/etc/app/config.json

docker container cp /home/user/html/ web-server:/usr/share/nginx/

docker container cp ./certs/server.crt web-app:/etc/ssl/certs/
```
- First example: Update application configuration.
- Second example: Deploy static website files.
- Third example: Install SSL certificate.
```Shell title='Copy with archive mode'
docker container cp -a nginx:/var/www/html ./backup/

docker container cp -a ./migration-scripts/ database:/opt/scripts

docker container cp -L web-app:/app/logs ./logs/
```
- First example: Preserve file permissions and timestamps during backup.
- Second example: Copy scripts preserving ownership.
- Third example: Follow symlinks when copying logs.
- Copy entire directory contents by adding `/` after source directory.
- Without trailing `/`, the directory itself is copied.
# Docker container prune
## Behavior
- ==Remove all stopped containers== to free up disk space.
- Useful for cleaning up containers after development or testing.
## Syntax
```Shell
docker container prune [OPTIONS]
```
## Options
- `-f` or `--force`: Do not prompt for confirmation.
- `--filter`: Filter which containers to remove based on conditions.
## Examples
```Shell title='Remove all stopped containers'
docker container prune

docker container prune -f
```
- First example: Prompt for confirmation before removing.
- Second example: Skip confirmation prompt.
```Shell title='Remove containers with filters'
docker container prune --filter "until=24h"

docker container prune -f --filter "until=2024-01-01"

docker container prune --filter "label=environment=testing"

docker container prune --filter "label=project=demo" --filter "until=48h"
```
- First example: Remove containers stopped more than $24$ hours ago.
- Second example: Remove containers stopped before specific date.
- Third example: Remove containers with specific label.
- Fourth example: Combine multiple filters (AND logic).
- Filters support: `until=<timestamp>`, `label=<key>`, `label=<key>=<value>`.
```Shell title='Prune and check freed space'
docker container prune -f

docker system df
```
- Check disk space reclaimed after pruning.
# Docker container rename
## Behavior
- ==Rename an existing container== to a new name.
- Container names must be unique across the Docker host.
## Syntax
```Shell
docker container rename CONTAINER NEW_NAME
```
## Example
```Shell title='Rename container'
docker container rename old-web-server new-web-server

docker container rename loving_euler production-db
```
- Useful for organizing containers with meaningful names.
- Can rename both running and stopped containers.
# Docker container diff
## Behavior
- ==Inspect changes== to files or directories on a container's filesystem.
- Shows files and directories that have been added `A`, deleted `D`, or modified `C`.
- Compares container's current filesystem against its base image.
## Syntax
```Shell
docker container diff CONTAINER
```
## Examples
```Shell title='Inspect filesystem changes'
docker container diff nginx

docker container diff web-app | grep -E "^A"

docker container diff database | grep "/var/lib"
```
- First example: Show all filesystem changes.
- Second example: Show only added files.
- Third example: Filter changes in specific directory.
```Text title='Output example from running nginx'
C /var
C /var/cache
C /var/cache/nginx
A /var/cache/nginx/client_temp
A /var/cache/nginx/fastcgi_temp
A /var/run/nginx.pid
C /etc
A /etc/nginx/conf.d/custom.conf
D /tmp/deleted-file.txt
```
- `A`: File or directory was added.
- `D`: File or directory was deleted.
- `C`: File or directory was changed.
```Shell title='Use diff before commit'
docker container exec web-app apt-get install -y curl

docker container diff web-app

docker container commit web-app custom-web:v1
```
- Check what files changed before creating new image.
- Useful for debugging unexpected container behavior.
- Identifies which files were modified during runtime.
# Docker container commit
## Behavior
- ==Create a new image== from a container's changes.
- Captures the current state of a container's filesystem into a new image layer.
- Not recommended for production $\implies$ use Dockerfile for reproducible builds.
## Syntax
```Shell
docker container commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```
## Options
- `-a` or `--author`: Specify the author of the image.
- `-m` or `--message`: Commit message describing the changes.
- `-c` or `--change`: Apply Dockerfile instructions to the created image.
- `-p` or `--pause`: Pause container during commit to ensure data consistency, enabled by default.
## Examples
```Shell title='Commit container changes to new image'
docker container commit nginx my-custom-nginx:v1

docker container commit -m "Added custom config" -a "Admin <admin@example.com>" web-app my-app:v2

docker container commit --pause=false busy-app my-app:snapshot
```
- First example: Simple commit with custom tag.
- Second example: Commit with message and author metadata.
- Third example: Commit without pausing container (risks inconsistent state).
```Shell title='Commit with Dockerfile instructions'
docker container commit -c "ENV DEBUG=true" -c "EXPOSE 8080" app-container my-app:debug

docker container commit -c "CMD [\"nginx\", \"-g\", \"daemon off;\"]" nginx custom-nginx:v1

docker container commit -c "WORKDIR /app" -c "USER node" node-app node-custom:v1
```
- First example: Set environment variable and expose port in committed image.
- Second example: Override default command in new image.
- Third example: Set working directory and user for committed image.
```Shell title='Practical workflow - install package and commit'
docker container run -d --name web ubuntu:22.04 sleep infinity

docker container exec web apt-get update

docker container exec web apt-get install -y nginx curl

docker container commit -m "Ubuntu with nginx and curl" web custom-ubuntu:nginx

docker container run -d --name test custom-ubuntu:nginx nginx -g "daemon off;"
```
- Install software in running container, then save as new image.
- Useful for creating quick snapshots during debugging.
- For production, always prefer Dockerfile-based builds.
# Docker container pause
## Behavior
- ==Suspend all processes== in one or more containers using `SIGSTOP` signal.
- Freezes the container's execution without stopping it.
- Container continues to consume memory but not CPU.
## Syntax
```Shell
docker container pause CONTAINER+
```
## Example
```Shell title='Pause running containers'
docker container pause web-server

docker container pause db-primary db-replica
```
- Useful for temporarily freezing resource-intensive containers.
- Does not trigger graceful shutdown hooks.
# Docker container unpause
## Behavior
- ==Resume all processes== in one or more paused containers.
## Syntax
```Shell
docker container unpause CONTAINER+
```
## Example
```Shell title='Unpause containers'
docker container unpause web-server

docker container unpause db-primary db-replica
```
# Docker container update
## Behavior
- ==Update configuration== of one or more running containers.
- Allows runtime modification of resource constraints without restarting.
## Syntax
```Shell
docker container update [OPTIONS] CONTAINER+
```
## Options
- `--cpus`: Limit CPU quota.
- `--memory` or `-m`: Memory limit.
- `--memory-swap`: Swap limit equal to memory plus swap.
- `--restart`: Restart policy (`no`, `on-failure`, `always`, `unless-stopped`).
- `--cpu-shares`: CPU shares for relative weighting.
## Examples
```Shell title='Update memory and CPU limits'
docker container update --memory 512m --cpus 1.5 web-app

docker container update --memory 2g --memory-swap 4g database

docker container update --memory 256m worker-1 worker-2 worker-3
```
- First example: Limit container to $512$ MB memory and $1.5$ CPUs.
- Second example: Set $2$ GB memory limit with $4$ GB total swap.
- Third example: Update multiple containers simultaneously.
```Shell title='Change restart policy'
docker container update --restart unless-stopped nginx

docker container update --restart on-failure:5 app-container

docker container update --restart always production-db

docker container update --restart no temp-worker
```
- First example: Restart always except when explicitly stopped.
- Second example: Restart on failure up to $5$ times.
- Third example: Always restart, even after Docker daemon restart.
- Fourth example: Disable automatic restart.
```Shell title='Update CPU shares for priority'
docker container update --cpu-shares 1024 high-priority

docker container update --cpu-shares 512 medium-priority

docker container update --cpu-shares 256 low-priority
```
- CPU shares set relative CPU priority between containers.
- Higher share value $\implies$ more CPU time under contention.
- Default is $1024$, container with $2048$ gets twice the CPU time.
```Shell title='Combined updates'
docker container update --memory 1g --cpus 2 --restart always web-server

docker container update --memory-reservation 512m --memory 1g api-server
```
- First example: Update multiple resource limits at once.
- Second example: Set memory reservation (soft limit) and hard limit.
- Changes take effect immediately for running containers.
- Not all options can be updated at runtime.
# Docker container wait
## Behavior
- ==Block until one or more containers stop==, then print their exit codes.
- Useful in shell scripts to synchronize container lifecycle.
## Syntax
```Shell
docker container wait CONTAINER+
```
## Example
```Shell title='Wait for container to stop'
docker container wait nginx

docker container wait app-1 app-2 app-3
```

```Shell title='Use in shell script'
docker container run -d --name temp-worker worker:latest
exit_code=$(docker container wait temp-worker)
echo "Container exited with code: $exit_code"
```
- Returns `0` for successful exit.
- Non-zero exit codes indicate errors or failures.
# Docker container kill
## Behavior
- ==Send a kill signal== to one or more running containers.
- Default signal is `SIGKILL` which forcefully terminates the container.
- Unlike `docker container stop`, does not allow graceful shutdown.
## Syntax
```Shell
docker container kill [OPTIONS] CONTAINER+
```
## Options
- `-s` or `--signal`: Specify signal to send, default is `SIGKILL`.
## Examples
```Shell title='Kill containers forcefully'
docker container kill nginx

docker container kill web-1 web-2 web-3
```
```Shell title='Send custom signal'
docker container kill -s SIGTERM nginx

docker container kill -s SIGHUP web-server
```
- `SIGKILL` (`9`): Immediate termination, cannot be caught or ignored.
- `SIGTERM` (`15`): Graceful termination request.
- `SIGHUP` (`1`): Reload configuration in some applications.
# Docker container export
## Behavior
- ==Export a container's filesystem== as a tar archive.
- Creates a flattened archive of the container's entire filesystem.
- Does not include volumes or container metadata.
## Syntax
```Shell
docker container export [OPTIONS] CONTAINER
```
## Options
- `-o` or `--output`: Write to a file instead of stdout.
## Examples
```Shell title='Export container filesystem'
docker container export nginx > nginx-backup.tar

docker container export -o app-backup.tar web-app
```

```Shell title='Extract exported tar'
tar -xvf nginx-backup.tar -C /tmp/nginx-files/
```
- Useful for backing up container state.
- Does not preserve image layers $\implies$ creates a single flattened filesystem.
- Use `docker image save` to preserve layers and metadata.
# Podman-specific commands
## Behavior
- Podman is a ==daemonless container engine== compatible with OCI containers.
- Most Docker commands work identically with Podman by replacing `docker` with `podman`.
- Key difference: Podman runs containers without a central daemon.
## Podman generate systemd
### Behavior
- ==Generate systemd unit files== for managing containers as system services.
- Allows containers to start automatically on boot.
### Syntax
```Shell
podman generate systemd [OPTIONS] CONTAINER
```
### Options
- `--name`: Use container name instead of ID in unit file.
- `--files`: Generate files instead of printing to stdout.
- `--new`: Create a new container instead of starting existing one.
- `--restart-policy`: Systemd restart policy (default: `on-failure`).
- `--time` or `-t`: Stop timeout before killing container.
### Examples
```Shell title='Generate systemd service for container'
podman generate systemd --name --files nginx

podman generate systemd --new --name web-app > /etc/systemd/system/web-app.service

podman generate systemd --name --new --files --restart-policy=always database
```
- First example: Generate unit file from existing container.
- Second example: Generate unit that creates new container on start.
- Third example: Generate with always restart policy.
```Shell title='Generate for user service'
podman run -d --name user-app nginx:alpine

podman generate systemd --name --new --files user-app

mkdir -p ~/.config/systemd/user/

mv container-user-app.service ~/.config/systemd/user/

systemctl --user enable container-user-app.service

systemctl --user start container-user-app.service
```
- Generate user-level systemd service (no root required).
- Service runs under user account.
```Shell title='Enable and start system service'
sudo podman run -d --name production-web -p 80:80 nginx:alpine

sudo podman generate systemd --name --new --files production-web

sudo mv container-production-web.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable container-production-web.service

sudo systemctl start container-production-web.service

sudo systemctl status container-production-web.service
```
- Systemd manages container lifecycle like a native service.
- Containers auto-restart on failure or system reboot.
- Service starts automatically on boot.
## Podman pod commands
### Behavior
- Podman supports ==pods== similar to Kubernetes.
- Pod is a group of containers sharing network namespace and storage.
- All containers in pod can communicate via `localhost`.
### Syntax
```Shell
podman pod create [OPTIONS]
podman pod start POD
podman pod stop POD
podman pod rm POD
podman pod ps
podman pod inspect POD
podman pod logs POD
```
### Options for pod create
- `--name`: Assign name to the pod.
- `-p` or `--publish`: Publish port for the pod.
- `--network`: Connect pod to specific network.
- `--share`: Namespaces to share (default: `net,uts,ipc`).
- `--infra`: Create infra container, default is `true`.
### Examples
```Shell title='Create and manage basic pod'
podman pod create --name web-pod -p 8080:80

podman run -d --pod web-pod nginx:alpine

podman run -d --pod web-pod redis:alpine

podman pod ps

podman pod stop web-pod

podman pod start web-pod
```
- First example: Create pod with port mapping.
- Containers added to pod share same network namespace.
- Access nginx at `http://localhost:8080` on host.
- Redis accessible at `localhost:6379` from nginx container.
```Shell title='Multi-container application pod'
podman pod create --name app-stack -p 3000:3000 -p 5432:5432

podman run -d --pod app-stack --name db postgres:15-alpine -e POSTGRES_PASSWORD=secret

podman run -d --pod app-stack --name backend node:18-alpine

podman run -d --pod app-stack --name frontend nginx:alpine

podman pod logs app-stack
```
- All containers in pod can reach each other via `localhost`.
- Backend connects to database at `localhost:5432`.
- Frontend proxies to backend at `localhost:3000`.
```Shell title='Inspect and manage pods'
podman pod inspect web-pod

podman pod ps -a

podman ps -a --pod

podman pod rm web-pod

podman pod rm -f running-pod
```
- First example: View detailed pod configuration.
- Second example: List all pods including stopped.
- Third example: List containers grouped by pod.
- Fourth example: Remove stopped pod.
- Fifth example: Force remove running pod.
```Shell title='WordPress with MySQL in pod'
podman pod create --name wordpress-pod -p 8080:80

podman run -d --pod wordpress-pod --name db \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=wppass \
  mysql:8

podman run -d --pod wordpress-pod --name wp \
  -e WORDPRESS_DB_HOST=127.0.0.1 \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppass \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress:latest

podman pod ps
```
- WordPress connects to MySQL via `localhost` (shared network).
- Access WordPress at `http://localhost:8080`.
- Containers in same pod share localhost network.
- Useful for multi-container applications that need tight coupling.
# Example
## Run container from MySQL image
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
5. [OCI-compliant container](site-reliability-engineering/container-engine/OCI-compliant%20container.md) for introduction to docker container.
6. 


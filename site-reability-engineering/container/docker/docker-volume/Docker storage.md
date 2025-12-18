#docker #container #file-system #volume #process #operating-system #secondary-storage 
# Docker storage
 - By default, all files created inside a container are stored in a <mark style="background: #e4e62d;">writable container layer</mark>. This mechanism has 3 implications:
	 - The data storage is not persistent. It is complicated to access that data when the container no longer exists.
	 - That writable container layer is <mark style="background: #e4e62d;">tightly coupled</mark> with the host.
	 - Requires storage <mark style="background: #e4e62d;">driver</mark> to manage filesystem $\implies$ incur performance overhead.
- Docker supports other ways to mount filesystem.
# Docker mounting file system
- ![](Pasted%20image%2020240930161313.png)
## Data volume
### Mechanism
- Container data is permanently stored on the <mark style="background: #e4e62d;">host filesystem</mark> but <mark style="background: #e4e62d;">managed by Docker</mark> (e.g: `/var/lib/mysql/docker`), which is independent of both the host's directory structure and operating system.
- The data can be employed by one or multiple containers at the same time.
### Backstage
```Shell title='Data volume mounting mechanism in Docker'
docker run -d \
  --name myapp \
  -v myapp-data:/app/data \
  nginx
```
- The `-v` follows the pattern `-v [VOLUME_NAME_OR_HOST_PATH]:[CONTAINER_PATH]:[OPTIONS]`
```Shell title='The actual volume mapping'
Host Side (Docker-managed):
/var/lib/docker/volumes/myapp-data/_data/
├── file1.txt
├── config.json
└── logs/
    └── app.log

Container Side:
/app/data/
├── file1.txt          ← Same files
├── config.json        ← Same files  
└── logs/               ← Same files
    └── app.log
```
- The mounting process occurs as follows
#### Volume creation or reference
- The volume `myapp-data` is first checked for existence. If it does, it is referenced; otherwise, it is automatically created by Docker.
```Shell title='Volume is first created or referenced'
# Docker first checks if volume "myapp-data" exists
docker volume ls | grep myapp-data

# If it doesn't exist, Docker automatically creates it
# Equivalent to: docker volume create myapp-data
```
- The volume created is in `/var/lib/docker/volumes/...` if the host is Linux or inside Docker virtual machine if the host is Mac or Windows.
#### Container filesystem mounting
- Layers of container's filesystem are created by Docker.
- The directory `/app/data` is created inside the container if it has not existed.
- The container filesystem at that path is mounted.
### Usage
- The data must survive container restarts and be <mark class="hltr-yellow">persistent</mark>.
- The data is <mark class="hltr-yellow">centralized and shared</mark> across container deployments such as logs.
## Bind mounts
- Bind mounts directly map a host filesystem path to a container path without any intermediary.
- The host filesystem can be manually modified from within the container.
```Bash title='Bind mounts example'
# Bind mount with absolute path
docker run -d \
  --name myapp \
  -v /home/user/myproject:/app \
  node:16

# Alternative syntax (more explicit)
docker run -d \
  --name myapp \
  --mount type=bind,source=/home/user/myproject,target=/app \
  node:16

# Read-only bind mount
docker run -d \
  --name myapp \
  -v /home/user/config:/app/config:ro \
  nginx
```
### Usage
- The files should be directly accessed from the host to the container.
## `tmpfs`
- Stands for temporary file system.
- Stored <mark style="background: #e4e62d;">only  on</mark> the host's <mark style="background: #e4e62d;">memory</mark> and never written the host's filesystem.
***
# References
1. https://docs.docker.com/engine/storage/ for Docker Storage.
2. https://docs.docker.com/engine/storage/drivers/ for Docker storage driver.
3. https://medium.com/@williehung/persisting-data-using-docker-volume-and-bind-mount-52a8cb42f4f0.
4. [Docker volume commands](Docker%20volume%20commands.md) 
5. 
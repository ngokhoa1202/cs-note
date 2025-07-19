#docker #container #file-system #volume #process #operating-system #secondary-storage 

# Docker storage
 - By default, all files created inside a container are stored in a <mark style="background: #e4e62d;">writable container layer</mark>. This mechanism has 3 implications:
	 - The data storage is not persistent. It is complicated to access that data when the container no longer exists.
	 - That writable container layer is <mark style="background: #e4e62d;">tightly coupled</mark> with the host.
	 - Requires storage <mark style="background: #e4e62d;">driver</mark> to manage filesystem $\implies$ incur performance overhead.
- Docker supports other ways to mount filesystem.
# Docker mounting filesystem
- ![800x400](Pasted%20image%2020240930161313.png)
## Volume
- Stored on the <mark style="background: #e4e62d;">host filesystem</mark> but <mark style="background: #e4e62d;">managed by Docker</mark> (e.g: `/var/lib/mysql/docker`).
- Non-Docker processes <mark style="background: #ABF7F7A6;">should not</mark> modify this part of filesystem.
- Independent of both the host's directory structure and operating system.
- Employed by one or multiple containers at the same time.
- Managed by [Docker volume commands](Docker%20volume%20commands.md)
- Highly recommended.
## Bind mounts
- Allows to mount any file on the host filesystem, even important directories (e.g: `/usr/bin`).
- Non-Docker processes or a Docker container can modify this part of filesystem anytime.
- Cannot be used in Dockerfile. Only in `docker container run`.
- Maps a host directory to a container directory.
## tmpfs
- Stands for temporary filesystem.
- Stored <mark style="background: #e4e62d;">only  on</mark> the host's <mark style="background: #e4e62d;">memory</mark> and never written the host's filesystem.
---
# References
1. https://docs.docker.com/engine/storage/ for Docker Storage.
2. https://docs.docker.com/engine/storage/drivers/ for Docker storage driver.
3. https://medium.com/@williehung/persisting-data-using-docker-volume-and-bind-mount-52a8cb42f4f0.
4. [Docker volume commands](Docker%20volume%20commands.md) 
5. 
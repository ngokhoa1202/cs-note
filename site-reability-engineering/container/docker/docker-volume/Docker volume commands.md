#cli #docker #volume #secondary-storage #file-system #container #process #operating-system #container 

# Docker volume create
In Docker, a container with a mounted volume can be created using either the **docker container run** or the **docker container create** commands:

```bash
docker container run -d --name web -v webvol:/webdata myapp:latest
```

The above command would create a Docker volume inside the Docker working directory **/var/lib/docker/volumes/webvol/_data** on the host system, mounted on the container at the **/webdata** mount point. We may list the exact mount path via the **docker container inspect** command:

```bash
docker container inspect web
```

In Docker, a container with a bind mount can be created using either the **docker container run** or the **docker container create** commands:

```bash
docker container run -d --name web -v /mnt/webvol:/webdata myapp:latest
```

It mounts the host's **/mnt/webvol** directory to the **/webdata** mount point on the container as it is being started.

# Plugins

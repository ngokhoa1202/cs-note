#cli #docker #volume #secondary-storage #file-system #container #process #os #container 

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
We can extend the functionality of the Docker Engine with the use of plugins. With volume plugins, third-party vendors can integrate their storage solutions with the Docker ecosystem. Some examples of Docker-supported [volume plugins](https://docs.docker.com/engine/extend/legacy_plugins/#volume-plugins) are:

- Azure File Storage
- BeeGFS Volume
- Blockbridge
- Contiv Volume
- Convoy
- DigitalOcean Block Storage
- Flocker
- Fuxi Volume
- gce-docker
- GlusterFS
- Horcrux Volume
- Local Persists
- NetApp (nDVP)
- OpenStorage
- Portworx
- REX-Ray
- VMware vSphere Storage.

Volume plugins are especially helpful when we migrate a stateful container, like a database, on a multi-host environment. In such an environment, we have to make sure that the volume attached to a container is also migrated to the host where the container is migrated or started afresh.

Podman is also capable of using the [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write) mechanism when containers are run. The container image is saved on a read-only filesystem layer, while all changes performed by the container are saved on a writable filesystem layer of the container. We can choose the storage driver for Podman from the supports list below: 

- AUFS (Another Union File System)
- BtrFS
- Thinpool (Device Mapper)
- Overlay
- VFS (Virtual File System)
- ZFS.

# Podman volume command
A container with a mounted volume can be created using either the **podman container run** or the **podman container create** commands:

```bash
podman container run -d --name=web -v webvol:/webdata myapp:latest
```

The above command would create on the host system a volume in the Podman working directory of the current user **$HOME/.local/share/containers/storage/volumes/webvol/_data**, or in the **/var/lib/containers/storage/volumes/webvol/_data** if run by root, and mount it on the container at the **/webdata** mount point. We may display the mount path with the **podman container inspect** command:

```bash
podman container inspect web
```

A bind mount can be achieved with either the **podman container run** or the **podman container create** commands:

```bash
podman container run -d --name=web -v /mnt/webvol:/webdata myapp:latest
```
It mounts the host's **/mnt/webvol** directory to the **/webdata** mount point on the container as it is being started.

![](Pasted%20image%2020241219094330.png)

![](Pasted%20image%2020241219101941.png)


![](Pasted%20image%2020241219101920.png)


A volume can be easily created with the following command. By default it uses the local driver.

![$ podman volume create container-volume](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__podman_volume_create_container-volume.png)

Once created, the volume listing displays the volume driver and the volume name.

![$ podman volume ls](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__podman_volume_ls.png)

Inspecting the volume reveals additional details, such as the mountpoint on the host system where the volume is created by the container engine.

![$ podman volume inspect container-volume](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__podman_volume_inspect_container-volume.png)

We run the alpine image in the data-container and attach the container-volume. It opens a shell in interactive mode. Navigate to the **/data** container mountpoint, create the “datafile” and populate it with the desired data.

![$ podman container run -v container-volume:/data -it --name data-container alpine sh](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__podman_container_run_-v_container-volume-_data_-it_--name_data-container_alpine_sh.png)

On the container host system we locate the “datafile” at the local mountpoint and display its content as well.

![$ cd .local/share/containers/storage/volumes/container-volume/_data](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__cd_.local_share_containers_storage_volumes_container-volume__data.png)

Describing the container reveals its configuration details, together with the mounted volume details. These details are aligned with the ones displayed by the volume described above.

![$ podman container inspet data-container | grep Mounts -A16](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__podman_container_inspet_data-container___grep_Mounts_-A16.png)
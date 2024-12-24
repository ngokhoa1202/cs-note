

"_Gluster is a free and open source software scalable network file system._"

Gluster can utilize common off-the-shelf hardware to create large, distributed storage solutions for media streaming, data analysis, and other data- and bandwidth-intensive tasks.

To create shared storage, we need to start by grouping the machines in a trusted pool. Then, we group the directories (called _bricks_) from those machines in a GlusterFS volume using [FUSE](https://docs.gluster.org/en/latest/Quick-Start-Guide/Architecture/#fuse) (Filesystem in Userspace). GlusterFS supports different [types of volumes](https://docs.gluster.org/en/latest/Quick-Start-Guide/Architecture/#types-of-volumes):

- Distributed GlusterFS volume
- Replicated GlusterFS volume
- Distributed replicated GlusterFS volume
- Dispersed GlusterFS volume
- Distributed dispersed GlusterFS volume.

Below, we present an example of a distributed GlusterFS volume:

![Distributed GlusterFS Volume](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Fig_12.4-Distributed_GlusterFS_Volume.png)

**Distributed GlusterFS Volume**  
(by Gluster, Inc., retrieved from [gluster.org](https://docs.gluster.org/en/latest/Quick-Start-Guide/Architecture/))

GlusterFS does not have a centralized metadata server. It uses an elastic [hashing](https://en.wikipedia.org/wiki/Hash_function) algorithm to store files on bricks.

The GlusterFS volume can be accessed using one of the following methods:

- Native FUSE mount
	- NFS (Network File System)
	- CIFS (Common Internet File System).
# Benefits
Key benefits of using GlusterFS are:

- It scales to several petabytes.
- It can be configured on commodity hardware.
- It is an open source storage solution that supports _Object_, _Block_, and _Filesystem_ storage.
- It does not have a metadata server.
- It is scalable, modular, and extensible.
- It provides features such as replication, quotas, geo-replication, snapshots, and BitRot detection.
- It is POSIX-compliant, providing High Availability via local and remote data replication.
- It allows optimization for different workloads.
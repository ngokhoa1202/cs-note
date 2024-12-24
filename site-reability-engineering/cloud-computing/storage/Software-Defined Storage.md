
# Introduction
_Software-defined storage_ (SDS) represents storage virtualization aimed to separate the underlying storage hardware from the software that manages and provisions it. Physical hardware from various sources can be combined and managed with software, as a single storage pool. SDS replaces static and inefficient storage solutions backed directly by physical hardware with dynamic, agile, and automated solutions. In addition, SDS may provide resiliency features such as replication, erasure coding, and snapshots of the pooled resources. Once the pooled storage is configured in the form of a storage cluster, SDS allows multiple access methods such as _File_, _Block_, and _Object_. 

In this chapter, we will first introduce a few software-defined storage implementations, and then dive into storage management for containers. 

Some examples of Software-Defined Storage implementations are:
- [Ceph](https://ceph.io/)
- [Gluster](https://www.gluster.org/)
- [LINBIT](https://www.linbit.com/)
- [MinIO](https://min.io/)
- [Nexenta](https://nexenta.com/)
- [OpenEBS](https://openebs.io/)
- [Soda Dock](https://github.com/sodafoundation/dock)
- [TrueNAS](https://www.truenas.com/)
- [VMware vSAN](https://www.vmware.com/products/vsan.html).

![Software Defined Storage](https://courses.edx.org/assets/courseware/v1/f68f1ffdbee4d1faa71c4a91ba458264/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/LFS151-SoftwareDefinedStorage_SDS___1_.png)

**Software-Defined Storage (SDS)**
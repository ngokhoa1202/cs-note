
"_Ceph is a unified, distributed storage system designed for excellent performance, reliability and scalability._"

# Architecture
Everything in Ceph is stored as objects. Ceph uses the CRUSH (Controlled Replication Under Scalable Hashing) algorithm to deterministically find, write, and read the location of objects.

![](Pasted%20image%2020241218140459.png)
- _Reliable Autonomic Distributed Object Store (RADOS__)_ It is the object store which stores the objects. This layer makes sure that data is always in a consistent and reliable state. It performs operations like replication, failure detection, recovery, data migration, and rebalancing across the cluster nodes. This layer has the following three major components:

1. Object Storage Device (OSD): This is where the actual user content is written and retrieved with read operations. One OSD daemon is typically tied to one physical disk in the cluster.
2. Ceph Monitors (MON): Monitors are responsible for monitoring the cluster state. All cluster nodes report to Monitors. Monitors map the cluster state through the OSD, Place Groups (PG), CRUSH, and Monitor maps.
3. Ceph Metadata Server (MDS): It is needed only by CephFS, to store the file hierarchy and metadata for files.

![](Pasted%20image%2020241218140554.png)

- _Librados_ It is a library that allows direct access to RADOS from languages like C, C++, Python, Java, PHP, etc. Ceph Block Device_,_ RADOSGW, and CephFS are implemented on top of Librados.
- _Ceph Block Device (RBD)_ This provides the block interface for Ceph. It works as a block device and has enterprise features like thin provisioning and snapshots.
- _RADOS Gateway (RADOSGW)_ This provides a REST API interface for Ceph, which is compatible with Amazon S3 and OpenStack Swift.
- _Ceph File System (CephFS)_ This provides a POSIX-compliant distributed filesystem on top of Ceph. It relies on Ceph MDS to track the file hierarchy.

# Benefits
Key benefits of using Ceph are:

- It is an open source storage solution, which supports _Object_, _Block_, and _File system_ storage.
- It runs on any commodity hardware, without any vendor lock-in.
- It provides data safety for mission-critical applications.
- It provides an automatic balance of filesystems for maximum performance.
- It is scalable and highly available, with no single point of failure.
- It is a reliable, flexible, and cost-effective storage solution.
- It achieves higher throughput by stripping files/data across multiple nodes.
- It achieves adaptive load-balancing by replicating frequently accessed objects over multiple nodes.
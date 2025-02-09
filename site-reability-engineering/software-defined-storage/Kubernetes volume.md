

Kubernetes uses volumes to attach external storage to containers managed by Pods. A volume is essentially a directory backed by a storage medium. The storage medium and its contents are determined by the volume type.

![Multi-container Pod with Shared Volume](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/pod-volume-multi-container.svg)

**Multi-container Pod with Shared Volume**

A volume in Kubernetes is linked to a Pod and shared among containers of that Pod. The volume has the same lifetime as the Pod, but it outlives the containers of that Pod, meaning that data remains preserved across container restarts. However, once the Pod is deleted, the volume and all its data are lost as well.

A volume may be shared by some of the containers running in the same Pod. The diagram above illustrates a Pod with two containers, a File Puller and a Web Server, sharing a storage Volume.


# Volume type
A volume mounted inside a Pod is backed by an underlying volume type. A volume type decides the properties of the volume, such as size and content type. Kubernetes is currently (as of September 2023) migrating from its in-tree always available storage plugins approach. The new approach is based on third party drivers implementing the Container Storage Interface (CSI), and it impacts most cloud storage types. The CSI driver approach requires the Kubernetes operators to download and install the desired CSI driver when needed. Some of the [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#volume-types) supported by Kubernetes are:

- _awsElasticBlockStore_  
    To mount an [AWS EBS](https://aws.amazon.com/ebs/) volume on containers of a Pod.
- _azureDisk_  
    To mount an [Azure Data Disk](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/managed-disks-overview?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json) on containers of a Pod.
- _azureFile_  
    To mount an Azure File Volume on containers of a Pod.
- _cephfs_  
    To mount a CephFS volume on containers of a Pod.
- _configMap_  
    To attach a decoupled storage object that encapsulates configuration data, scripts, and possibly entire filesystems, to containers of a Pod. 
- _emptyDir_  
    An empty volume is created for the Pod as soon as it is scheduled on a worker node. The life of the volume is tightly coupled with the Pod. If the Pod dies, the content of **emptyDir** is deleted forever.
- _gcePersistentDisk_  
    To mount a [Google Compute Engine (GCE)](https://cloud.google.com/compute/docs/disks/) persistent disk into a Pod.
- _hostPath_  
    To share a directory from the host with the containers of a Pod. If the Pod dies, the content of the volume is still available on the host.
- _nfs_  
    To mount an NFS share on containers of a Pod.
- _persistentVolumeClaim_  
    To attach a persistent volume to a Pod. Persistent Volumes are covered in the next section.
- _rbd_  
    To mount a [Rados Block Device](https://docs.ceph.com/docs/master/rbd/) (RBD) volume on containers of a Pod.
- _secret_  
    To attach storage objects that encapsulate encoded sensitive information such as passwords, keys, certificates, or tokens to containers in a Pod.
- _vsphereVolume_  
    To mount a vSphere VMDK volume on containers of a Pod.

# Persistent volume
In a typical IT environment, the storage infrastructure is managed by the storage/system administrators, while the end-user receives precise instructions only on how to use the storage.

In the containerized world, we would like to follow similar rules, but it becomes very challenging given the many volume types we have seen earlier. In Kubernetes, this problem is solved with the persistent volume subsystem, which provides APIs to manage and consume the storage. To manage the volume, it uses the [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (PV) resource type, and to consume it, it uses the [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) (PVC) resource type.

Persistent volumes can be provisioned statically or dynamically. In the example below, a Kubernetes Administrator has statically created several PVs:

![Persistent Volumes](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/pv.png)

**Persistent Volumes**

For [dynamic provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) of PVs, Kubernetes uses the [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) resource, which contains predefined provisioners and parameters for PV creation. With PersistentVolumeClaim (PVC), a user sends the requests for dynamic PV creation, which gets wired to the StorageClass resource.

The PV types are also impacted by the migration towards CSI drivers. Some of the [volume types](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes) that support managing storage using PersistentVolumes are:

- AWSElasticBlockStore
- AzureFile
- AzureDisk
- GCEPersistentDisk
- NFS
- iSCSI
- RBD
- CephFS
- vsphereVolume.

# Persistent volume claim
A [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) (PVC) is a request for storage by a user. Users request for PV resources based on size, access modes, and volume type. Once a suitable PV is found, it is bound to PVC.

After a successful bind, the PVC can be used in a Pod to allow the containers' access to the PV.

![Using PVC in Pod](https://courses.edx.org/assets/courseware/v1/e9ffef624de66a89523db570023d7536/asset-v1:LinuxFoundationX+LFS151.x+3T2021+type@asset+block/pvc2__1_.png)

**PVC Requested by User and Mounted by a Pod**

Once a user completes his/her tasks and the Pod is deleted, the PVC may be detached from the PV, releasing it for possible future use. Keep in mind, however, that the PVC may be detached from the PV once all the Pods using the same PVC have completed their activities and have been deleted. Once released, the PV can be either deleted, retained, or recycled for future usage, all based on the [reclaim policy](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy) the user has defined on the PV.


# K8s volume command

The Pod definition manifest sets up an ubuntu container with a hostPath volume. The hostPath volume plugin binds the **/tmp/data-vol** host directory with the **/data** container directory. If the host directory does not exist prior to the Pod’s deployment, it will be created once the Pod is deployed.

![$ cat storage-pod.yaml](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__cat_storage-pod.yaml.png)

The **nodeName** ensures the Pod is scheduled on a specific node. Prior to deploying the Pod, the targeted node does not have a **/tmp/data-vol** directory.

![$ ls -la /tmp/data-vol](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__ls_-la__tmp_data-vol.png)

The following command deploys the application Pod.

![$ kubectl apply -f storage-pod.yaml](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__kubectl_apply_-f_storage-pod.yaml.png)

The Pod is listed in a Running state, with its private IP address and the node hosting the Pod.

![$ kubectl -n infra get pod - o wide](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__kubectl_-n_infra_get_pod_-o_wide.png)

Describing the Pod displays details of the mounted volume.

![$ kubectl -n infra describe pod storage-pod | grep -A4 -i volumes](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__kubectl_-n_infra_describe_pod_storage-pod___grep_-A4_-i_volumes.png)

After the Pod deployment, the host directory can be located on the node.

![$ ls -la /tmp/data-vol](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__ls_-la__tmp_data-vol_second_screenshot.png)

We create a **newfile** in the **/data** directory of the container, and populate it with “Cloud Infrastructure Technologies”.

![$ kubectl -n infra exec storage-pod — bash -c ‘echo Cloud Infrastructure Technologies > /data/newfile’](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__kubectl_-n_infra_exec_storage-pod___bash_-c__echo_Cloud_Infrastructure_Technologies____data_newfile_.png)

We validate the content of **newfile** on the container.

![$ kubectl -n infra exec storage-pod --bash -c ‘cat /data/newfile’ Cloud Infrastructure Technologies](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__kubectl_-n_infra_exec_storage-pod_--bash_-c__cat__data_newfile__Cloud_Infrastructure_Technologies.png)

On the node the **newfile** can be found in the host **/tmp/data-vol** directory.

![$ ls -la /tmp/data-vol](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__ls_-la__tmp_data-vol__2_.png)

And the contents of the **newfile** can be displayed on the node as well.

![$ cat /tmp/data-vol/newfile](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__cat__tmp_data-vol_newfile__3_.png)

The hostPath plugin is one of the several Kubernetes native plugins that implement container storage. However, as practical as it seems to share storage space between a container and its host, this method, if misconfigured, may expose the host to attackers who could access resources on the container host.


# Distributed Storage Management
The Volume property of a Pod definition or the PersistentVolume paired with a matching PersistentVolumeClaim seems to be quite simple to manage with the help of the Kubernetes-supported storage plugins. This is true when we have to manage only a handful of such resources. Once our application grows to hundreds, possibly thousands of distinct microservices, managing an equally large number of PersistentVolume and PersistentVolumeClaim objects could become very challenging. In addition, lots of very specific storage requirements will definitely not help to improve the management process in any way.

As storage platforms and services mature, users may be faced with increased complexity and the possibility of vendor lock-in, which would tightly couple a cluster's storage resources with cloud storage services. As a result, it becomes nearly impossible to pick up the cluster and move it to another infrastructure without adversely impacting applications, requiring manual reconfiguration of many definition manifests for PersistentVolume and PersistentVolumeClaim objects, StorageClass definitions, and possibly Pod definitions as well.

Kubernetes best practices recommend that we should aim for decoupling as much as possible, which includes decoupling our applications from the underlying storage infrastructure. This can be achieved by introducing a new abstraction layer between the Kubernetes storage resource definitions and the storage infrastructure - storage interfaces that are not available as Kubernetes native storage plugins. Open source projects that implement such interfaces are:

[Rook](https://rook.io/)  
A graduated project of the [Cloud Native Computing Foundation](https://cncf.io) (CNCF) is capable of managing File, Block, and Object storage for Kubernetes clusters. Rook simplifies and automates the deployment, scalability, self-healing, disaster recovery, management, and monitoring of distributed storage systems such as Ceph. It minimizes data loss through distribution and replication, and it optimizes the usage of commodity hardware in favor of costly storage solutions, therefore, preventing possible vendor lock-in scenarios. 

 ![Rook Architecture](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/rook-ceph-kubernetes.png)
[Longhorn](https://longhorn.io/)  
An incubating project of the [Cloud Native Computing Foundation](https://cncf.io) (CNCF) originally developed by [Rancher](https://rancher.com/), it implements highly available persistent storage for Kubernetes. Longhorn is capable of managing cloud-native persistent block storage at reduced costs, unlike proprietary cloud storage service alternatives. It has built-in backups and incremental snapshots capabilities, together with cross-cluster disaster recovery, much-desired features for today's multi-cluster Kubernetes deployment models. 

![Longhorn Architecture](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/how-longhorn-works.svg)

 **Longhorn Architecture**  
(retrieved from [longhorn.io](https://longhorn.io/))
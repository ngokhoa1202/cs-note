

On Cloud Foundry, applications connect to other services via a service marketplace. Each service has a service broker, which encapsulates the logic for creating, managing, and binding services to applications.

With volume services, the volume service broker allows Cloud Foundry applications to attach external storage.

![Cloud Foundry Volume Service](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Cloud_Foundry_Volume_Service.png)

**Cloud Foundry Volume Service**

With the **volume bind** command, the service broker issues a volume mount instruction that instructs the Diego scheduler to schedule the app instances on cells that have the appropriate volume driver. In the backend, the volume driver gets attached to the device. Cells then mount the device into the container and start the app instance.

Following are some examples of CF Volume Services:

- [nfs-volume-release](https://github.com/cloudfoundry/nfs-volume-release)  
    This allows for easy mounting of external [Network File System](https://en.wikipedia.org/wiki/Network_File_System) (NFS) shares for Cloud Foundry applications.
- [smb-volume-release](https://github.com/cloudfoundry/smb-volume-release)   
    This allows for easy mounting of external [Server Message Block](https://docs.microsoft.com/en-us/windows/win32/fileio/microsoft-smb-protocol-and-cifs-protocol-overview) (SMB) shares for Cloud Foundry applications.
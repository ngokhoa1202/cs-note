
[Podman network](https://docs.podman.io/en/latest/markdown/podman-network.1.html) operations allow us to list networks, create custom networks, inspect them, attach containers to them, and finally remove them when no longer needed. Podman supports the creation of CNI-compliant container networks. To create container networks, Podman supports drivers for various network types. Default is the bridge driver, usable in both rootless and rooted modes. However, in rooted mode, two additional drivers can be used, the macvlan and ipvlan drivers, with options such as **parent** to designate a host device and the **mode** to be set on the interface. The macvlan and ipvlan drivers are only available in rooted mode because they require access to the host network interfaces, otherwise the rootless networking needs a separate network namespace. 


```bash
podman network ls

podman network create --subnet 192.168.20.0/24 --gateway 192.168.20.3 bridgenet

podman network inspect bridgenet**

podman network create -d macvlan -o parent=eth0 macvnet # root

podman network inspect macvnet # root
```
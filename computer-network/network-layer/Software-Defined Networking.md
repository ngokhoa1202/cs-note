Every network device has to perform three distinct activities:

- _Ingress and egress packets_   
    These are performed at the lowest layer, which decides what to do with ingress packets and which packets to forward based on forwarding tables. These activities are mapped as Data Plane activities. All routers, switches, modems, etc., are part of this plane.
- _Collect, process, and manage the network information_   
    By collecting, processing, and managing the network information, the network device makes the forwarding decisions, which the Data Plane follows. These activities are mapped by the Control Plane activities. Some of the protocols which run on the Control Plane are routing and adjacent device discovery.
- _Monitor and manage the network_   
    Using the tools available in the Management Plane_,_ we can interact with the network device to configure it and monitor it with tools like SNMP (Simple Network Management Protocol).

In software-defined networking, we decouple the Control Plane from the Data Plane. The Control Plane has a centralized view of the overall network, which allows it to create _forwarding tables_ of interest. These tables are then submitted to the Data Plane to manage network traffic.

![SDN Framework](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/LFS151-SDN-Framework.png)

The Control Plane has well-defined APIs that receive requests from applications to configure the network. After preparing the desired state of the network, the Control Plane communicates that to the Data Plane (also known as the Forwarding Plane), using a well-defined protocol like OpenFlow.
- We can use configuration tools like Ansible or Chef to configure SDN, adding lots of flexibility and agility on the operations side as well.
---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
2. 
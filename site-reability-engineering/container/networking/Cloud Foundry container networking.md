

By default, [Gorouter](https://docs.cloudfoundry.org/concepts/architecture/router.html) routes the external and internal traffic to various Cloud Foundry (CF) components. The [container-to-container networking](https://docs.cloudfoundry.org/concepts/understand-cf-networking.html) feature of CF enables application instances to communicate with each other directly. However, when the container-to-container networking feature is disabled, all application-to-application traffic must go through the Gorouter. 

Container-to-container networking is made possible by several components of the CF architecture:

- _Network Policy Server_  
    A management node hosting a database of app traffic policies.
- _Garden External Networker_  
    Sets up networking for each app through the CNI plugin, exposing apps to the outside by allowing incoming traffic from Gorouter, TCP Router, and SSH Proxy.
- _Silk CNI Plugin_  
    For IP management through a shared VXLAN overlay network that assigns each container a unique IP address. The overlay network is not externally routable, and it prevents the container-to-container traffic from escaping the overlay.
- _VXLAN Policy Agent_  
    Enforces network policies between apps. When creating routing rules for network policies, we should include the source app, destination app, protocol, and ports, without going through the Gorouter, a load balancer, or a firewall.
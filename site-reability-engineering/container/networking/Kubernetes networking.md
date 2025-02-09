
As we know, the smallest deployment unit in Kubernetes is a Pod, which may include one or more containers. Kubernetes assigns a unique IP address to each Pod. Containers in a Pod share the same network namespace, thus sharing the same IP address of the Pod, and can refer to each other by localhost. We learned about network namespaces sharing between containers earlier, in a prior section. Containers in a Pod can expose unique ports, and become accessible through the same Pod IP address.

As each Pod gets a unique IP, Kubernetes assumes that Pods should be able to communicate with each other, irrespective of the nodes they get scheduled on. There are different ways to achieve this. Kubernetes introduced the [Container Network Interface](https://github.com/containernetworking/cni/blob/master/SPEC.md) (CNI) specification for container networking together with the following requirements that need to be implemented by Kubernetes networking driver developers:

- All Pods on a Node can communicate with all Pods on all Nodes without NAT
- Agents on a Node (e.g., system daemons, kubelet) can communicate with all Pods on that Node
- The Pods in the host network of a Node can communicate with all Pods on all Nodes without NAT (for Linux or other platforms supporting Pods running in the host network).

The projects implementing the Kubernetes [CNI](https://www.cni.dev/) are in fact SDN implementations, deployed on a Kubernetes cluster as plugins, that build a private, virtual, and isolated network layer for Pod-to-Pod communication. Several implementations of Kubernetes networking plugins:

- [AWS VPC CNI for Kubernetes](https://github.com/aws/amazon-vpc-cni-k8s)  
    AWS VPC CNI offers integrated AWS Virtual Private Cloud (VPC) networking for Kubernetes clusters. Kubernetes cluster networks can use AWS VPC networking and security features such as VPC flow logs, VPC routing policies, and Security Groups for traffic isolation.
- [Azure CNI for Kubernetes](https://docs.microsoft.com/en-us/azure/virtual-network/container-networking-overview)  
    Azure CNI is an open source plugin that integrates Kubernetes Pods with an Azure Virtual Network (also known as VNet) providing network performance at par with VMs. 
- [Calico](https://docs.projectcalico.org/about/about-calico)  
    Calico uses the BGP protocol to meet the Kubernetes networking requirements.
- [Cilium  
    ](https://cilium.io/)Provides secure network connectivity between application containers. It is L7/HTTP aware and can also enforce network policies on L3-L7.
- [Flannel](https://github.com/flannel-io/flannel#flannel)  
    Flannel uses the overlay network, as we have seen with Docker, to meet the Kubernetes networking requirements.
- [NSX-T  
    ](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.0/ncp-kubernetes/GUID-FB641321-319D-41DC-9D16-37D6BA0BC0DE.html)NSX-T from VMware provides network virtualization for a multi-cloud and multi-hypervisor environment. The [NSX-T Container Plug-in](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.0/nsxt_20_ncp_kubernetes.pdf) (NCP) provides integration between NSX-T and container orchestrators such as Kubernetes.
- [OVN-Kubernetes](https://github.com/ovn-org/ovn-kubernetes/)  
    Provides overlay based networking for Kubernetes, and Open VSwitch (OVS) based load balancing and network policy.
- [Weave Net](https://www.weave.works/oss/net/)  
    Weave Net, a simple network for Kubernetes, may run as a [CNI plug-in](https://www.weave.works/docs/net/latest/kubernetes/) or stand-alone. It does not require additional configuration to run, and the network provides one IP address per pod, as it is required and expected by Kubernetes.

For more details and other implementations, please refer to the [Kubernetes Documentation](https://kubernetes.io/docs/concepts/cluster-administration/networking/)

# Multi-node networking
Let's illustrate how microservices communicate on a multi-node Kubernetes cluster.

_**NOTE**: The following set of screenshots may have a different look on your system. The Kubernetes platform is constantly evolving and features may change without notice._

On a two worker node Kubernetes cluster the Pod network is managed by the Calico network plugin. Two distinct application Pods are deployed, a client application and a server application, each deployed to a node. The listing displays the two application Pods with their respective IP addresses and the nodes hosting them. The Service exposing the webserver application displays a private virtual ClusterIP and its Endpoint.

![Screenshot showing the kubectl -n demos get po,svc,ep -l demo=demo3 -owide command](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Screenshot_showing_the_kubectl_-n_demos_get_po_svc_ep_-l_demo_demo3_-owide_command.png)

The Pods deployed to different nodes can communicate with each other over the Pod network managed by the network plugin. From the client application we can submit a curl request targeting the IP address of the webserver application Pod. However, the Pods and their respective IP addresses are considered ephemeral resources, thus unreliable for long term communication.

![Screenshot of the kubectl -n demos exec client-app-7d9bb6c977-fslxq — sh -c ‘curl -s 192.168.142.153’ command](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Screenshot_of_the_kubectl_-n_demos_exec_client-app-7d9bb6c977-fslxq___sh_-c__curl_-s_192.168.142.153__command.png)

The Service exposing the webserver application Pod is also accessible from the client application Pod by targeting the Service ClusterIP. However, this ClusterIP may also change in time even if considered less ephemeral in comparison with the application Pod IP addresses.

![Screenshot showing the kubectl -n demos exec client-app-7d9bb6c977-fslxq — sh -c ‘curl -s 10.98.67.45’ command](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Screenshot_showing_the_kubectl_-n_demos_exec_client-app-7d9bb6c977-fslxq___sh_-c__curl_-s_10.98.67.45__command.png)

The Cluster DNS server helps to resolve communication issues between application Pods hosted by different nodes.

![Screenshot of the kubectl -n demos exec client-app-7d9bb6c977-fslxq --sh -c ‘curl -s web-app-svc command](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Screenshot_of_the_kubectl_-n_demos_exec_client-app-7d9bb6c977-fslxq_--sh_-c__curl_-s_web-app-svc_.png)

Due to the complexity of the Kubernetes distributed architecture, it is critical that application Pods are able to communicate over the entire cluster, regardless of the nodes hosting them.
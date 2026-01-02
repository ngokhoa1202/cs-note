#sdn #network-layer #computer-network #control-plane #backend #site-reliability-engineering #kubernetes
# Software-Defined Networking
## Overview
- ==Decouples control plane from data plane== for centralized network management
- Enables ==programmatic network configuration== via APIs
- Provides ==network abstraction== and automation
- Critical for cloud-native infrastructure and container orchestration
## Traditional vs SDN Architecture

### Traditional Networking
```
┌─────────────────────────────────────┐
│  Router/Switch (Monolithic Device) │
│  ┌───────────────────────────────┐ │
│  │    Control Plane              │ │ ← Distributed, per-device
│  │  (Routing protocols, config)  │ │
│  └───────────────────────────────┘ │
│  ┌───────────────────────────────┐ │
│  │    Data Plane                 │ │
│  │  (Packet forwarding)          │ │
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

### SDN Architecture
```
┌─────────────────────────────────────────────┐
│       Application Layer                     │
│  (Network Apps, Orchestration, Security)    │
└─────────────────────────────────────────────┘
                    ↕ Northbound API (REST)
┌─────────────────────────────────────────────┐
│       SDN Controller (Control Plane)        │ ← Centralized
│  (OpenDaylight, ONOS, Ryu, Kubernetes)      │
└─────────────────────────────────────────────┘
                    ↕ Southbound API (OpenFlow, gRPC)
┌───────────┐  ┌───────────┐  ┌───────────┐
│ Switch 1  │  │ Switch 2  │  │ Switch 3  │
│ Data Plane│  │ Data Plane│  │ Data Plane│ ← Simplified forwarding
└───────────┘  └───────────┘  └───────────┘
```

## SDN Planes
### Data Plane (Forwarding Plane)
- **Function**: Packet forwarding based on ==flow tables==
- **Speed**: Hardware-based, nanosecond latency
- **Components**: Physical/virtual switches, routers, OVS
- **Protocol**: OpenFlow, P4, gRPC (gNMI)
### Control Plane
- **Function**: Network topology management, ==flow table programming==
- **Speed**: Software-based, millisecond to second latency
- **Components**: SDN controllers, network OS
- **Scope**: Centralized view of entire network
### Management Plane
- **Function**: Configuration, monitoring, policy management
- **Tools**: REST APIs, CLI, web UI
- **Integration**: Ansible, Terraform, Kubernetes operators
## SDN Protocols
### OpenFlow
- Industry-standard SDN protocol
- Defines ==flow table== structure and match-action rules
- Controller ↔ Switch communication
**Flow Table Structure:**
| Match Fields | Priority | Counters | Instructions | Timeouts |
|--------------|----------|----------|--------------|----------|
| src IP, dst IP, port | 100 | Packets, bytes | Forward to port 2 | Idle: 60s |
| VLAN ID, MAC | 200 | 150 packets | Drop | Hard: 300s |

**OpenFlow Actions:**
- **Forward**: Send to specific port(s)
- **Drop**: Discard packet
- **Modify**: Change header fields (VLAN, IP, MAC)
- **Enqueue**: QoS queue assignment
### P4 (Programming Protocol-Independent Packet Processors)
- Define custom packet processing pipelines
- More flexible than OpenFlow
- Used in modern data center switches
### gRPC Network Management Interface (gNMI)
- Modern alternative to NETCONF/SNMP
- Used in cloud-native networking
- Protocol buffers for efficient encoding
## SDN Controllers
### Open vSwitch (OVS)
- Most widely deployed virtual switch
- Supports OpenFlow, VXLAN, GRE tunneling
- Used in KVM, Xen, Docker, Kubernetes

```bash
# Install OVS
sudo apt install openvswitch-switch

# Create bridge
sudo ovs-vsctl add-br br0

# Add ports
sudo ovs-vsctl add-port br0 eth0
sudo ovs-vsctl add-port br0 veth0

# Configure OpenFlow controller
sudo ovs-vsctl set-controller br0 tcp:192.168.1.10:6633

# View flow tables
sudo ovs-ofctl dump-flows br0

# Add flow rule
sudo ovs-ofctl add-flow br0 "priority=100,ip,nw_src=10.0.1.0/24,actions=output:2"
```
### Popular SDN Controllers

| Controller | Language | Use Case | Adoption |
|------------|----------|----------|----------|
| **OpenDaylight** | Java | Enterprise, service provider | High |
| **ONOS** | Java | Service provider, carrier networks | Medium |
| **Ryu** | Python | Research, custom applications | Medium |
| **Floodlight** | Java | Enterprise, data center | Medium |
| **OVN** | C | Kubernetes, OpenStack networking | High |

## SDN in Cloud Platforms
### AWS VPC (Virtual Private Cloud)
- SDN-based virtual network
- Centralized control via AWS APIs
- Dynamic routing with Transit Gateway

```bash
# Create VPC with SDN-like control
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Create subnet
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.1.0/24

# Configure route table (SDN flow rules)
aws ec2 create-route --route-table-id rtb-xxxxx \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-xxxxx

# Security groups act as distributed firewall (SDN policy)
aws ec2 authorize-security-group-ingress \
  --group-id sg-xxxxx \
  --protocol tcp --port 443 --cidr 0.0.0.0/0
```
### GCP VPC
- Global SDN fabric
- Dynamic routing with Cloud Router
- VPC peering and Shared VPC
```bash
# Create VPC network
gcloud compute networks create vpc-network \
  --subnet-mode=custom

# Create subnet with SDN routing
gcloud compute networks subnets create subnet-1 \
  --network=vpc-network \
  --region=us-central1 \
  --range=10.0.1.0/24

# Firewall rules (SDN access control)
gcloud compute firewall-rules create allow-internal \
  --network=vpc-network \
  --allow=tcp,udp,icmp \
  --source-ranges=10.0.0.0/8
```
### Azure Virtual Network (vNet)
- SDN-based virtual networking
- Network Security Groups for access control
- Virtual Network Peering
## SDN in Kubernetes
### CNI (Container Network Interface)
- Standard for container networking plugins
- Kubernetes delegates networking to CNI plugins
**Popular CNI Plugins:**
- **Calico**: L3 routing, network policy, BGP
- **Cilium**: eBPF-based, service mesh, network policy
- **Flannel**: Simple overlay network, VXLAN
- **Weave Net**: Overlay network, automatic encryption
- **Multus**: Multiple network interfaces per pod
### Cilium (eBPF-based SDN)
```yaml
# Cilium network policy example
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: allow-frontend-to-backend
spec:
  endpointSelector:
    matchLabels:
      app: backend
  ingress:
  - fromEndpoints:
    - matchLabels:
        app: frontend
    toPorts:
    - ports:
      - port: "8080"
        protocol: TCP
```

**Cilium Features:**
- L3-L7 network policy
- Service mesh (without sidecar proxies)
- Multi-cluster networking
- Transparent encryption
### Calico
```yaml
# Calico global network policy
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: deny-all-ingress
spec:
  selector: all()
  types:
  - Ingress
  ingress:
  - action: Deny
```
**Calico Features:**
- Pure L3 routing (no overlay)
- BGP peering with physical network
- Network policy enforcement
- eBPF dataplane option
## Service Mesh as SDN
### Istio / Envoy
- Control plane for ==L7 network traffic==
- Manages service-to-service communication
- Dynamic routing, load balancing, security

```yaml
# Istio VirtualService (L7 SDN routing)
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: reviews-route
spec:
  hosts:
  - reviews
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews
        subset: v2  # Route to specific version
  - route:
    - destination:
        host: reviews
        subset: v1  # Default route
```
### Linkerd
- Lightweight service mesh.
- Automatic mTLS between services.
- Intelligent load balancing.
## Monitoring SDN
### Key Metrics
- **Flow table utilization**: Percentage of flow entries used
- **Controller latency**: Time to program flow rules
- **Packet drop rate**: Packets without matching flows
- **Control plane bandwidth**: Controller ↔ switch traffic
### Monitoring Tools
```Shell title='Monitoring tools'
# OVS statistics
ovs-ofctl dump-flows br0
ovs-ofctl dump-ports br0
ovs-appctl dpctl/show

# Cilium metrics (Prometheus format)
curl http://localhost:9090/metrics | grep cilium

# Calico monitoring
calicoctl get workloadEndpoints
calicoctl node status
```
***
# References
1. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 5: Network Layer - The Control Plane
2. [ONF OpenFlow Specification](https://opennetworking.org/software-defined-standards/specifications/)
3. [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
4. [Cilium Documentation](https://docs.cilium.io/)
5. [Calico Documentation](https://docs.tigera.io/calico/latest/about/)
6. [Open vSwitch Documentation](https://www.openvswitch.org/support/documentation/)
7. [Istio Traffic Management](https://istio.io/latest/docs/concepts/traffic-management/)

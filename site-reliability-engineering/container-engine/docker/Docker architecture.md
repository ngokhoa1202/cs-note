#continuous-integration #shell #docker #software-architecture #client-server #application-layer #web-server #dbms #binary-image #operating-system #process #memory #virtual-memory #site-realibility-engineering #container-engine #container-orchestration #linux
#computer-network #go
# Overview
- Docker is a ==client-server container engine== for developing, shipping, and running OCI-compliant containers.
- Uses a <mark style="background: #e4e62d;">daemon-based architecture</mark> where a central daemon (dockerd) manages all container operations.
- Implements a layered architecture with multiple components working together to provide container functionality.
# Components
## Docker Client
### Purpose
- Provides ==user interface== for interacting with Docker daemon.
- Sends commands to Docker daemon via REST API over Unix sockets or network.
- Multiple interfaces available:
  - **Docker CLI** (`docker` command): Command-line interface
  - **Docker Desktop**: GUI application for Windows, macOS, Linux
  - **Docker Compose**: Tool for defining multi-container applications
  - **Docker API**: RESTful HTTP API for programmatic access
### Communication Methods
- **Unix Socket** (default on Linux): `/var/run/docker.sock`
  - Fast local communication
  - Requires appropriate permissions
- **TCP Socket**: Remote Docker daemon access
  - Format: `tcp://host:port`
  - Requires TLS for secure communication
- **Named Pipe** (Windows): `npipe:////./pipe/docker_engine`
### Client-Server Model
```mermaid
sequenceDiagram
    participant Client as Docker Client
    participant Daemon as Docker Daemon

    Client->>Daemon: docker run nginx:alpine
    Note over Daemon: 1. Check local images
    Note over Daemon: 2. Pull from registry if needed
    Note over Daemon: 3. Create container
    Note over Daemon: 4. Start container
    Daemon-->>Client: Container ID returned
```

## Docker Daemon (dockerd)
### Purpose
- Core ==background service== that manages Docker objects: containers, images, networks, volumes.
- Listens for Docker API requests and processes them.
- Communicates with other daemons for orchestration (Swarm mode).
### Responsibilities
#### Image management
   - Pulling images from registries
   - Building images from Dockerfiles
   - Caching and storing image layers
   - Pushing images to registries
#### Container lifecycle management
   - Creating containers from images
   - Starting, stopping, restarting containers
   - Monitoring container state
   - Removing containers
#### Network management
   - Creating virtual networks
   - Connecting containers to networks
   - Port mapping and forwarding
   - DNS resolution between containers
#### Volume management
   - Creating and managing volumes
   - Mounting volumes to containers
   - Volume driver plugins
#### Resource management
   - CPU and memory limits (cgroups)
   - Process isolation (namespaces)
   - Security policies (SELinux, AppArmor, Seccomp)
### Daemon Configuration
- Configuration file: `/etc/docker/daemon.json`
- Command-line flags: `dockerd --option=value`
- Common settings:
    - Storage driver selection
    - Registry mirrors
    - Logging drivers
    - Network settings
## containerd
### Purpose
- Industry-standard ==container runtime== that manages container lifecycle.
- Sits between Docker daemon and runc.
- Originally part of Docker Engine, now a separate CNCF graduated project.
### Responsibilities
- **Image Transfer**: Pulling and pushing images from/to registries
- **Image Storage**: Managing local image storage
- **Container Execution**: Creating and managing container processes via runc
- **Network Namespace Management**: Setting up container networking
- **Storage Management**: Managing container filesystem layers
### Architecture Position
```mermaid
graph TB
    Dockerd["Docker Daemon (dockerd)"]
    Containerd["containerd"]
    Runc["runc"]
    Process["Container Process"]

    Dockerd -->|gRPC API| Containerd
    Containerd -->|OCI Runtime Spec| Runc
    Runc --> Process

    style Dockerd fill:#81d4fa
    style Containerd fill:#4fc3f7
    style Runc fill:#29b6f6
    style Process fill:#0277bd
```
## runc
### Purpose
- Lightweight ==OCI-compliant runtime== for spawning and running containers.
- Low-level tool that creates containers according to OCI Runtime Specification.
- Written in Go.
### Responsibilities
#### Namespace isolation
- Creates Linux namespaces for isolation
  - PID: Process isolation
  - NET: Network isolation
  - MNT: Filesystem mount isolation
  - UTS: Hostname isolation
  - IPC: Inter-process communication isolation
  - USER: User ID isolation
#### CGroup configuration
 - Sets resource limits
     - CPU limits
      - Memory limits
      - I/O limits
      - Network bandwidth

- **Security Policies**: Applies security configurations
  - Seccomp profiles
  - SELinux contexts
  - AppArmor profiles
  - Capabilities
# Architectural Flow
## Container Creation and Execution
```mermaid
graph TD
    A[User: docker run nginx] --> B[Docker Client CLI]
    B -->|REST API| C[Docker Daemon dockerd]
    C -->|Check local| D{Image exists?}
    D -->|No| E[Pull from Registry]
    E --> F[Store Image Layers]
    D -->|Yes| F
    F --> G[Create Container Config]
    G -->|gRPC| H[containerd]
    H --> I[Prepare Container Bundle]
    I -->|OCI Runtime Spec| J[runc]
    J --> K[Create Namespaces]
    K --> L[Apply Cgroups]
    L --> M[Set Security Policies]
    M --> N[Execute Container Process]
    N --> O[Running Container]

    style A fill:#e1f5ff
    style B fill:#b3e5fc
    style C fill:#81d4fa
    style H fill:#4fc3f7
    style J fill:#29b6f6
    style O fill:#0277bd
```

## Image Build Process
1. **Docker CLI** receives `docker build` command
2. **Docker Daemon** reads Dockerfile
3. **Layer Creation**.
4. **Image Tagging** and storage in local image cache
5. **Optional Push** to registry
## Container Networking Flow
1. **Network Creation**: Docker daemon creates virtual network
2. **Bridge Setup**: Creates Linux bridge (default: docker0)
3. **veth Pair**: Creates virtual Ethernet pair
   - One end in container network namespace
   - Other end attached to bridge
4. **IP Assignment**: Assigns IP from bridge subnet
5. **Port Mapping**: iptables rules for port forwarding
6. **DNS Configuration**: Container DNS resolver

# Storage Architecture
- Docker images use ==layered filesystem== with Copy-on-Write (CoW) mechanism.
- Each layer is ==immutable== and uniquely identified by ==SHA-256 hash==.
- Containers add a ==writable layer== on top of image layers.
- See [Container storage](site-reliability-engineering/container-engine/Container%20storage.md) for detailed information on:
  - Storage drivers (overlay2, devicemapper, btrfs, zfs, vfs)
  - Storage locations and volume management
  - Layer structure and Copy-on-Write mechanism
  - Rootless storage considerations

# Network Architecture
- Docker provides multiple network drivers for different use cases.
- Each container runs in isolated ==network namespace==.
- Default bridge network (docker0) connects containers on single host.
- See [Container networking](site-reliability-engineering/container-engine/Container%20networking.md) for detailed information on:
  - Network drivers (bridge, host, none, overlay, macvlan)
  - Network namespace isolation and veth pairs
  - DNS resolution and port mapping
  - Bridge network topology and configuration

# Registry Architecture
- Docker uses ==centralized registries== for image distribution.
- Implements Docker Registry HTTP API V2 (now OCI Distribution Specification).
- Default registry: Docker Hub (hub.docker.com)
- See [Container registry](site-reliability-engineering/container-engine/Container%20registry.md) for detailed information on:
  - Registry hierarchy and image naming conventions
  - Registry types (Docker Hub, ECR, GCR, ACR, GHCR, Quay.io)
  - Authentication and TLS configuration
  - Image signing and verification

# Image vs Container
## Docker Image
- ==Runnable binary package== containing application code, dependencies, and configurations.
- Immutable and versioned.
- Composed of ==multiple layers== stacked on top of each other.
- Each layer identified by ==SHA-256 hash==.
- Stored in registry for distribution $\equiv$ program or executable.
## Docker Container
- ==Running instance== of a Docker image.
- Loaded into memory and executed as one or more [processes](operating-system/unix/linux/process/Process.md).
- Adds writable layer on top of image layers.
- Has own network, storage, and process namespace.
- Ephemeral by design $\implies$ destroyed data unless persisted in volumes $\equiv$ process.
## Relationship
```mermaid
graph LR
    Image["Image<br/>(Template)"]
    C1["Container 1<br/>(Instance)"]
    C2["Container 2<br/>(Instance)"]
    C3["Container 3<br/>(Instance)"]

    Image -->|docker run| C1
    Image -->|docker run| C2
    Image -->|docker run| C3

    style Image fill:#e1f5ff
    style C1 fill:#81d4fa
    style C2 fill:#81d4fa
    style C3 fill:#81d4fa
```

# Security Architecture
- Docker implements multiple isolation and security mechanisms.
- Uses Linux kernel features: namespaces, cgroups, capabilities.
- Applies syscall filtering via seccomp profiles.
- See [Container security](site-reliability-engineering/container-engine/Container%20security.md) for detailed information on:
  - Isolation mechanisms (namespaces, cgroups, capabilities)
  - Seccomp filtering and MAC (AppArmor, SELinux)
  - Docker daemon security and TLS authentication
  - Rootless containers and user namespace mapping

# Docker vs Traditional VMs
## Architecture Comparison
| Aspect             | Docker Containers             | Virtual Machines              |
| ------------------ | ----------------------------- | ----------------------------- |
| **Abstraction**    | OS-level virtualization       | Hardware-level virtualization |
| **Startup Time**   | Seconds                       | Minutes                       |
| **Size**           | MBs                           | GBs                           |
| **Performance**    | Near-native                   | Overhead from hypervisor      |
| **Isolation**      | Process-level (shared kernel) | Full OS isolation             |
| **Resource Usage** | Lightweight                   | Heavy                         |
| **Portability**    | High (same kernel)            | Moderate (full OS)            |
| **Security**       | Shared kernel risks           | Stronger isolation            |
|                    |                               |                               |

## Deployment Model
### Containers
```mermaid
graph TB
    subgraph ContainerLayer["Container Layer"]
        C1["Container 1"]
        C2["Container 2"]
    end
    Runtime["Container Runtime<br/>(Docker, containerd)"]
    Kernel["Host OS Kernel"]
    Hardware1["Physical Hardware"]

    C1 & C2 --> Runtime
    Runtime --> Kernel
    Kernel --> Hardware1

    style ContainerLayer fill:#e1f5ff
    style Runtime fill:#b3e5fc
    style Kernel fill:#81d4fa
    style Hardware1 fill:#4fc3f7
```

### Virtual Machines
```mermaid
graph TB
    subgraph VMLayer["Virtual Machine Layer"]
        subgraph VM1["VM 1"]
            GuestOS1["Guest OS"]
        end
        subgraph VM2["VM 2"]
            GuestOS2["Guest OS"]
        end
    end
    Hypervisor["Hypervisor<br/>(ESXi, KVM)"]
    HostOS["Host OS<br/>(optional)"]
    Hardware2["Physical Hardware"]

    GuestOS1 & GuestOS2 --> Hypervisor
    Hypervisor --> HostOS
    HostOS --> Hardware2

    style VMLayer fill:#fff9e1
    style VM1 fill:#ffeb3b
    style VM2 fill:#ffeb3b
    style Hypervisor fill:#ffc107
    style HostOS fill:#ff9800
    style Hardware2 fill:#ff6f00
```

# Docker Daemon vs Podman Architecture
| Feature | Docker | Podman |
|---------|--------|--------|
| **Architecture** | Client-Server (daemon) | Daemonless (fork-exec) |
| **Background Service** | dockerd required | No daemon |
| **Root Requirement** | Daemon runs as root | Rootless by default |
| **Process Model** | All containers owned by daemon | Containers owned by user |
| **Systemd Integration** | Via daemon | Native support |
| **Single Point Failure** | Daemon crash kills containers | No single point of failure |
| **Socket** | /var/run/docker.sock | No socket needed |
| **Security** | Daemon runs as root | Better isolation |

# Advantages
1. **Easy Distribution**: Package applications with dependencies in portable images
2. **Rapid Deployment**: Start containers in seconds vs minutes for VMs
3. **Resource Efficiency**: Share host kernel, minimal overhead
4. **Scalability**: Run hundreds of containers on single host
5. **Version Control**: Tag and version images for rollback
6. **Ecosystem**: Large registry of pre-built images (Docker Hub)
7. **CI/CD Integration**: Standardized build and deployment pipeline
8. **Microservices**: Ideal for microservice architectures
9. **Development Parity**: Same environment from dev to production
# Limitations
1. **Shared Kernel**: All containers share host kernel $\implies$ kernel exploits affect all
2. **Linux-Centric**: Native Linux support only, Windows/Mac use VM
3. **Daemon Dependency**: Single daemon failure affects all containers
4. **Storage Complexity**: Multiple storage drivers with different characteristics
5. **Network Overhead**: Bridge network adds latency vs host network
6. **Persistent Data**: Requires volume management for stateful applications
7. **GUI Applications**: Challenging to run GUI apps in containers
8. **Debugging**: More complex than traditional application debugging

***
# References
1. [Docker Official Documentation](https://docs.docker.com/) for comprehensive Docker documentation.
2. [Docker Architecture Overview](https://docs.docker.com/get-started/overview/) for official architecture explanation.
3. [containerd](https://containerd.io/) for containerd project documentation.
4. [runc](https://github.com/opencontainers/runc) for OCI runtime reference implementation.
5. [OCI Runtime Specification](https://github.com/opencontainers/runtime-spec) for container runtime standards.
6. [OCI Image Specification](https://github.com/opencontainers/image-spec) for image format specification.
7. [Podman architecture](site-reliability-engineering/container-engine/podman/Podman%20architecture.md) for comparison with daemonless architecture.
8. [OCI-compliant container](site-reliability-engineering/container-engine/OCI-compliant%20container.md) for container fundamentals.
9. [OCI-compliant image](site-reliability-engineering/container-engine/OCI-compliant%20image.md) for image layer concepts.
10. [Containerfile](site-reliability-engineering/container-engine/artifacts/Containerfile.md) for Dockerfile syntax and image building.
11. [Container commands](site-reliability-engineering/container-engine/Container%20commands.md) for Docker CLI commands.
12. [Container storage](site-reliability-engineering/container-engine/Container%20storage.md) for storage drivers and volume management.
13. [Container networking](site-reliability-engineering/container-engine/Container%20networking.md) for network drivers and configuration.
14. [Container security](site-reliability-engineering/container-engine/Container%20security.md) for security mechanisms and best practices.
15. [Container registry](site-reliability-engineering/container-engine/Container%20registry.md) for registry types and image distribution.
16. https://www.udemy.com/course/docker-mastery/ for Docker Mastery course.
17. https://www.aquasec.com/blog/a-brief-history-of-containers-from-1970s-chroot-to-docker-2016/ for container history.

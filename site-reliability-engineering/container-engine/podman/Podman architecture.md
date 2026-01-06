#continuous-integration #shell #docker #software-architecture #client-server #application-layer #web-server  #dbms #binary-image  #operating-system #process #memory #virtual-memory
#site-realibility-engineering
# Podman Architecture
## Overview
- Podman (Pod Manager) is a <mark class="hltr-yellow">daemonless</mark> container engine for developing, managing, and running OCI containers on Linux systems.
- Unlike Docker, Podman operates without a central daemon, providing enhanced security and flexibility through a fork-exec model.
## Components
###  Daemonless Architecture
- **No Central Daemon**: Podman runs containers as child processes of the Podman command itself
- **Fork-Exec Model**: Each container runs as a direct child process of the user's shell
- **Process Ownership**: Containers inherit the user's privileges, eliminating the need for root daemon
#### Daemonless Execution Flow
```mermaid title='Daemonless execution flow of Podman'
sequenceDiagram
    participant User as User Shell
    participant CLI as Podman CLI
    participant Libpod as Libpod Library
    participant Conmon as Conmon Monitor
    participant Runtime as OCI Runtime (runc/crun)
    participant Container as Container Process

    User->>CLI: podman run nginx:alpine
    Note over CLI: Direct process (no daemon)
    CLI->>Libpod: Check local image
    alt Image not found
        Libpod->>Libpod: Pull from registry
    end
    Libpod->>Libpod: Create container config
    Libpod->>Conmon: Fork conmon process
    Note over Conmon: Monitors container lifecycle
    Conmon->>Runtime: Execute OCI runtime
    Runtime->>Runtime: Create namespaces & cgroups
    Runtime->>Container: Fork container process
    Note over Container: Runs as child of user shell
    Container-->>Conmon: Process started
    Conmon-->>Libpod: Container running
    Libpod-->>CLI: Container ID
    CLI-->>User: Container ID returned

    Note over User,Container: No daemon - direct parent-child relationship
```
### Key Components
#### Libpod
- Core library implementing container and pod management logic
- Handles container lifecycle (create, start, stop, remove)
- Manages pods as groups of containers sharing resources
#### Container Runtime (OCI Runtime)
- **Default**: runc (OCI-compliant runtime)
- **Alternatives**: crun (lightweight C implementation)
- Responsible for low-level container execution and isolation
#### Conmon (Container Monitor)
- Monitors container processes
- Handles logging and TTY allocation
- Maintains container state information
- Acts as the intermediary between Podman and the runtime
### Pod Architecture
Podman introduces the concept of pods (borrowed from Kubernetes):
- **Infra Container**: Special pause container for shared namespaces
- **Shared Resources**: Network namespace, IPC namespace, UTS namespace
- **Multiple Containers**: Run within the same pod, sharing networking
## Architectural Flow

```mermaid
graph TD
    A[User Command<br/>podman run] --> B[Podman CLI]
    B --> C[Libpod<br/>Container/Pod Management]
    C --> D[Conmon<br/>Process Monitor]
    D --> E[OCI Runtime<br/>runc/crun]
    E --> F[Linux Kernel<br/>namespaces, cgroups]
    F --> G[Container Process]

    style A fill:#e1f5ff
    style B fill:#b3e5fc
    style C fill:#81d4fa
    style D fill:#4fc3f7
    style E fill:#29b6f6
    style F fill:#039be5
    style G fill:#0277bd
```
## Rootless Mode Architecture

### Key Features
- Runs containers without root privileges.
- Uses user namespaces for UID/GID mapping.
- Storage in user's home directory (`~/.local/share/containers`)
- Enhanced security through privilege separation.
### Rootless-Specific Components
- **User Namespaces**: Maps container UIDs to unprivileged user UIDs.
- **slirp4netns**: Provides user-mode networking without root privileges
- **fuse-overlayfs**: Enables overlay filesystem without root access
- **UID/GID Mapping**: Container root (UID 0) $\implies$ unprivileged host user
### Storage Location
```
~/.local/share/containers/     (rootless mode)
/var/lib/containers/storage/   (rootful mode)
```

# Storage Architecture
- Podman uses ==layered storage== with Copy-on-Write mechanism.
- Supports multiple storage drivers optimized for rootless operation.
- See [Container storage](site-reliability-engineering/container-engine/Container%20storage.md) for detailed information on:
  - Storage drivers (overlay, vfs, devicemapper)
  - fuse-overlayfs for rootless containers
  - Storage locations and configuration
  - Volume management
# Network Architecture
- Podman supports ==CNI (Container Network Interface)== for plugin-based networking.
- Modern versions use ==Netavark== for improved performance.
- Rootless mode uses slirp4netns for user-mode networking.
- See [Container networking](site-reliability-engineering/container-engine/Container%20networking.md) for detailed information on:
  - CNI plugins and Netavark configuration
  - Network drivers and modes
  - DNS resolution and port mapping
  - Rootless networking with slirp4netns

# Security Architecture
- Podman implements ==defense in depth== through multiple isolation layers.
- Daemonless architecture eliminates daemon-level vulnerabilities.
- Rootless mode provides enhanced security for multi-tenant environments.
- See [Container security](site-reliability-engineering/container-engine/Container%20security.md) for detailed information on:
  - Isolation mechanisms (namespaces, cgroups, capabilities)
  - Seccomp filtering and MAC (SELinux, AppArmor)
  - Rootless security benefits and UID/GID mapping
  - Security best practices
# Registry Architecture
- Podman supports all OCI-compliant registries.
- Compatible with Docker Hub, Quay.io, and private registries.
- See [Container registry](site-reliability-engineering/container-engine/Container%20registry.md) for detailed information on:
  - Registry types and authentication
  - Image naming conventions
  - Pulling and pushing images
  - Registry configuration
## Comparison with Docker Architecture

| Aspect | Podman | Docker |
|--------|--------|--------|
| Daemon | Daemonless | Central daemon (dockerd) |
| Process Model | Fork-exec | Client-server |
| Root Requirement | Optional (rootless) | Required for daemon |
| Systemd Integration | Native | Via daemon |
| Pod Support | Native | Requires Kubernetes |
| Security | Process-level isolation | Daemon-level vulnerability |

## Integration Points

### Systemd Integration
- Generate systemd unit files: `podman generate systemd`
- Socket activation support
- Native service management
### Kubernetes Compatibility
- Generate Kubernetes YAML: `podman generate kube`
- Pod manifest support
- Seamless transition to Kubernetes deployments
### Registry Integration
- Pull/push images from OCI registries
- Support for Docker Hub, Quay.io, private registries
- Authentication and credential management

## Advantages
1. **Security**: No central daemon eliminates single point of failure
2. **Systemd Integration**: Better alignment with Linux service management
3. **Rootless Operation**: Enhanced security for multi-tenant environments
4. **Docker Compatibility**: Drop-in replacement with familiar CLI
5. **Pod Support**: Native Kubernetes-like pod management
6. **Auditing**: Easier process tracking and security auditing
***
# References
1. **Podman Official Documentation** - Red Hat. "Podman Documentation." Available at: https://docs.podman.io/
2. **Open Container Initiative (OCI)** - "OCI Runtime Specification." Available at: https://github.com/opencontainers/runtime-spec
3. **OCI Image Specification** - "Open Container Initiative Image Format Specification." Available at: https://github.com/opencontainers/image-spec
4. **Libpod GitHub Repository** - "Podman: A tool for managing OCI containers and pods." Available at: https://github.com/containers/podman
5. **runc** - OCI Reference Implementation. "runc - CLI tool for spawning and running containers." Available at: https://github.com/opencontainers/runc
6. **crun** - "A fast and lightweight OCI runtime written in C." Available at: https://github.com/containers/crun
7. **Conmon** - "An OCI container runtime monitor." Available at: https://github.com/containers/conmon
8. **Linux Namespaces** - "namespaces(7) - Linux manual page." Available at: https://man7.org/linux/man-pages/man7/namespaces.7.html
9. **Control Groups (cgroups)** - "cgroups(7) - Linux manual page." Available at: https://man7.org/linux/man-pages/man7/cgroups.7.html
10. **Container Network Interface (CNI)** - "CNI Specification." Available at: https://github.com/containernetworking/cni
11. **Netavark** - "Container network stack." Available at: https://github.com/containers/netavark
12. **slirp4netns** - "User-mode networking for unprivileged network namespaces." Available at: https://github.com/rootless-containers/slirp4netns
13. **Kubernetes Pods** - "Pod Overview." Available at: https://kubernetes.io/docs/concepts/workloads/pods/
14. **Buildah** - "A tool for building OCI container images." Available at: https://buildah.io/
15. **Skopeo** - "Work with remote images registries." Available at: https://github.com/containers/skopeo
16. **Podman vs Docker** - Red Hat Developer. "Podman and Buildah for Docker users." Available at: https://developers.redhat.com/blog/2019/02/21/podman-and-buildah-for-docker-users
17. **Rootless Containers** - "Rootless Containers Documentation." Available at: https://rootlesscontaine.rs/
18. **User Namespaces** - "user_namespaces(7) - Linux manual page." Available at: https://man7.org/linux/man-pages/man7/user_namespaces.7.html
19. **Seccomp** - "Seccomp BPF (SECure COMPuting with filters)." Available at: https://www.kernel.org/doc/html/latest/userspace-api/seccomp_filter.html
20. **SELinux** - Red Hat. "What is SELinux?" Available at: https://www.redhat.com/en/topics/linux/what-is-selinux
21. [Docker architecture](site-reliability-engineering/container-engine/docker/Docker%20architecture.md) for comparison with daemon-based architecture.
22. [OCI-compliant container](site-reliability-engineering/container-engine/OCI-compliant%20container.md) for container fundamentals.
23. [Container storage](site-reliability-engineering/container-engine/Container%20storage.md) for storage drivers and rootless storage.
24. [Container networking](site-reliability-engineering/container-engine/Container%20networking.md) for CNI and Netavark configuration.
25. [Container security](site-reliability-engineering/container-engine/Container%20security.md) for security mechanisms and rootless benefits.
26. [Container registry](site-reliability-engineering/container-engine/Container%20registry.md) for registry integration.

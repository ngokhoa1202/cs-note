#containerization #docker #podman #cybersecurity #operating-system #linux #site-realibility-engineering #access-control

# Container Security
## Overview
- Containers provide ==process isolation== through Linux kernel features.
- Multiple security layers: namespaces, cgroups, capabilities, seccomp, MAC.
- Defense in depth: combining multiple security mechanisms.
- Rootless containers enhance security by avoiding root privileges.
## Isolation Mechanisms
### Linux Namespaces
Namespaces provide ==resource isolation== by creating separate views of system resources.

#### PID Namespace
- **Purpose**: Process isolation
- **Effect**: Container sees only its own processes
- **Process Tree**: Container init process becomes PID 1
- **Signals**: Cannot send signals to host processes
- **Use Case**: Prevents container from seeing/killing host processes

#### Network Namespace
- **Purpose**: Network stack isolation
- **Resources**: Interfaces, IP addresses, routing tables, firewall rules
- **Effect**: Each container has independent network configuration
- **Communication**: Via virtual ethernet (veth) pairs
- **Use Case**: Network isolation between containers

#### Mount Namespace
- **Purpose**: Filesystem view isolation
- **Effect**: Container has its own filesystem tree
- **Root**: Container sees its own root filesystem
- **Mounts**: Host mounts not visible in container
- **Use Case**: Prevents access to host filesystem

#### UTS Namespace
- **Purpose**: Hostname and domain name isolation
- **Effect**: Container can have different hostname than host
- **Configuration**: Set via `--hostname` flag
- **Use Case**: Service identification, network configuration

#### IPC Namespace
- **Purpose**: Inter-process communication isolation
- **Resources**: Message queues, semaphores, shared memory
- **Effect**: Containers cannot use IPC to communicate with host
- **Use Case**: Prevents IPC-based attacks

#### User Namespace
- **Purpose**: UID/GID mapping
- **Effect**: Root in container $\implies$ unprivileged user on host
- **Rootless**: Enables rootless container execution
- **Security**: Reduces impact of container breakout
- **Use Case**: Rootless containers, privilege separation

### Control Groups (cgroups)
Cgroups provide ==resource limitation== and ==accounting==.

#### CPU Limits
- **--cpus**: Limit CPU cores (e.g., `--cpus=2.5`)
- **--cpu-shares**: Relative CPU weight (default 1024)
- **--cpuset-cpus**: Pin to specific CPUs (e.g., `0-3`)
- **Use Case**: Prevent CPU starvation, ensure fairness

**Example:**
```bash
# Docker/Podman
docker run --cpus=1.5 nginx
podman run --cpu-shares=512 nginx
```

#### Memory Limits
- **--memory**: Hard memory limit (e.g., `--memory=512m`)
- **--memory-reservation**: Soft limit (warning threshold)
- **--memory-swap**: Total memory + swap limit
- **--oom-kill-disable**: Prevent OOM killer
- **Use Case**: Prevent memory exhaustion attacks

**Example:**
```bash
# Docker/Podman
docker run --memory=1g --memory-swap=2g nginx
```

#### Block I/O Limits
- **--blkio-weight**: I/O priority (10-1000, default 500)
- **--device-read-bps**: Read bandwidth limit
- **--device-write-bps**: Write bandwidth limit
- **Use Case**: Prevent I/O starvation

#### Device Access Control
- **--device**: Whitelist devices for container access
- **Default**: Most devices blocked
- **Security**: Reduces attack surface
- **Use Case**: Hardware access (GPU, USB)

### Linux Capabilities
Fine-grained privilege control beyond traditional root/non-root model.

#### Capability Model
- **Drop by Default**: Containers run with reduced capabilities
- **Explicit Add**: Use `--cap-add` for required capabilities
- **Explicit Drop**: Use `--cap-drop` to remove capabilities
- **Principle**: Least privilege

#### Common Capabilities
| Capability | Purpose | Risk if Granted |
|------------|---------|----------------|
| **CAP_NET_ADMIN** | Network configuration | Network attacks |
| **CAP_SYS_ADMIN** | System administration | Container escape |
| **CAP_SYS_TIME** | Set system time | Time-based attacks |
| **CAP_SYS_MODULE** | Load kernel modules | Kernel compromise |
| **CAP_NET_RAW** | Raw sockets | Network sniffing |
| **CAP_CHOWN** | Change file ownership | Permission bypass |

#### Default Docker Capabilities
Containers start with these capabilities:
- CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_FOWNER, CAP_FSETID
- CAP_KILL, CAP_SETGID, CAP_SETUID, CAP_SETPCAP
- CAP_NET_BIND_SERVICE, CAP_NET_RAW, CAP_SYS_CHROOT
- CAP_AUDIT_WRITE, CAP_SETFCAP

**Example:**
```bash
# Drop all capabilities, add only NET_BIND_SERVICE
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx

# Drop dangerous capability
podman run --cap-drop=NET_RAW nginx
```

### Seccomp (Secure Computing Mode)
Syscall filtering to reduce attack surface.

#### Overview
- **Technology**: Berkeley Packet Filter (BPF) for syscall filtering
- **Default Profile**: Blocks ~44 dangerous syscalls
- **Custom Profiles**: JSON-based seccomp profiles
- **Action**: Allow, deny, or log syscalls

#### Blocked Syscalls (Default)
Common blocked syscalls for security:
- `reboot`, `swapon`, `swapoff` - System control
- `mount`, `umount` - Filesystem operations
- `kexec_load` - Kernel loading
- `acct` - Process accounting
- `clone` (with certain flags) - Namespace creation

#### Custom Seccomp Profile
```json
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": ["read", "write", "open", "close"],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
```

**Usage:**
```bash
# Docker
docker run --security-opt seccomp=/path/to/profile.json nginx

# Podman
podman run --security-opt seccomp=/path/to/profile.json nginx

# Disable seccomp (insecure, testing only)
docker run --security-opt seccomp=unconfined nginx
```

### Mandatory Access Control (MAC)
#### AppArmor (Ubuntu/Debian)
- **Profile-Based**: Each container has security profile
- **Default Profile**: `docker-default` restricts dangerous operations
- **Custom Profiles**: Define allowed operations
- **Location**: `/etc/apparmor.d/`

**Usage:**
```bash
# Docker with custom AppArmor profile
docker run --security-opt apparmor=my-profile nginx

# Disable AppArmor (insecure)
docker run --security-opt apparmor=unconfined nginx
```

#### SELinux (RHEL/Fedora/CentOS)
- **Context-Based**: Security contexts (labels) control access
- **Type Enforcement**: Processes can only access allowed types
- **Container Label**: `svirt_lxc_net_t` or `container_t`
- **MCS**: Multi-Category Security for container separation

**SELinux Labels:**
```bash
# Docker - automatic labeling
docker run --security-opt label=type:container_runtime_t nginx

# Disable SELinux (insecure)
docker run --security-opt label=disable nginx

# Podman - SELinux by default
podman run nginx
```

## Rootless Containers
### Podman Rootless Mode
- **No Root Daemon**: Podman runs without root privileges
- **User Namespaces**: Maps container root to unprivileged host user
- **Storage**: User home directory (`~/.local/share/containers/`)
- **Security**: Container escape affects only user, not system

### UID/GID Mapping
```bash
# Inside container: root (UID 0)
# On host: unprivileged user (UID 1000)

# Example mapping:
# Container UID 0 → Host UID 1000
# Container UID 1 → Host UID 100000
# Container UID 2 → Host UID 100001
```

### Rootless Limitations
- **Privileged Ports**: Cannot bind to ports < 1024 without CAP_NET_BIND_SERVICE
- **Device Access**: Limited hardware device access
- **Performance**: fuse-overlayfs slightly slower than kernel overlay2
- **Networking**: slirp4netns vs native networking

### Rootless Benefits
1. **No Root Daemon**: Eliminates daemon-level privilege escalation
2. **User Isolation**: Container compromise limited to user account
3. **Multi-Tenancy**: Safe for shared systems
4. **Auditing**: Easier to track user actions

## Docker Daemon Security
### TLS Authentication
```bash
# Generate certificates
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

# Configure daemon
dockerd --tlsverify \
  --tlscacert=ca.pem \
  --tlscert=server-cert.pem \
  --tlskey=server-key.pem \
  -H=0.0.0.0:2376
```

### Content Trust
- **Image Signing**: Verify image publisher
- **Notary**: Image signature storage
- **Environment**: `DOCKER_CONTENT_TRUST=1`

```bash
# Enable content trust
export DOCKER_CONTENT_TRUST=1
docker pull alpine  # Verifies signature
```

### Registry Authentication
```bash
# Login to registry
docker login registry.example.com

# Use credentials
docker pull registry.example.com/private/image
```

## Security Best Practices
### Image Security
1. **Minimal Base Images**: Use Alpine, distroless, or scratch
2. **Vulnerability Scanning**: Scan with Trivy, Grype, Snyk
3. **Digest References**: Pin images by SHA-256 digest
4. **Multi-Stage Builds**: Remove build tools from final image
5. **No Secrets**: Never embed secrets in images

### Runtime Security
1. **Non-Root User**: Run as non-root inside container
   ```dockerfile
   USER 1000:1000
   ```
2. **Read-Only Filesystem**: Use `--read-only` flag
   ```bash
   docker run --read-only nginx
   ```
3. **Drop Capabilities**: Remove unnecessary capabilities
4. **Resource Limits**: Set CPU/memory limits
5. **Network Segmentation**: Use custom networks

### Monitoring and Auditing
1. **Log Collection**: Centralize container logs
2. **Audit Trails**: Enable Docker/Podman audit logging
3. **Runtime Detection**: Use Falco for anomaly detection
4. **Vulnerability Scanning**: Regular image scanning
5. **Compliance**: CIS Docker/Kubernetes benchmarks

## Security Tools
### Vulnerability Scanners
- **Trivy**: Fast, accurate vulnerability scanner
- **Grype**: Vulnerability scanner for containers
- **Snyk**: Security platform with container scanning
- **Clair**: Static analysis for container security

### Runtime Security
- **Falco**: Runtime threat detection
- **Sysdig**: Container monitoring and security
- **Aqua Security**: Container security platform

### Compliance
- **Docker Bench**: CIS Docker Benchmark script
- **InSpec**: Compliance as code framework
- **OpenSCAP**: Security compliance checking

***
# References
1. [Docker Security](https://docs.docker.com/engine/security/) for Docker security best practices.
2. [Podman Rootless](https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md) for rootless container documentation.
3. [Linux Namespaces](https://man7.org/linux/man-pages/man7/namespaces.7.html) for namespace documentation.
4. [Linux Capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html) for capability documentation.
5. [Seccomp](https://docs.docker.com/engine/security/seccomp/) for seccomp filtering.
6. [AppArmor](https://wiki.ubuntu.com/AppArmor) for AppArmor documentation.
7. [SELinux](https://www.redhat.com/en/topics/linux/what-is-selinux) for SELinux concepts.
8. [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker) for security hardening.
9. [Docker architecture](site-reliability-engineering/container-engine/docker/Docker%20architecture.md) for Docker-specific security.
10. [Podman architecture](site-reliability-engineering/container-engine/podman/Podman%20architecture.md) for Podman-specific security.

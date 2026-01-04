#dockerfile #docker #continuous-integration #operating-system #scripting #bash #shell #file-system #operating-system #software-engineering #software-architecture #computer-network #transport-layer #application-layer 
- Containerfile or Dockerfile is a special file for building Docker image.
- From a base image, docker employs user-defined dockerfile to <mark style="background: #e4e62d;">encapsulate and add new layer</mark> to that image and build a new image for a particular application. 
# Syntax
```Dockerfile title='Dockerfile syntax'
FROM <base-image> [AS <stage-name>]

LABEL <key>=<value> <key>=<value> ...

ARG <name>[=<default-value>]

ENV <key_1>=<value_1> \
    <key_2>=<value_2> \
    ...

WORKDIR <new-workdir>

COPY [OPTIONS] <src> <dest>
ADD [OPTIONS] <src> <dest>

RUN <<EOF
<commands>
EOF

USER <user>[:<group>]

VOLUME ["/data"]

EXPOSE <listening-port/protocol>

HEALTHCHECK [OPTIONS] CMD <command>

ENTRYPOINT ["executable", "param_1", ...]
CMD ["executable", "param_1", "param_2", "param_3",...]

```
## `{Dockerfile}FROM`
- Creates a new build stage from the base image.
- If the base image does not exist on the host, Docker daemon automagically downloads it from Docker registry.
## `{Dockerfile}Expose`
- Exposes the port and its corresponding transport layer's protocol on which the image will be listening on Docker virtual network.
- The specified port will be <mark style="background: #e4e62d;">bound with the host's port</mark> when running the container from the image.
## `{Dockerfile}ENV`
- Specifies global variables for building image.
- Format: `<key> = <value>`
## `{Dockerfile}WORKDIR`
- Changes the current working directory which is applied for `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `AND` commands.
## `{Dockerfile}COPY`
- Copy files or directories from `src` to `dest` in the build context.
- Only supports <mark style="background: #e4e62d;">basic file copying</mark> from local build context.
- Recommended for most file copying operations due to transparency.
## `{Dockerfile}ADD`
- Similar to `COPY` but with additional features:
	- Can extract <mark style="background: #e4e62d;">compressed archives</mark> (tar, gzip, bzip2, xz) automatically.
	- Can download files from <mark style="background: #e4e62d;">remote URLs</mark>.
- **Best practice**: Use `COPY` unless you specifically need `ADD`'s extra features.
- Format: `ADD [OPTIONS] <src> <dest>`
## `{Dockerfile}ARG`
- Defines build-time variables that users can pass at build-time.
- Only available during the <mark style="background: #e4e62d;">build process</mark>, not in running containers.
- Can be overridden: `docker build --build-arg <varname>=<value>`
- Format: `ARG <name>[=<default value>]`
```Dockerfile title='ARG example'
ARG VERSION=latest
FROM ubuntu:${VERSION}
ARG BUILD_DATE
RUN echo "Built on ${BUILD_DATE}"
```
## `{Dockerfile}LABEL`
- Adds metadata to the image as key-value pairs.
- Used for version information, maintainer details, licensing, etc.
- Format: `LABEL <key>=<value> <key>=<value> ...`
```Dockerfile title='LABEL example'
LABEL maintainer="admin@example.com" \
      version="1.0" \
      description="My application container"
```
## `{Dockerfile}USER`
- Specifies the username or UID to use when running the image.
- Affects `RUN`, `CMD`, and `ENTRYPOINT` instructions that follow it.
- <mark style="background: #e4e62d;">Security best practice</mark>: Run containers as non-root user.
- Format: `USER <user>[:<group>]` or `USER <UID>[:<GID>]`
```Dockerfile title='USER example'
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser
CMD ["./app"]
```
## `{Dockerfile}VOLUME`
- Creates a mount point for externally mounted volumes or other containers.
- Data in volumes <mark style="background: #e4e62d;">persists beyond container lifecycle</mark>.
- Format: `VOLUME ["/data"]` or `VOLUME /var/log /var/db`
## `{Dockerfile}HEALTHCHECK`
- Instructs Docker how to test if the container is still working.
- Container can have three health states: `starting`, `healthy`, `unhealthy`.
- Format: `HEALTHCHECK [OPTIONS] CMD <command>`
```Dockerfile title='HEALTHCHECK example'
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
```
## `{Dockerfile}RUN`
- Executes a specific command to create a new layer on top of the current image.
- The new layer will be used on the next stage of Dockerfile.
- There are two forms
### Executable form
- `RUN [OPTIONS] <commands>`
### Shell form
- `RUN [OPTIONS] <commands>`
- *Heredoc syntax* can be used In case there are multi-line segments of scripts:
```Dockerfile title='Default heredoc'
RUN <<EOF
apt-get update
apt-get install -y curl
EOF
```

```Dockerfile title='Bash heredoc'
RUN <<EOT bash
  set -ex
  apt-get update
  apt-get install -y vim
EOT
```
## `{Dockerfile}CMD`
- Provides <mark style="background: #e4e62d;">default command and arguments</mark> when container starts.
- Can be <mark style="background: #e4e62d;">overridden</mark> by user when running the container: `docker run <image> <new-command>`
- Only the last `CMD` instruction in Dockerfile takes effect.
- Used to perform utility functions or provide default parameters to `ENTRYPOINT`.
### Executable form
- Most common and recommended.
- `CMD ["executable", "param_1", "param_2", "param_3",...]`
### Shell form
- `CMD <cmd> <param1> <param2> ...`
- Runs in `/bin/sh -c` shell.
### Parameter form
- `CMD ["param_1", "param_2"]`
- Provides default parameters to `ENTRYPOINT`.
## `{Dockerfile}ENTRYPOINT`
- Configures the container to run as an <mark style="background: #e4e62d;">executable</mark>.
- Command arguments are <mark style="background: #e4e62d;">appended</mark> to `ENTRYPOINT`, not replaced.
- Can only be overridden with `docker run --entrypoint` flag.
- Defines the main command that should always run when container starts.
### Executable form
- Most common and recommended.
- `ENTRYPOINT ["executable", "param_1", "param_2", "param_3",...]`
### Shell form
- `ENTRYPOINT <cmd> <param1> <param2> ...`
- Prevents `CMD` or `docker run` arguments from being used.
### `CMD` vs `ENTRYPOINT` interaction
| Dockerfile | Command executed |
|------------|------------------|
| `ENTRYPOINT ["/bin/echo"]`<br>`CMD ["Hello"]` | `/bin/echo Hello` |
| `ENTRYPOINT ["/bin/echo"]` | `/bin/echo` |
| `CMD ["/bin/echo", "Hello"]` | `/bin/echo Hello` |
```Dockerfile title='ENTRYPOINT and CMD example'
# Container always runs as Python interpreter
ENTRYPOINT ["python3"]
CMD ["--help"]  # Default argument, can be overridden

# Running: docker run myimage        → python3 --help
# Running: docker run myimage app.py → python3 app.py
```
# Example
```Dockerfile
# Clone the node image for running nodejs
FROM node:6-alpine

# Listen on port 3000, the traffic coming to port 80 on localhost will be routed to this container port
EXPOSE 3000

# Clear cache
RUN apk add --no-cache tini

# Specify new directory for the image
WORKDIR ~/Documents/test/src

# Copy the package.json in current directory to new directory
COPY package.json package.json

# After copying package.json, we know which node modules should be installed
# Run npm install according to package.json
RUN npm install \
  && npm cache clean --force

# copy all remaining source files to WORKDIR
COPY . .
CMD ["tini", "--", "node", "./bin/www"]
```
# COPY vs ADD comparison
| Feature | COPY | ADD |
|---------|------|-----|
| **Basic file copying** | ✓ | ✓ |
| **Copy from URL** | ✗ | ✓ |
| **Auto-extract archives** | ✗ | ✓ (tar, gzip, bzip2, xz) |
| **Transparency** | High (predictable) | Low (implicit behavior) |
| **Best practice** | Recommended | Use only when needed |
| **Docker cache** | Better (simpler) | Can be unpredictable |
```Dockerfile title='COPY vs ADD examples'
# COPY: Simple and predictable
COPY package.json /app/
COPY src/ /app/src/

# ADD: Auto-extraction of archive
ADD myapp.tar.gz /app/
# Automatically extracts to /app/

# ADD: Download from URL (not recommended, use RUN + curl instead)
ADD https://example.com/file.tar.gz /tmp/
# Better approach:
RUN curl -o /tmp/file.tar.gz https://example.com/file.tar.gz
```
**Recommendation**: Use `COPY` unless you explicitly need `ADD`'s auto-extraction feature for local archives.
# Multi-stage builds
- Each `FROM` instruction can use a different base image, and each of them begins a new stage of the build.
- Files can be <mark style="background: #e4e62d;">selectively copied</mark> from one stage to another stage until the final image.
- Primary benefits:
	- <mark style="background: #e4e62d;">Smaller image size</mark>: Only production artifacts are in final image, not build tools.
	- <mark style="background: #e4e62d;">Security</mark>: Build tools and source code are not included in production image.
	- <mark style="background: #e4e62d;">Separation of concerns</mark>: Build environment vs runtime environment.
## Naming build stages
- Use `AS` keyword to name a stage: `FROM <image> AS <stage-name>`
- Reference named stages in `COPY --from=<stage-name>` instruction.
## Example: Go application multi-stage build
```Dockerfile title='Multi-stage build for Go'
# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Production stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
```
**Explanation:**
- **Builder stage**: Uses full Go environment (~300MB) to compile the application.
- **Production stage**: Uses minimal Alpine Linux (~5MB), copies only the compiled binary.
- **Result**: Final image is ~15MB instead of ~300MB.
## Example: Java Spring Boot multi-stage build
```Dockerfile title='Multi-stage build for Spring Boot'
# Build stage
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Production stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
## Using external image as stage
- Can copy files from any image, not just previous stages:
```Dockerfile title='Copy from external image'
FROM nginx:latest
COPY --from=alpine:latest /etc/os-release /container-os-release
```
# Build context
- The <mark style="background: #e4e62d;">build context</mark> is the set of files and directories sent to Docker daemon during image build.
- Specified by the path in `docker build` command: `docker build -t myapp:latest .`
- The `.` represents current directory as build context.
- Large build contexts <mark style="background: #e4e62d;">slow down builds</mark> due to file transfer to daemon.
## `.dockerignore` file
- Excludes files and directories from build context.
- Similar to `.gitignore` syntax.
- Should exclude: `node_modules/`, `.git/`, `*.log`, temporary files, secrets.
```dockerignore title='.dockerignore example'
# Dependencies
node_modules/
vendor/

# Version control
.git/
.gitignore

# Logs and temporary files
*.log
tmp/
*.tmp

# Environment and secrets
.env
.env.local
*.key
*.pem
```
# Layer caching and optimization
- Each Dockerfile instruction creates a <mark style="background: #e4e62d;">new image layer</mark>.
- Docker caches layers and reuses them if instruction hasn't changed.
- Cache is invalidated when instruction or its context changes.
- **Important**: Once a layer is invalidated, <mark style="background: #e4e62d;">all subsequent layers are rebuilt</mark>.
## Layer caching best practices
1. **Order instructions from least to most frequently changing:**
```Dockerfile title='Optimized layer ordering'
FROM node:18-alpine

# 1. Install system dependencies (rarely changes)
RUN apk add --no-cache python3 make g++

# 2. Copy dependency files first (changes occasionally)
COPY package.json package-lock.json ./

# 3. Install dependencies (reuses cache if package files unchanged)
RUN npm ci --production

# 4. Copy application code (changes frequently)
COPY . .

CMD ["node", "server.js"]
```
2. **Combine related RUN commands to reduce layers:**
```Dockerfile title='Layer reduction'
# Bad: Creates 3 layers
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y vim

# Good: Creates 1 layer
RUN apt-get update && \
    apt-get install -y curl vim && \
    rm -rf /var/lib/apt/lists/*
```
3. **Separate dependency installation from code copying:**
```Dockerfile title='Dependency caching'
# Copy only dependency manifests first
COPY package.json package-lock.json ./
RUN npm install

# Copy source code after dependencies installed
COPY . .
```
# Best practices
## Security best practices
1. **Use specific base image tags:**
```Dockerfile
# Bad: Version can change unexpectedly
FROM node:latest

# Good: Explicit version
FROM node:18.17-alpine3.18
```
2. **Run as non-root user:**
```Dockerfile
# Create and use non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup
USER appuser
```
3. **Scan for vulnerabilities:**
```bash
# Use Docker Scout or Trivy
docker scout cves myimage:latest
trivy image myimage:latest
```
4. **Use multi-stage builds to exclude build dependencies.**
5. **Don't store secrets in Dockerfile:**
```Dockerfile
# Bad: Hardcoded secrets
ENV API_KEY=secret123

# Good: Use build arguments or runtime environment variables
ARG API_KEY
# Or pass at runtime: docker run -e API_KEY=secret123
```
## Image size optimization
1. **Use minimal base images:**
	- `alpine` variants: Smallest (~5MB base)
	- `slim` variants: Debian-based without extras (~50MB)
	- `distroless`: Minimal runtime without shell
```Dockerfile
# 1GB+ image
FROM ubuntu:22.04

# 100MB image
FROM node:18-slim

# 50MB image
FROM node:18-alpine
```
2. **Clean up in same layer:**
```Dockerfile
RUN apt-get update && \
    apt-get install -y curl && \
    curl https://example.com/file.tar.gz -o file.tar.gz && \
    tar -xzf file.tar.gz && \
    rm file.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```
3. **Use `.dockerignore` to exclude unnecessary files.**
## Maintainability best practices
1. **Use meaningful stage names in multi-stage builds.**
2. **Add LABEL for metadata:**
```Dockerfile
LABEL org.opencontainers.image.source="https://github.com/user/repo" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.authors="team@example.com"
```
3. **Pin versions for reproducible builds:**
```Dockerfile
FROM node:18.17-alpine3.18
RUN apk add --no-cache python3=3.11.6-r0
```
4. **Use WORKDIR instead of `cd` in RUN:**
```Dockerfile
# Bad
RUN cd /app && npm install

# Good
WORKDIR /app
RUN npm install
```
# `ARG` vs `ENV` comparison
| Feature | ARG | ENV |
|---------|-----|-----|
| **Availability** | Build-time only | Build-time and runtime |
| **Persistence** | Not in final image | Persists in image and containers |
| **Override** | `--build-arg` flag | `-e` flag at container runtime |
| **Use case** | Build configuration | Application configuration |
```Dockerfile title='ARG vs ENV example'
# Build-time variable (not in running container)
ARG BUILD_VERSION=1.0.0

# Runtime variable (available in container)
ENV APP_ENV=production \
    LOG_LEVEL=info

# Use ARG to set ENV
ARG NODE_VERSION=18
ENV NODE_VERSION=${NODE_VERSION}
```
***
# References
1. [OCI-compliant image](site-reability-engineering/container-engine/OCI-compliant%20image.md) for Docker image concepts.
2. https://docs.docker.com/reference/dockerfile/ for Dockerfile command references.
3. https://docs.docker.com/reference/dockerfile/#copy for Copy command.
4. https://www.udemy.com/course/docker-mastery/learn/lecture/6806640?start=390#overview for tutorial.
5. https://docs.docker.com/build/building/multi-stage/ for multi-stage build documentation.
6. https://docs.docker.com/build/building/best-practices/ for Dockerfile best practices.
7. https://docs.docker.com/build/building/context/ for build context details. 
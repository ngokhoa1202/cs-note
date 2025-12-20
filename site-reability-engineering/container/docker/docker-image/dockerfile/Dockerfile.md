#dockerfile #docker #ci-cd #operating-system #scripting #bash #shell #file-system #operating-system #software-engineering #software-architecture #computer-network #transport-layer #application-layer 

- Dockerfile is a special file for building Docker image.
- From a base image, docker employs user-defined dockerfile to <mark style="background: #e4e62d;">encapsulate and add new layer</mark> to that image and build a new image for a particular application. 
# Syntax
```Dockerfile
FROM <base-image>

EXPOSE <listening-port/protocol>

ENV <key_1> = <value_1> \
  <key_2> = <value_2> \
  ...
WORKDIR <new-workdir>

COPY [OPTIONS] <src> <dest>

RUN <<EOF
<commands>
EOF

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
- Copy files or directories from `src` to `dest`
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
## `CMD`
- The command is run when a container is built from the current image.
### Executable form
- Most common.
- `CMD ["executable", "param_1", "param_2", "param_3",...]`
### Shell form
- `CMD <cmd> <param1> <param2> ...` .
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
# Multi-stage builds
- Each `FROM` instruction can use a different base image, and each of them begins a new stage of the build.
- Files can be *selectively copied* from one stage to another stage until the final image.
***
# References
1. [Docker image](Docker%20image.md) for Docker image concepts.
2. https://docs.docker.com/reference/dockerfile/ for Dockerfile command references.
3. https://docs.docker.com/reference/dockerfile/#copy for Copy command.
4. https://www.udemy.com/course/docker-mastery/learn/lecture/6806640?start=390#overview for tutorial.
5. 
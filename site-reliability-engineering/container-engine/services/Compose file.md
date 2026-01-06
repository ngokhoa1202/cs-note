#linux #container-engine #container-orchestration #containerization #podman #docker
#computer-network #application-layer #transport-layer #windows #wsl #fedora #ubuntu
#debian #centos-stream #rhel   #site-realibility-engineering #continuous-delivery 
#continuous-integration 
# Purpose
- Compose file (or Docker Compose file) is a *YAML configuration file* that defines and manages multi-container applications.
- Instead of running multiple `docker run` commands with numerous flags, Compose file allows <mark class="hltr-yellow">defining services, networks, and volumes in a single declarative file</mark>.
- Compose file enables *reproducible deployments* across different environments (development, staging, production).
# File Structure
## File naming convention
- Default filename: `compose.yaml` or `docker-compose.yaml`
- Legacy filename: `docker-compose.yml`
- Custom filename can be specified using `-f` flag.
## Version specification
- Compose file format has evolved through multiple versions: `1`, `2`, `2.x`, `3`, `3.x`.
- Modern Compose files (Compose Specification) ==do not require== explicit version field.
- Legacy files use `version: "3.8"` at the top of the file.
# Compose File Syntax
## Basic structure
```yaml title='Basic yaml syntax'
services:
  <service-name-1>:
    <service-configuration>
  <service-name-2>:
    <service-configuration>

networks:
  <network-name>:
    <network-configuration>

volumes:
  <volume-name>:
    <volume-configuration>
```
## Service definition
### `image`
- Specifies the container image to use for the service.
- If image does not exist locally, Compose automagically *pulls* from registry.
```yaml
services:
  web:
    image: nginx:alpine
```
### `build`
- *Builds image* from Dockerfile instead of pulling from registry.
- Can specify build context path and Dockerfile location.
```yaml
services:
  app:
    build: ./app

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.prod
```
### `container_name`
- Assigns custom name to container.
- If not specified, Compose generates name: `<project-name>_<service-name>_<replica-number>`.
```yaml
services:
  db:
    container_name: mysql-database
    image: mysql:8.0
```
### `ports`
- Maps container ports to host ports $\equiv$ `docker run -p`.
- Format: `"HOST:CONTAINER"` or `"HOST:CONTAINER/PROTOCOL"`.
```yaml
services:
  web:
    ports:
      - "8080:80"           # Map host 8080 to container 80
      - "443:443"
      - "127.0.0.1:3306:3306/tcp"  # Bind to specific interface
```
### `environment`
- Sets environment variables inside container $\equiv$ `docker run -e`.
- Two formats: key-value pairs or list format.
```yaml
services:
  db:
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: myapp

  app:
    environment:
      - NODE_ENV=production
      - DEBUG=false
```
### `env_file`
- Loads environment variables from external file.
- Useful for ==separating secrets== from version control.
```yaml
services:
  app:
    env_file:
      - .env
      - .env.production
```
### `volumes`
- Mounts host directories or named volumes into container $\equiv$ `docker run -v`.
- Format: `"HOST_PATH:CONTAINER_PATH"` or `"VOLUME_NAME:CONTAINER_PATH"`.
```yaml
services:
  db:
    volumes:
      - mysql-data:/var/lib/mysql          # Named volume
      - ./config:/etc/mysql/conf.d:ro      # Bind mount (read-only)
      - /var/run/docker.sock:/var/run/docker.sock  # Socket mount

volumes:
  mysql-data:  # Named volume declaration
```
### `networks`
- Connects service to specific network(s).
- Services in same network can ==communicate== using service names as hostnames.
```yaml
services:
  web:
    networks:
      - frontend
      - backend

  db:
    networks:
      - backend

networks:
  frontend:
  backend:
```
### `depends_on`
- Defines service startup ==dependencies==.
- Ensures dependent services start before current service.
- Does not wait for service to be "ready", only "started".
```yaml
services:
  web:
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
```
### `restart`
- Configures container restart policy.
- Options: `no`, `always`, `on-failure`, `unless-stopped`.
```yaml
services:
  app:
    restart: unless-stopped

  cache:
    restart: on-failure
```
### `command`
- Overrides default command from Docker image $\equiv$ `docker run` `COMMAND`.
```yaml
services:
  app:
    image: node:18-alpine
    command: npm run dev

  worker:
    image: python:3.11
    command: ["python", "worker.py", "--verbose"]
```
### `working_dir`
- Sets working directory inside container $\equiv$ Dockerfile `WORKDIR`.
```yaml
services:
  app:
    working_dir: /app
```
### `user`
- Specifies user to run container process.
- Format: `username`, `uid`, or `uid:gid`.
```yaml
services:
  app:
    user: "1000:1000"
```

### `healthcheck`
- Defines health check command to test container health.
```yaml
services:
  web:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```
## Network definition
### Driver types
- `bridge`: Default network driver, creates isolated network.
- `host`: Use host network directly, ==no isolation==.
- `overlay`: Multi-host networking for Swarm mode.
- `none`: Disable networking.
```yaml
networks:
  frontend:
    driver: bridge

  backend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```
## Volume definition
### Driver types
- `local`: Default driver, stores data on host filesystem.
- `nfs`: Network File System for shared storage.
```yaml
volumes:
  db-data:
    driver: local

  shared-storage:
    driver: local
    driver_opts:
      type: nfs
      o: addr=192.168.1.100,rw
      device: ":/path/to/dir"
```
# Docker Compose Commands
## General syntax
```Shell title='docker compose basic syntax'
docker compose [OPTIONS] COMMAND
```
- For older Docker Compose standalone: `docker-compose [OPTIONS] COMMAND`
- Podman equivalent: `podman-compose [OPTIONS] COMMAND`
## `docker compose up`
### Behavior
- ==Creates and starts== all services defined in Compose file.
- Builds images if `build` is specified and image does not exist.
- Creates networks and volumes if they do not exist.
- Attaches to container logs by default.
### Syntax
```Shell title='docker compose up command'
docker compose up [OPTIONS] [SERVICE...]
```
### Options
#### Detached mode
- `-d` or `--detach`: Run containers in ==background== and return control to terminal.
```bash
docker compose up -d
```
#### Build before starting
- `--build`: Force rebuild images even if they exist.
```Shell title='Force rebuild images when run compose file'
docker compose up --build
```
#### Recreate containers
- `--force-recreate`: Recreate containers even if configuration has not changed.
- `--no-recreate`: Do not recreate existing containers.
```bash
docker compose up --force-recreate
```
#### Scale services
- `--scale SERVICE=NUM`: Run specific number of container instances for a service.
```bash
docker compose up --scale web=3
```
#### Remove orphans
- `--remove-orphans`: Remove containers for services not defined in current Compose file.
```bash
docker compose up --remove-orphans
```
## `docker compose down`
### Behavior
- ==Stops and removes== containers, networks created by `up`.
- Does not remove volumes by default.
### Syntax
```bash
docker compose down [OPTIONS]
```
### Options
#### Remove volumes
- `-v` or `--volumes`: Remove named volumes declared in Compose file.
```bash
docker compose down -v
```
#### Remove images
- `--rmi TYPE`: Remove images used by services.
  - `all`: Remove all images.
  - `local`: Remove only images without custom tag.
```bash
docker compose down --rmi all
```
## `docker compose start`
### Behavior
- ==Starts== existing stopped containers.
- Does not create new containers.
### Syntax
```bash
docker compose start [SERVICE...]
```
## `docker compose stop`
### Behavior
- ==Stops== running containers without removing them.
### Syntax
```bash
docker compose stop [SERVICE...]
```
### Options
- `-t` or `--timeout`: Timeout in seconds before killing container (default: 10).
```bash
docker compose stop -t 30
```
## `docker compose restart`
### Behavior
- ==Restarts== running containers.
### Syntax
```Shell title='Restart docker compose'
docker compose restart [OPTIONS] [SERVICE...]
```
### Options
- `-t` or `--timeout`: Timeout in seconds.
```bash
docker compose restart -t 30
```
## `docker compose ps`
### Behavior
- Lists containers for services defined in Compose file.
### Syntax
```Shell title='Inspect containers and services'
docker compose ps [OPTIONS] [SERVICE...]
```
### Options
- `-a` or `--all`: Show all containers including stopped ones.
```bash
docker compose ps -a
```
## `docker compose logs`
### Behavior
- Displays ==logs== from service containers.
### Syntax
```bash
docker compose logs [OPTIONS] [SERVICE...]
```
### Options
#### Follow logs
- `-f` or `--follow`: Follow log output in real-time.
```Shell title='Log a specific container in real-time'
docker compose logs -f web
```
#### Show timestamps
- `-t` or `--timestamps`: Show timestamps in logs.
```Shell title='Show timestamps in logs'
docker compose logs -t
```
#### Limit lines
- `--tail NUM`: Show last NUM lines of logs.
```Shell title='Limit the number of lines in logs'
docker compose logs --tail=100 app
```
## `docker compose exec`
### Behavior
- ==Executes command== in running service container $\equiv$ `docker exec`.
### Syntax
```Shell
docker compose exec [OPTIONS] SERVICE COMMAND [ARGS...]
```
### Options
- `-it`: Interactive terminal mode.
```bash
docker compose exec -it db bash
docker compose exec web npm test
```
## `docker compose build`
### Behavior
- Builds or rebuilds service images.
### Syntax
```Shell
docker compose build [OPTIONS] [SERVICE...]
```
### Options
- `--no-cache`: Build without using cache.
- `--pull`: Always pull newer version of base image.
```Shell
docker compose build --no-cache --pull
```
## `docker compose pull`
### Behavior
- *Pulls* service images from registry.
### Syntax
```Shell title='Pull service images from registry'
docker compose pull [SERVICE...]
```
## `docker compose push`
### Behavior
- *Pushes* service images to registry.
### Syntax
```Shell title='Push service images to registry'
docker compose push [SERVICE...]
```
## `docker compose config`
### Behavior
- Validates and displays Compose file configuration.
- Useful for *debugging* syntax errors.
### Syntax
```Shell title='Display compose file configuration'
docker compose config
```
## `docker compose top`
### Behavior
- Displays *running processes* of service containers.
### Syntax
```Shell title='Display running processes'
docker compose top [SERVICE...]
```
## Specify custom Compose file
- `-f` or `--file`: Specify alternative Compose file.
- `-p` or `--project-name`: Specify custom project name.
```bash
docker compose -f docker-compose.prod.yaml up -d
docker compose -f compose.yaml -f compose.override.yaml up
docker compose -p myproject up
```
# Practical Examples
## Simple web application with database
```Yaml
services:
  web:
    image: nginx:alpine
    container_name: web-server
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./html:/usr/share/nginx/html:ro
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    networks:
      - frontend
    depends_on:
      - app
    restart: unless-stopped

  app:
    build: ./app
    container_name: application
    environment:
      - DB_HOST=db
      - DB_USER=root
      - DB_PASSWORD=secret
      - DB_NAME=myapp
    networks:
      - frontend
      - backend
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: mysql:8.0
    container_name: database
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: myapp
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - backend
    restart: unless-stopped

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

volumes:
  db-data:
```

## Node.js application with Redis cache
```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
      REDIS_URL: redis://cache:6379
    volumes:
      - ./src:/app/src:ro
      - node-modules:/app/node_modules
    depends_on:
      - cache
    command: npm start
    restart: always

  cache:
    image: redis:7-alpine
    ports:
      - "127.0.0.1:6379:6379"
    volumes:
      - redis-data:/data
    command: redis-server --appendonly yes
    restart: always

volumes:
  node-modules:
  redis-data:
```
## Microservices architecture
```yaml
services:
  frontend:
    build: ./frontend
    ports:
      - "80:80"
    networks:
      - public
    depends_on:
      - api-gateway

  api-gateway:
    build: ./gateway
    ports:
      - "8080:8080"
    environment:
      USER_SERVICE_URL: http://user-service:3001
      ORDER_SERVICE_URL: http://order-service:3002
    networks:
      - public
      - internal
    depends_on:
      - user-service
      - order-service

  user-service:
    build: ./services/users
    environment:
      DB_HOST: postgres
      DB_NAME: users
    networks:
      - internal
    depends_on:
      - postgres

  order-service:
    build: ./services/orders
    environment:
      DB_HOST: postgres
      DB_NAME: orders
    networks:
      - internal
    depends_on:
      - postgres

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - pg-data:/var/lib/postgresql/data
    networks:
      - internal

networks:
  public:
    driver: bridge
  internal:
    driver: bridge

volumes:
  pg-data:
```
## Using environment file
### `.env` file
```Properties title='.env file example'
# Database configuration
MYSQL_ROOT_PASSWORD=mysecretpassword
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppassword

# WordPress configuration
WP_DEBUG=false
```
### `compose.yaml`
```yaml
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: ${MYSQL_USER}
      WORDPRESS_DB_PASSWORD: ${MYSQL_PASSWORD}
      WORDPRESS_DB_NAME: ${MYSQL_DATABASE}
      WORDPRESS_DEBUG: ${WP_DEBUG}
    volumes:
      - wp-content:/var/www/html/wp-content
    depends_on:
      - db

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - db-data:/var/lib/mysql

volumes:
  wp-content:
  db-data:
```
## Development environment with hot reload
```yaml
services:
  app:
    build:
      context: .
      target: development  # Multi-stage Dockerfile
    ports:
      - "3000:3000"
      - "9229:9229"  # Node.js debugger port
    environment:
      NODE_ENV: development
    volumes:
      - ./src:/app/src        # Mount source code
      - ./package.json:/app/package.json
      - node-modules:/app/node_modules  # Prevent overwriting node_modules
    command: npm run dev
    stdin_open: true   # Keep stdin open for interactive debugging
    tty: true          # Allocate pseudo-TTY

volumes:
  node-modules:
```
## Running commands
```Shell
# Start all services in background
docker compose up -d

# View logs from all services
docker compose logs -f

# View logs from specific service
docker compose logs -f web

# Execute command in running container
docker compose exec app npm test
docker compose exec db mysql -u root -p

# Scale specific service
docker compose up -d --scale worker=3

# Rebuild and restart specific service
docker compose up -d --build app

# Stop all services
docker compose stop

# Stop and remove all containers, networks
docker compose down

# Stop and remove all containers, networks, volumes
docker compose down -v

# Restart specific service
docker compose restart web

# View running containers
docker compose ps

# Validate Compose file syntax
docker compose config

# Pull latest images
docker compose pull

# Build all images
docker compose build

# Build without cache
docker compose build --no-cache
```
***
# References
1. [Docker Compose Specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) for official Compose file specification.
2. [Docker Compose CLI Reference](https://docs.docker.com/compose/reference/) for complete command documentation.
3. [Docker Compose File Reference](https://docs.docker.com/compose/compose-file/) for all service configuration options.
4. [Podman Compose](https://github.com/containers/podman-compose) for Podman's Compose implementation.
5. [Container commands](site-reliability-engineering/container-engine/Container%20commands.md) for individual container commands.
6. [Containerfile](site-reliability-engineering/container-engine/artifacts/Containerfile.md) for Dockerfile syntax and image building.
7. [OCI-compliant container](site-reliability-engineering/container-engine/OCI-compliant%20container.md) for container fundamentals.
8. [Docker Compose Networking](https://docs.docker.com/compose/networking/) for advanced networking concepts.
9. [Docker Compose Environment Variables](https://docs.docker.com/compose/environment-variables/) for environment variable substitution.
10. https://www.udemy.com/course/docker-mastery/ for Docker Compose tutorials.
11. [[site-reliability-engineering/container-engine/artifacts/Containerfile|Containerfile]]


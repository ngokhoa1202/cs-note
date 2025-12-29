#quarkus #java #java21 #java17 #podman #container #site-realibility-engineering 
#continuous-delivery #bash #cli #rhel #debian #ubuntu #serverless #cloud-computing #maven #gradle #binary-image #fedora 
- Quarkus framework is microservice-oriented, so its final `.jar` file is not standalone but dynamically links to other libraries.
- Quarkus framework is aligned with *Redhat-based* container.
# JVM image
## Redhat-based image
### Build with Maven
```Dockerfile title='Build Redhat-based Quarkus image' hl=21-24,5
FROM registry.redhat.io/ubi9/openjdk-21:latest AS builder
WORKDIR /app

USER root
RUN microdnf install -y gzip

COPY mvnw ./
COPY .mvn ./.mvn
COPY pom.xml ./

RUN ./mvnw wrapper:wrapper
RUN ./mvnw dependency:go-offline

COPY src ./src
RUN ./mvnw package -DskipTests
FROM registry.redhat.io/ubi8/openjdk-21-runtime:latest AS runtime

USER 100

WORKDIR /app
COPY --from=builder --chown=100 /app/target/quarkus-app/lib ./deployments/lib/
COPY --from=builder --chown=100 /app/target/quarkus-app/*.jar ./deployments/
COPY --from=builder --chown=100 /app/target/quarkus-app/app/ ./deployments/app/
COPY --from=builder --chown=100 /app/target/quarkus-app/quarkus/ ./deployments/quarkus/

EXPOSE 8080

ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/app/deployments/quarkus-run.jar"
ENTRYPOINT ["/opt/jboss/container/java/run/run-java.sh"]
```
### Build with Gradle
## Debian-based image
### Build with maven
#### Build  with Maven container and copy binary image into JRE container
```Dockerfile title='Build Debian-based Quarkus image by using maven container' info:1,14,33-36
FROM docker.io/library/maven:3.9.12-eclipse-temurin-17-alpine AS builder

USER 100
WORKDIR /app

USER root
COPY ./pom.xml ./pom.xml

RUN mvn dependency:go-offline

COPY ./src /app/src
RUN mvn clean package -DskipTests

FROM docker.io/library/eclipse-temurin:17-jre AS runtime

USER root
RUN <<EOT bash
  set -ex
  apt-get -y update
  apt-get -y install --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOT

USER 100
WORKDIR /app

COPY --from=builder --chown=100 /app/target/quarkus-app/lib ./deployments/lib
COPY --from=builder --chown=100 /app/target/quarkus-app/*.jar ./deployments/
COPY --from=builder --chown=100 /app/target/quarkus-app/app ./deployments/app
COPY --from=builder --chown=100 /app/target/quarkus-app/quarkus ./deployments/quarkus

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app/deployments/quarkus-run.jar" ]
```
#### Copy source and directly build into JRE container
```Dockerfile title='Build Debian-based Quarkus image by copying source and build' info:6-18,23-26,1
COPY ./src /app/src
RUN mvn clean package -DskipTests

FROM docker.io/library/eclipse-temurin:17-jre AS runtime

USER root
RUN <<EOT bash
  set -ex
  apt-get -y update
  apt-get -y install --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOT

USER 100
WORKDIR /app

COPY --from=builder --chown=100 /app/target/quarkus-app/lib ./deployments/lib
COPY --from=builder --chown=100 /app/target/quarkus-app/*.jar ./deployments/
COPY --from=builder --chown=100 /app/target/quarkus-app/app ./deployments/app
COPY --from=builder --chown=100 /app/target/quarkus-app/quarkus ./deployments/quarkus

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app/deployments/quarkus-run.jar" ]
```
# Native image
## Red Hat's GraalVM builder
```Dockerfile title='Build a Red Hat based Quarkus image with Red Hat's GraalVM builder'
# ============================================
# Stage 1: Build Native Image with GraalVM
# ============================================
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21 AS builder

WORKDIR /build

# Copy Maven wrapper and pom.xml for dependency caching
COPY --chown=quarkus:quarkus mvnw /build/mvnw
COPY --chown=quarkus:quarkus .mvn /build/.mvn
COPY --chown=quarkus:quarkus pom.xml /build/

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY --chown=quarkus:quarkus src /build/src

# Build native executable
RUN ./mvnw package -Pnative -DskipTests -B

# ============================================
# Stage 2: Runtime with Minimal Image
# ============================================
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3

WORKDIR /app

# Copy the native executable
COPY --from=builder --chown=1001:root /build/target/*-runner /app/application

# Set ownership and permissions
RUN chmod 775 /app/application

# Run as non-root user
USER 1001

EXPOSE 8080

ENTRYPOINT ["/app/application"]
```
## Micro-native image
***
# References
1. https://www.graalvm.org/ for GraalVM.
2. 
#quarkus #java #java21 #java17 #podman #containerization #site-realibility-engineering 
#continuous-delivery #shell #shell #rhel #debian #ubuntu #serverless #cloud-computing #maven #gradle #binary-image #fedora 
- Quarkus framework is microservice-oriented, so its final `.jar` file is not standalone but dynamically links to other libraries.
- Quarkus framework is aligned with *Redhat-based* container.
# Prerequisites
- Toggle off the `devservices` properties via `application.properties` or `application.yaml` file.
```Properties title='Turn devservices off'
quarkus.datasource.devservices.enabled=false
```

```yaml title='Turn devservices off'
application:
  datasource:
    devservices:
      enable: false
```
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

USER 1000

WORKDIR /app
COPY --from=builder --chown=1000 /app/target/quarkus-app/lib ./deployments/lib/
COPY --from=builder --chown=1000 /app/target/quarkus-app/*.jar ./deployments/
COPY --from=builder --chown=1000 /app/target/quarkus-app/app/ ./deployments/app/
COPY --from=builder --chown=1000 /app/target/quarkus-app/quarkus/ ./deployments/quarkus/

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
- The builder image must have the same Linux distribution as the runtime image.
## Red Hat's GraalVM builder
- GraalVM is natively supported by Red Hat operating system and Red Hat `mandrel` image, which is a customized version of Eclipse Temurin. 
```Dockerfile title='Build a Red Hat based Quarkus image with Red Hat GraalVM builder'
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
FROM registry.access.redhat.com/ubi10/ubi-minimal:latest

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
## Debian-based GraalVM builder
- GraalVM is not natively supported by Debian-based operating system; as a result, a separate installation of GraalVM is required.
```Dockerfile title='Build a Red Hat based Quarkus image with Debian GraalVM builder' hl=16-20
FROM docker.io/library/eclipse-temurin:21 AS builder

USER root
RUN <<EOT bash
  set -ex
  apt-get -y update
  apt-get -y install build-essential \
    zlib1g-dev \
    wget \
    tar
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOT

WORKDIR /opt
RUN wget -q https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.2/graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz && \
    tar -xzf graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz && \
    rm 'graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz'
ENV JAVA_HOME=/opt/graalvm-community-openjdk-21.0.2+13.1
ENV PATH=$JAVA_HOME/bin:$PATH

WORKDIR /build
COPY ./.mvn ./.mvn
COPY ./mvnw ./mvnw
COPY ./pom.xml ./pom.xml
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw package -Pnative -DskipTests

FROM docker.io/library/ubuntu:noble AS runtime

WORKDIR /app
COPY --from=builder --chown=1000:root /build/target/*-runner /app/application
RUN chmod 775 /app/application

USER 1000
EXPOSE 3563
ENTRYPOINT ["/app/application"]
```
***
# References
1. https://www.graalvm.org/ for GraalVM.
2. https://adoptium.net/temurin for Eclipse Temurin JDK.
3. https://quarkus.io/guides/building-native-image for building a Quarkus native image tutorial.
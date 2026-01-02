#spring #java #java21 #java17 #podman #containerization #site-realibility-engineering 
#continuous-delivery #bash #cli #rhel #spring-boot #ubuntu #debian
- The Spring Boot `.jar` is a standalone executable image.
# Debian-based image
```Dockerfile title='Containerfile to build simple Spring Boot image based on Debian'
FROM maven:3.9.12-eclipse-temurin-17-alpine AS builder

# USER root
WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app/pom.xml

RUN mvn dependency:go-offline
RUN mvn clean package -DskipTests

FROM docker.io/library/eclipse-temurin:17-jre as runtime

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
COPY --from=builder --chown=100 /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```
# Red Hat-based image
```Dockerfile title='Containerfile to build simple Spring Boot image based on Red Hat'
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21.0.9 AS builder

USER root
WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app/pom.xml
COPY ./.mvn /app/.mvn
COPY ./mvnw /app/mvnw

RUN mkdir ./target
RUN ./mvnw dependency:go-offline
RUN ./mvnw clean package -DskipTests

FROM registry.redhat.io/ubi8/openjdk-21-runtime:latest as runtime

USER root


RUN <<EOT bash
  set -ex
  microdnf update -y
  microdnf install -y \
    curl \
    wget \
    procps-ng \
    net-tools \
    iputils
  microdnf clean all
EOT

USER 100
WORKDIR /app
COPY --from=builder --chown=100 /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

```
***
# References
1. https://spring.io/guides/gs/spring-boot-docker
2. 
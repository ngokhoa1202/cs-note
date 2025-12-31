#spring #java #java21 #java17 #podman #containerization #site-realibility-engineering 
#continuous-delivery #bash #cli #rhel #spring-boot #ubuntu #debian
- The Spring Boot `.jar` is a standalone executable image.
# Debian-based image
```Dockerfile title='Containerfile to build simple Spring Boot image'
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
***
# References
1. https://spring.io/guides/gs/spring-boot-docker
2. 
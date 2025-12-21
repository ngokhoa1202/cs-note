#quarkus #java #java21 #java17 #podman #container #site-realibility-engineering 
#continuous-delivery #bash #cli #redhat #debian #ubuntu 
- Quarkus framework is microservice-oriented, so its final `.jar` file is not standalone but dynamically links to other libraries.
# Redhat-based image
```Dockerfile title='Build Redhat-based Quarkus image' hl=22-25

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
# Debian-based image
```Dockerfile title='Build Debian-based Quarkus image' info:6-18,23-26
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
***
# References
1. 
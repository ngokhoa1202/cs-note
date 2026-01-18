#spring #java #java21 #java17 #podman #containerization #site-realibility-engineering 
#continuous-delivery #shell  #rhel #spring-boot #ubuntu #debian #ibm #rhel10 #graalvm #gradle #maven 
- The Spring Boot `.jar` is a standalone executable image.
# JVM image
## Debian-based image
### Ubuntu-based image
#### Eclipse Temurin JDK
##### Java 17
```Dockerfile title='Containerfile to build simple Spring Boot image based on Debian with Eclipse Temurin JDK 17 and Maven' hl=31,9-10
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
- The image size recorded in reality is 653 MB.
- ![[assets/Pasted image 20260104145737.png]]
##### Java 21
```Dockerfile title='Containerfile to build simple Spring Boot image based on Debian with Eclipse Temurin JDK 21'
FROM maven:3.9.12-eclipse-temurin-21-alpine as builder

WORKDIR /build

COPY ./src ./src
COPY ./pom.xml ./pom.xml

RUN mvn dependency:go-offline
RUN mvn clean package -DskipTests

FROM docker.io/library/eclipse-temurin:21-jre
USER root
RUN <<EOT bash
  set -ex
  apt-get update -y
  apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOT

USER 1000
WORKDIR /app
COPY --from=builder --chown=1000 /build/target/*.jar /app/app.jar

EXPOSE 5483
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```

```Dockerfile title='Containerfile to build simple Spring Boot image based on Debian with Eclipse Temurin JDK 17 and Gradle' hl=5-7,9,29
FROM docker.io/library/gradle:9.2.1-jdk21-noble AS builder
USER gradle

WORKDIR /home/gradle
COPY ./src ./src
COPY ./build.gradle ./build.gradle
COPY ./settings.gradle ./settings.gradle

RUN gradle clean build --info

FROM docker.io/library/eclipse-temurin:21-jre AS runtime
USER root

RUN <<EOT bash
  set -ex
  apt-get update -y
  apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOT

USER 1000
WORKDIR /app
COPY --from=builder --chown=1000 /home/gradle/build/libs/spring-petclinic-?.?.?-SNAPSHOT.jar /app/app.jar
```
- The image size recorded in reality is 677 MB.
- ![[assets/Pasted image 20260104165012.png]]
#### IBM Semeru JDK
##### Java 21
```Dockerfile title='Containerfile to build simple Spring Boot image based on Ubuntu with IBM Semeru JDK 21'
FROM docker.io/library/ibm-semeru-runtimes:open-21.0.9_10-jdk-noble as builder
USER root
WORKDIR /build

COPY ./src ./src
COPY ./pom.xml ./pom.xml
COPY ./.mvn ./.mvn
COPY ./mvnw ./mvnw

RUN ./mvnw dependency:go-offline
RUN ./mvnw clean package -DskipTests

FROM docker.io/library/ibm-semeru-runtimes:open-21.0.9_10-jre-noble AS runtime
USER root
RUN <<EOT bash
  set -ex
  apt-get update
  apt-get upgrade -y
  apt-get install -y --no-install-recommends \
    ca-certificates \
    openssl \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    libssl3 \
    libcurl4 \
    zlib1g \
    tzdata \
    procps \
    locales
  
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
  locale-gen
  
  update-ca-certificates
  
  apt-get clean
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*
EOT

RUN groupadd -r -g 1001 app && \
  useradd -r -u 1001 -g app -m -s /bin/bash app

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF_8

ENV TZ=UTC
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app
RUN chown -R app:app /app

USER app

COPY --from=builder --chown=app /build/target/*.jar /app/app.jar

EXPOSE 5483
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```
- The image size recorded is 405 MB.
- ![[assets/Pasted image 20260107203951.png]]
## Red Hat-based image
### Red Hat 8
#### Java  21
```Dockerfile title='Containerfile to build simple Spring Boot image based with OpenJDK 21 on Red Hat 8'
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
### Red Hat 9
- Remove the post-quantum certificates introduced by Red Hat 9 because it causes unsupported versions of V6 key from third-party libraries.
- When building the executable `.jar` file, root permission can be required to access check style XML.
```Dockerfile title='Containerfile to build simple Spring Boot image based on Debian with OpenJDK 21 on Red Hat 10' hl=16,2
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21.0.9 as builder
USER root
WORKDIR /build

COPY ./src ./src
COPY ./pom.xml ./pom.xml
COPY ./.mvn ./.mvn
COPY ./mvnw ./mvnw

RUN ./mvnw dependency:go-offline
RUN ./mvnw clean package -DskipTests

FROM registry.redhat.io/ubi9/openjdk-21:latest AS runtime
USER root
RUN <<EOT bash
  rm -f /etc/pki/rpm-gpg/RPM-GPG-KEY-PQC-redhat-release
  set -ex
  microdnf update -y
  microdnf install -y \
    wget \
    procps-ng \
    net-tools \
    iputils
  microdnf clean all 
EOT

USER 1000
WORKDIR /app
COPY --from=builder --chown=1000 /build/target/*.jar /app/app.jar

EXPOSE 5483
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```
- The image size recorded is 560 MB.
- ![[assets/Pasted image 20260107072603.png]]
# Native image
- Spring Boot native image is only supported from Java 25.
## Red Hat-based image
### Red Hat 10
#### Mandrel
- The image size recorded is 479 MB but the single executable file is only 105 MB.
- ![[assets/Pasted image 20260108201852.png]]
- A native build profile must be added to `pom.xml`
```Xml title='Native profile in pom.xml' hl=88-112,181-203
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>4.0.0</version>
  </parent>
  <groupId>org.springframework.samples</groupId>
  <artifactId>spring-petclinic</artifactId>
  <version>3.4.1-SNAPSHOT</version>
  <name>petclinic</name>

  <properties>
    <!-- Generic properties -->
    <java.version>25</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <!-- Important for reproducible builds. Update using e.g. ./mvnw versions:set -DnewVersion=... -->
    <project.build.outputTimestamp>2024-11-28T14:37:52Z</project.build.outputTimestamp>

    <!-- Web dependencies -->
    <webjars-locator.version>1.1.2</webjars-locator.version>
    <webjars-bootstrap.version>5.3.8</webjars-bootstrap.version>
    <webjars-font-awesome.version>4.7.0</webjars-font-awesome.version>

    <checkstyle.version>12.1.2</checkstyle.version>
    <jacoco.version>0.8.14</jacoco.version>
    <libsass.version>0.3.4</libsass.version>
    <lifecycle-mapping>1.0.0</lifecycle-mapping>
    <maven-checkstyle.version>3.6.0</maven-checkstyle.version>
    <nohttp-checkstyle.version>0.0.11</nohttp-checkstyle.version>
    <spring-format.version>0.0.47</spring-format.version>
  </properties>

  <licenses>
    <license>
      <name>Apache License, Version 2.0</name>
      <url>https://www.apache.org/licenses/LICENSE-2.0</url>
    </license>
  </licenses>

  <dependencies>
    <!-- Spring and Spring Boot dependencies -->
    <dependency>
      <groupId>org.testcontainers</groupId>
      <artifactId>testcontainers-mysql</artifactId>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-enforcer-plugin</artifactId>
        <executions>
          <execution>
            <id>enforce-java</id>
            <goals>
              <goal>enforce</goal>
            </goals>
            <configuration>
              <rules>
                <requireJavaVersion>
                  <message>This build requires at least Java ${java.version}, update your JVM, and run the build again</message>
                  <version>${java.version}</version>
                </requireJavaVersion>
              </rules>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>io.spring.javaformat</groupId>
        <artifactId>spring-javaformat-maven-plugin</artifactId>
        <version>${spring-format.version}</version>
        <executions>
          <execution>
            <goals>
              <goal>validate</goal>
            </goals>
            <phase>validate</phase>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.graalvm.buildtools</groupId>
        <artifactId>native-maven-plugin</artifactId>
      </plugin>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <executions>
          <execution>
            <!-- Spring Boot Actuator displays build-related information
              if a META-INF/build-info.properties file is present -->
            <goals>
              <goal>build-info</goal>
            </goals>
            <configuration>
              <additionalProperties>
                <encoding.source>${project.build.sourceEncoding}</encoding.source>
                <encoding.reporting>${project.reporting.outputEncoding}</encoding.reporting>
                <java.source>${java.version}</java.source>
                <java.target>${java.version}</java.target>
              </additionalProperties>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.jacoco</groupId>
        <artifactId>jacoco-maven-plugin</artifactId>
        <version>${jacoco.version}</version>
        <executions>
          <execution>
            <goals>
              <goal>prepare-agent</goal>
            </goals>
          </execution>
          <execution>
            <id>report</id>
            <goals>
              <goal>report</goal>
            </goals>
            <phase>prepare-package</phase>
          </execution>
        </executions>
      </plugin>

      <!-- Spring Boot Actuator displays build-related information if a git.properties file is
      present at the classpath -->
      <plugin>
        <groupId>io.github.git-commit-id</groupId>
        <artifactId>git-commit-id-maven-plugin</artifactId>
        <configuration>
          <failOnNoGitDirectory>false</failOnNoGitDirectory>
          <failOnUnableToExtractRepoInfo>false</failOnUnableToExtractRepoInfo>
        </configuration>
      </plugin>
      <!-- Spring Boot Actuator displays sbom-related information if a CycloneDX SBOM file is
      present at the classpath -->
      <plugin>
        <?m2e ignore?>
        <groupId>org.cyclonedx</groupId>
        <artifactId>cyclonedx-maven-plugin</artifactId>
      </plugin>
    </plugins>
  </build>
  <profiles>
    <profile>
      <id>css</id>
      <build>
        <plugins>
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-dependency-plugin</artifactId>
            <executions>
              <execution>
                <id>unpack</id>
                <goals>
                  <goal>unpack</goal>
                </goals>
                <?m2e execute onConfiguration,onIncremental?>
                <phase>generate-resources</phase>
                <configuration>
                  <artifactItems>
                    <artifactItem>
                      <groupId>org.webjars.npm</groupId>
                      <artifactId>bootstrap</artifactId>
                      <version>${webjars-bootstrap.version}</version>
                    </artifactItem>
                  </artifactItems>
                  <outputDirectory>${project.build.directory}/webjars</outputDirectory>
                </configuration>
              </execution>
            </executions>
          </plugin>
        <plugins>
    <profile>
        <id>native</id>
        <build>
            <plugins>
                <plugin>
                    <groupId>org.graalvm.buildtools</groupId>
                    <artifactId>native-maven-plugin</artifactId>
                </plugin>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>
                    <configuration>
                        <image>
                            <builder>paketobuildpacks/builder:tiny</builder>
                            <env>
                                <BP_NATIVE_IMAGE>true</BP_NATIVE_IMAGE>
                            </env>
                        </image>
                    </configuration>
                </plugin>
            </plugins>
        </build>
    </profile>
  </profiles>
</project>
```

```Dockerfile title='Containerfile to build native Spring Boot image based on Debian with GraalVM 25 on Red Hat 10' hl=11,30
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-25.0.1 AS builder

WORKDIR /build

COPY --chown=quarkus:quarkus ./src ./src
COPY --chown=quarkus:quarkus ./pom.xml ./pom.xml
COPY --chown=quarkus:quarkus ./.mvn ./.mvn
COPY --chown=quarkus:quarkus ./mvnw ./mvnw

RUN ./mvnw dependency:go-offline
RUN ./mvnw clean package -Pnative native:compile -DskipTests

FROM registry.access.redhat.com/ubi10/ubi-minimal:latest
USER root

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF_8

ENV TZ=UTC
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app
RUN chown -R 1001 /app

USER 1001

COPY --from=builder --chown=1001 /build/target/spring-petclinic /app/spring-petclinic

RUN chmod 775 /app/spring-petclinic

EXPOSE 5483
ENTRYPOINT ["/app/spring-petclinic"]
```
***
# References
1. https://spring.io/guides/gs/spring-boot-docker
2. https://github.com/spring-projects/spring-petclinic for reference repository.
3. [[site-reliability-engineering/build-tools/java/java-runtime/java-distribution/Eclipse Temurin]]
4. 
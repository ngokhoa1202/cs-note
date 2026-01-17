#maven #quarkus #java #dependency-manager #configuration #production #development #microservices
# Complete Quarkus Maven Configuration

```xml title='pom.xml - Complete Quarkus Configuration'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>quarkus-app</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>Quarkus Application</name>
    <description>Production-ready Quarkus microservice with Maven</description>

    <properties>
        <!-- Java Version -->
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <maven.compiler.release>17</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>

        <!-- Quarkus Version -->
        <quarkus.platform.version>3.6.0</quarkus.platform.version>
        <quarkus.platform.artifact-id>quarkus-bom</quarkus.platform.artifact-id>
        <quarkus.platform.group-id>io.quarkus.platform</quarkus.platform.group-id>

        <!-- Dependency Versions -->
        <lombok.version>1.18.30</lombok.version>
        <mapstruct.version>1.5.5.Final</mapstruct.version>
        <testcontainers.version>1.19.3</testcontainers.version>

        <!-- Plugin Versions -->
        <surefire-plugin.version>3.2.2</surefire-plugin.version>
        <compiler-plugin.version>3.11.0</compiler-plugin.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <!-- Quarkus BOM for dependency management -->
            <dependency>
                <groupId>${quarkus.platform.group-id}</groupId>
                <artifactId>${quarkus.platform.artifact-id}</artifactId>
                <version>${quarkus.platform.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <dependencies>
        <!-- ========== WEB & REST API ========== -->
        <!-- RESTEasy Reactive for REST endpoints -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-resteasy-reactive</artifactId>
        </dependency>

        <!-- RESTEasy Reactive Jackson for JSON -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-resteasy-reactive-jackson</artifactId>
        </dependency>

        <!-- Bean Validation -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-hibernate-validator</artifactId>
        </dependency>

        <!-- ========== DATA & PERSISTENCE ========== -->
        <!-- Hibernate ORM with Panache for simplified JPA -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-hibernate-orm-panache</artifactId>
        </dependency>

        <!-- Hibernate Reactive with Panache -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-hibernate-reactive-panache</artifactId>
        </dependency>

        <!-- PostgreSQL JDBC driver -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-jdbc-postgresql</artifactId>
        </dependency>

        <!-- PostgreSQL Reactive driver -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-reactive-pg-client</artifactId>
        </dependency>

        <!-- Flyway for database migrations -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-flyway</artifactId>
        </dependency>

        <!-- Redis for caching -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-redis-client</artifactId>
        </dependency>

        <!-- MongoDB client -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-mongodb-panache</artifactId>
        </dependency>

        <!-- ========== SECURITY ========== -->
        <!-- OIDC (OpenID Connect) authentication -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-oidc</artifactId>
        </dependency>

        <!-- JWT authentication -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-jwt</artifactId>
        </dependency>

        <!-- Security JPA for user storage -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-security-jpa</artifactId>
        </dependency>

        <!-- ========== MONITORING & OBSERVABILITY ========== -->
        <!-- SmallRye Health for health checks -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-health</artifactId>
        </dependency>

        <!-- Micrometer for metrics -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-micrometer-registry-prometheus</artifactId>
        </dependency>

        <!-- OpenTelemetry for distributed tracing -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-opentelemetry</artifactId>
        </dependency>

        <!-- ========== API DOCUMENTATION ========== -->
        <!-- OpenAPI and Swagger UI -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-openapi</artifactId>
        </dependency>

        <!-- ========== MESSAGING ========== -->
        <!-- Kafka for event streaming -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-reactive-messaging-kafka</artifactId>
        </dependency>

        <!-- AMQP (RabbitMQ) -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-reactive-messaging-amqp</artifactId>
        </dependency>

        <!-- ========== MICROSERVICES PATTERNS ========== -->
        <!-- REST Client Reactive -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-rest-client-reactive-jackson</artifactId>
        </dependency>

        <!-- Fault Tolerance (Circuit Breaker, Retry) -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-fault-tolerance</artifactId>
        </dependency>

        <!-- gRPC for microservice communication -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-grpc</artifactId>
        </dependency>

        <!-- ========== CACHING ========== -->
        <!-- Cache API -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-cache</artifactId>
        </dependency>

        <!-- ========== SCHEDULING ========== -->
        <!-- Quartz for scheduled jobs -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-quartz</artifactId>
        </dependency>

        <!-- ========== UTILITIES ========== -->
        <!-- Lombok for boilerplate reduction -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>

        <!-- MapStruct for DTO mapping -->
        <dependency>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct</artifactId>
            <version>${mapstruct.version}</version>
        </dependency>

        <!-- ========== CONFIGURATION ========== -->
        <!-- Config YAML support -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-config-yaml</artifactId>
        </dependency>

        <!-- ========== DEVELOPMENT TOOLS ========== -->
        <!-- Dev UI for development -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-devservices-keycloak</artifactId>
        </dependency>

        <!-- ========== TESTING ========== -->
        <!-- Quarkus JUnit 5 -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-junit5</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Quarkus Mock support -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-junit5-mockito</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- REST Assured for API testing -->
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Testcontainers -->
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>postgresql</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>

        <!-- WireMock for HTTP mocking -->
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-test-wiremock</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>${project.artifactId}</finalName>
        <plugins>
            <!-- Quarkus Maven Plugin -->
            <plugin>
                <groupId>${quarkus.platform.group-id}</groupId>
                <artifactId>quarkus-maven-plugin</artifactId>
                <version>${quarkus.platform.version}</version>
                <extensions>true</extensions>
                <executions>
                    <execution>
                        <goals>
                            <goal>build</goal>
                            <goal>generate-code</goal>
                            <goal>generate-code-tests</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <!-- Maven Compiler Plugin with annotation processing -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${compiler-plugin.version}</version>
                <configuration>
                    <compilerArgs>
                        <arg>-parameters</arg>
                    </compilerArgs>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>${lombok.version}</version>
                        </path>
                        <path>
                            <groupId>org.mapstruct</groupId>
                            <artifactId>mapstruct-processor</artifactId>
                            <version>${mapstruct.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>

            <!-- Maven Surefire Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>${surefire-plugin.version}</version>
                <configuration>
                    <systemPropertyVariables>
                        <java.util.logging.manager>org.jboss.logmanager.LogManager</java.util.logging.manager>
                        <maven.home>${maven.home}</maven.home>
                    </systemPropertyVariables>
                </configuration>
            </plugin>

            <!-- Maven Failsafe Plugin for integration tests -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>${surefire-plugin.version}</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>integration-test</goal>
                            <goal>verify</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <systemPropertyVariables>
                        <native.image.path>${project.build.directory}/${project.build.finalName}-runner</native.image.path>
                        <java.util.logging.manager>org.jboss.logmanager.LogManager</java.util.logging.manager>
                        <maven.home>${maven.home}</maven.home>
                    </systemPropertyVariables>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <profiles>
        <!-- ========== DEVELOPMENT PROFILE ========== -->
        <profile>
            <id>dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <quarkus.profile>dev</quarkus.profile>
            </properties>
        </profile>

        <!-- ========== PRODUCTION PROFILE ========== -->
        <profile>
            <id>prod</id>
            <properties>
                <quarkus.profile>prod</quarkus.profile>
                <quarkus.package.type>uber-jar</quarkus.package.type>
            </properties>
        </profile>

        <!-- ========== NATIVE COMPILATION PROFILE ========== -->
        <profile>
            <id>native</id>
            <activation>
                <property>
                    <name>native</name>
                </property>
            </activation>
            <properties>
                <skipITs>false</skipITs>
                <quarkus.package.type>native</quarkus.package.type>
            </properties>
        </profile>
    </profiles>
</project>
```
# Environment-Specific Application Configuration
## Development Configuration
```yaml title='src/main/resources/application-dev.yml'
quarkus:
  # Application configuration
  application:
    name: quarkus-app-dev

  # HTTP configuration
  http:
    port: 8080
    cors: true
    access-log:
      enabled: true

  # Development datasource (DevServices auto-starts PostgreSQL)
  datasource:
    db-kind: postgresql
    username: quarkus
    password: quarkus
    jdbc:
      url: jdbc:postgresql://localhost:5432/quarkus_dev

  # Hibernate ORM configuration
  hibernate-orm:
    database:
      generation: drop-and-create
    log:
      sql: true
      format-sql: true
      bind-parameters: true

  # Flyway disabled in dev (using Hibernate DDL)
  flyway:
    migrate-at-start: false

  # Redis configuration
  redis:
    hosts: redis://localhost:6379

  # Kafka configuration
  kafka:
    bootstrap:
      servers: localhost:9092
    devservices:
      enabled: true

  # Live reload
  live-reload:
    enabled: true

  # Dev UI
  dev-ui:
    enabled: true

  # OpenAPI
  smallrye-openapi:
    path: /openapi
    enable: true

  # Swagger UI
  swagger-ui:
    always-include: true
    path: /swagger-ui

  # Health checks
  smallrye-health:
    ui:
      always-include: true

  # Logging
  log:
    level: INFO
    category:
      "com.example":
        level: DEBUG
      "org.hibernate":
        level: DEBUG
      "io.quarkus.hibernate.orm.runtime.boot":
        level: INFO
    console:
      enable: true
      format: "%d{HH:mm:ss} %-5p [%c{2.}] (%t) %s%e%n"

  # Dev Services (auto-start containers)
  devservices:
    enabled: true
```
## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
quarkus:
  # Application configuration
  application:
    name: quarkus-app-prod

  # HTTP configuration
  http:
    port: 8080
    cors:
      ~: true
      origins: ${ALLOWED_ORIGINS}
    ssl:
      certificate:
        key-file: ${SSL_KEY_FILE}
        cert-file: ${SSL_CERT_FILE}

  # Production datasource
  datasource:
    db-kind: postgresql
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    jdbc:
      url: jdbc:postgresql://${DB_HOST}:${DB_PORT:5432}/${DB_NAME}
      max-size: 20
      min-size: 5
      acquisition-timeout: 30
      background-validation-interval: 2M

  # Hibernate ORM configuration
  hibernate-orm:
    database:
      generation: none
    log:
      sql: false

  # Flyway migrations
  flyway:
    migrate-at-start: true
    baseline-on-migrate: true
    baseline-version: 1.0.0

  # Redis configuration
  redis:
    hosts: ${REDIS_URL}
    password: ${REDIS_PASSWORD}
    ssl: true
    max-pool-size: 20

  # Kafka configuration
  kafka:
    bootstrap:
      servers: ${KAFKA_BOOTSTRAP_SERVERS}
    security:
      protocol: SASL_SSL
    sasl:
      mechanism: PLAIN
      jaas-config: |
        org.apache.kafka.common.security.plain.PlainLoginModule required \
        username="${KAFKA_USERNAME}" \
        password="${KAFKA_PASSWORD}";

  # OpenAPI disabled in production
  smallrye-openapi:
    enable: false

  # Swagger UI disabled in production
  swagger-ui:
    always-include: false

  # Health checks
  smallrye-health:
    ui:
      always-include: false

  # Metrics
  micrometer:
    export:
      prometheus:
        enabled: true
        path: /metrics

  # Logging
  log:
    level: WARN
    category:
      "com.example":
        level: INFO
    console:
      enable: true
      json: true
      format: json

  # Security
  security:
    users:
      embedded:
        enabled: false

  # Thread pool
  thread-pool:
    core-threads: 10
    max-threads: 100
```

# Commands for Different Environments
## Development Environment
```shell title='Development build and run'
# Run in dev mode with live reload
mvn quarkus:dev

# Run with specific profile
mvn quarkus:dev -Dquarkus.profile=dev

# Run with debugging enabled
mvn quarkus:dev -Ddebug=5005

# Run tests
mvn test

# Package application
mvn clean package

# Access Dev UI
# http://localhost:8080/q/dev
```
## Production Environment
```shell title='Production build'
# Build production JAR
mvn clean package -Pprod

# Build uber-jar (all dependencies included)
mvn clean package -Pprod -Dquarkus.package.type=uber-jar

# Skip tests for faster build
mvn clean package -Pprod -DskipTests

# Run uber-jar
java -jar target/quarkus-app-runner.jar
```
## Native Compilation
```shell title='Native image compilation'
# Build native executable
mvn package -Pnative

# Build native executable with container
mvn package -Pnative -Dquarkus.native.container-build=true

# Build native executable with specific builder image
mvn package -Pnative \
    -Dquarkus.native.container-build=true \
    -Dquarkus.native.builder-image=quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-17

# Run native executable
./target/quarkus-app-runner

# Test native executable
mvn verify -Pnative
```
## Container Image
```shell title='Container image build'
# Build JVM container image
mvn clean package -Dquarkus.container-image.build=true

# Build native container image
mvn clean package -Pnative \
    -Dquarkus.native.container-build=true \
    -Dquarkus.container-image.build=true

# Push to registry
mvn clean package \
    -Dquarkus.container-image.build=true \
    -Dquarkus.container-image.push=true \
    -Dquarkus.container-image.registry=docker.io \
    -Dquarkus.container-image.group=myorganization \
    -Dquarkus.container-image.name=quarkus-app \
    -Dquarkus.container-image.tag=1.0.0
```
# Project Structure
```
quarkus-app/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── resource/          # JAX-RS resources (REST endpoints)
│   │   │       ├── service/           # Business logic
│   │   │       ├── repository/        # Panache repositories
│   │   │       ├── entity/            # JPA entities
│   │   │       ├── dto/               # Data transfer objects
│   │   │       ├── mapper/            # MapStruct mappers
│   │   │       ├── config/            # Configuration classes
│   │   │       └── security/          # Security configuration
│   │   ├── resources/
│   │   │   ├── application.yml
│   │   │   ├── application-dev.yml
│   │   │   ├── application-prod.yml
│   │   │   └── db/migration/          # Flyway migrations
│   │   │       ├── V1.0.0__init.sql
│   │   │       └── V1.0.1__users.sql
│   │   └── proto/                      # gRPC protocol buffers
│   └── test/
│       ├── java/
│       │   └── com/example/
│       │       ├── resource/           # REST endpoint tests
│       │       └── integration/        # Integration tests
│       └── resources/
│           └── application-test.yml
└── target/                              # Build output
    ├── quarkus-app/
    │   └── quarkus-run.jar
    └── quarkus-app-runner                # Native executable
```

---
# References
1. https://quarkus.io/guides/ - Official Quarkus Guides
2. https://quarkus.io/guides/maven-tooling - Quarkus Maven Tooling
3. https://quarkus.io/guides/building-native-image - Native Executable Guide
4. https://quarkus.io/guides/dev-mode-differences - Development Mode
5. https://quarkus.io/guides/config-reference - Configuration Reference

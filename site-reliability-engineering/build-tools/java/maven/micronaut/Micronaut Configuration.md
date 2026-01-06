#maven #micronaut #java #dependency-manager #configuration #production #development #microservices
# Complete Micronaut Maven Configuration
```xml title='pom.xml - Complete Micronaut Configuration'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>io.micronaut.platform</groupId>
        <artifactId>micronaut-parent</artifactId>
        <version>4.2.0</version>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>micronaut-app</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>Micronaut Application</name>
    <description>Production-ready Micronaut microservice with Maven</description>

    <properties>
        <!-- Java Version -->
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <maven.compiler.release>17</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>

        <!-- Micronaut Version -->
        <micronaut.version>4.2.0</micronaut.version>
        <micronaut.runtime>netty</micronaut.runtime>
        <micronaut.test.resources.enabled>true</micronaut.test.resources.enabled>

        <!-- Dependency Versions -->
        <lombok.version>1.18.30</lombok.version>
        <mapstruct.version>1.5.5.Final</mapstruct.version>
        <testcontainers.version>1.19.3</testcontainers.version>

        <!-- Plugin Versions -->
        <exec.mainClass>com.example.Application</exec.mainClass>
        <packaging>jar</packaging>
    </properties>

    <repositories>
        <repository>
            <id>central</id>
            <url>https://repo.maven.apache.org/maven2</url>
        </repository>
    </repositories>

    <dependencies>
        <!-- ========== CORE MICRONAUT ========== -->
        <!-- Micronaut HTTP Server (Netty) -->
        <dependency>
            <groupId>io.micronaut</groupId>
            <artifactId>micronaut-http-server-netty</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Micronaut HTTP Client -->
        <dependency>
            <groupId>io.micronaut</groupId>
            <artifactId>micronaut-http-client</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Micronaut Jackson for JSON -->
        <dependency>
            <groupId>io.micronaut</groupId>
            <artifactId>micronaut-jackson-databind</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Validation -->
        <dependency>
            <groupId>io.micronaut.validation</groupId>
            <artifactId>micronaut-validation</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== DATA & PERSISTENCE ========== -->
        <!-- Micronaut Data JDBC -->
        <dependency>
            <groupId>io.micronaut.data</groupId>
            <artifactId>micronaut-data-jdbc</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Micronaut Data Hibernate JPA -->
        <dependency>
            <groupId>io.micronaut.data</groupId>
            <artifactId>micronaut-data-hibernate-jpa</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Micronaut Data R2DBC (Reactive) -->
        <dependency>
            <groupId>io.micronaut.data</groupId>
            <artifactId>micronaut-data-r2dbc</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- PostgreSQL driver -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- PostgreSQL R2DBC driver -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>r2dbc-postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- Flyway for database migrations -->
        <dependency>
            <groupId>io.micronaut.flyway</groupId>
            <artifactId>micronaut-flyway</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- HikariCP connection pool -->
        <dependency>
            <groupId>io.micronaut.sql</groupId>
            <artifactId>micronaut-jdbc-hikari</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Redis -->
        <dependency>
            <groupId>io.micronaut.redis</groupId>
            <artifactId>micronaut-redis-lettuce</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- MongoDB -->
        <dependency>
            <groupId>io.micronaut.mongodb</groupId>
            <artifactId>micronaut-mongo-reactive</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== SECURITY ========== -->
        <!-- Micronaut Security -->
        <dependency>
            <groupId>io.micronaut.security</groupId>
            <artifactId>micronaut-security</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- JWT authentication -->
        <dependency>
            <groupId>io.micronaut.security</groupId>
            <artifactId>micronaut-security-jwt</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- OAuth 2.0 -->
        <dependency>
            <groupId>io.micronaut.security</groupId>
            <artifactId>micronaut-security-oauth2</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== MONITORING & OBSERVABILITY ========== -->
        <!-- Micronaut Management for health checks -->
        <dependency>
            <groupId>io.micronaut</groupId>
            <artifactId>micronaut-management</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Micrometer for metrics -->
        <dependency>
            <groupId>io.micronaut.micrometer</groupId>
            <artifactId>micronaut-micrometer-core</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Prometheus registry -->
        <dependency>
            <groupId>io.micronaut.micrometer</groupId>
            <artifactId>micronaut-micrometer-registry-prometheus</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Distributed tracing -->
        <dependency>
            <groupId>io.micronaut.tracing</groupId>
            <artifactId>micronaut-tracing-opentelemetry</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== API DOCUMENTATION ========== -->
        <!-- OpenAPI -->
        <dependency>
            <groupId>io.micronaut.openapi</groupId>
            <artifactId>micronaut-openapi</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Swagger UI -->
        <dependency>
            <groupId>io.swagger.core.v3</groupId>
            <artifactId>swagger-annotations</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== MESSAGING ========== -->
        <!-- Kafka -->
        <dependency>
            <groupId>io.micronaut.kafka</groupId>
            <artifactId>micronaut-kafka</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- RabbitMQ -->
        <dependency>
            <groupId>io.micronaut.rabbitmq</groupId>
            <artifactId>micronaut-rabbitmq</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== MICROSERVICES PATTERNS ========== -->
        <!-- Service Discovery (Consul) -->
        <dependency>
            <groupId>io.micronaut.discovery</groupId>
            <artifactId>micronaut-discovery-client</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- Circuit Breaker (Resilience4j) -->
        <dependency>
            <groupId>io.micronaut</groupId>
            <artifactId>micronaut-retry</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- gRPC Server -->
        <dependency>
            <groupId>io.micronaut.grpc</groupId>
            <artifactId>micronaut-grpc-server-runtime</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- gRPC Client -->
        <dependency>
            <groupId>io.micronaut.grpc</groupId>
            <artifactId>micronaut-grpc-client-runtime</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== CACHING ========== -->
        <!-- Micronaut Cache -->
        <dependency>
            <groupId>io.micronaut.cache</groupId>
            <artifactId>micronaut-cache-caffeine</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== REACTIVE PROGRAMMING ========== -->
        <!-- Reactor -->
        <dependency>
            <groupId>io.micronaut.reactor</groupId>
            <artifactId>micronaut-reactor</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- RxJava 3 -->
        <dependency>
            <groupId>io.micronaut.rxjava3</groupId>
            <artifactId>micronaut-rxjava3</artifactId>
            <scope>compile</scope>
        </dependency>

        <!-- ========== UTILITIES ========== -->
        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>

        <!-- MapStruct -->
        <dependency>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct</artifactId>
            <version>${mapstruct.version}</version>
        </dependency>

        <!-- ========== LOGGING ========== -->
        <!-- Logback -->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- ========== DEVELOPMENT TOOLS ========== -->
        <!-- H2 for development -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- ========== TESTING ========== -->
        <!-- Micronaut Test JUnit 5 -->
        <dependency>
            <groupId>io.micronaut.test</groupId>
            <artifactId>micronaut-test-junit5</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- JUnit 5 -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Mockito -->
        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-core</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- AssertJ -->
        <dependency>
            <groupId>org.assertj</groupId>
            <artifactId>assertj-core</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- REST Assured -->
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

        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>kafka</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>${project.artifactId}</finalName>
        <plugins>
            <!-- Maven Compiler Plugin with annotation processing -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <fork>true</fork>
                    <compilerArgs>
                        <arg>-parameters</arg>
                        <arg>-J-Dmicronaut.openapi.views.spec=rapidoc.enabled=true,swagger-ui.enabled=true</arg>
                    </compilerArgs>
                    <annotationProcessorPaths combine.self="override">
                        <!-- Micronaut annotation processors -->
                        <path>
                            <groupId>io.micronaut</groupId>
                            <artifactId>micronaut-inject-java</artifactId>
                            <version>${micronaut.version}</version>
                        </path>
                        <path>
                            <groupId>io.micronaut.data</groupId>
                            <artifactId>micronaut-data-processor</artifactId>
                            <version>${micronaut.data.version}</version>
                        </path>
                        <path>
                            <groupId>io.micronaut</groupId>
                            <artifactId>micronaut-graal</artifactId>
                            <version>${micronaut.version}</version>
                        </path>
                        <path>
                            <groupId>io.micronaut</groupId>
                            <artifactId>micronaut-http-validation</artifactId>
                            <version>${micronaut.version}</version>
                        </path>
                        <path>
                            <groupId>io.micronaut.openapi</groupId>
                            <artifactId>micronaut-openapi</artifactId>
                            <version>${micronaut.openapi.version}</version>
                            <exclusions>
                                <exclusion>
                                    <groupId>io.micronaut</groupId>
                                    <artifactId>micronaut-inject</artifactId>
                                </exclusion>
                            </exclusions>
                        </path>
                        <path>
                            <groupId>io.micronaut.security</groupId>
                            <artifactId>micronaut-security-annotations</artifactId>
                            <version>${micronaut.security.version}</version>
                        </path>
                        <!-- Lombok -->
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>${lombok.version}</version>
                        </path>
                        <!-- MapStruct -->
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
            </plugin>

            <!-- Maven Shade Plugin for uber-jar -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.5.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>${exec.mainClass}</mainClass>
                                </transformer>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ServicesResourceTransformer"/>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <!-- Exec Maven Plugin for running -->
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>3.1.0</version>
                <configuration>
                    <executable>java</executable>
                    <arguments>
                        <argument>-classpath</argument>
                        <classpath/>
                        <argument>-noverify</argument>
                        <argument>-XX:TieredStopAtLevel=1</argument>
                        <argument>${exec.mainClass}</argument>
                    </arguments>
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
                <micronaut.environments>dev</micronaut.environments>
            </properties>
        </profile>

        <!-- ========== PRODUCTION PROFILE ========== -->
        <profile>
            <id>prod</id>
            <properties>
                <micronaut.environments>prod</micronaut.environments>
                <packaging>jar</packaging>
            </properties>
        </profile>

        <!-- ========== NATIVE IMAGE PROFILE ========== -->
        <profile>
            <id>native</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.graalvm.buildtools</groupId>
                        <artifactId>native-maven-plugin</artifactId>
                        <version>0.9.28</version>
                        <extensions>true</extensions>
                        <executions>
                            <execution>
                                <id>build-native</id>
                                <goals>
                                    <goal>compile-no-fork</goal>
                                </goals>
                                <phase>package</phase>
                            </execution>
                        </executions>
                        <configuration>
                            <imageName>${project.artifactId}</imageName>
                            <mainClass>${exec.mainClass}</mainClass>
                            <buildArgs>
                                <buildArg>--no-fallback</buildArg>
                                <buildArg>--initialize-at-build-time=ch.qos.logback</buildArg>
                            </buildArgs>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>
</project>
```

# Environment-Specific Application Configuration

## Development Configuration
```yaml title='src/main/resources/application-dev.yml'
micronaut:
  application:
    name: micronaut-app-dev

  server:
    port: 8080
    cors:
      enabled: true

  # Development datasource (H2)
  datasources:
    default:
      url: jdbc:h2:mem:devDb
      driverClassName: org.h2.Driver
      username: sa
      password: ''
      schema-generate: CREATE_DROP
      dialect: H2

  # JPA settings
  jpa:
    default:
      properties:
        hibernate:
          hbm2ddl:
            auto: create-drop
          show_sql: true
          format_sql: true

  # Redis
  redis:
    uri: redis://localhost:6379

  # Kafka
  kafka:
    bootstrap:
      servers: localhost:9092

  # HTTP client
  http:
    client:
      read-timeout: 30s

  # Router
  router:
    static-resources:
      swagger:
        paths: classpath:META-INF/swagger
        mapping: /swagger/**
      swagger-ui:
        paths: classpath:META-INF/swagger/views/swagger-ui
        mapping: /swagger-ui/**

# Endpoints
endpoints:
  all:
    enabled: true
    sensitive: false
  health:
    enabled: true
    sensitive: false

# Logging
logger:
  levels:
    root: INFO
    com.example: DEBUG
    io.micronaut: INFO
    io.micronaut.http: DEBUG

# OpenAPI
openapi:
  enabled: true
  swagger-ui:
    enabled: true
    path: /swagger-ui
```

## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
micronaut:
  application:
    name: micronaut-app-prod

  server:
    port: 8080
    cors:
      enabled: false
    ssl:
      enabled: ${SSL_ENABLED:false}
      keyStore:
        path: ${SSL_KEYSTORE_PATH}
        password: ${SSL_KEYSTORE_PASSWORD}
        type: PKCS12

  # Production datasource (PostgreSQL)
  datasources:
    default:
      url: jdbc:postgresql://${DB_HOST}:${DB_PORT:5432}/${DB_NAME}
      driverClassName: org.postgresql.Driver
      username: ${DB_USERNAME}
      password: ${DB_PASSWORD}
      maximum-pool-size: 20
      minimum-idle: 5

  # JPA settings
  jpa:
    default:
      properties:
        hibernate:
          hbm2ddl:
            auto: validate
          show_sql: false

  # Flyway
  flyway:
    datasources:
      default:
        enabled: true

  # Redis
  redis:
    uri: ${REDIS_URL}
    password: ${REDIS_PASSWORD}
    ssl: true

  # Kafka
  kafka:
    bootstrap:
      servers: ${KAFKA_BOOTSTRAP_SERVERS}
    security:
      protocol: SASL_SSL
    sasl:
      mechanism: PLAIN
      jaas:
        config: |
          org.apache.kafka.common.security.plain.PlainLoginModule required \
          username="${KAFKA_USERNAME}" \
          password="${KAFKA_PASSWORD}";

  # HTTP client
  http:
    client:
      read-timeout: 30s
      pool:
        enabled: true
        max-connections: 50

  # Metrics
  metrics:
    enabled: true
    export:
      prometheus:
        enabled: true
        step: PT1M

# Endpoints (restricted in production)
endpoints:
  all:
    enabled: false
  health:
    enabled: true
    sensitive: false
  info:
    enabled: true
    sensitive: false
  metrics:
    enabled: true
    sensitive: true
  prometheus:
    enabled: true
    sensitive: false

# Logging
logger:
  levels:
    root: WARN
    com.example: INFO

# OpenAPI (disabled in production)
openapi:
  enabled: false
  swagger-ui:
    enabled: false
```

# Maven Commands for Different Environments

## Development Environment
```shell title='Development build and run'
# Compile and run
mvn clean compile exec:exec

# Package and run
mvn clean package
java -jar target/micronaut-app.jar

# Run with continuous compilation
mvn mn:run
```

## Production Environment
```shell title='Production build'
# Build production JAR
mvn clean package -Pprod

# Build uber-jar
mvn clean package shade:shade

# Run production JAR
java -jar target/micronaut-app.jar

# Skip tests
mvn clean package -Pprod -DskipTests
```

## Native Compilation
```shell title='Native image with GraalVM'
# Build native executable
mvn package -Pnative

# Run native executable
./target/micronaut-app

# Build with container
docker build -f Dockerfile.native -t micronaut-app:native .
```

## Testing
```shell title='Testing commands'
# Run tests
mvn test

# Run integration tests
mvn verify

# Run specific test
mvn test -Dtest=UserControllerTest
```

# Dependency Management Strategy

## Compile Scope
- **Micronaut core** - HTTP server, DI, validation
- **Data access** - Micronaut Data, Hibernate
- **Messaging** - Kafka, RabbitMQ

## Provided Scope
- **Lombok** - Compile-time code generation

## Runtime Scope
- **Database drivers** - PostgreSQL, H2
- **Logging** - Logback

## Test Scope
- **Micronaut Test** - Testing framework
- **Testcontainers** - Integration testing

# Key Features

## Compile-Time Dependency Injection
- No reflection at runtime.
- Faster startup time.
- Lower memory footprint.

## Ahead-of-Time (AOT) Compilation
- Code generation at compile-time.
- Optimized bytecode.
- GraalVM native image support.

## Reactive Programming
- Non-blocking HTTP client and server.
- Reactive data access (R2DBC).
- Reactive messaging.

## Test Resources
- Automatic test container management.
- Zero configuration for development databases.

# Project Structure
```
micronaut-app/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── Application.java
│   │   │       ├── controller/      # HTTP controllers
│   │   │       ├── service/         # Business logic
│   │   │       ├── repository/      # Data repositories
│   │   │       ├── entity/          # JPA entities
│   │   │       ├── dto/             # Data transfer objects
│   │   │       ├── mapper/          # MapStruct mappers
│   │   │       ├── config/          # Configuration
│   │   │       └── security/        # Security configuration
│   │   └── resources/
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       ├── logback.xml
│   │       └── db/migration/        # Flyway migrations
│   │           ├── V1__init.sql
│   │           └── V2__users.sql
│   └── test/
│       ├── java/
│       │   └── com/example/
│       │       ├── controller/      # Controller tests
│       │       └── integration/     # Integration tests
│       └── resources/
│           └── application-test.yml
└── target/                           # Build output
    ├── micronaut-app.jar
    └── micronaut-app                 # Native executable
```

---
# References
1. https://micronaut.io/documentation.html - Official Micronaut Documentation
2. https://guides.micronaut.io/ - Micronaut Guides
3. https://micronaut-projects.github.io/micronaut-maven-plugin/latest/ - Micronaut Maven Plugin
4. https://docs.micronaut.io/latest/guide/#graal - GraalVM Native Image Guide
5. https://micronaut-projects.github.io/micronaut-test/latest/guide/ - Micronaut Test Documentation

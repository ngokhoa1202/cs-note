#maven #spring-boot #java #dependency-manager #configuration #production #development
# Purpose
- Demonstrate comprehensive Maven configuration for Spring Boot applications.
- Include environment-specific dependencies and configurations for development and production.
- Showcase proper use of Maven lifecycle phases and profiles.
# Complete Spring Boot Maven Configuration

```xml title='pom.xml - Complete Spring Boot Configuration'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>springboot-app</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>Spring Boot Application</name>
    <description>Production-ready Spring Boot application with Maven</description>

    <properties>
        <!-- Java Version -->
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>

        <!-- Dependency Versions -->
        <lombok.version>1.18.30</lombok.version>
        <mapstruct.version>1.5.5.Final</mapstruct.version>
        <jjwt.version>0.12.3</jjwt.version>
        <springdoc.version>2.2.0</springdoc.version>
        <testcontainers.version>1.19.3</testcontainers.version>
        <mockito.version>5.7.0</mockito.version>
    </properties>

    <dependencies>
        <!-- ========== WEB & REST API ========== -->
        <!-- Spring MVC, embedded Tomcat, JSON serialization -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <!-- Validation API (JSR-303, Hibernate Validator) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>

        <!-- ========== DATA & PERSISTENCE ========== -->
        <!-- Spring Data JPA with Hibernate -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>

        <!-- Redis for caching and session storage -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

        <!-- Flyway database migrations -->
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>

        <!-- PostgreSQL driver for production -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- ========== SECURITY ========== -->
        <!-- Spring Security -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>

        <!-- JWT token generation and validation -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
            <version>${jjwt.version}</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
            <version>${jjwt.version}</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
            <version>${jjwt.version}</version>
            <scope>runtime</scope>
        </dependency>

        <!-- ========== MONITORING & OBSERVABILITY ========== -->
        <!-- Production-ready endpoints (health, metrics, info) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>

        <!-- Micrometer for metrics -->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-registry-prometheus</artifactId>
        </dependency>

        <!-- Distributed tracing with Zipkin -->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing-bridge-brave</artifactId>
        </dependency>
        <dependency>
            <groupId>io.zipkin.reporter2</groupId>
            <artifactId>zipkin-reporter-brave</artifactId>
        </dependency>

        <!-- ========== API DOCUMENTATION ========== -->
        <!-- OpenAPI 3.0 documentation (Swagger UI) -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>${springdoc.version}</version>
        </dependency>

        <!-- ========== MESSAGING ========== -->
        <!-- Apache Kafka for event streaming -->
        <dependency>
            <groupId>org.springframework.kafka</groupId>
            <artifactId>spring-kafka</artifactId>
        </dependency>

        <!-- RabbitMQ for message queuing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-amqp</artifactId>
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

        <!-- Apache Commons Lang3 utilities -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>

        <!-- Google Guava utilities -->
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
            <version>32.1.3-jre</version>
        </dependency>

        <!-- ========== DEVELOPMENT TOOLS ========== -->
        <!-- Hot reload, LiveReload, property defaults -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>

        <!-- Configuration metadata for IDE autocomplete -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>

        <!-- ========== TESTING ========== -->
        <!-- Spring Boot Test (JUnit 5, Mockito, AssertJ, Hamcrest) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Spring Security Test -->
        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-test</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Testcontainers for integration testing -->
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
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

        <!-- REST Assured for API testing -->
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- ========== PROFILE-SPECIFIC DEPENDENCIES ========== -->
        <!-- H2 in-memory database for development -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>${project.artifactId}</finalName>
        <plugins>
            <!-- Spring Boot Maven Plugin -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>

            <!-- Maven Compiler Plugin with annotation processing -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
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
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok-mapstruct-binding</artifactId>
                            <version>0.2.0</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>

            <!-- Maven Surefire Plugin for unit tests -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.2.2</version>
            </plugin>

            <!-- Maven Failsafe Plugin for integration tests -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>3.2.2</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>integration-test</goal>
                            <goal>verify</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <!-- JaCoCo for code coverage -->
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.11</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <!-- Flyway Maven Plugin for database migrations -->
            <plugin>
                <groupId>org.flywaydb</groupId>
                <artifactId>flyway-maven-plugin</artifactId>
                <version>10.3.0</version>
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
                <spring.profiles.active>dev</spring.profiles.active>
            </properties>
        </profile>

        <!-- ========== PRODUCTION PROFILE ========== -->
        <profile>
            <id>prod</id>
            <properties>
                <spring.profiles.active>prod</spring.profiles.active>
            </properties>
            <build>
                <plugins>
                    <!-- Skip DevTools in production -->
                    <plugin>
                        <groupId>org.springframework.boot</groupId>
                        <artifactId>spring-boot-maven-plugin</artifactId>
                        <configuration>
                            <excludeDevtools>true</excludeDevtools>
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
spring:
  # Development datasource (H2 in-memory)
  datasource:
    url: jdbc:h2:mem:testdb
    driver-class-name: org.h2.Driver
    username: sa
    password:

  # H2 Console for development
  h2:
    console:
      enabled: true
      path: /h2-console

  # JPA settings for development
  jpa:
    hibernate:
      ddl-auto: create-drop
    show-sql: true
    properties:
      hibernate:
        format_sql: true

  # Redis for development
  data:
    redis:
      host: localhost
      port: 6379

  # Kafka for development
  kafka:
    bootstrap-servers: localhost:9092
    consumer:
      group-id: dev-group
      auto-offset-reset: earliest

  # RabbitMQ for development
  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest

  # DevTools settings
  devtools:
    livereload:
      enabled: true
    restart:
      enabled: true

# Actuator endpoints for development
management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      show-details: always

# Logging for development
logging:
  level:
    root: INFO
    com.example: DEBUG
    org.springframework.web: DEBUG
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE

# API Documentation
springdoc:
  api-docs:
    enabled: true
  swagger-ui:
    enabled: true
    path: /swagger-ui.html
```

## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
spring:
  # Production datasource (PostgreSQL)
  datasource:
    url: jdbc:postgresql://${DB_HOST:localhost}:${DB_PORT:5432}/${DB_NAME:proddb}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000

  # JPA settings for production
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        jdbc:
          batch_size: 20
        order_inserts: true
        order_updates: true

  # Redis for production
  data:
    redis:
      host: ${REDIS_HOST:localhost}
      port: ${REDIS_PORT:6379}
      password: ${REDIS_PASSWORD}
      ssl:
        enabled: true

  # Kafka for production
  kafka:
    bootstrap-servers: ${KAFKA_BOOTSTRAP_SERVERS}
    consumer:
      group-id: prod-group
      auto-offset-reset: earliest
      enable-auto-commit: false
    producer:
      acks: all
      retries: 3

  # RabbitMQ for production
  rabbitmq:
    host: ${RABBITMQ_HOST}
    port: ${RABBITMQ_PORT:5672}
    username: ${RABBITMQ_USERNAME}
    password: ${RABBITMQ_PASSWORD}
    ssl:
      enabled: true

# Actuator endpoints for production (restricted)
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: when-authorized
  metrics:
    export:
      prometheus:
        enabled: true

# Logging for production
logging:
  level:
    root: WARN
    com.example: INFO
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
  file:
    name: /var/log/springboot-app/application.log
    max-size: 10MB
    max-history: 30

# API Documentation (disabled in production)
springdoc:
  api-docs:
    enabled: false
  swagger-ui:
    enabled: false

# Security settings
server:
  ssl:
    enabled: ${SSL_ENABLED:false}
    key-store: ${SSL_KEYSTORE_PATH}
    key-store-password: ${SSL_KEYSTORE_PASSWORD}
  error:
    include-message: never
    include-stacktrace: never
```

# Maven Commands for Different Environments

## Development Environment
```shell title='Development build and run'
# Clean and package with dev profile (default)
mvn clean package

# Run with dev profile
mvn spring-boot:run

# Run with H2 console enabled
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.h2.console.enabled=true"

# Run tests
mvn test

# Run with hot reload (DevTools)
mvn spring-boot:run -Dspring-boot.run.fork=false
```

## Production Environment
```shell title='Production build and deployment'
# Clean and package with prod profile
mvn clean package -Pprod

# Skip tests for faster build (not recommended)
mvn clean package -Pprod -DskipTests

# Run integration tests
mvn verify -Pprod

# Build Docker image with prod profile
mvn spring-boot:build-image -Pprod

# Install to local repository
mvn clean install -Pprod
```

## Database Migrations
```shell title='Flyway migrations'
# Run migrations
mvn flyway:migrate

# Clean database (development only)
mvn flyway:clean

# Get migration info
mvn flyway:info

# Validate migrations
mvn flyway:validate
```

## Code Quality
```shell title='Code coverage and quality'
# Generate code coverage report
mvn clean test jacoco:report

# View coverage report
open target/site/jacoco/index.html
```

# Dependency Management Strategy

## Compile Scope
- **Spring Boot Starters** - Web, JPA, Security, Actuator
- **Business logic libraries** - MapStruct, Commons Lang3, Guava

## Provided Scope
- **Lombok** - Code generation at compile-time only

## Runtime Scope
- **Database drivers** - PostgreSQL, H2
- **JWT implementation** - JJWT runtime dependencies
- **DevTools** - Development hot reload (optional)

## Test Scope
- **Testing frameworks** - Spring Boot Test, JUnit 5, Mockito
- **Integration testing** - Testcontainers, REST Assured
- **Security testing** - Spring Security Test

# Project Structure
```
springboot-app/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── SpringBootApplication.java
│   │   │       ├── config/              # Configuration classes
│   │   │       ├── controller/          # REST controllers
│   │   │       ├── service/             # Business logic
│   │   │       ├── repository/          # Data access
│   │   │       ├── entity/              # JPA entities
│   │   │       ├── dto/                 # Data transfer objects
│   │   │       ├── mapper/              # MapStruct mappers
│   │   │       └── security/            # Security configuration
│   │   └── resources/
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       └── db/migration/            # Flyway migrations
│   │           ├── V1__init_schema.sql
│   │           └── V2__add_users.sql
│   └── test/
│       ├── java/
│       │   └── com/example/
│       │       ├── integration/         # Integration tests
│       │       └── unit/                # Unit tests
│       └── resources/
│           └── application-test.yml
└── target/                               # Build output
    ├── classes/
    ├── test-classes/
    ├── springboot-app.jar
    └── site/jacoco/                      # Coverage reports
```

---
# References
1. https://spring.io/guides/gs/spring-boot/ - Official Spring Boot Getting Started Guide
2. https://docs.spring.io/spring-boot/docs/current/maven-plugin/reference/html/ - Spring Boot Maven Plugin
3. https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html - Configuration Properties
4. https://flywaydb.org/documentation/usage/maven/ - Flyway Maven Plugin
5. https://testcontainers.com/ - Testcontainers for integration testing

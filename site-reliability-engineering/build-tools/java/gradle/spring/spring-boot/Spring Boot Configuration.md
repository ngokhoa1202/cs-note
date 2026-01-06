#gradle #spring-boot #java #kotlin #groovy #dependency-manager #configuration #production #development
# Complete Spring Boot Gradle Configuration

## Kotlin DSL

```kotlin title='build.gradle.kts - Complete Spring Boot Configuration'
import org.springframework.boot.gradle.tasks.bundling.BootJar

plugins {
    java
    id("org.springframework.boot") version "3.2.0"
    id("io.spring.dependency-management") version "1.1.4"
    id("org.flywaydb.flyway") version "10.3.0"
    jacoco
}

group = "com.example"
version = "1.0.0-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

extra["lombokVersion"] = "1.18.30"
extra["mapstructVersion"] = "1.5.5.Final"
extra["jjwtVersion"] = "0.12.3"
extra["springdocVersion"] = "2.2.0"
extra["testcontainersVersion"] = "1.19.3"

dependencies {
    // ========== WEB & REST API ==========
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-validation")

    // ========== DATA & PERSISTENCE ==========
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-data-redis")
    implementation("org.flywaydb:flyway-core")
    runtimeOnly("org.postgresql:postgresql")

    // ========== SECURITY ==========
    implementation("org.springframework.boot:spring-boot-starter-security")
    implementation("io.jsonwebtoken:jjwt-api:${property("jjwtVersion")}")
    runtimeOnly("io.jsonwebtoken:jjwt-impl:${property("jjwtVersion")}")
    runtimeOnly("io.jsonwebtoken:jjwt-jackson:${property("jjwtVersion")}")

    // ========== MONITORING & OBSERVABILITY ==========
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("io.micrometer:micrometer-registry-prometheus")
    implementation("io.micrometer:micrometer-tracing-bridge-brave")
    implementation("io.zipkin.reporter2:zipkin-reporter-brave")

    // ========== API DOCUMENTATION ==========
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:${property("springdocVersion")}")

    // ========== MESSAGING ==========
    implementation("org.springframework.kafka:spring-kafka")
    implementation("org.springframework.boot:spring-boot-starter-amqp")

    // ========== UTILITIES ==========
    compileOnly("org.projectlombok:lombok:${property("lombokVersion")}")
    annotationProcessor("org.projectlombok:lombok:${property("lombokVersion")}")
    implementation("org.mapstruct:mapstruct:${property("mapstructVersion")}")
    annotationProcessor("org.mapstruct:mapstruct-processor:${property("mapstructVersion")}")
    annotationProcessor("org.projectlombok:lombok-mapstruct-binding:0.2.0")
    implementation("org.apache.commons:commons-lang3")
    implementation("com.google.guava:guava:32.1.3-jre")

    // ========== DEVELOPMENT TOOLS ==========
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    annotationProcessor("org.springframework.boot:spring-boot-configuration-processor")

    // ========== TESTING ==========
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.springframework.security:spring-security-test")
    testImplementation("org.testcontainers:testcontainers:${property("testcontainersVersion")}")
    testImplementation("org.testcontainers:postgresql:${property("testcontainersVersion")}")
    testImplementation("org.testcontainers:kafka:${property("testcontainersVersion")}")
    testImplementation("io.rest-assured:rest-assured")

    // ========== PROFILE-SPECIFIC ==========
    runtimeOnly("com.h2database:h2")
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.named<BootJar>("bootJar") {
    archiveFileName.set("${project.name}.jar")
}

tasks.jacocoTestReport {
    dependsOn(tasks.test)
    reports {
        xml.required.set(true)
        html.required.set(true)
    }
}

// Development profile configuration
val devProfile by tasks.registering {
    group = "application"
    description = "Run with dev profile"
    doFirst {
        System.setProperty("spring.profiles.active", "dev")
    }
}

// Production profile configuration
val prodProfile by tasks.registering {
    group = "application"
    description = "Run with prod profile"
    doFirst {
        System.setProperty("spring.profiles.active", "prod")
    }
}

flyway {
    url = project.findProperty("flyway.url") as String? ?: "jdbc:postgresql://localhost:5432/springboot"
    user = project.findProperty("flyway.user") as String? ?: "postgres"
    password = project.findProperty("flyway.password") as String? ?: "postgres"
}
```
## Groovy DSL
```groovy title='build.gradle - Complete Spring Boot Configuration'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
    id 'org.flywaydb.flyway' version '10.3.0'
    id 'jacoco'
}

group = 'com.example'
version = '1.0.0-SNAPSHOT'

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

configurations {
    compileOnly {
        extendsFrom annotationProcessor
    }
}

repositories {
    mavenCentral()
}

ext {
    lombokVersion = '1.18.30'
    mapstructVersion = '1.5.5.Final'
    jjwtVersion = '0.12.3'
    springdocVersion = '2.2.0'
    testcontainersVersion = '1.19.3'
}

dependencies {
    // ========== WEB & REST API ==========
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-validation'

    // ========== DATA & PERSISTENCE ==========
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-data-redis'
    implementation 'org.flywaydb:flyway-core'
    runtimeOnly 'org.postgresql:postgresql'

    // ========== SECURITY ==========
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation "io.jsonwebtoken:jjwt-api:${jjwtVersion}"
    runtimeOnly "io.jsonwebtoken:jjwt-impl:${jjwtVersion}"
    runtimeOnly "io.jsonwebtoken:jjwt-jackson:${jjwtVersion}"

    // ========== MONITORING & OBSERVABILITY ==========
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    implementation 'io.micrometer:micrometer-registry-prometheus'
    implementation 'io.micrometer:micrometer-tracing-bridge-brave'
    implementation 'io.zipkin.reporter2:zipkin-reporter-brave'

    // ========== API DOCUMENTATION ==========
    implementation "org.springdoc:springdoc-openapi-starter-webmvc-ui:${springdocVersion}"

    // ========== MESSAGING ==========
    implementation 'org.springframework.kafka:spring-kafka'
    implementation 'org.springframework.boot:spring-boot-starter-amqp'

    // ========== UTILITIES ==========
    compileOnly "org.projectlombok:lombok:${lombokVersion}"
    annotationProcessor "org.projectlombok:lombok:${lombokVersion}"
    implementation "org.mapstruct:mapstruct:${mapstructVersion}"
    annotationProcessor "org.mapstruct:mapstruct-processor:${mapstructVersion}"
    annotationProcessor 'org.projectlombok:lombok-mapstruct-binding:0.2.0'
    implementation 'org.apache.commons:commons-lang3'
    implementation 'com.google.guava:guava:32.1.3-jre'

    // ========== DEVELOPMENT TOOLS ==========
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    annotationProcessor 'org.springframework.boot:spring-boot-configuration-processor'

    // ========== TESTING ==========
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.springframework.security:spring-security-test'
    testImplementation "org.testcontainers:testcontainers:${testcontainersVersion}"
    testImplementation "org.testcontainers:postgresql:${testcontainersVersion}"
    testImplementation "org.testcontainers:kafka:${testcontainersVersion}"
    testImplementation 'io.rest-assured:rest-assured'

    // ========== PROFILE-SPECIFIC ==========
    runtimeOnly 'com.h2database:h2'
}

tasks.named('test') {
    useJUnitPlatform()
}

tasks.named('bootJar') {
    archiveFileName = "${project.name}.jar"
}

jacocoTestReport {
    dependsOn test
    reports {
        xml.required = true
        html.required = true
    }
}

task devProfile {
    group = 'application'
    description = 'Run with dev profile'
    doFirst {
        System.setProperty('spring.profiles.active', 'dev')
    }
}

task prodProfile {
    group = 'application'
    description = 'Run with prod profile'
    doFirst {
        System.setProperty('spring.profiles.active', 'prod')
    }
}

flyway {
    url = project.findProperty('flyway.url') ?: 'jdbc:postgresql://localhost:5432/springboot'
    user = project.findProperty('flyway.user') ?: 'postgres'
    password = project.findProperty('flyway.password') ?: 'postgres'
}
```

# Environment-Specific Application Configuration

## Development Configuration
```yaml title='src/main/resources/application-dev.yml'
spring:
  datasource:
    url: jdbc:h2:mem:testdb
    driver-class-name: org.h2.Driver
    username: sa
    password:

  h2:
    console:
      enabled: true
      path: /h2-console

  jpa:
    hibernate:
      ddl-auto: create-drop
    show-sql: true
    properties:
      hibernate:
        format_sql: true

  data:
    redis:
      host: localhost
      port: 6379

  kafka:
    bootstrap-servers: localhost:9092

  devtools:
    livereload:
      enabled: true
    restart:
      enabled: true

management:
  endpoints:
    web:
      exposure:
        include: '*'

logging:
  level:
    root: INFO
    com.example: DEBUG
```

## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
spring:
  datasource:
    url: jdbc:postgresql://${DB_HOST}:${DB_PORT:5432}/${DB_NAME}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    hikari:
      maximum-pool-size: 20

  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false

  data:
    redis:
      host: ${REDIS_HOST}
      port: ${REDIS_PORT:6379}
      password: ${REDIS_PASSWORD}

  kafka:
    bootstrap-servers: ${KAFKA_BOOTSTRAP_SERVERS}

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus

logging:
  level:
    root: WARN
    com.example: INFO
```

# Gradle Commands for Different Environments
## Development Environment
```shell title='Development build and run'
# Build and run with dev profile
./gradlew bootRun --args='--spring.profiles.active=dev'

# Build project
./gradlew build

# Run tests
./gradlew test

# Run with continuous build
./gradlew build --continuous

# View test report
open build/reports/tests/test/index.html
```
## Production Environment
```shell title='Production build'
# Build production JAR
./gradlew clean bootJar

# Build without tests
./gradlew bootJar -x test

# Run production JAR
java -jar build/libs/springboot-app.jar --spring.profiles.active=prod

# Build with specific environment
./gradlew bootJar -Pprofile=prod
```
## Database Migrations
```shell title='Flyway migrations'
# Run migrations
./gradlew flywayMigrate

# Clean database (development only)
./gradlew flywayClean

# Get migration info
./gradlew flywayInfo

# Validate migrations
./gradlew flywayValidate
```

## Code Quality
```shell title='Code coverage'
# Generate coverage report
./gradlew test jacocoTestReport

# View coverage report
open build/reports/jacoco/test/html/index.html
```

# Dependency Configuration Strategy

| Configuration | Use Case | Example |
|--------------|----------|---------|
| `implementation` | Internal dependencies | Spring Boot starters, utilities |
| `compileOnly` | Compile-time only | Lombok |
| `annotationProcessor` | Code generation | Lombok, MapStruct |
| `runtimeOnly` | Runtime dependencies | Database drivers, H2 |
| `developmentOnly` | Development tools | DevTools |
| `testImplementation` | Testing frameworks | JUnit, Mockito, Testcontainers |
# Project Structure
```
springboot-app/
├── build.gradle.kts (or build.gradle)
├── settings.gradle.kts (or settings.gradle)
├── gradle.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── SpringBootApplication.java
│   │   │       ├── controller/
│   │   │       ├── service/
│   │   │       ├── repository/
│   │   │       ├── entity/
│   │   │       ├── dto/
│   │   │       ├── mapper/
│   │   │       ├── config/
│   │   │       └── security/
│   │   └── resources/
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       └── db/migration/
│   └── test/
│       ├── java/
│       │   └── com/example/
│       │       ├── integration/
│       │       └── unit/
│       └── resources/
└── build/
    ├── classes/
    ├── libs/
    │   └── springboot-app.jar
    └── reports/
```
# Gradle Properties
```properties title='gradle.properties'
# Build properties
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
org.gradle.parallel=true
org.gradle.caching=true

# Spring Boot properties
spring.profiles.active=dev

# Flyway properties (can be overridden)
flyway.url=jdbc:postgresql://localhost:5432/springboot
flyway.user=postgres
flyway.password=postgres
```
# Settings Configuration
**Kotlin DSL:**
```kotlin title='settings.gradle.kts'
rootProject.name = "springboot-app"
```
**Groovy DSL:**
```groovy title='settings.gradle'
rootProject.name = 'springboot-app'
```

---
# References
1. https://spring.io/guides/gs/gradle/ - Building Spring Boot with Gradle
2. https://docs.spring.io/spring-boot/docs/current/gradle-plugin/reference/html/ - Spring Boot Gradle Plugin Reference
3. https://docs.gradle.org/current/userguide/kotlin_dsl.html - Gradle Kotlin DSL
4. https://docs.gradle.org/current/userguide/dependency_management.html - Gradle Dependency Management

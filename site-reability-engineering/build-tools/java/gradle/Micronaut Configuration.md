#gradle #micronaut #java #kotlin #groovy #dependency-manager #configuration #production #development #microservices
# Purpose
- Demonstrate comprehensive Gradle configuration for Micronaut applications.
- Include environment-specific dependencies and configurations for development and production.
- Showcase both Kotlin DSL and Groovy DSL configurations.
- Highlight Micronaut-specific features: compile-time DI, AOT compilation, and GraalVM support.

# Complete Micronaut Gradle Configuration

## Kotlin DSL

```kotlin title='build.gradle.kts - Complete Micronaut Configuration'
plugins {
    id("com.github.johnrengelman.shadow") version "8.1.1"
    id("io.micronaut.application") version "4.2.0"
    id("io.micronaut.aot") version "4.2.0"
}

version = "1.0.0-SNAPSHOT"
group = "com.example"

repositories {
    mavenCentral()
}

dependencies {
    // ========== CORE MICRONAUT ==========
    implementation("io.micronaut:micronaut-http-server-netty")
    implementation("io.micronaut:micronaut-http-client")
    implementation("io.micronaut:micronaut-jackson-databind")
    implementation("io.micronaut.validation:micronaut-validation")

    // ========== DATA & PERSISTENCE ==========
    implementation("io.micronaut.data:micronaut-data-jdbc")
    implementation("io.micronaut.data:micronaut-data-hibernate-jpa")
    implementation("io.micronaut.data:micronaut-data-r2dbc")
    implementation("io.micronaut.sql:micronaut-jdbc-hikari")
    implementation("io.micronaut.flyway:micronaut-flyway")
    runtimeOnly("org.postgresql:postgresql")
    runtimeOnly("org.postgresql:r2dbc-postgresql")
    implementation("io.micronaut.redis:micronaut-redis-lettuce")
    implementation("io.micronaut.mongodb:micronaut-mongo-reactive")

    // ========== SECURITY ==========
    implementation("io.micronaut.security:micronaut-security")
    implementation("io.micronaut.security:micronaut-security-jwt")
    implementation("io.micronaut.security:micronaut-security-oauth2")

    // ========== MONITORING & OBSERVABILITY ==========
    implementation("io.micronaut:micronaut-management")
    implementation("io.micronaut.micrometer:micronaut-micrometer-core")
    implementation("io.micronaut.micrometer:micronaut-micrometer-registry-prometheus")
    implementation("io.micronaut.tracing:micronaut-tracing-opentelemetry")

    // ========== API DOCUMENTATION ==========
    implementation("io.micronaut.openapi:micronaut-openapi")
    implementation("io.swagger.core.v3:swagger-annotations")

    // ========== MESSAGING ==========
    implementation("io.micronaut.kafka:micronaut-kafka")
    implementation("io.micronaut.rabbitmq:micronaut-rabbitmq")

    // ========== MICROSERVICES PATTERNS ==========
    implementation("io.micronaut.discovery:micronaut-discovery-client")
    implementation("io.micronaut:micronaut-retry")
    implementation("io.micronaut.grpc:micronaut-grpc-server-runtime")
    implementation("io.micronaut.grpc:micronaut-grpc-client-runtime")

    // ========== CACHING ==========
    implementation("io.micronaut.cache:micronaut-cache-caffeine")

    // ========== REACTIVE PROGRAMMING ==========
    implementation("io.micronaut.reactor:micronaut-reactor")
    implementation("io.micronaut.rxjava3:micronaut-rxjava3")

    // ========== UTILITIES ==========
    compileOnly("org.projectlombok:lombok:1.18.30")
    annotationProcessor("org.projectlombok:lombok:1.18.30")
    implementation("org.mapstruct:mapstruct:1.5.5.Final")
    annotationProcessor("org.mapstruct:mapstruct-processor:1.5.5.Final")

    // ========== LOGGING ==========
    runtimeOnly("ch.qos.logback:logback-classic")

    // ========== DEVELOPMENT TOOLS ==========
    runtimeOnly("com.h2database:h2")

    // ========== TESTING ==========
    testImplementation("io.micronaut.test:micronaut-test-junit5")
    testImplementation("org.junit.jupiter:junit-jupiter-api")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine")
    testImplementation("org.mockito:mockito-core")
    testImplementation("org.assertj:assertj-core")
    testImplementation("io.rest-assured:rest-assured")
    testImplementation("org.testcontainers:postgresql:1.19.3")
    testImplementation("org.testcontainers:kafka:1.19.3")
}

application {
    mainClass.set("com.example.Application")
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

graalvmNative.toolchainDetection.set(false)

micronaut {
    runtime("netty")
    testRuntime("junit5")
    processing {
        incremental(true)
        annotations("com.example.*")
    }
    aot {
        // AOT optimization settings
        optimizeServiceLoading.set(false)
        convertYamlToJava.set(false)
        precomputeOperations.set(true)
        cacheEnvironment.set(true)
        optimizeClassLoading.set(true)
        deduceEnvironment.set(true)
        optimizeNetty.set(true)
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.named<io.micronaut.gradle.docker.NativeImageDockerfile>("dockerfileNative") {
    jdkVersion.set("17")
}
```

## Groovy DSL

```groovy title='build.gradle - Complete Micronaut Configuration'
plugins {
    id 'com.github.johnrengelman.shadow' version '8.1.1'
    id 'io.micronaut.application' version '4.2.0'
    id 'io.micronaut.aot' version '4.2.0'
}

version = '1.0.0-SNAPSHOT'
group = 'com.example'

repositories {
    mavenCentral()
}

dependencies {
    // ========== CORE MICRONAUT ==========
    implementation 'io.micronaut:micronaut-http-server-netty'
    implementation 'io.micronaut:micronaut-http-client'
    implementation 'io.micronaut:micronaut-jackson-databind'
    implementation 'io.micronaut.validation:micronaut-validation'

    // ========== DATA & PERSISTENCE ==========
    implementation 'io.micronaut.data:micronaut-data-jdbc'
    implementation 'io.micronaut.data:micronaut-data-hibernate-jpa'
    implementation 'io.micronaut.data:micronaut-data-r2dbc'
    implementation 'io.micronaut.sql:micronaut-jdbc-hikari'
    implementation 'io.micronaut.flyway:micronaut-flyway'
    runtimeOnly 'org.postgresql:postgresql'
    runtimeOnly 'org.postgresql:r2dbc-postgresql'
    implementation 'io.micronaut.redis:micronaut-redis-lettuce'
    implementation 'io.micronaut.mongodb:micronaut-mongo-reactive'

    // ========== SECURITY ==========
    implementation 'io.micronaut.security:micronaut-security'
    implementation 'io.micronaut.security:micronaut-security-jwt'
    implementation 'io.micronaut.security:micronaut-security-oauth2'

    // ========== MONITORING & OBSERVABILITY ==========
    implementation 'io.micronaut:micronaut-management'
    implementation 'io.micronaut.micrometer:micronaut-micrometer-core'
    implementation 'io.micronaut.micrometer:micronaut-micrometer-registry-prometheus'
    implementation 'io.micronaut.tracing:micronaut-tracing-opentelemetry'

    // ========== API DOCUMENTATION ==========
    implementation 'io.micronaut.openapi:micronaut-openapi'
    implementation 'io.swagger.core.v3:swagger-annotations'

    // ========== MESSAGING ==========
    implementation 'io.micronaut.kafka:micronaut-kafka'
    implementation 'io.micronaut.rabbitmq:micronaut-rabbitmq'

    // ========== MICROSERVICES PATTERNS ==========
    implementation 'io.micronaut.discovery:micronaut-discovery-client'
    implementation 'io.micronaut:micronaut-retry'
    implementation 'io.micronaut.grpc:micronaut-grpc-server-runtime'
    implementation 'io.micronaut.grpc:micronaut-grpc-client-runtime'

    // ========== CACHING ==========
    implementation 'io.micronaut.cache:micronaut-cache-caffeine'

    // ========== REACTIVE PROGRAMMING ==========
    implementation 'io.micronaut.reactor:micronaut-reactor'
    implementation 'io.micronaut.rxjava3:micronaut-rxjava3'

    // ========== UTILITIES ==========
    compileOnly 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok:1.18.30'
    implementation 'org.mapstruct:mapstruct:1.5.5.Final'
    annotationProcessor 'org.mapstruct:mapstruct-processor:1.5.5.Final'

    // ========== LOGGING ==========
    runtimeOnly 'ch.qos.logback:logback-classic'

    // ========== DEVELOPMENT TOOLS ==========
    runtimeOnly 'com.h2database:h2'

    // ========== TESTING ==========
    testImplementation 'io.micronaut.test:micronaut-test-junit5'
    testImplementation 'org.junit.jupiter:junit-jupiter-api'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine'
    testImplementation 'org.mockito:mockito-core'
    testImplementation 'org.assertj:assertj-core'
    testImplementation 'io.rest-assured:rest-assured'
    testImplementation 'org.testcontainers:postgresql:1.19.3'
    testImplementation 'org.testcontainers:kafka:1.19.3'
}

application {
    mainClass = 'com.example.Application'
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

graalvmNative.toolchainDetection = false

micronaut {
    runtime 'netty'
    testRuntime 'junit5'
    processing {
        incremental true
        annotations 'com.example.*'
    }
    aot {
        optimizeServiceLoading = false
        convertYamlToJava = false
        precomputeOperations = true
        cacheEnvironment = true
        optimizeClassLoading = true
        deduceEnvironment = true
        optimizeNetty = true
    }
}

tasks.named('test') {
    useJUnitPlatform()
}

tasks.named('dockerfileNative') {
    jdkVersion = '17'
}
```

# Gradle Properties

```properties title='gradle.properties'
# Micronaut version
micronautVersion=4.2.0

# Gradle settings
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.daemon=true
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

  datasources:
    default:
      url: jdbc:h2:mem:devDb
      driverClassName: org.h2.Driver
      username: sa
      password: ''
      schema-generate: CREATE_DROP

  redis:
    uri: redis://localhost:6379

  kafka:
    bootstrap:
      servers: localhost:9092

  router:
    static-resources:
      swagger:
        paths: classpath:META-INF/swagger
        mapping: /swagger/**

endpoints:
  all:
    enabled: true
    sensitive: false

logger:
  levels:
    root: INFO
    com.example: DEBUG
```

## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
micronaut:
  application:
    name: micronaut-app-prod

  server:
    port: 8080
    ssl:
      enabled: ${SSL_ENABLED:false}

  datasources:
    default:
      url: jdbc:postgresql://${DB_HOST}:${DB_PORT:5432}/${DB_NAME}
      username: ${DB_USERNAME}
      password: ${DB_PASSWORD}
      maximum-pool-size: 20

  flyway:
    datasources:
      default:
        enabled: true

  redis:
    uri: ${REDIS_URL}
    password: ${REDIS_PASSWORD}
    ssl: true

  kafka:
    bootstrap:
      servers: ${KAFKA_BOOTSTRAP_SERVERS}

  metrics:
    enabled: true
    export:
      prometheus:
        enabled: true

endpoints:
  all:
    enabled: false
  health:
    enabled: true

logger:
  levels:
    root: WARN
    com.example: INFO
```

# Gradle Commands for Different Environments

## Development Environment
```shell title='Development build and run'
# Compile and run
./gradlew run

# Run with continuous build
./gradlew run --continuous

# Build project
./gradlew build

# Run tests
./gradlew test

# Clean build
./gradlew clean build
```

## Production Environment
```shell title='Production build'
# Build production JAR
./gradlew shadowJar

# Build optimized JAR
./gradlew optimizedJar

# Run production JAR
java -jar build/libs/micronaut-app-all.jar

# Build without tests
./gradlew shadowJar -x test
```

## Native Compilation
```shell title='Native image with GraalVM'
# Build native executable
./gradlew nativeCompile

# Run native executable
./build/native/nativeCompile/micronaut-app

# Build native Docker image
./gradlew dockerBuildNative
```

## Docker Image
```shell title='Docker image build'
# Build JVM Docker image
./gradlew dockerBuild

# Build and tag
./gradlew dockerBuild \
    -Pmicronaut.docker.image=myorg/micronaut-app:latest

# Push to registry
./gradlew dockerPush
```

## Testing
```shell title='Testing commands'
# Run all tests
./gradlew test

# Run specific test
./gradlew test --tests UserControllerTest

# Run tests with reports
./gradlew test jacocoTestReport

# View test report
open build/reports/tests/test/index.html
```

# Dependency Configuration Strategy

| Configuration | Use Case | Example |
|--------------|----------|---------|
| `implementation` | Core dependencies | Micronaut modules, libraries |
| `compileOnly` | Compile-time only | Lombok |
| `annotationProcessor` | Code generation | Lombok, MapStruct, Micronaut processors |
| `runtimeOnly` | Runtime dependencies | Database drivers, Logback |
| `testImplementation` | Testing frameworks | JUnit 5, Mockito, Testcontainers |

# Key Features

## Compile-Time Dependency Injection
- No reflection at runtime.
- Faster startup.
- Lower memory usage.

## Ahead-of-Time (AOT) Compilation
- Compile-time code generation.
- Optimized bytecode.
- GraalVM native image support.

## Reactive Programming
- Reactive HTTP client/server.
- R2DBC reactive database access.
- Reactive messaging.

## Test Resources
- Automatic test container lifecycle.
- Zero configuration testing.

# Project Structure
```
micronaut-app/
├── build.gradle.kts (or build.gradle)
├── settings.gradle.kts (or settings.gradle)
├── gradle.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── Application.java
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
│   │       ├── logback.xml
│   │       └── db/migration/
│   └── test/
│       ├── java/
│       │   └── com/example/
│       └── resources/
└── build/
    ├── libs/
    │   └── micronaut-app-all.jar
    └── native/
        └── nativeCompile/
            └── micronaut-app
```

# Settings Configuration

**Kotlin DSL:**
```kotlin title='settings.gradle.kts'
pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

plugins {
    id("io.micronaut.platform.catalog") version "4.2.0"
}

rootProject.name = "micronaut-app"
```

**Groovy DSL:**
```groovy title='settings.gradle'
pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

plugins {
    id 'io.micronaut.platform.catalog' version '4.2.0'
}

rootProject.name = 'micronaut-app'
```

# Advanced Build Configuration

**Kotlin DSL:**
```kotlin title='Advanced build.gradle.kts configuration'
tasks {
    named<io.micronaut.gradle.docker.MicronautDockerfile>("dockerfile") {
        baseImage("eclipse-temurin:17-jre-jammy")
    }

    named<io.micronaut.gradle.docker.NativeImageDockerfile>("dockerfileNative") {
        baseImage("gcr.io/distroless/cc-debian12")
    }

    shadowJar {
        mergeServiceFiles()
    }

    optimizedJar {
        enabled = true
    }
}
```

**Groovy DSL:**
```groovy title='Advanced build.gradle configuration'
tasks.named('dockerfile') {
    baseImage = 'eclipse-temurin:17-jre-jammy'
}

tasks.named('dockerfileNative') {
    baseImage = 'gcr.io/distroless/cc-debian12'
}

shadowJar {
    mergeServiceFiles()
}

optimizedJar {
    enabled = true
}
```

---
# References
1. https://micronaut.io/documentation.html - Official Micronaut Documentation
2. https://micronaut-projects.github.io/micronaut-gradle-plugin/latest/ - Micronaut Gradle Plugin
3. https://guides.micronaut.io/ - Micronaut Guides
4. https://docs.micronaut.io/latest/guide/#graal - GraalVM Native Image Guide
5. https://docs.gradle.org/current/userguide/application_plugin.html - Gradle Application Plugin

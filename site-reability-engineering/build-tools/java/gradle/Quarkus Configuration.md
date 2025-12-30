#gradle #quarkus #java #kotlin #groovy #dependency-manager #configuration #production #development #microservices
# Purpose
- Demonstrate comprehensive Gradle configuration for Quarkus applications.
- Include environment-specific dependencies and configurations for development and production.
- Showcase both Kotlin DSL and Groovy DSL configurations.
- Highlight Quarkus-specific features: native compilation, live reload, and reactive programming.

# Complete Quarkus Gradle Configuration

## Kotlin DSL

```kotlin title='build.gradle.kts - Complete Quarkus Configuration'
plugins {
    java
    id("io.quarkus") version "3.6.0"
}

group = "com.example"
version = "1.0.0-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
    mavenLocal()
}

val quarkusPlatformGroupId: String by project
val quarkusPlatformArtifactId: String by project
val quarkusPlatformVersion: String by project

val lombokVersion = "1.18.30"
val mapstructVersion = "1.5.5.Final"
val testcontainersVersion = "1.19.3"

dependencies {
    // ========== QUARKUS PLATFORM BOM ==========
    implementation(enforcedPlatform("${quarkusPlatformGroupId}:${quarkusPlatformArtifactId}:${quarkusPlatformVersion}"))

    // ========== WEB & REST API ==========
    implementation("io.quarkus:quarkus-resteasy-reactive")
    implementation("io.quarkus:quarkus-resteasy-reactive-jackson")
    implementation("io.quarkus:quarkus-hibernate-validator")

    // ========== DATA & PERSISTENCE ==========
    implementation("io.quarkus:quarkus-hibernate-orm-panache")
    implementation("io.quarkus:quarkus-hibernate-reactive-panache")
    implementation("io.quarkus:quarkus-jdbc-postgresql")
    implementation("io.quarkus:quarkus-reactive-pg-client")
    implementation("io.quarkus:quarkus-flyway")
    implementation("io.quarkus:quarkus-redis-client")
    implementation("io.quarkus:quarkus-mongodb-panache")

    // ========== SECURITY ==========
    implementation("io.quarkus:quarkus-oidc")
    implementation("io.quarkus:quarkus-smallrye-jwt")
    implementation("io.quarkus:quarkus-security-jpa")

    // ========== MONITORING & OBSERVABILITY ==========
    implementation("io.quarkus:quarkus-smallrye-health")
    implementation("io.quarkus:quarkus-micrometer-registry-prometheus")
    implementation("io.quarkus:quarkus-opentelemetry")

    // ========== API DOCUMENTATION ==========
    implementation("io.quarkus:quarkus-smallrye-openapi")

    // ========== MESSAGING ==========
    implementation("io.quarkus:quarkus-smallrye-reactive-messaging-kafka")
    implementation("io.quarkus:quarkus-smallrye-reactive-messaging-amqp")

    // ========== MICROSERVICES PATTERNS ==========
    implementation("io.quarkus:quarkus-rest-client-reactive-jackson")
    implementation("io.quarkus:quarkus-smallrye-fault-tolerance")
    implementation("io.quarkus:quarkus-grpc")

    // ========== CACHING ==========
    implementation("io.quarkus:quarkus-cache")

    // ========== SCHEDULING ==========
    implementation("io.quarkus:quarkus-quartz")

    // ========== UTILITIES ==========
    compileOnly("org.projectlombok:lombok:$lombokVersion")
    annotationProcessor("org.projectlombok:lombok:$lombokVersion")
    implementation("org.mapstruct:mapstruct:$mapstructVersion")
    annotationProcessor("org.mapstruct:mapstruct-processor:$mapstructVersion")

    // ========== CONFIGURATION ==========
    implementation("io.quarkus:quarkus-config-yaml")

    // ========== DEVELOPMENT TOOLS ==========
    implementation("io.quarkus:quarkus-devservices-keycloak")

    // ========== TESTING ==========
    testImplementation("io.quarkus:quarkus-junit5")
    testImplementation("io.quarkus:quarkus-junit5-mockito")
    testImplementation("io.rest-assured:rest-assured")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("io.quarkus:quarkus-test-wiremock")
}

tasks.withType<Test> {
    systemProperty("java.util.logging.manager", "org.jboss.logmanager.LogManager")
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
    options.compilerArgs.add("-parameters")
}

// Custom task for dev mode
tasks.register("runDev") {
    group = "application"
    description = "Run Quarkus in dev mode"
    dependsOn("quarkusDev")
}

// Custom task for production build
tasks.register("buildProd") {
    group = "build"
    description = "Build for production"
    dependsOn("build")
    doLast {
        println("Production build completed")
    }
}
```

## Groovy DSL

```groovy title='build.gradle - Complete Quarkus Configuration'
plugins {
    id 'java'
    id 'io.quarkus' version '3.6.0'
}

group = 'com.example'
version = '1.0.0-SNAPSHOT'

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
    mavenLocal()
}

def lombokVersion = '1.18.30'
def mapstructVersion = '1.5.5.Final'
def testcontainersVersion = '1.19.3'

dependencies {
    // ========== QUARKUS PLATFORM BOM ==========
    implementation enforcedPlatform("${quarkusPlatformGroupId}:${quarkusPlatformArtifactId}:${quarkusPlatformVersion}")

    // ========== WEB & REST API ==========
    implementation 'io.quarkus:quarkus-resteasy-reactive'
    implementation 'io.quarkus:quarkus-resteasy-reactive-jackson'
    implementation 'io.quarkus:quarkus-hibernate-validator'

    // ========== DATA & PERSISTENCE ==========
    implementation 'io.quarkus:quarkus-hibernate-orm-panache'
    implementation 'io.quarkus:quarkus-hibernate-reactive-panache'
    implementation 'io.quarkus:quarkus-jdbc-postgresql'
    implementation 'io.quarkus:quarkus-reactive-pg-client'
    implementation 'io.quarkus:quarkus-flyway'
    implementation 'io.quarkus:quarkus-redis-client'
    implementation 'io.quarkus:quarkus-mongodb-panache'

    // ========== SECURITY ==========
    implementation 'io.quarkus:quarkus-oidc'
    implementation 'io.quarkus:quarkus-smallrye-jwt'
    implementation 'io.quarkus:quarkus-security-jpa'

    // ========== MONITORING & OBSERVABILITY ==========
    implementation 'io.quarkus:quarkus-smallrye-health'
    implementation 'io.quarkus:quarkus-micrometer-registry-prometheus'
    implementation 'io.quarkus:quarkus-opentelemetry'

    // ========== API DOCUMENTATION ==========
    implementation 'io.quarkus:quarkus-smallrye-openapi'

    // ========== MESSAGING ==========
    implementation 'io.quarkus:quarkus-smallrye-reactive-messaging-kafka'
    implementation 'io.quarkus:quarkus-smallrye-reactive-messaging-amqp'

    // ========== MICROSERVICES PATTERNS ==========
    implementation 'io.quarkus:quarkus-rest-client-reactive-jackson'
    implementation 'io.quarkus:quarkus-smallrye-fault-tolerance'
    implementation 'io.quarkus:quarkus-grpc'

    // ========== CACHING ==========
    implementation 'io.quarkus:quarkus-cache'

    // ========== SCHEDULING ==========
    implementation 'io.quarkus:quarkus-quartz'

    // ========== UTILITIES ==========
    compileOnly "org.projectlombok:lombok:${lombokVersion}"
    annotationProcessor "org.projectlombok:lombok:${lombokVersion}"
    implementation "org.mapstruct:mapstruct:${mapstructVersion}"
    annotationProcessor "org.mapstruct:mapstruct-processor:${mapstructVersion}"

    // ========== CONFIGURATION ==========
    implementation 'io.quarkus:quarkus-config-yaml'

    // ========== DEVELOPMENT TOOLS ==========
    implementation 'io.quarkus:quarkus-devservices-keycloak'

    // ========== TESTING ==========
    testImplementation 'io.quarkus:quarkus-junit5'
    testImplementation 'io.quarkus:quarkus-junit5-mockito'
    testImplementation 'io.rest-assured:rest-assured'
    testImplementation "org.testcontainers:postgresql:${testcontainersVersion}"
    testImplementation 'io.quarkus:quarkus-test-wiremock'
}

tasks.withType(Test) {
    systemProperty 'java.util.logging.manager', 'org.jboss.logmanager.LogManager'
}

tasks.withType(JavaCompile) {
    options.encoding = 'UTF-8'
    options.compilerArgs << '-parameters'
}

task runDev {
    group = 'application'
    description = 'Run Quarkus in dev mode'
    dependsOn 'quarkusDev'
}

task buildProd {
    group = 'build'
    description = 'Build for production'
    dependsOn 'build'
    doLast {
        println 'Production build completed'
    }
}
```

# Gradle Properties

```properties title='gradle.properties'
# Quarkus platform
quarkusPlatformGroupId=io.quarkus.platform
quarkusPlatformArtifactId=quarkus-bom
quarkusPlatformVersion=3.6.0

# Gradle settings
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g
org.gradle.parallel=true
org.gradle.caching=true

# Quarkus settings
quarkus.package.type=fast-jar
```

# Environment-Specific Application Configuration

## Development Configuration
```yaml title='src/main/resources/application-dev.yml'
quarkus:
  application:
    name: quarkus-app-dev

  http:
    port: 8080
    cors: true

  datasource:
    db-kind: postgresql
    username: quarkus
    password: quarkus
    jdbc:
      url: jdbc:postgresql://localhost:5432/quarkus_dev

  hibernate-orm:
    database:
      generation: drop-and-create
    log:
      sql: true

  redis:
    hosts: redis://localhost:6379

  kafka:
    devservices:
      enabled: true

  live-reload:
    enabled: true

  dev-ui:
    enabled: true

  smallrye-openapi:
    enable: true

  swagger-ui:
    always-include: true

  log:
    level: INFO
    category:
      "com.example":
        level: DEBUG
```

## Production Configuration
```yaml title='src/main/resources/application-prod.yml'
quarkus:
  application:
    name: quarkus-app-prod

  http:
    port: 8080
    ssl:
      certificate:
        key-file: ${SSL_KEY_FILE}
        cert-file: ${SSL_CERT_FILE}

  datasource:
    db-kind: postgresql
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    jdbc:
      url: jdbc:postgresql://${DB_HOST}:${DB_PORT:5432}/${DB_NAME}
      max-size: 20

  hibernate-orm:
    database:
      generation: none

  flyway:
    migrate-at-start: true

  redis:
    hosts: ${REDIS_URL}
    password: ${REDIS_PASSWORD}

  kafka:
    bootstrap:
      servers: ${KAFKA_BOOTSTRAP_SERVERS}

  smallrye-openapi:
    enable: false

  swagger-ui:
    always-include: false

  log:
    level: WARN
    category:
      "com.example":
        level: INFO
```

# Gradle Commands for Different Environments

## Development Environment
```shell title='Development build and run'
# Run in dev mode with live reload
./gradlew quarkusDev

# Run with debug
./gradlew quarkusDev --debug-jvm

# Build project
./gradlew build

# Run tests
./gradlew test

# Access Dev UI
# http://localhost:8080/q/dev
```

## Production Environment
```shell title='Production build'
# Build production JAR
./gradlew build

# Build uber-jar
./gradlew build -Dquarkus.package.type=uber-jar

# Build without tests
./gradlew build -x test

# Run production JAR
java -jar build/quarkus-app/quarkus-run.jar
```

## Native Compilation
```shell title='Native image compilation'
# Build native executable
./gradlew build -Dquarkus.package.type=native

# Build native with container
./gradlew build \
    -Dquarkus.package.type=native \
    -Dquarkus.native.container-build=true

# Run native executable
./build/quarkus-app-runner

# Test native build
./gradlew testNative
```

## Container Image
```shell title='Container image build'
# Build container image
./gradlew build \
    -Dquarkus.container-image.build=true

# Build and push to registry
./gradlew build \
    -Dquarkus.container-image.build=true \
    -Dquarkus.container-image.push=true \
    -Dquarkus.container-image.registry=docker.io \
    -Dquarkus.container-image.group=myorg \
    -Dquarkus.container-image.name=quarkus-app
```

# Dependency Configuration Strategy

| Configuration | Use Case | Example |
|--------------|----------|---------|
| `implementation` | Quarkus extensions and libraries | RESTEasy, Hibernate, Security |
| `compileOnly` | Compile-time only | Lombok |
| `annotationProcessor` | Code generation | Lombok, MapStruct |
| `testImplementation` | Testing frameworks | JUnit 5, REST Assured, Testcontainers |

# Key Features

## Live Reload
- Automatic reload on code changes.
- Fast iteration cycle.
- No manual restart needed.

## DevServices
- Automatic container startup.
- Zero configuration development.
- Testcontainers integration.

## Native Compilation
- GraalVM native image.
- Millisecond startup time.
- Low memory footprint.
- Ideal for serverless.

## Reactive Programming
- Mutiny reactive types.
- Non-blocking I/O.
- Reactive database drivers.

# Project Structure
```
quarkus-app/
├── build.gradle.kts (or build.gradle)
├── settings.gradle.kts (or settings.gradle)
├── gradle.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── resource/
│   │   │       ├── service/
│   │   │       ├── repository/
│   │   │       ├── entity/
│   │   │       ├── dto/
│   │   │       ├── mapper/
│   │   │       ├── config/
│   │   │       └── security/
│   │   ├── resources/
│   │   │   ├── application.yml
│   │   │   ├── application-dev.yml
│   │   │   ├── application-prod.yml
│   │   │   └── db/migration/
│   │   └── proto/
│   └── test/
│       ├── java/
│       │   └── com/example/
│       └── resources/
└── build/
    ├── quarkus-app/
    │   └── quarkus-run.jar
    └── quarkus-app-runner
```

# Settings Configuration

**Kotlin DSL:**
```kotlin title='settings.gradle.kts'
pluginManagement {
    repositories {
        mavenCentral()
        gradlePluginPortal()
        mavenLocal()
    }
    plugins {
        id("io.quarkus") version "3.6.0"
    }
}

rootProject.name = "quarkus-app"
```

**Groovy DSL:**
```groovy title='settings.gradle'
pluginManagement {
    repositories {
        mavenCentral()
        gradlePluginPortal()
        mavenLocal()
    }
    plugins {
        id 'io.quarkus' version '3.6.0'
    }
}

rootProject.name = 'quarkus-app'
```

---
# References
1. https://quarkus.io/guides/gradle-tooling - Quarkus Gradle Tooling
2. https://quarkus.io/guides/building-native-image - Native Executable Guide
3. https://quarkus.io/guides/dev-mode-differences - Development Mode
4. https://quarkus.io/guides/config-reference - Configuration Reference
5. https://docs.gradle.org/current/userguide/java_plugin.html - Gradle Java Plugin

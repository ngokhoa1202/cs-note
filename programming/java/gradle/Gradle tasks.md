#dependency-manager #gradle #cli #java #jakarta-ee #spring #spring-boot #quarkus #kotlin #compilation 

> [!Disclamer]
> The following documentation is written with respect to  JVM on Ubuntu 22.04 Linux platform. The gradle behaviour is slightly different on Windows' JVM.

# Task
- An independent unit of work.
- Includes:
	- <mark style="background: #e4e62d;">Generating byte code</mark> (`.class` files) from source code.
	- <mark style="background: #e4e62d;">Compiling byte code</mark> to generate executable code (`.jar` files).
	- Generating Javadoc.
 
>[!Note]
>Because Java is compiled programming language on JVM, the output of our project looks like:
><mark style="background: #e4e62d;">source code $\to$ class files $\to$ .jar file</mark>
>
>An aggregate task means that an additional task that depends on another task and a more user-defined task.

# Task lifecycle
- For simplicity, we mention only the essential parts.
- ![](Pasted%20image%2020240917155051.png)
- The solid arrow A $\to$ B means that:
	- Task A needs Task B to complete in advance.
	- Performing task A triggers task B to perform.
## Task compileJava
- Generates byte code from all of the `.java` file into `.class` file.
- The output is inside the `build/classes`
## Task processResources
- Copy all of the files inside the `src/main/resources` (e.g: `application.properties`) directory into a new directory so that the folder containing the final `.jar` file does not contain the those files.
## Task classes
- An aggregate task (https://docs.gradle.org/current/userguide/java_plugin.html#sec:java_plugin_and_dependency_management)
- Marks that the byte code generation phase is already finished.
## Task jar
- Compiles all of the generated `.class` files and their resources; assembles them and create a final executable `.jar` file.
## Task compileTestJava
- Directly compiles the test source code.
- The official documentation <mark style="background: #e4e62d;">ignores</mark> the byte code generation and compilation phase.
> [!Note]
> Ignore does not mean not including


## Task processTestResources
- Identical to [Task processResources](#Task%20processResources) but this task processes test resources only.
## Task testClasses
- An aggregate task.
- Marks that the test byte code generation is already finished.
## Task test
- Run unit tests using JUnit or TestNG.
## Task check
- An aggregate task.
- Can be used to check the testing coverage.

# Dependency configuration
- Define the <mark style="background: #e4e62d;">scope</mark> of a specific dependency - when the dependency is needed:
	- compile time $\implies$ static checking $\implies$ pass when writing code but not apply when running the final `.jar` file.
	- run time $\implies$ being executed $\implies$ apply for third-party API (include their `.jar` file).
	- test $\implies$ unit test.
## implementation
- Compile time and run time.
## compileOnly
- Only compile time.
## runtimeOnly
- Only run time.
## testImplementation
- Extends `implementation`.
- Both compile time and run time for test.
## testCompileOnly
- Only compile time for test.
## testRuntimeOnly
- Extends `runtimeOnly`
- Only run time for test.
## annotationProcessor
- Processes annotations - beans during run time.
- Refers to [Incremental annotation processing](#Incremental%20annotation%20processing)
# Incremental annotation processing
- Since Gradle 4.7,  compiler supports incremental annotation processing to <mark style="background: #e4e62d;">minimize a full recompilation</mark> (similar to Just-In-Time Compiler):
	- Only recompiles when the `.class` files change.
	- Annotation are equivalent to a dependency injection $\implies$ minimize recompilation $\equiv$ minimize executable file redeployment.
- Popular annotation third-parties may require both `implementation` and `annotationProcessor` to avoid recompilation.
```kotlin
dependencies {
    // The dagger compiler and its transitive dependencies will only be found on annotation processing classpath
    annotationProcessor("com.google.dagger:dagger-compiler:2.44")

    // And we still need the Dagger library on the compile classpath itself
    implementation("com.google.dagger:dagger:2.44")
}
```
# Example
```kotlin
plugins {  
  java  
  id("io.quarkus")  
  id("io.swagger.core.v3.swagger-gradle-plugin") version "2.2.22"  
}  
  
repositories {  
  mavenCentral()  
  mavenLocal()  
}  
  
val quarkusPlatformGroupId: String by project  
val quarkusPlatformArtifactId: String by project  
val quarkusPlatformVersion: String by project  
  
dependencies {  
  implementation("io.quarkus:quarkus-security-jpa")  
  implementation("io.quarkus:quarkus-smallrye-jwt")  
  implementation("io.quarkus:quarkus-smallrye-jwt-build")  
  implementation("io.quarkus:quarkus-container-image-docker")  
  implementation(enforcedPlatform("${quarkusPlatformGroupId}:${quarkusPlatformArtifactId}:${quarkusPlatformVersion}"))  
  implementation("io.quarkus:quarkus-rest")  
  implementation("io.quarkus:quarkus-rest-jackson")  
  implementation("io.quarkus:quarkus-arc")  
  implementation("io.quarkus:quarkus-jdbc-postgresql")  
  implementation("io.quarkus:quarkus-smallrye-openapi")  
  implementation("io.quarkus:quarkus-hibernate-orm")  
  implementation("io.quarkus:quarkus-hibernate-validator")  
  
  compileOnly("org.projectlombok:lombok:1.18.34")  
  annotationProcessor("org.projectlombok:lombok:1.18.34")  
  
  implementation("org.mapstruct:mapstruct:1.6.0")  
  annotationProcessor("org.mapstruct:mapstruct-processor:1.6.0")  
  
  
  testImplementation("io.quarkus:quarkus-junit5")  
  testImplementation("io.rest-assured:rest-assured")  
  testImplementation("org.projectlombok:lombok:1.18.34")  
  testImplementation("io.quarkus:quarkus-junit5-mockito")  
}  
  
group = "org.hr"  
version = "1.0-SNAPSHOT"  
  
java {  
  sourceCompatibility = JavaVersion.VERSION_21  
  targetCompatibility = JavaVersion.VERSION_21  
}  
  
tasks.withType<Test> {  
  systemProperty("java.util.logging.manager", "org.jboss.logmanager.LogManager")  
}  
tasks.withType<JavaCompile> {  
  options.encoding = "UTF-8"  
  options.compilerArgs.add("-parameters")  
}
```

---
# References
1. https://docs.gradle.org/current/userguide/java_plugin.html#sec:java_plugin_and_dependency_management for task lifecycle.
2. https://docs.gradle.org/current/userguide/tutorial_using_tasks.html for task dependecy Gradle.
3. https://docs.gradle.org/current/userguide/java_plugin.html#sec:java_plugin_and_dependency_management for incremental annotation processing.


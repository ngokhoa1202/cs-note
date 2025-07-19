#software-engineering  #software-architecture #dependency-manager #ci-cd #gradle #java #jakarta-ee #spring  
#spring-boot #quarkus #operating-system #ubuntu #windows #configuration #installation #scripting 

# Purpose
- Define the dependencies during the project build.
- For modernity, Kotlin DSL (Domain-Specific Language) is chosen to support Gradle.
- ![800](Pasted%20image%2020240809153503.png)
# Gradle project architecture
```
project
├── gradle                              
│   ├── libs.versions.toml              
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew                             
├── gradlew.bat                         
├── settings.gradle(.kts)               
├── subproject-a
│   ├── build.gradle(.kts)              
│   └── src                             
└── subproject-b
    ├── build.gradle(.kts)              
    └── src                             
```

## Gradle directory
- Stores version metadata and built gradle wrapper `.jar` file.
- ![](Pasted%20image%2020240919094936.png)
### lib.versions.toml
- Specify versions so that plugins can index that version on the central repository for downloading.
### gradle-wrapper.jar
- Built-and-packaged Gradle wrapper binary file
- Install Gradle version if uninstalled.
### gradle-wrapper.properties
- Includes the metadata for the current Gradle being used.
```properties
distributionBase=GRADLE_USER_HOME  
distributionPath=wrapper/dists  
distributionUrl=https\://services.gradle.org/distributions/gradle-8.8-bin.zip  
zipStoreBase=GRADLE_USER_HOME  
zipStorePath=wrapper/dists
```

## gradlew(.bat)
- `gradlew` and `gradlew` stores built-in gradle scripts (like `.sh` file):
	- `gradlew`: Unix-based OS.
	- `gradlew.bat`: Windows.
- In order to build a `gradle` project, there are 2 ways:
	- Directly use `gradle` command (must be installed in advanced). `gradle build`
	- Use `gradlew` wrapper script files pre-installed by the IDE (IntelliJ,...). `./<project-dir>/gradlew build`
## Setting.gradle(.kts)
- Defines the metadata for the <mark style="background: #e4e62d;">main project</mark> and its child projects if exists.
```kotlin
pluginManagement {  
    val quarkusPluginVersion: String by settings  
    val quarkusPluginId: String by settings  
    repositories {  
        mavenCentral()  
        gradlePluginPortal()  
        mavenLocal()  
    }  
    plugins {  
        id(quarkusPluginId) version quarkusPluginVersion  
    }  
}  
rootProject.name="human-resource"
```
## Build.gradle(.kts)
- Define the <mark style="background: #e4e62d;">third-party dependencies</mark> (or simply API) needed to develop the main project.

- Refers to [Gradle tasks](Gradle%20tasks.md) for specific task APIs.
--- 
# References
1. https://docs.gradle.org/current/userguide/gradle_basics.html#gradle for gradle official documentation about project architecture.
2. https://docs.gradle.org/current/userguide/gradle_wrapper_basics.html#gradle_wrapper_basics for gradle wrapper.
3. https://gradle.org/install/ for gradle installation.
4. https://docs.gradle.org/current/userguide/building_java_projects.html#sec:building_java_enterprise_apps for building Gradle for Java application guideline.
5. [Gradle tasks](Gradle%20tasks.md) for Java plugin API to build Gradle project.
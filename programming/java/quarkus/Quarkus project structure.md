#software-engineering #software-architecture #quarkus #java #software-testing #solid 

# Project structure
```tree title='Quarkus project structure'
quarkus-project/
│── src/
│   ├── main/
│   │   ├── java/com/example/
│   │   │   ├── Application.java
│   │   │   ├── resources/
│   │   │   │   ├── GreetingResource.java
│   │   │   │   ├── service/
│   │   │   │   │   ├── GreetingService.java
│   │   │   │   ├── repository/
│   │   │   │   │   ├── UserRepository.java
│   │   │   │   ├── entity/
│   │   │   │   │   ├── User.java
│   │   │   │   ├── dto/
│   │   │   │   │   ├── UserDTO.java
│   │   │   ├── grpc/
│   │   │   │   ├── UserGrpcService.java
│   │   ├── resources/
│   │   │   ├── application.properties
│   │   │   ├── import.sql
│   │   │   ├── META-INF/
│   │   │   │   ├── persistence.xml  (If using JPA)
│   │   ├── docker/
│   │   │   ├── Dockerfile.jvm
│   │   │   ├── Dockerfile.native
│   ├── test/
│   │   ├── java/com/example/
│   │   │   ├── GreetingResourceTest.java
│   │   │   ├── GreetingServiceTest.java
│── target/  (Generated build output)
│── pom.xml  (Maven)
│── build.gradle.kts (Gradle, if using Kotlin DSL)
│── gradlew / gradlew.bat  (Gradle wrapper)
│── mvnw / mvnw.cmd  (Maven wrapper)
│── README.md
│── .gitignore
│── .dockerignore
```


# References
1. https://quarkus.io/guides/getting-started
2. 
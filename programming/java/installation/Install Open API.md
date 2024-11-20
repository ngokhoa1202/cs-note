#maven #spring-boot  #spring #open-api #api #restful  #installation  #swagger 

# Set up Open API
- Add dependency in `pom.xml` file
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.5.0</version>
</dependency>
```

- Configure docs path:
```bash
springdoc.api-docs.path=/api-docs
```

# Swagger UI
- OpenAPI 3.0 ifself includes Swagger UI, so we don't have to install `swagger-ui` dependency. Access at `/swagger-ui/index.html`
```url
http://localhost:8080/swagger-ui/index.html
```

- Configure swagger ui path:
```bash
springdoc.swagger-ui.path=/swagger-ui-custom.html
```

--- 
# References
1. https://www.baeldung.com/spring-rest-openapi-documentation for setting OpenAPI Spring.
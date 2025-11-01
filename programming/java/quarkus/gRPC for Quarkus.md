#java #quarkus #rpc #grpc #operating-system #computer-network #application-layer #google #cloud #transport-layer #software-engineering  #software-architecture #jakarta-ee #microservice #proxy-server 

# Quarkus gRPC architecture
- ![](gRPC.drawio.png)
- https://drive.google.com/file/d/1LR3gMJJW-HNo8pNfR3pCCbyI5-NiJnT8/view?usp=sharing
- 
# Quarkus gRPC implementation
## Required dependencies
- In your `build.gradle` (`.kts`), specify `quarkus-grpc`
```kotlin
implementation("${quarkusPluginId}:quarkus-grpc")
```

## Protobuf files
- The `.proto` files must be in the directory `proto` which is in the same level as `java` directory.
- ![](Pasted%20image%2020241018150217.png)
- Examples:
```protobuf
syntax = "proto3";  
  
option java_multiple_files = true;  
option java_package = "org.gateway.service.authentication";  
option java_outer_classname = "AuthenticationProto";  
  
import "google/protobuf/empty.proto";  
  
package security;  
  
service AuthenticationGrpcService {  
  rpc Login (UserLoginProto) returns (JwtProto) {}  
  rpc CreateUser (UserPayloadProto) returns (UserResponseProto) {}  
  rpc GetUser(UserIdProto) returns (UserResponseProto) {}  
}  
  
message UserLoginProto {  
  string username = 1;  
  string password = 2;  
}  
  
message JwtProto {  
  string token = 1;  
}  
  
message UserPayloadProto {  
  
  message RolePlainProto {  
    int32 id = 1;  
    string name = 2;  
  }  
  
  string username = 1;  
  string password = 2;  
  string email = 3;  
  RolePlainProto rolePlainProto = 4;  
}  
  
message UserResponseProto {  
  message RolePlainProto {  
    int32 id = 1;  
    string name = 2;  
  }  
  
  string id = 1;  
  string username = 2;  
  string password = 3;  
  string email = 4;  
  RolePlainProto rolePlainProto = 5;  
}  
  
message UserIdProto {  
  string id = 1;  
}
```

- These `.proto` files will end up being generated into `.class` files in `build` directory. Run `./gradlew assemble` or `./gradlew classes` to generate these classes at first to avoid annoying syntax errors.

> [!Important]
> For the time being, `.proto` files do not support mutual importation. As a result, if you want to import file `a.proto` which has imported file `b.proto`, then you must define a nested message instead or else encounter an error.

## gRPC client
### Resource layer - gateway
- On client side, you have to define a resource layer to listens to HTTP requests and convert them to gRPC messages in case a `StatusRunTimeException` is thrown.
```java
package org.gateway.resource.security;  
  
  
import io.grpc.StatusRuntimeException;  
import jakarta.annotation.security.RolesAllowed;  
import jakarta.ws.rs.*;  
import jakarta.ws.rs.core.MediaType;  
import lombok.RequiredArgsConstructor;  
import org.gateway.dto.token.JwtDto;  
import org.gateway.dto.user.UserLoginDto;  
import org.eclipse.microprofile.openapi.annotations.parameters.RequestBody;  
import org.gateway.dto.user.UserResponseDto;  
import org.gateway.exception.handler.ExceptionHandler;  
import org.gateway.exception.GatewayException;  
import org.gateway.service.security.AuthenticationService;  
import org.jboss.resteasy.reactive.RestPath;  
import org.jboss.resteasy.reactive.RestResponse;  
  
import java.util.UUID;  
  
  
@Path("security")  
@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})  
@Consumes({MediaType.APPLICATION_JSON})  
@RequiredArgsConstructor  
public class AuthenticationResource {  
  
  private final AuthenticationService authenticationService;  
  
  private final ExceptionHandler exceptionHandler;  
  
  @POST  
  @Path(value = "login")  
  public RestResponse<JwtDto> login(@RequestBody UserLoginDto userLoginDto) throws GatewayException {  
    try {  
      JwtDto jwtDto = this.authenticationService.login(userLoginDto);  
      return RestResponse.ok(jwtDto);  
    } catch (StatusRuntimeException exception) {  
      throw this.exceptionHandler.convert(exception);  
    }  
  }  
}
```

- In previous section [gRPC client](#gRPC%20client), you only have to add `@GrpcClient("service-name")` to inject a gRPC client. 
- By default, Quarkus supports non-blocking gRPC via Mutiny API. However, the default gRPC API can behave differently.
### gRPC-to-HTTP exception conversion
- Because gRPC protocol does not allow to propagate the callee's exception to the caller, a <mark style="background: #e4e62d;">message in form of Json</mark> is employed to transfer exception object.
- The interface has only one method for conversion.
```java
package org.gateway.exception.handler;  
  
import io.grpc.StatusRuntimeException;  
import org.gateway.exception.GatewayException;  
  
public interface ExceptionHandler {  
  
  GatewayException convert(StatusRuntimeException exception);  
}
```
- Its implementation does three tasks:
	- Parse Json message to a Json node.
	- Map gRPC status to its equivalent HTTP status.
	- Instantiate a predefined generic exception from that Json node and HTTP Status.
### application.properties
- By default, Quarkus will use another port for gRPC request. You have to configure it if you want your RPC requests to stay on top of HTTP.
```bash
# gRPC client  
## Authentication grpc service  
quarkus.grpc.server.use-separate-server=false  
quarkus.grpc.clients.authenticationGrpcService.host=localhost  
quarkus.grpc.clients.authenticationGrpcService.port=7373  
quarkus.grpc.clients.authenticationGrpcService.use-quarkus-grpc-client=true  
## Department grpc service  
quarkus.grpc.clients.departmentGrpcService.host=localhost  
quarkus.grpc.clients.departmentGrpcService.port=7272  
quarkus.grpc.clients.departmentGrpcService.use-quarkus-grpc-client=true

# Cross Origin Resource Sharing - Cors policy  
quarkus.http.cors=true  
quarkus.http.cors.origins=http://localhost:7000,grpc://localhost:7000
```

## gRPC server
### gRPC service
- Implements your own service with `@GrpcService` annotation.
```java
package org.security.grpc;  
  
  
import io.grpc.stub.StreamObserver;  
import io.quarkus.grpc.GrpcService;  
import io.smallrye.mutiny.Uni;  
import io.smallrye.mutiny.infrastructure.Infrastructure;  
import io.smallrye.mutiny.unchecked.Unchecked;  
import jakarta.inject.Named;  
import lombok.RequiredArgsConstructor;  
import org.gateway.service.authentication.AuthenticationGrpcService;  
import org.gateway.service.authentication.AuthenticationGrpcServiceGrpc;  
import org.gateway.service.authentication.JwtProto;  
import org.gateway.service.authentication.UserLoginProto;  
import org.security.dto.token.JwtMapper;  
import org.security.dto.user.UserLoginDto;  
import org.security.dto.user.UserMapper;  
import org.security.exception.handler.ExceptionConverter;  
import org.security.exception.mapper.HumanResourceException;  
import org.security.service.AuthenticationService;  
  
@GrpcService  
@Named("AuthenticationGrpcServiceImpl")  
@RequiredArgsConstructor  
public class AuthenticationGrpcServiceImpl implements AuthenticationGrpcService {  
  
  private final AuthenticationService authenticationService;  
  private final ExceptionConverter exceptionConverter;  
  
  public Uni<JwtProto> login(UserLoginProto userLoginProto) throws HumanResourceException {  
    return Uni.createFrom().item(() -> {  
	    // wait for database query => I/O blocking
        UserLoginDto userLoginDto = UserMapper.INSTANCE.userLoginProtoToUserLoginDto(userLoginProto);  
        return this.authenticationService.login(userLoginDto);  
      })  
      // get a worker thread from thread pool and make it wait for database query
      .runSubscriptionOn(Infrastructure.getDefaultWorkerPool())  
      // whenever an object is successfully fired, handle it immediately
      .onItem().transform(JwtMapper.INSTANCE::jwtDtoToJwtProto); 
  }  
}
```

- By default, Quarkus Mutiny does not allow main thread to wait for I/O. In case blocking is inevitable, the method `runSubscriptionOn(Infrastructure.getDefaultWorkerPool())` is employed to retrieve a worker thread from the server thread pool for database access and help the caller thread avoid starvation.
### Manual exception
- For the reason that gRPC has its own exception throw handling mechanism, the manual application must not follow the conventional HTTP exception provider but instead <mark style="background: #e4e62d;">provider necessary properties in the superclass exception</mark>.
```java title:"Superclass exception"
package org.hr.exception;  
  
import io.quarkus.runtime.annotations.RegisterForReflection;  
import lombok.AllArgsConstructor;  
import lombok.Getter;  
import lombok.Setter;  
  
import java.time.LocalDateTime;  
  
@Getter  
@Setter  
@AllArgsConstructor  
@RegisterForReflection  
public sealed class HumanResourceException extends RuntimeException  
  permits DuplicateFieldException, EntityNotFoundException, InvalidRequestBodyException, InvalidFieldException,  
    UnauthorizedException {  
  private String field;  
  private String message;  
  private LocalDateTime timeStamp;  
}
```

```java title:"Subclass exception"
package org.hr.exception;  
  
  
import io.quarkus.runtime.annotations.RegisterForReflection;  
  
import java.time.LocalDateTime;  
  
@RegisterForReflection  
public final class DuplicateFieldException extends HumanResourceException {  
  
  public DuplicateFieldException(String fieldName) {  
    super(  
      fieldName,  
      String.format("The %s field has already existed", fieldName),  
      LocalDateTime.now()  
    );  
  }  
}
```
- These manual exceptions can be arbitrarily thrown in your service class.
```java title:"Application exception example"
package org.hr.employee.service;  
  
import jakarta.enterprise.context.ApplicationScoped;  
import jakarta.transaction.Transactional;  
import jakarta.validation.ConstraintViolationException;  
import jakarta.validation.Valid;  
import lombok.RequiredArgsConstructor;  
import org.hibernate.JDBCException;  
import org.hr.employee.dao.AssignmentDao;  
import org.hr.employee.dao.EmployeeDao;  
import org.hr.employee.dao.ProjectDao;  
import org.hr.employee.dto.employee.EmployeeMapper;  
import org.hr.employee.dto.project.ProjectMapper;  
import org.hr.employee.dto.project.assignment.AssignmentMapper;  
import org.hr.employee.dto.project.assignment.AssignmentPayloadDto;  
import org.hr.employee.dto.project.assignment.AssignmentResponseDto;  
import org.hr.employee.entity.Assignment;  
import org.hr.employee.entity.Employee;  
import org.hr.employee.entity.Project;  
import org.hr.exception.EntityNotFoundException;  
import org.hr.exception.InvalidRequestBodyException;  
  
@ApplicationScoped  
@RequiredArgsConstructor  
@Transactional  
public class AssignmentServiceImpl implements AssignmentService {  
  
  private final EmployeeDao employeeDAO;  
  private final AssignmentDao assignmentDAO;  
  private final ProjectDao projectDAO;  
  
  @Override  
  public AssignmentResponseDto getAssignment(Long id) throws EntityNotFoundException {  
    Assignment assignment = this.assignmentDAO.findById(id)  
      .orElseThrow(() -> new EntityNotFoundException("id", Assignment.class.getName()));  
    return AssignmentMapper.INSTANCE.assignmentToAssignmentResponseDto(assignment);  
  }
}
```

### application.properties
```bash
# gRPC server  
quarkus.grpc.server.use-separate-server=false  
quarkus.grpc.clients.authenticationGrpcService.use-quarkus-grpc-client=true  
quarkus.http.insecure-requests=enabled  
quarkus.grpc.clients.authenticationGrpcService.tls.enabled=false

# Cross Origin Resource Sharing - Cors policy  
quarkus.http.cors=true  
quarkus.http.cors.origins=http://localhost:7373,grpc://localhost:7373,grpc://localhost:7272
```

### gRPC exception customization
- The throw flow of gRPC exception is distinct from that of HTTP exception. The server must itself intercept the gRPC exception for customization before sending it to the client (https://quarkus.io/guides/grpc-service-implementation#server-interceptors).
- Whenever a predefined application exception is caught, it is transformed into a `StatusRuntimeException`.
- The exception cause is not allowed to propagate from server to client; as a result, a message in form of JSON is manually serialized into a string object.
```java title:"Exception message"
package org.hr.exception.grpc;  
  
import io.quarkus.runtime.annotations.RegisterForReflection;  
import org.hr.exception.HumanResourceException;  
  
import java.time.LocalDateTime;  
  
@RegisterForReflection  
public record ExceptionMessage(  
  String field,  
  String message,  
  LocalDateTime timeStamp  
) {  
  
  public static ExceptionMessage from(HumanResourceException exception) {  
    return new ExceptionMessage(  
      exception.getField(),  
      exception.getMessage(),  
      exception.getTimeStamp()  
    );  
  }  
}
```

```java title:"gRPC exception interceptor"
package org.hr.exception.grpc;  
  
import com.fasterxml.jackson.core.JsonProcessingException;  
import com.fasterxml.jackson.databind.ObjectMapper;  
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;  
import io.grpc.Metadata;  
import io.grpc.ServerCall;  
import io.grpc.Status;  
import io.grpc.StatusRuntimeException;  
import io.quarkus.grpc.ExceptionHandler;  
import io.quarkus.grpc.ExceptionHandlerProvider;  
import io.quarkus.logging.Log;  
import jakarta.enterprise.context.ApplicationScoped;  
import org.hr.exception.*;  
  
  
@ApplicationScoped  
public class HumanResourceProviderHandler implements ExceptionHandlerProvider {  
  
  @Override  
  public <ReqT, RespT> ExceptionHandler<ReqT, RespT> createHandler(  
    ServerCall.Listener<ReqT> listener, ServerCall<ReqT, RespT> serverCall, Metadata metadata  
  ) {  
    return new HumanResourceSecurityHandler<>(listener, serverCall, metadata);  
  }  
  
  
  @Override  
  public Throwable transform(Throwable t)  {  
    Log.infof("An exception has been thrown: %s", t.getMessage());  
    try {  
      if (! (t instanceof HumanResourceException)) {  
        return new StatusRuntimeException(Status.INTERNAL.withDescription("Cannot parse json"));  
      }  
  
      String exceptionJson = new ObjectMapper()  
        .registerModule(new JavaTimeModule())  
        .writer()  
        .withDefaultPrettyPrinter()  
        .writeValueAsString(ExceptionMessage.from((HumanResourceException) t));  
  
      switch (t) {  
        case EntityNotFoundException ex -> {  
          return new StatusRuntimeException(  
            Status.NOT_FOUND.withCause(ex).withDescription(exceptionJson)  
          );  
        }  
  
        case UnauthorizedException ex -> {  
          return new StatusRuntimeException(Status.PERMISSION_DENIED.withDescription(exceptionJson));  
        }  
  
        case DuplicateFieldException ex -> {  
          return new StatusRuntimeException(Status.ALREADY_EXISTS.withDescription(exceptionJson));  
        }  
  
        case InvalidFieldException ex -> {  
          return new StatusRuntimeException(Status.INVALID_ARGUMENT.withDescription(exceptionJson));  
        }  
  
        case InvalidRequestBodyException ex -> {  
          return new StatusRuntimeException(Status.INVALID_ARGUMENT.withDescription(exceptionJson));  
        }  
  
        default -> {  
          return new StatusRuntimeException(Status.UNIMPLEMENTED.withDescription(exceptionJson));  
        }  
      }  
    } catch (JsonProcessingException e) {  
      return new StatusRuntimeException(Status.INTERNAL.withDescription("Cannot parse json"));  
    }  
  
  }  
  
  private static class HumanResourceSecurityHandler<A, B> extends ExceptionHandler<A, B> {  
  
    public HumanResourceSecurityHandler(ServerCall.Listener<A> listener, ServerCall<A, B> call, Metadata metadata) {  
      super(listener, call, metadata);  
    }  
  
    @Override  
    protected void handleException(Throwable t, ServerCall<A, B> call, Metadata metadata) {  
      StatusRuntimeException statusRuntimeException = (StatusRuntimeException) ExceptionHandlerProvider.toStatusException(t, true);  
      Metadata trailers = (statusRuntimeException.getTrailers() != null) ? statusRuntimeException.getTrailers() : metadata;  
      call.close(statusRuntimeException.getStatus(), trailers);  
    }  
  }  
}
```


# References
1. *https://grpc.io/docs/languages/java/basics/ for gRPC official documentation.*
2. https://grpc.io/docs/what-is-grpc/core-concepts/ for gRPC architecture.
3. https://protobuf.dev/ for protobuffer official documentation.
4. *https://protobuf.dev/programming-guides/proto3/ for proto3 syntax.*
5. https://smallrye.io/smallrye-mutiny/latest/ for Mutiny official documentation.
6. *https://quarkus.io/guides/grpc-service-implementation for Quarkus gRPC guidelines.*
7. . Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 3: Processes.
		1. Section 3.8.2: Remote Procedure Calls.
8. https://drive.google.com/file/d/1LR3gMJJW-HNo8pNfR3pCCbyI5-NiJnT8/view?usp=sharing for full gRPC Quarkus architecture.
9. https://smallrye.io/smallrye-mutiny/latest/ for SmallRye reactive API.
10. https://quarkus.io/guides/grpc-service-implementation#server-interceptors for Quarkus gRPC server interceptors.
11. *https://github.com/smallrye/smallrye-mutiny/tree/main for SmallRye Mutiny official repository.*
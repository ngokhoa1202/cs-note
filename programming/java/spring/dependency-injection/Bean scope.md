#dependency-injection  #bean #spring  #spring-boot  #java #design-pattern 
#software-architecture #inversion-of-control  #metadata  #application-layer  
#http  #annotation 

- Use `@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)` to specify Bean scope after `@Bean` or `@Component`, `@Controller` annotation.
# Singleton scope
- Only a single object is instantiated per bean and per IoC Container (`ApplicationContext` container).
# Prototype scope
- A new object is instantiated for every required bean.
# Request scope
- A new object for the bean is instantiated for evert HTTP Request.
- Only used for Web.
# Session scope
- A new object for the bean is instantiated for every HTTP Session.
# WebSocket scope
- A new object for the bean is instantiated for every WebSocket.
# References
1. https://docs.spring.io/spring-framework/reference/core/beans/factory-scopes.html for official documentation.
2. 
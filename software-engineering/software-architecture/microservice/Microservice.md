
Over the years, after trials and errors, the technology evolved towards a new approach where an application is deployed and managed via a small set of services. Each service runs its own process and communicates with other services via lightweight mechanisms like REST APIs. Each of these services is independently deployed and managed. Technologies like containers and unikernels are becoming default choices for creating such services.

![Monolithic vs Microservices](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Monoliths-Microservices.png)
# Disadvantages
- Just like any other technology, there are also challenges and disadvantages to using microservices:

- _Choosing the right service size_ While refactoring the monolith application or creating microservices from scratch, it is very important to choose the right functionality for a service. For example, if we create a microservice for each function of a monolith, then we would end up with lots of small services, which would bring unnecessary complexity. 

- _Deployment_We can easily deploy a monolith application. However, to deploy a microservice, we need to use a distributed environment such as Kubernetes. 

- _Testing_ With lots of services and their interdependency, sometimes it becomes challenging to perform end-to-end testing of a microservice.  

- _Inter-service communication_ Inter-service communication can be very costly if it is not implemented correctly. There are options such as message passing or RPC, and we need to choose the one that fits our requirements and has the least overhead. 

- _Managing databases_ When it comes to the microservices' architecture, we may decide to implement a database local to a microservice. However, to close a business loop, changes may be required in other related databases as well, especially when a transaction needs to be persisted across many databases. This may add dependencies and complexity (e.g., partitioned databases). 

- _Monitoring and logging_ Monitoring individual services in a microservices environment can be challenging. This challenge is being addressed by specialized tools, such as [Elastic](https://www.elastic.co/), [Sysdig](https://sysdig.com/), or [Datadog](https://www.datadoghq.com/), designed to monitor, log, and help debug microservices-type applications scaled across distributed environments.

Even with the above challenges and drawbacks, deploying microservices is still an advantageous approach when applications are complex and continuously evolving.

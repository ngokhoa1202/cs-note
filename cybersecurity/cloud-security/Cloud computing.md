#cloud #cybersecurity #web #client-server #computer-network 


# Concepts
![](Pasted%20image%2020240513082725.png)
## Characteristics
- Broad network access => availability.
- Rapid elasticity => scalability.
- Measured service => dependable system (...).
- On-demand self-service => availability.
- ==Resource pooling== => availability + reliability + resilience + (security)?
## Service models
## Software as a Service - SaaS
- SaaS means a whole application.
- Examples:
	- Google Workspace.
	- Salesforce.
	- Microsoft Office 365.
## Platform as a Service - PaaS
- ==PaaS== means middleware and application which is on a deeper layer.
- Examples:
	- Microsoft Azure App Service.
	- Google App Engine.
	- Heroku.
	- AWS Elastic Beanstalk.
## Infrastructure as a Service - IaaS 
- ==IaaS== means physical storage ( or virtualized machine), network interfaces, middleware and application (almost everything).
- Examples:
	- Amazon Web Service EC2.
	- Microsoft Azure Virtual Machines.
	- Google Compute Engine.
	- IBM Cloud Virtual Servers.
## Deployment model
- ==Public== cloud => everyone can use.
- ==Community== cloud => who shares concerns.
- ==Private== cloud.
- Hybrid cloud => combine together.

# Reference architecture
![](Pasted%20image%2020240513085330.png)

# Security
## Multi-instance model vs Multi-tenant model
- ==Multi-instance model==: Each instance for each tenant runs in ==its own isolated environment==, with separate resources (such as databases, storage, and runtime environments).
- ==Multi-tenant model:== multiple users or tenants ==share a single instance== of the application or service => must have security mechanism such as: isolation...
## Three-tier Database architecture
![](Pasted%20image%2020240513093507.png)
- All records in cloud server must be encrypted before stored.
- The server itself does not own encryption key, the client with permission stores a copy of encryption key.
- Encryption means that some specific queries must be changed (e.g: encrypted data do not maintain ordering of number).
***
# References
1. 
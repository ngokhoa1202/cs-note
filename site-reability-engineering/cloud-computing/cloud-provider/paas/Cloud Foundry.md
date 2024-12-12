#paas #cloud #cloud  #software-engineering #software-architecture 

[Cloud Foundry](https://www.cloudfoundry.org/) (CF) is an open source Platform as a Service (PaaS) framework aimed at developers in large organizations, that is portable to any cloud, highly interoperable, has an architecture supporting any programming language, and integrates easily with various cloud and on-premises tools. In addition to supporting any type of application, it provides means for these applications to access external resources through application services gateway.

While CF can be deployed on-premises, it is recommended to install it on one of the supported [IaaS](https://www.cloudfoundry.org/the-foundry/#providers), such as Amazon AWS, Microsoft Azure, Google Cloud Platform (GCP), IBM Cloud, OpenStack, or VMware vSphere. Stable Cloud Foundry releases are also available through several certified commercial [distributions](https://www.cloudfoundry.org/the-foundry/#cert-distros) as well, such as Atos Cloud Foundry, Cloud.gov, SAP Cloud Platform, VMware Tanzu (formerly known as Pivotal Cloud Foundry), or others.

CF aims to address challenges faced by developers in large organizations through a collection of customized technologies. Popular core components such as the Cloud Foundry API, CF CLI, Korifi, Garden, Diego, Eirini, Paketo Buildpacks, Stratos UI, together with BOSH, Quarks, and a set of extensions such as the Open Service Broker API make up the Cloud Foundry platform.


# Feature
The following are key characteristics of Cloud Foundry:
- Application portability
- Application auto-scaling
- Application isolation
- Centralized platform management
- Centralized logging
- Dynamic routing
- Application health management
- Role-based application deployment
- Horizontal and vertical scaling
- Security
- Support for different IaaS platforms.
# Cloud Foundry BOSH
[Cloud Foundry BOSH](https://bosh.io/docs/) is an open source tool for release engineering, deployment, lifecycle management, and monitoring of complex distributed systems, enabling developers to easily version, package and deploy software in a reproducible manner.

BOSH aims to ease the process of building and administering consistently similar environments from development to staging and production. BOSH was designed to be the one tool to solve versioning, packaging, and reproducible software deployments as a whole, a collection of activities otherwise performed by tools such as Chef, Puppet, and Docker in various non-standard approaches. 

BOSH follows the four principles of release management:

- _identifiability_ of all components making up a release,
- _reproducibility_ of integration that guarantees operational stability,
- _consistency_ through a stable framework for development, deployment, audit and software components accountability, and
- _agility_ for software release automation according to software engineering best practices for Continuous Integration and Continuous Delivery.

BOSH can be installed on-premises on supported OSes such as several Linux distributions, macOS, and Windows. A popular on-premises hypervisor, VirtualBox is also supported. BOSH can be installed on supported IaaS providers as well, such as AWS, Microsoft Azure, GCP, IBM Cloud, OpenStack, VMware.

## cf push
A powerful feature of the Cloud Foundry platform is its command line interface (CLI) which allows users to interact with various components of the platform to manage infrastructure and application deployments. 

Applications can be pushed to Cloud Foundry through the **cf push** command, one of the many commands part of the cf CLI. This command is highly customizable; however, it can be easily run with default settings even by novice users of the Cloud Foundry platform. It supports popular programming languages such as Java, Node.js, Python, PHP, Go, Ruby, and .Net, but it can be extended to support additional languages and developer frameworks through community-developed buildpacks.

# Korifi
Current trends require applications to become lighter, faster, easier to share, secure, maintain, and manage. And most often these applications are designed to run in the cloud, whether on-premises, public, or hybrid, named cloud native applications. These application characteristics also reshape the application build models and tools that need to become cloud native themselves. While containers and <mark style="background: #e4e62d;">container orchestration</mark> concepts and tools will be discussed in later chapters, complex platforms such as Cloud Foundry can become cloud native as well. Converting CF into a cloud native tool is not an effortless process, however, the result is a CF project named Korifi. It is a CF offering redesigned from the ground up for another platform, Kubernetes, a popular container orchestrator.

The [Korifi](https://www.cloudfoundry.org/technology/korifi/) project aims to abstract CF components and dependency configuration, enabling the developer to focus on building applications. This further helps to widen the environment options where CF can be deployed, as containers and container orchestrators are platforms supported by a large array of cloud services, IaaS, and certified solution providers.

## Benefit
Key benefits of using Cloud Foundry are:

- It is an open source platform, but there are also many commercial Cloud Foundry providers. 
- It offers centralized platform management.
- It enables horizontal and vertical scaling.
- It provides infrastructure security.
- It provides multi-tenant compute efficiency.
- It offers support for multiple IaaS providers.
- It supports the full application lifecycle: development, testing, and deployment, thus enabling a continuous delivery strategy. It also provides integration with CI/CD tools.
- It allows for application virtualization using containers for application isolation.
- It leverages Kubernetes' workload management capabilities to optimize application deployments in containers. 
- It is a flexible solution, supported by an extensive community of developers.
- It reduces the chance of human errors.
- It is cost-effective, reducing the overhead for Ops teams.


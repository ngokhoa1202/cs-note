#cloud #iaas #software-engineering #operating-system #linux #windows #virtualization 

[Heroku](http://www.heroku.com) is a fully-managed container-based cloud platform with integrated data services and a strong ecosystem. Heroku is used to deploy and run enterprise level modern applications, and it is a [Salesforce](https://www.salesforce.com) company.

Heroku offers multiple products; however, its core remains the [Heroku Platform](https://www.heroku.com/platform), a PaaS solution used to deploy large scale applications. The Heroku Platform supports the following popular languages and frameworks:

- NodeJs
- Ruby
- Python
- Go
- PHP
- Clojure
- Scala
- Java

However, it can be easily extended to other languages and frameworks through custom [buildpacks](https://elements.heroku.com/buildpacks).

# Heroku core concepts
Heroku sets itself apart from other PaaS offerings by introducing a unique workflow for users to follow; hence a strict Heroku-centric development and deployment workflow needs to be followed once the decision has been made to use Heroku. However, the workflow aims to be developer-friendly. Below are several core concepts of the workflow:

- Applications should contain the source code, its dependency information, and the list of named commands to be executed when deployed in a file called **[Procfile](https://devcenter.heroku.com/articles/procfile).**
- For each supported language, it has a pre-built image which contains a compiler for that language. This pre-built image is referred to as a [buildpack](https://devcenter.heroku.com/articles/buildpacks). [Multiple buildpacks](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app) can be used together. We can also create a custom buildpack.
- While deploying, we need to send the application's content to Heroku, either via Git, GitHub, or via an API. Once the application is received by Heroku, a buildpack is selected based on the language of preference.
- To create the runtime which is ready for execution, we compile the application after fetching its dependency and configuration variables on the selected buildpack. This runtime is often referred to as a [slug](https://devcenter.heroku.com/articles/slug-compiler).
- We can also use third-party [add-ons](https://elements.heroku.com/addons) to enable access to value-added services like logging, caching, monitoring, etc.
- A combination of slug, configuration variables, and add-ons is referred to as a release, on which we can perform upgrade or rollback.
- Depending on the process-type declaration in the **Procfile**, a virtualized UNIX container is created to serve the process in an isolated environment, which can be scaled up or down, based on the requirements. Each virtualized UNIX container is referred to as a [dyno](https://devcenter.heroku.com/articles/dynos). Each dyno gets its own ephemeral storage.
- Dyno Manager manages dynos across all applications running on Heroku.

# Features
The Heroku Platform allows users to deploy, run, and manage applications written in multiple programming languages or frameworks, from source code that may also include dependencies. 

By encapsulating the application in a dyno, which is a lightweight and secure container, the application can be scaled based on demand.

Application configuration can be decoupled from the application source code, allowing for application customization based on the environment where the application is deployed. Configuration customization is achieved through [config vars](https://devcenter.heroku.com/articles/config-vars), which combined with the application slug, produce a [release](https://devcenter.heroku.com/articles/releases).

It is a very rich ecosystem, and it allows us to extend the functionality of an application with [add-ons](https://devcenter.heroku.com/articles/add-ons) available in the [Elements Marketplace](https://elements.heroku.com/addons). Add-ons allow us to easily integrate our applications with other fully-managed cloud services such as storage, database, monitoring, logging, pipelines, email, message queue, security, and networking.

Applications deployed on the Heroku Platform can be easily integrated with Salesforce.

# Benefits
Key benefits of using the Heroku platform are:

- It enables a development-friendly workflow.
- It provides a rich ecosystem, allowing you to extend the functionality through add-ons.
- It supports Continuous Integration and Continuous Delivery pipelines.
- It is easy to start and allows us to quickly scale our applications, both horizontally and vertically. 
- It provides the ability to automate backups.
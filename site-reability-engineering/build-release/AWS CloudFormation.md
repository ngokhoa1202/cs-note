

[CloudFormation](https://aws.amazon.com/cloudformation/) is a tool that allows us to define our infrastructure as code on Amazon AWS. This helps us treat our AWS infrastructure as software. The configuration files can be written in YAML or JSON format, while CloudFormation can also be used from a web console or from the command line.

# Features
AWS CloudFormation provides an easy method to create and manage resources on AWS, adding order and predictability to the provisioning and updating processes. CloudFormation uses templates to describe the AWS resources and dependencies needed to run applications. It also allows for resources to be modified and updated while applying version control to the AWS infrastructure, similar to software version control.

CloudFormation presents the following features:

- _Extensibility_  
    It supports the modeling, provisioning, and management of third-party app resources through [AWS CloudFormation Registry](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry.html) for monitoring, incident management, and version control.
- _Authoring with JSON or YAML_  
    To model the infrastructure and describe resources in a text file. The CloudFormation Designer helps with visual design when required.  
- _Authoring with programming languages_  
    Through AWS Cloud Development Kit (AWS CDK) it supports TypeScript, Python, Java, and .Net to model cloud applications, integrated with CloudFormation for infrastructure provisioning.
- _Safety controls_  
    It provides Rollback Triggers to safely roll back to a prior state.
- _Preview environment changes_  
    To model the possible impact of the proposed changes to any of the existing resources.
- _Dependency management_  
    Determines actions sequence during stack operations.
- _Cross-account and cross-region management_  
    Allowed from a single template, called StackSet.
# Example
Let's illustrate how the AWS infrastructure state is managed by CloudFormation.

_**NOTE**: The commands in the following set of screenshots may produce slightly different outputs on your system as the AWS CLI features may change without notice._

The AWS CloudFormation has a web interface, the Designer. However, the AWS CLI is presented below. The AWS CLI is used in this illustration to provision an EC2 instance on the AWS platform, configured to run a webserver. A cloudformation template file needs to be created, that declares the infrastructure resources to be provisioned.

![$ aws cloudformation validate-template --template-body](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__aws_cloudformation_validate-template_--template-body.png)

The template should be validated prior to creating the resource stack declared by the template. While the stack ID is created and returned quickly by the CLI, the EC2 instance takes a little longer to become ready, and for the webserver application to become operational.

![$ aws cloudformation create-stack](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__aws_cloudformation_create-stack.png)

The IP address of the EC2 instance can be retrieved once it becomes ready, otherwise the returned **“Exports”** will be empty.

![$ aws cloudformation list-exports](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__aws_cloudformation_list-exports.png)

The AWS EC2 Dashboard confirms the public IP address of the instance.

![The AWS EC2 Dashboard confirms the public IP address of the instance](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_AWS_EC2_Dashboard_confirms_the_public_IP_address_of_the_instance.png)

The public IP is then entered in the browser’s address bar to display the contents of the webpage.

![Welcome to AWS CloudFormation](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Welcome_to_AWS_CloudFormation.png)

The stack resources can be easily deleted when they are no longer required.

![$ aws cloudformation delete-stack](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__aws_cloudformation_delete-stack.png)


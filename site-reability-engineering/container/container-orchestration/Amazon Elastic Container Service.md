

[Amazon Elastic Container Service](https://aws.amazon.com/ecs/) (ECS) is part of the Amazon Web Services (AWS) offerings. It is a fully managed containers orchestration service that is fast, secure, and highly scalable, making it easy to run, stop and manage containers on a cluster.

Based on the desired infrastructure expected to host the running containers, it can be configured in the following launch modes:

**Fargate Launch Type**  
AWS Fargate allows us to run containers without managing servers and clusters. In this mode, we just have to package our applications in containers along with CPU, memory, networking, and IAM policies. We don't have to provision, configure, and scale clusters of virtual machines to run containers, as AWS will take care of it for us.

![Fargate Launch Type](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/aws-ecs-overview-fargate.png)

**Fargate Launch Type**  
(retrieved from [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html))

**EC2 Launch Type  
**With the EC2 launch type, we can provision, patch, and scale the ECS cluster. This gives more control to our servers and provides a range of customization options.

![EC2 Launch Type](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/EC2_Launch_Type.png)

**EC2 Launch Type**  
(retrieved from [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html))

**External Launch Type**  
- The External launch type enables us to run containerized applications on-premises, on our own physical/virtual infrastructure with the help of the [Amazon ECS Anywhere](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-anywhere.html) service. Amazon ECS Anywhere, or External Instances, allows for the on-premises infrastructure to be registered and appended as external instances to our public cloud infrastructure.

# Components
Key components of Amazon ECS are:

- _Cluster_   
    It is a logical grouping of tasks or services. With the EC2 launch type, a cluster is also a grouping of container instances.
- _Container Instance_  
    It is only applicable if we use the EC2 launch type. We define the Amazon EC2 instance to become part of the ECS cluster and to run the container workload.
- _Container Agent_  
    It is only applicable if we use the Fargate launch type. It allows container instances to connect to your cluster.
- _Task Definition_  
    It specifies the blueprint of an application, which consists of one or more containers. Below, you can see an example of a sample task definition file (from [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/example_task_definitions.html)):
```json
{
"containerDefinitions": [
  {
    "name": "wordpress",
    "links": [
      "mysql"
    ],
    "image": "wordpress",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 500,
    "cpu": 10
  },
  {
    "environment": [
      {
        "name": "MYSQL_ROOT_PASSWORD",
        "value": "password"
      }
    ],
    "name": "mysql",
    "image": "mysql",
    "cpu": 10,
    "memory": 500,
    "essential": true
  }
],
	"family": "hello_world"
}
```


- _Scheduler_   
    It places tasks on the cluster.
- _Service_  
    It allows one or more instances of tasks to run, depending on the task definition. Below you can see the template of a service definition (from [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_parameters.html)). If there is an unhealthy task, then the service restarts it. One elastic load balancer (ELB) is attached to each service.
- _Task_  
    It is a running container instance from the task definition.
- _Container_  
    It is a container created from the task definition.
# Features
Key features of Amazon ECS are:

- It is compatible with Docker containers and Windows containers as well.
- It provides a managed cluster so that users do not have to worry about managing and scaling the cluster.
- The task definition allows the user to define the applications through a JSON file. Shared data volumes, as well as resource constraints for memory and CPU, can also be defined in the same file.
- It provides APIs to manage clusters, tasks, etc.
- It allows easy updates of containers to new versions.
- The monitoring feature is available through AWS CloudWatch.
- The logging facility is available through AWS CloudTrail.
- It supports third-party hosted Docker registries, the public Docker Hub, or the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/) (ECR).
- AWS Fargate allows you to run and manage containers without having to provision or manage servers.
- It allows you to build all types of containers. You can build a long-running service or a batch service in a container and run it on ECS.
- You can apply your Amazon Virtual Private Cloud (VPC), security groups, and AWS Identity and Access Management (IAM) roles to the containers, which helps maintain a secure environment.
- You can run containers across multiple availability zones within regions to maintain High Availability.
- It can be integrated with AWS services like Elastic Load Balancing (ELB), Virtual Private Cloud (VPC), Identity and Access Management (IAM), Amazon ECR, AWS Batch, Amazon CloudWatch, AWS CloudFormation, AWS CodeStar, AWS CloudTrail, and more.
# Benefits
Key benefits of Amazon ECS are:

- It provides a managed cluster on a public, private, or hybrid cloud.
- It is built on top of Amazon Elastic Compute Cloud (EC2).
- It is highly available and scalable.
- It leverages other AWS services, such as CloudWatch Metrics.
- We can manage it using CLI, Dashboard, or APIs.
# References

[HashiCorp Nomad](https://www.nomadproject.io/) is a cluster manager and resource scheduler from [HashiCorp](https://www.hashicorp.com/), which is distributed, highly available, and scales to thousands of nodes. It is designed to run microservices and batch jobs, and it supports different types of workloads, from Docker containers, VMs, to individual Java applications. In addition, it is capable of scheduling applications and services on different platforms like Linux, Windows, and Mac, both on-premises and public clouds.

Although an alternative to the Kubernetes container orchestrator, it can run in conjunction with Kubernetes in a multi-orchestrator pattern, complementing each other especially in large enterprises where multiple types of applications need to be deployed and managed on diverse infrastructures through mixed scheduling mechanisms.  

It is distributed as a single binary, which has all of its dependency and runs in a _server_ and _client_ mode. To submit a job, the user has to define it using a declarative language called [HashiCorp Configuration Language](https://github.com/hashicorp/hcl) (HCL) with its resource requirements. Once submitted, Nomad will find available resources in the cluster and run it to maximize resource utilization.

Below we provide a sample job file:

```nomad

# Define the hashicorp/web/frontend job**
job "hashicorp/web/frontend" {

    # Job should run in the "us" region  
    region = "us"

    # Run in two datacenters**

    datacenters = ["us-west-1", "us-east-1"]**

    # Only run workload on linux**

    constraint {  
        attribute = "$attr.kernel.name"  
        value = "linux"  
    }
    
    # Configure the job for rolling updates  
    update {  
        # Stagger updates every 30 seconds  
        stagger = "30s"

        **# Update a single task at a time  
        max_parallel = 1  
    }

    # Define the task group together with an individual task (unit of work)  
    group "frontend" {  
        # Ensure we have enough servers to handle traffic  
        count = 10

        task "web" {  
			# Use Docker to run our server  
			driver = "docker"  
			config {  
					image = "hashicorp/web-frontend:latest"  
			}

			# Specify resource limits  
			resources {  
				cpu = 500  
				memory = 128  
				network {  
					mbits = 10  
					dynamic_ports = ["http"]  
				}  
			}  
        }  
    }    
}
```

which would use 10 containers from the **hashicorp/web-frontend:latest** Docker image.

# Feature
The following are some of Nomad's key characteristics:

- It handles both cluster management and resource scheduling.
- It supports multiple workloads, like Docker containers, VMs, uni-kernels, and individual Java applications.
- It has multi-datacenter and multi-region support. We can have a Nomad _client_/_server_ running in different public clouds, while still part of the same logical Nomad _cluster_.
- It bin-packs applications onto servers to achieve high resource utilization.
- In Nomad, millions of containers can be deployed or upgraded by using the **job** file.
- It provides a built-in dry run execution facility, which shows the scheduling actions that are going to take place.
- It ensures that applications are running in _failure_ scenarios.
- It supports long-running services, as well as batch jobs and cron jobs.
- It provides a built-in mechanism for rolling upgrades.
- It can run in conjunction with Kubernetes in a multi-orchestrator pattern.
- It seamlessly integrates with Terraform, Consul, and Vault for provisioning, networking, and sensitive data management.
- Blue-green and canary deployments are supported through a declarative job file syntax.
- If nodes fail, Nomad automatically redistributes the applications from unhealthy nodes to healthy nodes.
# Benefits of Using Nomad
Key benefits of using Nomad are: 
- It is an open source solution that is distributed as a single binary for _servers_ and _agents_. 
- It is highly available and scalable. 
- It maximizes resource utilization. 
- It provides multi-datacenter and multi-region support. 
- It supports multi-cloud federation. 
- During maintenance, there is zero downtime to datacenter and services. 
- It simplifies operations, provides flexible workloads, and fast deployment. 
- It can integrate with the entire HashiCorp ecosystem of tools such as Terraform, Consul, and Vault for provisioning, service discovery, and secrets management. 
- It can support a cluster larger than ten thousand nodes.
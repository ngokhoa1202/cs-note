
# Introduction
[Terraform](https://www.terraform.io/) is a tool that allows us to define the infrastructure as code. This helps us deploy the same infrastructure on Virtual Machines, bare metal, or cloud. It helps us treat the infrastructure as software. The configuration files can be written in [HashiCorp Configuration Language](https://github.com/hashicorp/hcl) (HCL).

[HashiCorp](https://www.hashicorp.com/), the organization that created Terraform, has introduced Terraform Cloud and Terraform Enterprise. Both offerings enable collaboration among professionals and teams.

# Providers
Physical machines, VMs, network switches, or containers are treated as resources, which are exposed by providers.

A provider is responsible for understanding API interactions and exposing resources, which makes Terraform agnostic to the underlying platforms. A custom provider can be created through plugins.

Terraform has _[providers](https://www.terraform.io/docs/providers/index.html)_ in different stacks:

- IaaS: AWS, DigitalOcean, GCP, OpenStack, Azure, Alibaba Cloud, etc.
- PaaS: Heroku, Cloud Foundry, etc.
- SaaS: DNSimple, etc.

# Features
According to the [Terraform website](https://www.terraform.io/intro/index.html), it has the following "_key features:_

- _Infrastructure as Code: Infrastructure is described using a high-level configuration syntax. This allows a blueprint of your datacenter to be versioned and treated as you would any other code. Additionally, infrastructure can be shared and re-used._
- _Execution Plans: Terraform has a "planning" step where it generates an execution plan. The execution plan shows what Terraform will do when you call apply. This lets you avoid any surprises when Terraform manipulates infrastructure._
- _Resource Graph: Terraform builds a graph of all your resources, and parallelizes the creation and modification of any non-dependent resources. Because of this, Terraform builds infrastructure as efficiently as possible, and operators get insight into dependencies in their infrastructure._
- _Change Automation__: Complex changesets can be applied to your infrastructure with minimal human interaction. With the previously mentioned execution plan and resource graph, you know exactly what Terraform will change and in what order, avoiding many possible human errors_".

# Example
The Terraform CLI is used in this illustration to provision a GCE instance on the Google Cloud Platform, configured to run a webserver. Two distinct Terraform specific files need to be created. The **main.tf** that declares the infrastructure resources to be provisioned.

![$ cat main.tf](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__cat_main.tf..png)

The second file, **outputs.tf**, formats the output returned at the end of the provisioning phase, the URL to the webserver.

![$ cat outputs.tf](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__cat_outputs.tf..png)

The first command, initializes the plugins that are necessary to provision the Google Cloud resources.

![$ ./terraform init](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__._terraform_init.png)

The second command performs a dry run.

![$ ./terraform plan](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__._terraform_plan.png)

While the third command applies the declared configuration, the desired resources are provisioned by the Google Cloud Platform.

![$ ./terraform apply](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__._terraform_apply.png)

However, at the prompt a “yes” is required for confirmation.

![Do you want to perform these actions?](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Do_you_want_to_perform_these_actions_.png)

At the end of the provisioning phase, the URL of the webserver is displayed.

![The URL of the webserver is displayed](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_URL_of_the_webserver_is_displayed.png)

The Google Cloud GCE console confirms that the VM instance has been provisioned and it is in a running state. Its public IP address is also displayed, the same as the URL.

![The Google Cloud GCE console confirms that the VM instance has been provisioned and it is in a running state](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_Google_Cloud_GCE_console_confirms_that_the_VM_instance_has_been_provisioned_and_it_is_in_a_running_state.png)

The URL is verified in a browser that displays the desired webpage. Running a **curl** command from the terminal supplying the same URL would produce the same output.

![The URL is verified in a browser that displays the desired webpage](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_URL_is_verified_in_a_browser_that_displays_the_desired_webpage.png)

Terraform can also destroy all resources provisioned earlier.

![$ ./terraform destroy](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@__._terraform_destroy.png)

Before all resources are destroyed, a “yes” confirmation is expected at the prompt.

![Enter a value](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Enter_a_value-yes.png)

In a similar fashion Terraform can be used to provision infrastructure on other cloud providers, such as AWS, Azure, or Oracle Cloud.

# Benefits
Key benefits of using Terraform are:

- It allows us to build, change, and version infrastructure in a safe and efficient manner.
- It can manage existing, as well as customized service providers. It is agnostic to underlying providers.
- It can manage a single application or an entire datacenter.
- It is a flexible abstraction of resources.
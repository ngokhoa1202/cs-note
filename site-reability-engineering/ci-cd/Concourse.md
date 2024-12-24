

[Concourse](https://concourse-ci.org/) is an open source CI/CD system which was started by Alex Suraci and Christopher Brown in 2014. Later, Pivotal sponsored the project. It is written in the Go language.

With Concourse, we run a series of containerized tasks to perform the desired operations. For containerization, it uses Docker and Docker-Compose, while the series of tasks, together with resources, allow us to build a job or pipeline. Following is a sample [task](https://concourse-ci.org/tasks.html) file:

**platform: linux**

**image_resource:  
  type: docker-image  
  source: {repository: busybox}**

**run:  
  path: echo  
  args: [hello world]**

With the above configuration, we would be creating a Linux container using the **busybox** container image from Docker Hub, and inside that container, we would run the **echo hello world** program.

Concourse is driven by the _fly_ CLI and a web UI. We can use _fly_ to log in to our Concourse setup and to execute tasks, while the web UI helps to visualize jobs and resources in the form of graphs.


# Demo


This instance of Concourse is installed on a Kubernetes cluster from its official Helm chart. Once deployed, it requires a CLI client to be installed on a remote system. Independent logins are required from the web UI and from the fly CLI. Upon login, the welcome page of the web UI displays any available pipelines.

![Concourse welcome page of the web UI displaying any available pipelines](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Concourse_welcome_page_of_the_web_UI_displaying_any_available_pipelines.png)

On the remote client system we define a job to run a container.

![Concourse define a job to run a container](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Concourse_define_a_job_to_run_a_container.png)

This definition file is passed as an argument to the **fly set-pipeline** command. The pipeline is created but remains in a paused state. It can be unpaused from the fly CLI, as suggested by the generated output, or from the web UI.

![The fly set-pipeline command](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_fly_set-pipeline_command.png)

The created pipeline is now visible on the web UI. It can be unpaused, inspected, and a build can be started as well.

![Created pipeline is visible on the web UI](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Created_pipeline_is_visible_on_the_web_UI.png)

Clicking the large colored rectangle displays the pipeline build state.

![Display the pipeline build state](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Display_the_pipeline_build_state.png)

The build is initiated by clicking the “plus” symbol on the job listing.

![Initiate build by clicking the “plus” symbol on the job listing](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@Initiate_build_by_clicking_the__plus__symbol_on_the_job_listing_Updated1.png)

As the job build advances the top banner will change color corresponding to its build state.

![The top banner changes color to correspond to its build state](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_top_banner_changes_color_to_correspond_to_its_build_state.png)

Upon successful completion, the banner turns green and the build logs are displayed below.

![The banner turns green and the build logs are displayed below](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@The_banner_turns_green_and_the_build_logs_are_displayed_below.png)

The build state color also highlights the pipeline listing of the web UI.

![The build state color also highlights the pipeline listing of the web UI](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@The_banner_turns_green_and_the_build_logs_are_displayed_below.png)

The job build state color also highlights the job listing of the web UI.

![The job build state color also highlights the job listing of the web UI](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@The_job_build_state_color_also_highlights_the_job_listing_of_the_web_UI.png)

While the web UI offers limited functionality, the fly CLI needs to be used for most pipeline management options.
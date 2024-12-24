
Jenkins can build Freestyle, Apache Ant, and Apache Maven-based projects. We can also extend the functionality of Jenkins using [plugins](https://plugins.jenkins.io/ui/search?query=). As of September 2023, Jenkins supports a little over 1900 plugins in different categories, like _Source Code Management, Administration, Build management, User interface,and Platforms_.

Jenkins supports the build of a pipeline - a concept representing an entire application's lifecycle. A _Jenkins Pipeline_ is a series of plugins that collectively implement CD. 

According to the [Jenkins documentation](https://jenkins.io/doc/book/pipeline/), Pipeline's "_features are_:

- _Code**:** Pipelines are implemented in code and typically checked into source control, giving teams the ability to edit, review, and iterate upon their delivery pipeline._
- _Durable**:** Pipelines can survive both planned and unplanned restarts of your Jenkins master._
- _Pausable: Pipelines can optionally stop and wait for human input or approval before completing the jobs for which they were built._
- _Versatile: Pipelines support complex real-world CD requirements, including the ability to fork or join, loop, and work in parallel with each other._
- _Extensible: The Pipeline plugin supports custom extensions to its DSL (domain scripting language) and multiple options for integration with other plugins."_

The flowchart below illustrates a sample deployment using the Pipeline Plugin:

![Jenkins Pipeline](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Fig_13.1-Jenkins_Pipeline.png)

**Jenkins Pipeline**  
(by Jenkins/[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), retrieved from [jenkins.io](https://www.jenkins.io/doc/book/pipeline/))

While the Pipeline's classic UI complexity challenged some users, Jenkins introduced the [Blue Ocean](https://www.jenkins.io/doc/book/blueocean/), a UI designed to improve the user experience by simplifying the Pipeline build process. Recently, two alternative visualization plugins were made available, the [Pipeline: Stage View](https://plugins.jenkins.io/pipeline-stage-view/) and [Pipeline: Graph View](https://plugins.jenkins.io/pipeline-graph-view/). The newer plugins aim to offer the same functionality and eventually replace the Blue Ocean UI. Blue Ocean and its successors introduced the following features:

- _Sophisticated visualization_ for a comprehensive display of the CD Pipeline status. 
- _Pipeline editor_ that visually and intuitively guides the user through the Pipeline build process. 
- _Personalization_ to cater to each user's role. 
- _Pinpoint precision_ by highlighting areas where the user's attention is required. 
- _Native integration for branch and pull requests_ to maximize collaboration on GitHub and Bitbucket.

# Benefits
Key benefits of using Jenkins are: 

- It is an open source automation system. 
- It supports Continuous Integration and Continuous Delivery. 
- It is extensible through plugins. 
- It can be easily installed, configured, and distributed.
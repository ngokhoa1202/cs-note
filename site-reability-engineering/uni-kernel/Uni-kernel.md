
# Introduction
Generally a developer's target goal is to run an application. The container technology is helping to achieve this goal by packaging the application, dependencies, and libraries into an image, which ultimately ensures the application runs in an easily reproducible fashion on any environment, not only on the distribution where it was built. As part of the containers' running process, there is a necessity to ship the entire user-space libraries of the respective distribution with the application. In most cases, the majority of the libraries would not be consumed by the application. Therefore, it makes sense to ship the application only with the set of user-space libraries which are needed by the application. 

With _unikernels_, we can select the part of the kernel needed to run with the specific application. The unikernel image becomes a single address space executable, including both application and kernel components. The image can be deployed on VMs or bare metal, based on the unikernel's type.  

According to the [unikernels website](http://unikernel.org/), 

> "_Unikernels are specialized, single-address-space machine images constructed by using library operating systems_". 

In this chapter, we will discuss unikernels, their characteristics, implementations, and benefits.


# Specialized VM Images
The [Unikernel](http://unikernel.org/) goes one step further than other technologies, creating specialized virtual machine images with just:

- The application code
- The configuration files of the application
- The user-space libraries needed by the application
- The application runtime (like JVM)
- The system libraries of the unikernel, which allow back and forth communication with the hypervisor_._

According to the [protection ring](https://en.wikipedia.org/wiki/Protection_ring) of the x86 architecture, we run the kernel on **ring0** and the application on **ring3**, which has the least privileges. **Ring0** has the most privileges, like access to hardware, and a typical OS kernel runs on that. With unikernels, a combined binary of the application and the kernel runs on **ring0**.

Unikernel images would run directly on hypervisors like Xen, or on bare metal, based on the unikernels' type. The following image shows how the _Mirage Compiler_ creates a unikernel VM image. 

![Example of a Unikernel architecture (as compared to a traditional OS stack)](https://courses.edx.org/assets/courseware/v1/06dee41f4d33cfda12ee8452e7936e1a/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Fig8.1_-_Example_of_a_Unikernel_Architecture__as_Compared_to_a_Traditional_OS_Stack_.png)

**Comparison of a Traditional OS Stack and a MirageOS Unikernel**  
(by AmirMC/[CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/), retrieved from [Wikipedia](https://en.wikipedia.org/wiki/Unikernel#/media/File:Unikernel_mirage_example.png))

# Benefits
The following are key benefits of unikernels:

- A minimalistic VM image to run an application, which allows us to have more applications per host.
- A faster boot time.
- Efficient resource utilization.
- A simplified development and management model.
- A more secure application than the traditional VM, as the attack surface is reduced.
- An easily-reproducible VM environment, which can be managed through a source control system like Git.
# Implementation
There are several implementations of unikernels, and they are divided into two categories:

- _Specialized and purpose-built unikernels_  
    They utilize all the modern features of software and hardware, while disregarding backward compatibility. They are not POSIX-compliant. Some examples of specialized and purpose-built unikernels are [HaLVM](https://galois.com/project/halvm/), [MirageOS](https://mirage.io/), and [Clive](http://lsub.org/ls/clive.html).
- _Generalized 'fat' unikernels_ They run unmodified applications, which make them fat. Some examples of generalized 'fat' unikernels are [OSv](http://osv.io/) and [Drawbridge](https://www.microsoft.com/en-us/research/project/drawbridge/).
# ### Unikernels (MirageOS) and Docker

In January 2016, Docker acquired Unikernels to make them a first-class citizen of the Docker ecosystem. Both containers and unikernels can co-exist on the same host and be managed by the same Docker binary. 

For a long time, containers attempted to simplify things by running microservices that were simple to build and the containers themselves easy to deploy, yet still incorporating a lot of complexity in the container image. Once unikernels were introduced, further simplification of them resulted in a significant boost in performance. These specialized unikernel virtual machines are much lighter than containers because they remove the unnecessary components of the operating system, such as permissions and isolation, and further decrease the attack surface. MirageOS became a great unikernel success because it was able to produce a library operating system that was flexible, secure, reusable, and stripped of unnecessary drivers, daemons, and libraries.

Unikernels helped Docker to run the Docker Engine on top of Alpine Linux on Mac and Windows with their default hypervisors, which are xhyve Virtual Machine and Hyper-V VM respectively.

![Shared Kernel vs. Unikernel](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Fig8.2-SharedKernel-vs-Unikernel.png)
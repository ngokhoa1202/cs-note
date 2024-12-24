[Kubernetes](https://kubernetes.io/) is an Apache 2.0-licensed open source project for automating deployment, operations, and scaling of containerized applications. It was started by Google in 2014, but many other companies like Docker, Red Hat, and VMware contributed to its success.

In July 2015, [Cloud Native Computing Foundation](https://cncf.io/) (CNCF), the nonprofit organization dedicated to advancing the development of cloud-native applications and services and driving alignment among container technologies, accepted Kubernetes as its first hosted project. Intellectual Property (IP) was transferred to CNCF from Google.

As the Kubernetes project matures, the list of supported container [runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/) may change, however, currently containerd, CRI-O, Docker Engine, and Mirantis Container Runtime are supported to run containers.

![](Pasted%20image%2020241212142251.png)

# Components

The key components of the Kubernetes architecture are:

**Cluster** The cluster is a collection of systems (bare-metal or virtual) and other infrastructure resources used by Kubernetes to run containerized applications. 

**Control-Plane Node**:
The control-plane node is a system that takes containerized workload scheduling decisions, manages the worker nodes, enforces access control policies, and reconciles changes in the state of the cluster. Its main components are the _kube-apiserver_, _etcd_, _kube-scheduler_, and _kube-controller-manager_ responsible for coordinating tasks around container workload scheduling, deployment, scaling, self-healing, state persistence, state reconciliation, and delegation of container management tasks to worker node agents. Multiple control-plane nodes may be found in clusters as a solution for High Availability. 

**Worker Node**:
A system where containers are scheduled to run in workload management units called _Pods_. The node runs a daemon called _kubelet_ responsible for intercepting container deployment and lifecycle management related instructions from the kube-apiserver, delegating such tasks to the container runtime found on the node, implementing container health checks, enforcing resource utilization limits, and reporting node status information back to the kube-apiserver. _kube-proxy_, a network proxy, enables applications running in the cluster to be accessible by external requests. Both node agents - kubelet and kube-proxy, together with a container runtime are found on worker nodes and on control-plane nodes as well. 

**Namespace**   
The namespace allows us to logically partition the cluster into virtual sub-clusters by segregating the cluster's resources, addressing the multi-tenancy requirements of enterprises requiring an isolation method for their projects, applications, users, and teams. 

The key API resources of the Kubernetes architecture are: 

**Pod**   
The pod is a logical workload management unit, enabling the co-location of a group of containers with shared dependencies such as storage _Volumes_. However, a pod is often managing a single container and its dependencies such as _Secrets_ or _ConfigMaps_. The pod is the smallest deployment unit in Kubernetes. A pod can be created independently, but it is lacking the self-healing, scaling, and seamless update capabilities which Kubernetes is known for.  In order to overcome the pod's shortcomings, controller programs, or operators, such as the ReplicaSet, Deployment, DaemonSet, or the StatefulSet are recommended to be used to manage pods, even if only a single application pod replica is desired. 


```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod  
  labels:  
    run: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.17.9
    ports:
    - containerPort: 80
```

ReplicaSet
The ReplicaSet is a mid-level controller, or operator, that manages the lifecycle of pods. It rolls out a desired amount of pod replicas, uses state reconciliation to ensure that the desired number of application pod replicas is running at all times, and to self-heal the application if a pod replica is unexpectedly lost due to a crash or lack of computing resources. 

Deployment
The Deployment is a top-level controller that allows us to provide declarative updates for pods and ReplicaSets. We can define Deployments to create new resources, or replace existing ones with new ones. The Deployment controller, or operator, represents the default stateless application rollout mechanism. Typical Deployment use cases and a sample Deployment are provided below: 

1. Create a Deployment to roll out a desired amount of pods with a ReplicaSet.
2. Check the status of a Deployment to see if the rollout succeeded or not.
3. Later, update that Deployment to recreate the pods (to use a new image) - through the Rolling Update mechanism.
4. Roll back to an earlier Deployment revision if the current Deployment isn’t stable.
5. Scale, pause, and resume a Deployment. 

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment  
  labels:  
    app: nginx-deployment
spec:
  replicas: 3  
selector:
    matchLabels:
      app: nginx-deployment
  template:
    metadata:
      labels:
        app: nginx-deployment
    spec:
      containers:
      - name: nginx
        image: nginx:1.17.9
        ports:
        - containerPort: 80
```


DaemonSet
The DaemonSet is a controller, or operator, that manages the lifecycle of node agent pods. It rolls out a desired amount of pod replicas while ensuring that each cluster node will run exactly one application pod replica. It also uses state reconciliation to ensure that the desired number of application pod replicas is running at all times, and to self-heal the application if a pod replica is unexpectedly lost due to a crash or lack of computing resources.

**Service**   
The Service is a traffic routing unit implemented by the kube-proxy providing a load-balancing access interface to a logical grouping of pods, typically managed by the same operator. The Service enables applications with DNS name registration, name resolution to a private/cluster internal static IP. It can reference a single pod or a set of pods managed by ReplicaSets, Deployments, DaemonSets, or StatefulSets. 

```yaml
apiVersion: v1  
kind: Service  
metadata:  
  name: frontend  
  labels:  
    app: nginx-deployment  
    tier: frontend  
spec:  
  type: NodePort  
  ports:  
  - port: 8080  
    targetPort: 80  
  selector:  
    app: nginx-deployment  
    tier: frontend
```


**Label**  
The Label is an arbitrary key-value pair that is attached to resources. In the examples above, we defined labels with keys such as **run**, **app**, and **tier**. Labels are typically used to tag resources of a particular application, such as the Pods of a Deployment, to logically group them for management purposes - for updates, scaling, or traffic routing. 

**Selector**  
Selectors allow controllers, or operators, to search for resources or groups of resources described by a desired set of key-value pair Labels. In the examples above, the **frontend** Service will only forward traffic to Pods described simultaneously by both labels **app: nginx-deployment** and **tier: frontend**.

**Volume**  
The Volume is an abstraction layer implemented through Kubernetes plugins and third-party drivers aimed to provide a simplified and flexible method of container storage management with Kubernetes. Through Kubernetes, Volume containers are able to mount local host storage, network storage, distributed storage clusters, and even cloud storage services, in a seamless fashion.

# Features
Key features of Kubernetes are:

- It automatically distributes containers on cluster nodes based on containers' resource requirements, cluster topology, and other custom constraints.
- It supports horizontal scaling through the CLI or a UI. In addition, it can auto-scale based on resource utilization.
- It supports rolling updates and rollbacks.
- It supports several volume drivers from public cloud providers such as AWS, Azure, GCP, and VMware, together with network and distributed storage plugins like NFS, iSCSI, and the CephFS driver to orchestrate storage volumes for containers running in pods.
- It automatically self-heals by restarting failed containers, rescheduling containers from failed nodes, and supports custom health checks to ensure containers are continuously ready to serve.
- It manages sensitive and configuration data for an application without rebuilding the image.
- It supports batch execution.
- It supports High Availability of the control-plane node to add control plane resiliency.
- It eliminates infrastructure lock-in by providing core capabilities for containers without imposing restrictions.
- It supports application deployments and updates at scale. 
- It supports cluster topology aware routing of traffic to service endpoints.
# Kubernetes Hosted Solutions and Platforms
Kubernetes, the most popular container orchestrator, can be deployed anywhere, both on-premises or in the public cloud. If we are deploying it on-premises, then our Kubernetes administrators would have to perform all the Kubernetes management tasks to upgrade the cluster or backup resources. For public cloud deployments, we have different options. For instance, we can self-manage our own cluster in the public cloud or opt for hosted (managed) Kubernetes services where all the management tasks would be performed by the cloud services providers. There are several hosted solutions available for Kubernetes, including:

- [Amazon Elastic Kubernetes Service (Amazon EKS)](https://aws.amazon.com/eks/)  
    Offers a managed Kubernetes service on AWS. 
- [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)  
    Offers managed Kubernetes clusters on Microsoft Azure. 
- [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/)  
    Offers managed Kubernetes clusters on Google Cloud Platform. 
- [IBM Cloud Kubernetes Service](https://www.ibm.com/cloud/kubernetes-service)   
    Fully managed Kubernetes service at scale, providing continuous availability and high availability, multi-zone, and multi-region clusters. 
- [NetApp Project Astra](https://cloud.netapp.com/astra) (fusion between NetApp and Stackpoint.io)   
    Provides Kubernetes infrastructure automation and management for multiple public clouds optimized for stateful application data lifecycle management. 
- [Oracle Container Engine for Kubernetes (OKE)](https://www.oracle.com/cloud-native/container-engine-kubernetes/)  
    Enterprise-grade Kubernetes service offering highly available clusters optimized to run on Oracle Cloud Infrastructure. 
- [Red Hat OpenShift](https://cloud.redhat.com/learn/what-is-openshift)   
    Offers managed Kubernetes clusters powered by Red Hat on various cloud infrastructures such as AWS, GCP, Microsoft Azure, and IBM Cloud. 
- [Vultr Kubernetes Engine (VKE)](https://www.vultr.com/kubernetes/)  
    A managed Kubernetes service integrated with Vultr cloud load balancers and storage services.
- [VMware Tanzu Kubernetes Grid (TKG)](https://tanzu.vmware.com/kubernetes-grid)  
    An enterprise-grade multi-cloud Kubernetes service that runs both on-premises in vSphere and in the public cloud. 

In addition to hosted solutions, the managed Kubernetes Platform solutions have also grown in popularity. With this approach, vendors of Kubernetes services provide a managed Kubernetes environment flexible enough to be deployed on any public cloud, multi-cloud, or on-premises/private cloud, eliminating the vendor lock-in which has been troubling many users of the hosted Kubernetes solutions. Several Kubernetes platforms are listed below:

- [Managed Kubernetes](https://ubuntu.com/kubernetes/managed) by Canonical, a Kubernetes as a Service offering with built-in monitoring, analytics, security and compliance, optimized for multi-cloud deployment.
- [D2iQ Enterprise Kubernetes Platform](https://d2iq.com/kubernetes-platform) (DKP) is a managed Kubernetes service that incorporates features of [DC/OS](https://dcos.io/). 
- [Kubermatic Kubernetes Platform](https://www.kubermatic.com/products/kubermatic/) automates Kubernetes cluster management on-premises and in the public cloud.
- [Mirantis Kubernetes Engine](https://www.mirantis.com/software/mirantis-kubernetes-engine/), an Enterprise Kubernetes Platform, formerly Docker Enterprise, manages containerized workloads on any infrastructure.
- [Platform9 Managed Kubernetes](https://platform9.com/managed-kubernetes/) (PMK) is a managed SaaS that simplifies Kubernetes management on-premises and in the public cloud.
- [Rackspace Managed Platform for Kubernetes](https://www.rackspace.com/cloud/kubernetes) (MPK) - Powered by Platform9 Managed Kubernetes (PMK) solution, is a Kubernetes as a Service offering built-in monitoring, alerting, security management, infrastructure as code (IaC) to provision the entire stack. It is a flexible, cross-cloud portable solution.
- [Rancher Kubernetes Engine](https://www.rancher.com/products/rke) (RKE) is a Kubernetes distribution that runs in containers on any platform.
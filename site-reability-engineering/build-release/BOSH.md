
BOSH was primarily developed to deploy the Cloud Foundry PaaS, but it can deploy other software as well (e.g., Hadoop). BOSH supports multiple Infrastructure as a Service (IaaS) providers. BOSH creates VMs on top of IaaS, configures them to suit the requirements, and then deploys the applications on them. Supported IaaS providers for BOSH are:

- - - VMware vSphere
        - vCloud Director

With the Cloud Provider Interface (CPI), BOSH supports additional IaaS providers such as: 

- - - [Google Compute Engine](https://github.com/cloudfoundry/bosh-google-cpi-release)
        - [Amazon AWS](https://github.com/cloudfoundry/bosh-aws-cpi-release)
        - [OpenStack](https://github.com/cloudfoundry/bosh-openstack-cpi-release)

# Components
- [Stemcell](https://bosh.io/docs/stemcell.html)   
    A _Stemcell_ is a versioned, IaaS-specific, operating system image with some pre-installed utilities such as the BOSH Agent. Stemcells do not contain any application-specific code. The BOSH team is in charge of releasing stemcells, which are listed on the "[_Stemcells_](https://bosh.io/stemcells)" web page. 
- [Release](https://bosh.io/docs/release.html)   
    A _Release_ is placed on top of a _Stemcell_, and consists of a versioned collection of configuration properties, templates, scripts, and source code to build and deploy software. 
- [Deployment](https://bosh.io/docs/deployment.html)   
    A _Deployment_ is a collection of VMs which are built from Stemcells, populated with specific _Releases_ on top of them, and having disks to keep persistent data.
- [BOSH Director](https://bosh.io/docs/bosh-components.html#director)  
    The _BOSH Director_ is the central orchestrator component of BOSH, which controls the VM creation and deployment. It also controls software and service lifecycle events. We need to upload _Stemcells, Releases,_ and _Deployment_ _manifest files_ to the Director. The Director processes the manifest file and runs the deployment.
# Example
Next, we will reproduce an example of a sample [deployment manifest](https://bosh.io/docs/deployment-basics.html) from the BOSH website. This sample deployment manifest must be then uploaded to the _BOSH Director:_

**---
name: zookeeper

releases:
- name: zookeeper
  version: 0.0.5
  url: https://bosh.io/d/github.com/cppforlife/zookeeper-release?v=0.0.5
  sha1: 65a07b7526f108b0863d76aada7fc29e2c9e2095

stemcells:
- alias: default
  os: ubuntu-xenial
  version: latest

update:
  canaries: 2
  max_in_flight: 1
  canary_watch_time: 5000-60000
  update_watch_time: 5000-60000

instance_groups:
- name: zookeeper
  azs: [z1, z2, z3]
  instances: 5
  jobs:
  - name: zookeeper
    release: zookeeper
    properties: {}
  vm_type: default
  stemcell: default
  persistent_disk: 10240
  networks:
  - name: default

- name: smoke-tests
  azs: [z1]
  lifecycle: errand
  instances: 1
  jobs:
  - name: smoke-tests
    release: zookeeper
    properties: {}
  vm_type: default
  stemcell: default
  networks:
  - name: default**
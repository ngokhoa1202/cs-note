#virtualization #cloud 

- Used to manage virtual machines.
# Vagrant file
- Describes how Virtual Machines should be configured and provisioned. 
- It is a text file with the Ruby syntax.
- Includes the machine type, image, networking, provider-specific information, and provisioner details. While it is portable, there should be only one Vagrantfile per project.
```rb
**# -*- mode: ruby -*-**  
**# vi: set ft=ruby :**  
   
**Vagrant.configure("2") do |config|**  
      **# Every Vagrant development environment requires a box.**   
      **# You can search for boxes at**   
      **# https://app.vagrantup.com/boxes/search**  
      **config.vm.box = "ubuntu/focal64"**  
   
      **# Set the HOSTNAME of the guest VM**  
      **config.vm.hostname = "vagrant-host"**  
   
      **# Create a private network, which allows host-only access**   
      **# to the machine using a specific IP**  
      **config.vm.network "private_network", ip: "192.168.56.100"**  
   
      **# Vagrant VirtualBox provider specific VM properties**  
      **config.vm.provider "virtualbox" do |vb|**  
           **# Set VM name to be displayed in the VirtualBox VM Manager window**  
           **vb.name = "vagrant-vm"**  
           **# Customize the amount of CPUs on the VM**  
           **vb.cpus = 2**  
           **# Customize the amount of memory (2GB RAM) on the VM**  
           **vb.memory = 2048**  
      **end**  
   
      **# Share an additional folder to the guest VM. The first argument is**  
      **# the path on the host to the actual folder. The second argument is**  
      **# the path on the guest to mount the folder. And the optional third**  
      **# argument is a set of non-required options.**  
      **# config.vm.synced_folder "../data", "/vagrant_data"**  
   
      **# Vagrant shell provisioner to automatically**  
      **# install packages 'vim', 'curl', 'podman'**   
      **config.vm.provision "shell", inline: <<-SCRIPT**  
           **sudo apt update**  
           **sudo apt install -y vim curl**  
           **sudo mkdir -p /etc/apt/keyrings  
           curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null  
           echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg] https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null**  
           **sudo apt update -qq**  
           **sudo apt -y upgrade**  
           **sudo apt install -qq -y podman**  
           **echo NGINX PODMAN CONTAINER RUNNING ON VIRTUALBOX VM > /vagrant-demo**  
           **echo Provisioned at: >> /vagrant-demo**  
           **date >> /vagrant-demo**  
      **SCRIPT**  
   
      **# Vagrant Podman provisioner automatically installs Podman**  
      **# and then runs the 'nginx' image in a container**  
      **# (We have pre-installed Podman because of provisioner bugs)**  
      **config.vm.provision "podman" do |p|**  
           **p.run "nginx"**  
      **end**  
**end******
```

# Boxes
- [Boxes](https://developer.hashicorp.com/vagrant/docs/boxes) are the package format for the Vagrant environment. The Vagrantfile requires an image, which is then used to instantiate Virtual Machines. In the example above, we have used **ubuntu/focal64** as the base image. If the image is not available locally, then it can be downloaded from a central image repository such as [Vagrant Cloud box repository](https://app.vagrantup.com/boxes/search) provided by HashiCorp. Box images can be versioned and customized to specific needs simply by updating the Vagrantfile accordingly.
# Provision
- [Providers](https://www.vagrantup.com/docs/providers/) are the underlying engines or hypervisors used to provision VMs or containers. Although the default Vagrant provider is VirtualBox, it also supports Hyper-V, VMware, and Docker out of the box. Custom providers such as AWS may be configured as well.
# Synced Folder
- With the [Synced Folders](https://www.vagrantup.com/docs/synced-folders/) feature, we can sync a directory on the host system with a VM, which helps the user manage shared files/directories easily. In our example, if we uncomment the line describing the synced folder attribute, then the **../data** folder from the current working directory of the host system would be shared with the **/vagrant_data** folder of the VM.

```rb
config.vm.synced_folder "../data", "vagrant_data"**
```

# Provisioning
- [Provisioners](https://www.vagrantup.com/docs/provisioning/) allow us to automatically install software and make configuration changes after the machine is booted. It is part of the **vagrant up** process. There are many types of provisioners available, such as File, Shell, Ansible, Puppet, Chef, Docker, Podman, Puppet, and Salt. In the example below, we used Shell as the provisioner to update the VM and then install the **vim** and **curl** packages.

```rb
**config.vm.provision "shell", inline: <<-SCRIPT**  
     **sudo apt update**  
     **sudo apt install -y vim curl**
SCRIPT
```

# Networking
- Vagrant provides high-level [networking](https://www.vagrantup.com/docs/networking/) options for port forwarding, network connectivity, and network creation. These networking options represent an abstraction that enables cross-provider portability. That is, the same Vagrantfile used to provision a VirtualBox VM could be used to provision a VMware machine.
# Multi-machine
- A project's Vagrantfile may describe [multiple VMs](https://www.vagrantup.com/docs/multi-machine/), which are typically intended to work together or may be linked between themselves.
# References
1. 
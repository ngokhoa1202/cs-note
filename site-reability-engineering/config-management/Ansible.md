
Red Hat's [Ansible](http://www.ansible.com) is an easy-to-use, open source configuration management (CM) tool. It is an agentless tool that works through SSH. In addition, Ansible can automate infrastructure provisioning (on-premises or public cloud), application deployment, and orchestration. 

Due to its simplicity, Ansible quickly became one of the top in-demand CM tools in the DevOps world.

# Deployment workflow

One of Ansible's advantages is its agentless architecture. This ensures that maintenance tasks are restricted to a single management node and not to every managed instance in the cluster. As a result, all updates to managed nodes are pushed via SSH to lists of nodes that are managed through inventory files. To list the nodes which we want to manage in an inventory file, we must do the following:

**[webservers]
www1.example.com
www2.example.com

[dbservers]
db0.example.com
db1.example.com**

![Ansible Multi-Node Deployment Workflow](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Fig_14.1_Ansible_Multi-Node_Deployment_Workflow.png)

**Ansible Multi-Node Deployment Workflow**  
(retrieved from [sysadmincasts.com](https://sysadmincasts.com/episodes/43-19-minutes-with-ansible-part-1-4))

The nodes can be grouped together, as shown in the picture above. Ansible also supports dynamic inventory files for cloud providers like AWS and OpenStack. The management node connects to these nodes with a password, or it can do passwordless login using SSH keys.

Ansible ships with a [default set of modules](https://github.com/ansible/ansible/tree/devel/lib/ansible/modules), like packaging, network, etc., which can be executed directly or via [Playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html). We can also create custom modules.

# Playbook

[Skip to main content](https://courses.edx.org/xblock/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@vertical+block@8cad722b28cf4022a0ed792e01ec9db5?dest_lang=en&exam_access=&jumpToId&preview=0&recheck_access=1&show_bookmark=0&show_title=0&src_lang=en&view=student_view#main)

[Playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) are Ansible’s configuration, deployment, and orchestration language.

Below we provide an example of a playbook, which performs multiple tasks based on roles:

`**--- # This playbook deploys the whole application stack in this site.  - name: apply common configuration to all nodes   hosts: all   remote_user: root    roles:     - common  - name: configure and deploy the webservers and application code   hosts: webservers   remote_user: root    roles:     - web  - name: deploy MySQL and configure the databases   hosts: dbservers   remote_user: root    roles:     - db** The sample tasks mentioned in the playbook are:  **--- # These tasks install http and the php modules.  - name: Install http and php etc   yum: name={{ item }} state=present   with_items:    - httpd    - php    - php-mysql    - git    - libsemanage-python    - libselinux-python  - name: insert iptables rule for httpd   lineinfile: dest=/etc/sysconfig/iptables create=yes state=present regexp="{{ httpd_port }}" insertafter="^:OUTPUT "               line="-A INPUT -p tcp  --dport {{ httpd_port }} -j  ACCEPT"   notify: restart iptables  - name: http service state   service: name=httpd state=started enabled=yes**`

The Ansible management node connects to the nodes listed in the inventory file and runs the tasks included in the playbook. A management node can be installed on any Unix-based system like Linux or macOS. It can manage any node which supports SSH and Python.

[Ansible Galaxy](https://galaxy.ansible.com/) is a free site for finding, downloading, and sharing community-developed Ansible roles.

Ansible also has an enterprise product called [Ansible Automation Platform](https://www.ansible.com/products/controller), which introduces a UI interface, access control, and central management.
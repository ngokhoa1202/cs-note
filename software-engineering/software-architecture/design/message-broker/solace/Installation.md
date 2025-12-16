#solace #message-broker #software-engineering #software-architecture #linux #podman #docker 
#container #binary-image #installation #operating-system #container-engine #fedora #ubuntu #debian 
# Rootless container engine installation
- Increases system limits for the current user.
```Shell title='Access limit configuration file'
sudo nano /etc/security/limits.conf
```

```ApacheConf title='Configure system limits for current user'
<user> soft nofile 1048576
<user> hard nofile 1048576
<user> soft memlock unlimited
<user> hard memlock unlimited 
```
- For Red Hat-based images, installs additional library `slirp4netns`.
- Creates `compose.yaml` file for starting the container.
    - Configures the user limits for the number of files required by Solace.
```Yaml title='Solace yaml configuration file'
services:
  solace:
    image: solace/solace-pubsub-standard:lts
    container_name: solace-lts
    shm_size: '4gb' # Memory size can be changed
    user: '1000'
    ports:
      - "8080:8080" # Web Manager
      - "55555:55555" # SMF
      - "8008:8008" # Web Messaging
      - "1883:1883" # MQTT
      - "8000:8000" # MQTT Web
      - "5672:5672" # AMQP
      - "9000:9000" # REST
      - "2222:2222" # SSH
    environment:
      - username_admin_globalaccesslevel=admin
      - username_admin_password=admin
    volumes:
      - solace-data:/var/lib/solace
    network_mode: "slirp4netns:port_handler=slirp4netns"
volumes:
  solace-data:
```
# Rootful container engine installation
- Refers to https://docs.solace.com/Software-Broker/SW-Broker-Set-Up/Containers/Set-Up-Docker-Container-Linux.htm#before-you-begin.
***
# References
1. https://docs.solace.com/Software-Broker/SW-Broker-Set-Up/Containers/Set-Up-Podman-Container-Ubuntu.htm#before-you-begin.
2. https://docs.solace.com/Software-Broker/Container-Tasks/rootless-containers.htm#Rootless_Containers.
3. https://docs.solace.com/Software-Broker/SW-Broker-Set-Up/Containers/Set-Up-Docker-Container-Linux.htm#before-you-begin.
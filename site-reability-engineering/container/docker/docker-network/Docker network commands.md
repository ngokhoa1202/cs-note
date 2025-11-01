#docker #computer-network  #application-layer #transport-layer  #network-layer  #container  #configuration #ci-cd #cli  #nic 

# Docker network ls
## Behavior
- ==Display== all ==available== docker virtual ==network==.
## Syntax
```Shell
docker network ls
```


# Docker network inspect
## Behavior
- Display the configuration of a specific network
## Syntax
```Shell
docker network inspect [OPTIONS] NETWORK+ 
```
# Docker network create
## Behavior
- Create a new docker virtual network $\equiv$ establish a virtual NIC - network interface card $\equiv$ establish a ==subnet between containers==.
## Syntax
```Shell
docker network create [OPTIONS] NETWORK
```

## Options
- `-d` or `--driver` : the type of driver to configure the network.
### Docker network driver
- 
# Docker network connect
## Behavior
- Connect a container to a network.
## Syntax
```Shell
docker network connect [OPTIONS] NETWORK CONTAINER
```

# Docker network disconnect
## Behavior
- Disconnect a container from a network.
## Syntax
```Shell
docker network disconnect [OPTIONS] NETWORK CONTAINER
```

# References
1. https://docs.docker.com/engine/network/ for Docker network official documentation.
2. 


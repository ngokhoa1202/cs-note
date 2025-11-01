#binary-image  #docker  #cli #process #operating-system #installation #configuration #container 

# Docker image history
## Purpose
- Display the history of an image's layers.
- Each line represents a separate layer of that image, from the highest layer (the image being used) to the lowest layer (usually the host's operating system).
## Syntax
```bash
docker image history IMAGE
```

# Docker image inspect
## Purpose
- Display the configuration of an image.
## Syntax
```bash
docker image inspect IMAGE
```

# Docker image tag
## Purpose
- A tag is actually a ==pointer== to a specific image's commit.
- Label a name to an image. If the image is going to be pushed onto `docker hub` repository, the image name should be `<username>:<tagname>` so that docker can find your own repository.
## Syntax
```bash
docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

# Docker image build
- Refers to [Docker buildx commands](Docker%20buildx%20commands.md)
# Docker image prune
- Removes all dangling images.
## Syntax
```bash
docker image prune [OPTIONS]
```
## Options
### Remove unused images
- `-a` or `--all` to remove all unused images, not just dangling images.

>[!Note]
> Dangling images are <mark style="background: #e4e62d;">untagged</mark> images and <mark style="background: #e4e62d;">do not any relationship</mark> with any tagged image as intermediatary layers. These images waste memory space.
> 
> Unused images are images which are not used by any containers.


# References
1. https://docs.docker.com/reference/cli/docker/image/tag/ for `docker image tag`.
2. 
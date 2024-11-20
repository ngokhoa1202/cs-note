#os #binary-image #process #docker #ci-cd #debian #alpine-linux #ubuntu #installation  #windows 

# General
![](Pasted%20image%2020240805134005.png)

# Alpine image
- Package manger: `apk`  
- Shells: `/bin/sh`  
- Very small size: few MBs $\implies$ excellent performance.
- Secure.
- Minimal functionality $\implies$ maybe incompatible.
# Slim image
- Size is optimized but ensure functionality.
- Smaller size than original Debian-based image.
# Debian-based image
## Jessie - Debian 8
- Image name: `debian:jessie`  
- Packagemanager: `apt`  
- Shells: `/bin/bash`  
- Size: ~50mb
    
## Stretch - Debian 9
- Shorty: LTS is running out  
- Packagemanager: `apt`  
- Shells: `/bin/bash` and [many more](https://packages.debian.org/stretch/shells/)  
- Size: ~40mb

## Buster - Debian 10
  - Image name: `debian:buster`  
  - Shorty: All what you need, but newer  
  - Packagemanager: `apt`  
  - Shells: `/bin/bash` and [many more](https://packages.debian.org/buster/shells/)  
  - Size: ~50mb
    
## Bulleye - Debian 11  
- Image name: `debian:bullseye`  
- Shorty: All what you need, but newer  
- Shells: `/bin/bash` and [many more](https://packages.debian.org/bullseye/shells/)  
- Size: ~50mb

## Bookworm - Debian 12
  - Imagename: `debian:bookworm`  
  - Shorty: Newest debian  
  - Shells: `/bin/bash` and [many more](https://packages.debian.org/bullseye/shells/)  
  - Size: ~50mb
    
## Ubuntu
- Imagename: `ubuntu`  
- Shorty: All what you need  
- Packagemanager: `apt`  
- Shells: `/bin/bash` and more  
- Size: ~25mb
---
# References
1. https://mohibulalam75.medium.com/exploring-lightweight-docker-base-images-alpine-slim-and-debian-releases-bookworm-bullseye-688f88067f4b for docker image summary.
2. https://stackoverflow.com/questions/52083380/in-docker-image-names-what-is-the-difference-between-alpine-jessie-stretch-an for each type of image description.
3. 

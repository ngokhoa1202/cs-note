#docker #binary-image  #container #operating-system #process #cli  #software-architecture 

# Docker image
- An image is a standardized ==filesystem== that includes all of the files, ==binaries==, libraries, and ==configurations== to run a container:
- Docker image commands are actually ==mapped into the host's command line interface==.
- If an image is loaded into RAM and executed, it become a process or multiple [Process](operating-system/process/Process.md)
# Characteristics
- Immutable.
- Image is composed of ==separate layers==, which is uniquely identified by SHA Hash
	- If the two images have an ==identical layer== with the same hash, docker can ==cache== that layer of image and <mark style="background: #e4e62d;">build the higher layers</mark> on top of that layer. $\implies$ save memory usage and save time for downloading and uploading.
	- If the two containers are built on top of the same image layer, whenever one of the two containers need to access a file on that image layer, it (container) will copy that file into its filesystem and freely writes it $\implies$ ==Copy on Write== mechanism.
	- The lowest layer is the host's operating system while the highest layer is our application.
***
# References
1. https://docs.docker.com/guides/ for docker official documentation.
2. 

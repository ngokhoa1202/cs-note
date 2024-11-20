#ubuntu #java #installation #jdk #cli 

# Install java manually
## Download JDK
1. Download JDK from Oracle or OpenJDK.
2. Extract the `.tar.gz` file to retrieve the JDK folder.
```Bash
sudo tar -xvzf <java-bin-img>.tar.gz -C /usr/lib/jvm
```
- Or just extract and move it to the `/usr/lib/jvm`:
```Bash
sudo mv <java-repo> -r /usr/lib/jvm
```
## Set up JAVA_HOME
- Open `~/.bashrc` file.
```Bash
sudo vim ~/.bashrc
```
- Add `JAVA_HOME=/usr/lib/jvm/<jdk-21>/bin`
- Apply change
```Bash
source ~/.bashrc
```
# Switch between Java version
- `/usr/bin/java` is actually linked to `/usr/lib/jvm/<jdk-21>`, which a JDK repository.
- Update the link using `update-alternatives` command:
```Bash
sudo update-alternatives --config java
```
- Select an option being listed on the terminal.
- Change to `JAVA_HOME` variable with respect to the link on the terminal to avoid bugs. [Set up JAVA_HOME](#Set%20up%20JAVA_HOME)

# References
1. https://www.fosslinux.com/126382/how-to-install-different-versions-of-java-on-ubuntu.htm
2. 
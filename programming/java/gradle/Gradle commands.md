#cli #operating-system #gradle #dependency-manager #ci-cd  #java #quarkus #spring #spring-boot #jakarta-ee  #scripting 
# Syntax
```bash
gradle [--option-name...] [taskName...]
```
- Task name can be grouped into a single `gradle` command.
# Display all available tasks
```Shell title=''
./gradlew tasks
```
# Build
- Normal build. [Task lifecycle](Gradle%20tasks.md#Task%20lifecycle)
```bash
./gradlew build
```
- Use `-x` flag to skip test.
```Shell title=''
./gradlew -x test
```
# Add new extension to build scripts
```bash
./gradlew addExtension --extensions="security-jpa"
```
# Incremental builds
- Cache unchanged tasks $\equiv$ avoid re-running task whose inputs are unchanged $\implies$ store previous builds and ==rewrite only if necessary==.
- Employ `--build-cache` flag $\neq$ Disable cache `--no-build-cache`
```Shell title=''
./gradlew <task> --build-cache
```
***
# References
1. https://gradle.org/.
2. 
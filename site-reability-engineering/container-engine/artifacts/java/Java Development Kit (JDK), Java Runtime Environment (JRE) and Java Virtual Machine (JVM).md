#quarkus #java #java21 #java17 #podman #containerization #site-realibility-engineering 
#continuous-delivery #bash #shell #rhel #ibm #amazon #microsoft #continuous-integration 
```mermaid title='The architecture of Java runtime'
graph TB
    subgraph JDK["JDK (Java Development Kit)"]
        direction TB
        DevTools["<b>Development Tools</b><br/>• javac (compiler)<br/>• jar (archiver)<br/>• jdb (debugger)<br/>• javadoc (docs generator)<br/>• jconsole, jmap, jstack"]
        
        subgraph JRE["JRE (Java Runtime Environment)"]
            direction TB
            CoreLibs["<b>Core Java Libraries</b><br/>• java.lang<br/>• java.util<br/>• java.io<br/>• java.net"]
            
            subgraph JVM["JVM (Java Virtual Machine)"]
                direction TB
                JVMCore["<b>Core Engine</b><br/>• Executes bytecode<br/>• Memory management<br/>• Garbage collection<br/>• Just-In-Time (JIT) compiler"]
            end
        end
    end
    
    JRE --> DevTools
    JVM --> CoreLibs
    
    classDef jdkStyle fill:#e1f5ff,stroke:#0066cc,stroke-width:3px,color:#000
    classDef jreStyle fill:#fff4e6,stroke:#ff9800,stroke-width:2px,color:#000
    classDef jvmStyle fill:#e8f5e9,stroke:#4caf50,stroke-width:2px,color:#000
    classDef componentStyle fill:#f5f5f5,stroke:#666,stroke-width:1px,color:#000
    
    class JDK jdkStyle
    class JRE jreStyle
    class JVM jvmStyle
    class DevTools,CoreLibs,JVMCore componentStyle
```
# Java Development Kit (JDK)
## Definition
- JDK is a software development kit used to build Java applications. It *contains the JRE and a set of development tools such as compiler, debugger and so on*.
- JDK is *platform-dependent*.
## Usage
- JDK is used for compiling Java source files into bytecode files, debugging the application and packaging the executable `.jar` file in <mark class="hltr-yellow">development</mark> environment.
# Java Runtime Environment (JRE)
## Definition
- JRE provides an environment to run Java programs but *does not include development tools*.
- JRE is *platform-dependent*.
## Usage
- JRE is only used for application execution including class loading, bytecode verification and binary execution.
# Java Virtual Machine (JVM)
## Definition
- JVM the *core* execution engine of Java. It is responsible for *converting bytecode into machine-specific instructions*.
- Bytecode is platform-independent and can be executed on any JVM.
## Usage
- JDK performs memory management, garbage collection,...
***
# References
1. https://www.geeksforgeeks.org/java/differences-jdk-jre-jvm/
2. 
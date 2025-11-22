#application-layer  #computer-network #control-plane 

- Stands for ==Simple Network Management Protocol==.
- Employs [User Datagram Protocol (UDP)](User%20Datagram%20Protocol%20(UDP).md)
# Components
- Managed hosts.
- Agent on managed hosts.
- Network Management Station - NMS.
# SNMP Types
- ![](Pasted%20image%2020240523150951.png)
# SNMP Modes
## SNMP Polling
- Client agent and manager agent employ UDP port ==161==.
- ![400x400](Pasted%20image%2020240523151546.png)
## SNMP Trap
- Client agent still emloys UDP port 161, but manager ==employs UDP port 162 for notification receipt==.
- ![400x400](Pasted%20image%2020240523151726.png)

# SNMP Message format
- ![](Pasted%20image%2020240523151849.png)
# Principle
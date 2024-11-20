#routing #computer-network #algorithm #network-layer #control-plane 

- Stands for ==Open Shortest Path First==.
- intra-autonomous policy.
# Principle
- Employs [Link-state algorithm](Link-state%20algorithm.md)
- Router ==periodically broadcasts== its link state using IP datagram.
- Requires authentication and confidentiality.

# Hierachical OSPF
- ==Divides an autonomous system== into many areas:
- ![800x300](Pasted%20image%2020240523122234.png)
## Backbone area: 
- Boundary router: connects to other autonomous systems.
- Backbone router: routes traffic within backbone area using OSPF.
## Local area
- Local routers: routes traffic inside that local area and forwards traffic to area border router.
- Area border router: summaries local traffic, calculate link state and broadcasts within backbone area - stays in the middle.

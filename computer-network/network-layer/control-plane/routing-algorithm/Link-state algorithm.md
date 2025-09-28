#routing #control-plane #algorithm #computer-network #network-layer 
#graph-theory 

- Based on [Dijkstra algorithm](Dijkstra%20algorithm.md)

# Algorithm
## Requirement
- Graph $G=(V,E)$ where $V$: set of routers and $E$: set of links.
## Solution
- [Dijkstra algorithm](Dijkstra%20algorithm.md)

# Time complexity
## Normal implementation
$O(n^2)$ 
## Optimal implementation
- Use a heap.
- $O(nlogn)$ .

# Message complexity
- Routers have to broadcast its link state $\Rightarrow$ each message has to cross $O(n)$ links $\Rightarrow$ $O(n^2)$ .
# Characteristics
- Static routing $\equiv$ routes ==slowly changes== over time. 
- ==Global== $\equiv$ all nodes (routers) know complete topology.

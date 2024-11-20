#graph-theory #algorithm #minimum-path #routing 

- Single source shortest path algorithm.

# Algorithm
## Requirement
- Given graph $G=(V,E)$ . Starting from $src$ vertice, find all feasible shortest path from $src$.
## Solution
1. Initialization:
	- For every vertice $v \in V$:
		- $L_v = \infty$ 
		- $Previous[v]=undefined$ 
	- 
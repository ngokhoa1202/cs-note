#computer-network  #link-layer #virtualization #protocol 

- Stands for ==Multi-Protocol Label Switching==.
- Forwards IP datagrams according to ==labels==.
# Principle
- Forwards to outbound interface according to only ==label==. Does ==not inspect IP datagram==.
- Precompute backup routes in case of failure $\Rightarrow$ ==fast reroute==.

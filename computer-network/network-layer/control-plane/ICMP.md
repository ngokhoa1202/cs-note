#protocol #network-layer #control-plane 

- Stands for ==Internet Control Message Protocol==.
- Stays on IP layer.

# ICMP Types
- ![](Pasted%20image%2020240523143941.png)

# Ping
- Source host pings an ==ICMP `echo request` type 8 code 0== to destination host.
- Destination host receiving ICMP `echo request` and sends an ==ICMP `echo reply` type 0 code 0== back to source host.
# Traceroute
- Employs [User Datagram Protocol (UDP)](User%20Datagram%20Protocol%20(UDP).md).
- Source host sends a series of IP datagrams carrying UDP segments with infeasible port:
	- 1st series: `TTL=1`
	- 2nd series `TTL=2`.
	- ...
	- 30th series `TTL=3`.
- When $n$ th series arrives on $n$ th router, `TTL=0`. That router drops datagram, ==sends an ICMP `TTL expired` type 11 code 0== to source host.
- Source host receives ICMP `TTL expired` containing router name and IP and caculates RTT.
***
# References
1. 
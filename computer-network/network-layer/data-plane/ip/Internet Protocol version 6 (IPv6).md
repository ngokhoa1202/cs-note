#ip #computer-network #network-layer #protocol 

- Designed to gradually replace IPv4.
# IPv6 datagram format
- ![](Pasted%20image%2020240522153609.png)
## Compare with IPv4
- Head length is still 40 bytes.
- 128-bit IP address.
- No `fragmentation`, no `checksum`, no `options`
- Add `flow label`, `priori`, `traffic class` = `Type of Service`.
- ==IPv6 can encapsulate IPv4==, but not vice versa.
- Add ==anycast address== along with multicast address and unitcast address of IPv4.

# Transition to IPv4
- Employ tunnel mode (similar to [IP Security](IP%20Security.md) )
- ![](Pasted%20image%2020240522154700.png)
***
# References
1. 
#subnet #computer-network #network-layer #ip 


- Idenfies subnet class by the ==first leftmost octets==, which is also called ==network id==.

# Network id
- Network id identifies a ==network== as well as its ==subnet class.==
- The prefix (octets, binary format) identifying subnet class:
	- Example: `192.168.31.150/24` belongs to class C (191-223). $\Rightarrow$ ==First three octets are network id==, `192.168.x.x`.
# Class A
- First octet: `1-126`,  ==`127` for loopback address==.
- Network id occupies the ==first leftmost octet==.
- Used for huge organizations.
# Class B
- First octet: `128-191`.
- Network id occupies the ==leftmost two octets==.
- Used for smaller organizations.
# Class C
- First octet: `192-223`
- Network id occupies the ==leftmost three octets==.
- Used for very small organizations.
# Class D
- For ==multicast== purpose.
- First octet: `224-239`
# Class E
- For ==experimental== purpose.
- First octet `240-255`
# Summary 
- ![](Pasted%20image%2020240522081907.png)
- ![](Pasted%20image%2020240521164115.png)


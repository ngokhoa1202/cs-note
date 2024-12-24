#subnet #computer-network #network-layer 

- Acronym for FLSM.
- 
# Method
- Given network id (or IP address) $\Rightarrow$ identifies ==subnet class== $\Rightarrow$ Define $p$ is the ==prefix length== of IP address. ([Subnet class](Subnet%20class.md)).
- Let $n$ is the number of bits from which the subnet id ==borrows== the host id.
- Let $m$ is the number of usable IPs in a subnet id. $$m=32-p-n$$.
- The number of divided subnets: $2^n$
- The number of host ids: $2^m-2$ (excluding subnet address and broadcast address in a subnet).
- The number of addresses allocated for current subnets: $2^m$ (including subnet address and broadcast address).
- New subnet mask's octet: $256-2^m$ $\Rightarrow$ new subnet mask.
- The first subnet id, let all host bits $0$.
- The following subnet ids: $$Subnet_{current}+|Addresses_{allocated}|$$ if the sum $\geq 256$, first convert to binary form then recalculate sum.
- 

# References
1. [Subnet class](Subnet%20class.md) for subnet class.
2. *HCMUT Computer network Lab slide - Bùi Xuân Giang.*
3. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
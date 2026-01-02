#subnet #computer-network #network-layer 
# Problem
- Given network id (or IP address) $\Rightarrow$ identifies its ==subnet class==.
# Method
- Define $p$ is the ==prefix length== of IP address.
- Let $n$ is the number of bits from which the subnet id ==borrows== the host id.
- Let $m$ is the number of usable IPs in a subnet id. $$m=32-p-n$$.
- The number of divided subnets: $2^n$
- The number of host ids: $2^m-2$ (excluding subnet address and broadcast address in a subnet).
- The number of addresses allocated for current subnets: $2^m$ (including subnet address and broadcast address).
- New subnet mask's octet: $256-2^m$ $\Rightarrow$ new subnet mask.
- The first subnet id, let all host bits $0$.
- The following subnet ids: $$\text{Subnet}_\text{current}+2^m$$ if the sum $\geq 256$, first *convert to binary form* then recalculate sum.
# Practical Examples
## Example 1: Dividing Class C Network into 4 Subnets
### Problem
- Company network `192.168.1.0/24` needs 4 equal subnets for departments.
### Solution
#### Input
- Network: `192.168.1.0/24`
- Prefix length: $p = 24$
- Required subnets: $2^n = 4 \implies n = 2$
#### Calculation
1. Host bits borrowed: $n = 2$ bits
2. Remaining host bits: $m = 32 - 24 - 2 = 6$ bits
3. Addresses per subnet: $2^6 = 64$ addresses
4. Usable hosts per subnet: $2^6 - 2 = 62$ hosts
5. New subnet mask octet: $256 - 64 = 192 \implies$ subnet mask: `255.255.255.192` or `/26`
#### Subnets

| Subnet | Network Address  | First Host    | Last Host     | Broadcast     | Usable Hosts |
| ------ | ---------------- | ------------- | ------------- | ------------- | ------------ |
| 1      | 192.168.1.0/26   | 192.168.1.1   | 192.168.1.62  | 192.168.1.63  | 62           |
| 2      | 192.168.1.64/26  | 192.168.1.65  | 192.168.1.126 | 192.168.1.127 | 62           |
| 3      | 192.168.1.128/26 | 192.168.1.129 | 192.168.1.190 | 192.168.1.191 | 62           |
| 4      | 192.168.1.192/26 | 192.168.1.193 | 192.168.1.254 | 192.168.1.255 | 62           |

- **Subnet Calculation:**
    - Subnet 1: $192.168.1.0$ (host bits = 00000000)
    - Subnet 2: $192.168.1.0 + 64 = 192.168.1.64$
    - Subnet 3: $192.168.1.64 + 64 = 192.168.1.128$
    - Subnet 4: $192.168.1.128 + 64 = 192.168.1.192$
## Example 2: Dividing Class B Network into 8 Subnets
### Problem
- University network `172.16.0.0/16` requires 8 subnets for faculties.
### Solution
#### Input
- Network: `172.16.0.0/16`
- Prefix length: $p = 16$
- Required subnets: $2^n = 8 \implies n = 3$
#### Solution
1. Host bits borrowed: $n = 3$ bits
2. Remaining host bits: $m = 32 - 16 - 3 = 13$ bits
3. Addresses per subnet: $2^{13} = 8192$ addresses
4. Usable hosts per subnet: $2^{13} - 2 = 8190$ hosts
5. New subnet mask: `255.255.224.0` or `/19`
   - Third octet: $256 - 2^5 = 256 - 32 = 224$
#### Resulting Subnets

| Subnet | Network Address | Host Range                    | Usable Hosts |
| ------ | --------------- | ----------------------------- | ------------ |
| 1      | 172.16.0.0/19   | 172.16.0.1 - 172.16.31.254    | 8190         |
| 2      | 172.16.32.0/19  | 172.16.32.1 - 172.16.63.254   | 8190         |
| 3      | 172.16.64.0/19  | 172.16.64.1 - 172.16.95.254   | 8190         |
| 4      | 172.16.96.0/19  | 172.16.96.1 - 172.16.127.254  | 8190         |
| 5      | 172.16.128.0/19 | 172.16.128.1 - 172.16.159.254 | 8190         |
| 6      | 172.16.160.0/19 | 172.16.160.1 - 172.16.191.254 | 8190         |
| 7      | 172.16.192.0/19 | 172.16.192.1 - 172.16.223.254 | 8190         |
| 8      | 172.16.224.0/19 | 172.16.224.1 - 172.16.255.254 | 8190         |

- Binary Representation (3rd Octet):
    - Subnet 1: `00000000` = 0
    - Subnet 2: `00100000` = 32
    - Subnet 3: `01000000` = 64
    - Subnet 4: `01100000` = 96
    - Subnet 5: `10000000` = 128
    - Subnet 6: `10100000` = 160
    - Subnet 7: `11000000` = 192
    - Subnet 8: `11100000` = 224
### Example 3: Small Office Network
**Scenario**: ISP allocates `203.0.113.0/28` for small office needing 2 subnets.

**Given:**
- Network: `203.0.113.0/28`
- Prefix length: $p = 28$
- Required subnets: $2^n = 2 \implies n = 1$

**Calculation:**
1. Host bits borrowed: $n = 1$ bit
2. Remaining host bits: $m = 32 - 28 - 1 = 3$ bits
3. Addresses per subnet: $2^3 = 8$ addresses
4. Usable hosts per subnet: $2^3 - 2 = 6$ hosts
5. New subnet mask: `255.255.255.248` or `/29`

**Resulting Subnets:**

| Subnet | Network | First Host | Last Host | Broadcast | Usage |
|--------|---------|------------|-----------|-----------|-------|
| 1 | 203.0.113.0/29 | 203.0.113.1 | 203.0.113.6 | 203.0.113.7 | Office LAN |
| 2 | 203.0.113.8/29 | 203.0.113.9 | 203.0.113.14 | 203.0.113.15 | Guest WiFi |

**Key Points:**
- Each subnet provides 6 usable IP addresses.
- Subnet 1 can assign IPs: 203.0.113.1-6 for computers/printers.
- Subnet 2 can assign IPs: 203.0.113.9-14 for guest devices.
- Addresses 203.0.113.0, 203.0.113.7, 203.0.113.8, 203.0.113.15 are reserved (network/broadcast).

### Example 4: Cross-Octet Calculation
**Scenario**: Network `10.50.0.0/16` divided into 64 subnets.

**Given:**
- Network: `10.50.0.0/16`
- Required subnets: $2^n = 64 \implies n = 6$

**Calculation:**
1. Host bits borrowed: $n = 6$ bits
2. Remaining host bits: $m = 32 - 16 - 6 = 10$ bits
3. Addresses per subnet: $2^{10} = 1024$ addresses
4. New subnet mask: `255.255.252.0` or `/22`
   - Third octet: $256 - 4 = 252$ (since $2^{10} = 1024 = 4 \times 256$)

**Selected Subnets:**

| Subnet | Network Address | Calculation |
|--------|----------------|-------------|
| 1 | 10.50.0.0/22 | Base address |
| 2 | 10.50.4.0/22 | $0 + 1024 = 4.0$ (4 in 3rd octet) |
| 3 | 10.50.8.0/22 | $4.0 + 1024 = 8.0$ |
| 10 | 10.50.36.0/22 | $9 \times 1024 = 36.0$ |
| 64 | 10.50.252.0/22 | $63 \times 1024 = 252.0$ |

**Increment Calculation:**
- Each subnet increments 3rd octet by 4.
- Subnet $k$: Third octet = $(k-1) \times 4$
- Example: Subnet 10 $\implies$ third octet = $9 \times 4 = 36 \implies$ `10.50.36.0/22`

***
# References
1. [Subnet class](Subnet%20class.md) for subnet class.
2. Computer network Lab Slides 2023 - Giang Xuan Bui - Ho Chi Minh City University of Technology.
3. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
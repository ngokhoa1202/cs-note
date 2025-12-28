#subnet #computer-network #network-layer
# Problem
- Given network with ==multiple departments== requiring ==different host quantities== $\Rightarrow$ allocate IP addresses efficiently without waste.
- FLSM creates equal-sized subnets $\implies$ wastes addresses when departments have varying sizes.
- VLSM allows ==variable subnet sizes== $\implies$ optimal address utilization.
# Method
## Algorithm
1. **Sort requirements**: List all subnets in ==descending order== by number of required hosts.
2. **Calculate subnet size**: For each subnet with $h$ hosts:
   - Find smallest $m$ where $2^m - 2 \geq h$ (excluding network and broadcast addresses)
   - Subnet prefix: $p_{\text{new}} = 32 - m$
   - Subnet size: $2^m$ addresses
3. **Allocate sequentially**:
   - Start with largest subnet at network base address
   - Next subnet address: $\text{Current} + 2^m$
   - Repeat until all subnets allocated
1. **Verify**: Ensure no address overlap between subnets
## Key Formulas
- Usable hosts: $2^m - 2$ (where $m$ = host bits)
- Subnet size: $2^m$ addresses
- Next subnet: $\text{Address}_{\text{current}} + 2^m$
- Prefix length: $p = 32 - m$
- Subnet mask: First $p$ bits set to 1

## Advantages over FLSM
- **Efficient allocation**: Minimizes wasted IP addresses
- **Flexible sizing**: Each subnet sized according to actual needs
- **Hierarchical design**: Supports network aggregation and summarization
- **Scalability**: Easier to accommodate future growth in specific subnets
# Practical Examples
## Example 1: Corporate Network with 4 Departments
### Problem
- Network: `192.168.10.0/24` (254 usable addresses)
- Requirements:
  - Sales: 100 hosts
  - Engineering: 50 hosts
  - HR: 25 hosts
  - Management: 10 hosts

### Solution
#### Step 1: Sort by Size (Descending)
1. Sales: 100 hosts
2. Engineering: 50 hosts
3. HR: 25 hosts
4. Management: 10 hosts
#### Step 2: Calculate Subnet Sizes
**Sales (100 hosts):**
- Need: $2^m - 2 \geq 100 \implies 2^m \geq 102$
- Smallest $m = 7$ (since $2^7 = 128 \geq 102$)
- Subnet size: $2^7 = 128$ addresses
- Prefix: $32 - 7 = /25$
- Subnet mask: `255.255.255.128`

**Engineering (50 hosts):**
- Need: $2^m - 2 \geq 50 \implies 2^m \geq 52$
- Smallest $m = 6$ (since $2^6 = 64 \geq 52$)
- Subnet size: $2^6 = 64$ addresses
- Prefix: $32 - 6 = /26$

**HR (25 hosts):**
- Need: $2^m - 2 \geq 25 \implies 2^m \geq 27$
- Smallest $m = 5$ (since $2^5 = 32 \geq 27$)
- Subnet size: $2^5 = 32$ addresses
- Prefix: $32 - 5 = /27$

**Management (10 hosts):**
- Need: $2^m - 2 \geq 10 \implies 2^m \geq 12$
- Smallest $m = 4$ (since $2^4 = 16 \geq 12$)
- Subnet size: $2^4 = 16$ addresses
- Prefix: $32 - 4 = /28$

#### Step 3: Allocate Addresses

| Department | Hosts | Subnet Address | Prefix | First Host | Last Host | Broadcast | Usable | Wasted |
|------------|-------|----------------|--------|------------|-----------|-----------|--------|--------|
| Sales | 100 | 192.168.10.0 | /25 | 192.168.10.1 | 192.168.10.126 | 192.168.10.127 | 126 | 26 |
| Engineering | 50 | 192.168.10.128 | /26 | 192.168.10.129 | 192.168.10.190 | 192.168.10.191 | 62 | 12 |
| HR | 25 | 192.168.10.192 | /27 | 192.168.10.193 | 192.168.10.222 | 192.168.10.223 | 30 | 5 |
| Management | 10 | 192.168.10.224 | /28 | 192.168.10.225 | 192.168.10.238 | 192.168.10.239 | 14 | 4 |

#### Address Calculation
- Sales: Base address $192.168.10.0$
- Engineering: $192.168.10.0 + 128 = 192.168.10.128$
- HR: $192.168.10.128 + 64 = 192.168.10.192$
- Management: $192.168.10.192 + 32 = 192.168.10.224$
- Remaining: $192.168.10.224 + 16 = 192.168.10.240$ to $192.168.10.255$ (16 addresses available for future use)

#### Efficiency Analysis
- Total required: $100 + 50 + 25 + 10 = 185$ hosts
- Total allocated: $128 + 64 + 32 + 16 = 240$ addresses
- Total wasted: $26 + 12 + 5 + 4 = 47$ addresses
- Efficiency: $\frac{185}{240} \times 100\% = 77.1\%$

**FLSM Comparison:**
- FLSM with 4 equal subnets: Each /26 (64 addresses, 62 usable)
- Total FLSM usable: $4 \times 62 = 248$ addresses
- FLSM wasted: $248 - 185 = 63$ addresses
- VLSM saves: $63 - 47 = 16$ addresses (25% improvement)

## Example 2: Multi-Site Network
### Problem
- Network: `10.20.0.0/16`
- Requirements:
  - Main Office LAN: 500 hosts
  - Branch Office A: 200 hosts
  - Branch Office B: 100 hosts
  - Point-to-Point WAN Link 1: 2 hosts
  - Point-to-Point WAN Link 2: 2 hosts
  - Server Farm: 30 hosts

### Solution
#### Sorted Requirements
1. Main Office LAN: 500 hosts $\implies m = 9$ ($2^9 = 512$), /23
2. Branch Office A: 200 hosts $\implies m = 8$ ($2^8 = 256$), /24
3. Branch Office B: 100 hosts $\implies m = 7$ ($2^7 = 128$), /25
4. Server Farm: 30 hosts $\implies m = 5$ ($2^5 = 32$), /27
5. WAN Link 1: 2 hosts $\implies m = 2$ ($2^2 = 4$), /30
6. WAN Link 2: 2 hosts $\implies m = 2$ ($2^2 = 4$), /30

#### Allocated Subnets

| Site | Required | Subnet | Prefix | Address Range | Usable |
|------|----------|--------|--------|---------------|--------|
| Main Office | 500 | 10.20.0.0 | /23 | 10.20.0.1 - 10.20.1.254 | 510 |
| Branch A | 200 | 10.20.2.0 | /24 | 10.20.2.1 - 10.20.2.254 | 254 |
| Branch B | 100 | 10.20.3.0 | /25 | 10.20.3.1 - 10.20.3.126 | 126 |
| Server Farm | 30 | 10.20.3.128 | /27 | 10.20.3.129 - 10.20.3.158 | 30 |
| WAN Link 1 | 2 | 10.20.3.160 | /30 | 10.20.3.161 - 10.20.3.162 | 2 |
| WAN Link 2 | 2 | 10.20.3.164 | /30 | 10.20.3.165 - 10.20.3.166 | 2 |

#### Key Points
- Main Office uses /23 (2 Class C blocks) $\implies$ addresses span 10.20.0.0 - 10.20.1.255
- Point-to-point links use /30 $\implies$ minimal waste (only 2 usable addresses needed)
- Server Farm placed between larger subnets and WAN links for logical grouping
- Remaining address space: 10.20.3.168 onwards available for expansion

## Example 3: ISP Customer Allocation
### Problem
- ISP block: `203.0.113.0/24`
- Allocate to customers:
  - Customer A (Small Business): 60 hosts
  - Customer B (Home Office): 10 hosts
  - Customer C (Medium Business): 30 hosts
  - Reserve addresses for future customers

### Solution
#### Allocation Plan
**Customer A (60 hosts):**
- Subnet: `203.0.113.0/26` (64 addresses)
- Range: 203.0.113.0 - 203.0.113.63
- Usable: 203.0.113.1 - 203.0.113.62 (62 hosts)

**Customer C (30 hosts):**
- Subnet: `203.0.113.64/27` (32 addresses)
- Range: 203.0.113.64 - 203.0.113.95
- Usable: 203.0.113.65 - 203.0.113.94 (30 hosts)

**Customer B (10 hosts):**
- Subnet: `203.0.113.96/28` (16 addresses)
- Range: 203.0.113.96 - 203.0.113.111
- Usable: 203.0.113.97 - 203.0.113.110 (14 hosts)

**Reserved for Future:**
- Available: `203.0.113.112/28` onwards (144 addresses remaining)
- Can allocate: 9 additional /28 subnets or various combinations

| Customer | Hosts | Subnet | Addresses | Utilization |
|----------|-------|--------|-----------|-------------|
| A | 60 | 203.0.113.0/26 | 64 | 93.8% |
| C | 30 | 203.0.113.64/27 | 32 | 93.8% |
| B | 10 | 203.0.113.96/28 | 16 | 62.5% |
| Reserved | - | 203.0.113.112/28+ | 144 | - |

## Example 4: Hierarchical Network Design
### Problem
- Enterprise network: `172.16.0.0/16`
- Hierarchical allocation:
  - Region 1: 4000 hosts
  - Region 2: 2000 hosts
  - Region 3: 1000 hosts
  - Data Center: 500 hosts
  - WAN Links: 3 links × 2 hosts each

### Solution
#### Level 1: Regional Allocation

**Region 1 (4000 hosts):**
- Need: $2^m - 2 \geq 4000 \implies m = 12$ ($2^{12} = 4096$)
- Subnet: `172.16.0.0/20` (4096 addresses)
- Range: 172.16.0.0 - 172.16.15.255

**Region 2 (2000 hosts):**
- Need: $m = 11$ ($2^{11} = 2048$)
- Subnet: `172.16.16.0/21` (2048 addresses)
- Range: 172.16.16.0 - 172.16.23.255

**Region 3 (1000 hosts):**
- Need: $m = 10$ ($2^{10} = 1024$)
- Subnet: `172.16.24.0/22` (1024 addresses)
- Range: 172.16.24.0 - 172.16.27.255

**Data Center (500 hosts):**
- Need: $m = 9$ ($2^9 = 512$)
- Subnet: `172.16.28.0/23` (512 addresses)
- Range: 172.16.28.0 - 172.16.29.255

**WAN Links:**
- Link 1: `172.16.30.0/30`
- Link 2: `172.16.30.4/30`
- Link 3: `172.16.30.8/30`

#### Summary Table

| Location | Requirement | Subnet | Block Size | Address Range |
|----------|-------------|--------|------------|---------------|
| Region 1 | 4000 | 172.16.0.0/20 | 4096 | 172.16.0.0 - 172.16.15.255 |
| Region 2 | 2000 | 172.16.16.0/21 | 2048 | 172.16.16.0 - 172.16.23.255 |
| Region 3 | 1000 | 172.16.24.0/22 | 1024 | 172.16.24.0 - 172.16.27.255 |
| Data Center | 500 | 172.16.28.0/23 | 512 | 172.16.28.0 - 172.16.29.255 |
| WAN 1 | 2 | 172.16.30.0/30 | 4 | 172.16.30.0 - 172.16.30.3 |
| WAN 2 | 2 | 172.16.30.4/30 | 4 | 172.16.30.4 - 172.16.30.7 |
| WAN 3 | 2 | 172.16.30.8/30 | 4 | 172.16.30.8 - 172.16.30.11 |

#### Route Summarization
- All regional subnets fall within `172.16.0.0/16`
- Can summarize routing table entries at border routers
- Reduces routing overhead in core network
***
# References
1. [Fixed length Subnet Mask (FLSM)](Fixed%20length%20Subnet%20Mask%20(FLSM).md) for comparison with fixed-size subnetting.
2. [Subnet class](Subnet%20class.md) for subnet classification.
3. Computer network Lab Slides 2023 - Giang Xuan Bui - Ho Chi Minh City University of Technology.
4. Computer Networking A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
5. https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html for VLSM design principles.

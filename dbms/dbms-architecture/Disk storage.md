#operating-system #file-system #dbms #secondary-storage #cli 

# Disk controller
- Secondary storage - disks are typically managed by a <mark style="background: #e4e62d;">disk controller</mark> to manipulate I/O data.
- <mark style="background: #e4e62d;">Minimizing the number of block transfers</mark> significantly boosts performance.
# Disk architecture
- A disk is a <mark style="background: #e4e62d;">random access addressable</mark> device.
- The transfer process between main memory and disk takes place in <mark style="background: #e4e62d;">units of disk blocks</mark>.
- The hardware address of a block is a combination of a cyclinder number, track number and block number.
- For a read command, the disk block is copied into the <mark style="background: #e4e62d;">buffer</mark>; whereas for a write command, the contents of the buffer are copied into the disk block.
# Disk parameters
- ![](Pasted%20image%2020241025101216.png)
- ![](Pasted%20image%2020241025101247.png)
## Block size
- Denoted by $B$.
- Specific to each operating system:
	- For Ubuntu $B = 512 \space bytes$ 
```bash
sudo fdisk -l # check for block size
```

## Interblock gap size
- Denoted by $G$
## Disk speed
- Denoted by $p \space (\text{revolutions/min)}$
## Seek time
- The time it takes for the disk's head to move to a specific <mark style="background: #e4e62d;">track</mark>.
- Denoted by $s \space (ms)$
## Rotational delay
- The time it takes for the disk's head to rotate to a specific block.
- Denoted by $rd \space (ms)$.
- Average $$rd \space (min)=\frac{1}{2}\times\frac{1}{p}$$
## Transfer rate
- The rate at which data is transferred from a block to the buffer.
- Denoted by $tr \space (\text{bytes/ms})$ 
- $$tr \space (bytes/ms)=\frac{B}{rd}=2Bp $$
## Bulk transfer rate
- The rate at which <mark style="background: #e4e62d;">useful</mark> data excluding the interblock gap is transferred from a block to the buffer.
- Denoted by $btr$
- $$btr \space (bytes/ms)=\frac{B}{B+G} \times tr $$
## Block transfer time
- The time it takes to transfer a block of data from the disk to the buffer.
- Denoted by $btt$
- Ignore interblock gap $$btt \space (ms)=\frac{B}{tr}$$
- Only useful data considered
- $$btt \space (ms)=\frac{B}{btr}$$

## Rewrite time
### Scenario
- We have read a block from the disk and updated it in the main memory buffer.
- Then we want to write the buffer back to the same disk block.
- $\implies$ $$Time = T_{\text{buffer-update}}+T_{\text{disk-rewrite}} \approx T_{\text{disk\_rewrite}}$$
- However, $T_{buffer-update} \ll T_{disk-rewrite}$ .
- When the buffer is about to write, the system keeps the same track and needs a disk revolution to write data back to disk.
### Description
- Denoted by $T_{rw}$
- $$T_{rw} \space (min)=2rd=p$$
## Record size
- Denoted by $R$
- $$R \space (bytes)=\sum f_i$$ where $f_i$ is the size of field $i$ of the record.

## Record pointer
- Holds the record address.
- The record address is the sum of  the block address and the record address relative to the block.
## Blocking factor
- The number of records that a block can hold.
- Denoted by $bfr$ 
- Normally, $B \geq R$ :
	- Fixed-length records or unspanned records $$bfr \space (bytes)= \left\lfloor \frac{B}{R} \right \rfloor$$
	- $\implies$ calculate the number of blocks $b$ needed if the number of records $r$ is given $$b \space (bytes)=\left \lceil \frac{r}{bfr} \right \rceil$$
# Block buffering
- Buffers are parts of main memory reserved to receive blocks from secondary storage to speed up I/O transfers.
## Buffer manager
- Increases the hit cache probability.
- In case of reading a new disk block from disk,  finds a page to replace that will cause the least harm in the sense that it <mark style="background: #ABF7F7A6;">will not be required shortly</mark> again.

## Double buffering
- Use <mark style="background: #e4e62d;">two buffers</mark> to increase hit cache probability.

---
# References
1. *HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.*
2. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).*
	- Chapter 17: Indexing Structures for Files and Physical Database Design.
		- Section 17.3 Dynamic Multilevel indexes using B-Tree and B+-Tree.
			- Exercise 17.19 & 17.20
1. *https://www.youtube.com/watch?v=aZjYr87r1b8&t=13s*
2. HCMUT Basic DBMS Slides - Truong Quynh Chi.
3. HCMUT Advanced DBMS Slides - Le Thi Bao Thu.
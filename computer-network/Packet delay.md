#computer-network #packet-delay #traffic 

![](Pasted%20image%2020240512084803.png)
where:
- $d_{nodal}$: total delay.
- $d_{proc}$: nodal processing, includes checking bit error, finding interfaces...
- $d_{queue}$ : time waiting in the queue (buffer).
- $d_{trans}=\frac{L}{R}=\frac{Length-of-packet}{transmission-rate}$: transmission delay: from the 1st bit being pushed until the final bit being forwarded.
- $d_{prop}=\frac{d}{s}=\frac{distance-between-two-devices}{light-speed}$ : bit propagates on the media (fiber optics for example).

# Traffic intensity

$$Traffic=\frac{L \times a}{R}=\frac{Length-of-packet \times arrial-rate}{service-rate}$$
- $Traffic \approx 0$ => small delay.
- $Traffic \to^{a \to \inf} 1$ => large delay.
- $Traffic > 1$ => infinite delay.
![](Pasted%20image%2020240512085729.png)
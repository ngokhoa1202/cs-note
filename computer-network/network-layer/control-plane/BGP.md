#routing #algorithm #network-layer #computer-network 

- Stands for ==Border Gateway Protocol==.
- ==inter-autonomous== system routing.

# Principle

## BGP session
- Two BGP routers exchange BGP message over TCP connection.
- BGP States: Idle, Connect, Active, OpenSent, OpenConfirm, and Established.
## BGP message
- `OPEN`: opens TCP connection and authenticates.
- `UPDATE`: advertise new path.
- `KEEPALIVE`: Keep connection alive without `UPDATE` or `ACK`.
- `NOTIFICATION`: close connection or error message.
## BGP Routing & Advertisement
- Advertise `prefix` and `attributes`. Two crucial attributes:
	- `AS-PATH`: list of ASs that has been passed.
	- `NEXT-HOP`: internal AS router.
- Usually assigned local preference for each ASs.
# BGP routing criteria
- Local preference $\equiv$ policy.
- shortest `AS-PATH`.
- closes `NEXT-HOP` router.
- ...



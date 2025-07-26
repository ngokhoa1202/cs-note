#software-engineering #software-architecture #caching #computer-architecture 

- The database is also called the primary data store.
- The cache is also known the secondary data store.
# Read through
## Mechanism
- ![[Pasted image 20250726171140.png]]
- The cache acts as an <mark class="hltr-yellow">intermediary</mark> between the application and the database:
	- When the application requests data, it *first checks* whether the data is in the *cache* or not.
	- If there is a cache hit, it’s returned to the application.
	- Otherwise, the *cache itself is responsible* for fetching the data from the database; storing it and returning it back to the application.
## Consequences
- The application logic is <mark class="hltr-yellow">simplified</mark> because it does not deal with the logic of management.
- The cache itself handles both reading from the database and storing the requested data. This <mark class="hltr-yellow">minimizes unnecessary data</mark> in the cache and ensures that <mark class="hltr-yellow">frequently accessed data is readily available</mark>.
- For every caching request for data:
	- If the request hits the cache, the access is low-latency.
	- If the request misses the cache, there is an additional delay while the cache queries the database and stores the data. As a result, the initial reads are typically longer.
- Once the time-to-live expires, the data is automatically reloaded from the database.
## Usage
- Read Through caching is entirely appropriate for <mark class="hltr-yellow">read-heavy</mark> applications where data is *accessed frequently but updated less often*, such as content delivery systems (CDNs), social media feeds, or user profiles.
# Cache aside
- Cache aside is also known as Lazy Loading.
- ![[Pasted image 20250726171108.png]]
## Mechanism
- The application code dictates the interaction between the cache and the database. The data is loaded into the cache only when needed:
	- The application first checks whether the data is in the cache or not.
	- If there is a cache hit, it is returned to the application.
	- Otherwise, the application queries it from the database, then stores it into the cache for subsequent requests.
## Consequences
- The application takes charge of cache write and replacement. It decides when and how to store or delete the data in the cache.
- Once the time-to-live expires, the data is automatically removed from the cache.
## Usage
- Cache Aside is entirely appropriate for applications where the <mark class="hltr-yellow">read-to-write ratio is high</mark>, and data updates are infrequent. For example, in an e-commerce website, product data (like prices, descriptions, or stock status) is often read much more frequently than it's updated.
# Write through
- ![[Pasted image 20250726171150.png]]
# Write around
- ![[Pasted image 20250726171212.png]]
# Write back
- ![[Pasted image 20250726171224.png]]


---
# References.
1. https://blog.algomaster.io/p/top-5-caching-strategies-explained
2. 
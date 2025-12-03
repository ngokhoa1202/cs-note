#software-engineering #software-architecture #caching #computer-architecture #computer-network #redis 
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
- For every read request:
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
- The application takes charge of cache write and replacement. It decides when and how to store or evict the data in the cache.
- Once the time-to-live expires, the data is automatically removed from the cache.
## Usage
- Cache Aside is entirely appropriate for applications where the <mark class="hltr-yellow">read-to-write ratio is high</mark>, and data updates are infrequent. For example, in an e-commerce website, product data (like prices, descriptions, or stock status) is often read much more frequently than it's updated.
# Write through
- ![[Pasted image 20250726171150.png]]
## Mechanism
- Every write operation is performed <mark class="hltr-yellow">on both the cache and the database at the same time</mark>. This is a *synchronous* process because the cache and the database are updated within an operation, thereby ensuring no delay in data propagation.
## Consequences
- The data in the cache and the database is always <mark class="hltr-yellow">synchronized</mark> and the read requests from the cache always returns the latest data; as a result, <mark class="hltr-yellow">data consistency</mark> is fully guaranteed.
- The time-to-live expiration policy is not required. However, it may be implemented to evict the infrequently accessed data.
- Read operations are *low-latency* because data is directly accessed from the cache. Write operations, however, are *high-latency* due to the overhead of writing to both the cache and the database.
## Usage
- Write Through is entirely appropriate for <mark class="hltr-yellow">consistency-critical</mark> systems, such as financial applications or online transaction processing systems, where the cache and database must always have the latest data.
# Write around
- ![[Pasted image 20250726171212.png]]
## Mechanism
- Write operations are directly performed on the database, bypassing the cache.
- The cache is <mark class="hltr-yellow">only updated when the data is requested later</mark> during a read operation, at which point the **Cache Aside** strategy is used to load the data into the cache.
## Consequences
- Only frequently accessed data resides in the cache, thus prevents cache pollution.
- Write operations are faster because they only target the database and don’t incur the overhead of writing to the cache.
- Once the time-to-live expires, the data is removed from the cache, forcing the application to retrieve it from the database again if needed.
## Usage
- Write Around caching is best used in <mark class="hltr-yellow">write-heavy</mark> systems where data is frequently written or updated, but <mark class="hltr-yellow">not immediately or frequently read</mark> such as logging systems.
# Write back
- ![[Pasted image 20250726171224.png]]
## Mechanism
- Write operations are <mark class="hltr-yellow">first</mark> performed <mark class="hltr-yellow">on the cache</mark> and then <mark class="hltr-yellow">asynchronously executed on the database</mark> at a <mark class="hltr-yellow">later</mark> time.
## Consequences
- The write latency is drastically minimized by deferring the database writes.
- The cache acts as a primary storage during the write operations, while the<mark class="hltr-yellow"> database is updated periodically</mark> in the background.
- There is a risk of data loss if the cache fails before the data has been written to the database although the issue can be mitigated by employing using persistent caching solutions such as Redis with Append-Only-File, which logs every write operation to disk, ensuring data durability even if the cache crashes.
- Cache invalidation is not required in Write Back.
## Usage
- Write Back caching is entirely appropriate for <mark class="hltr-yellow">write-heavy</mark> scenarios where write operations need to be **fast** and **frequent**, but<mark class="hltr-blue"> immediate consistency</mark> with the database <mark class="hltr-blue"> is not critical</mark>, such as logging systems and social media feeds.
# Summary
- ![[Pasted image 20250727080252.png]]
---
# References.
1. https://blog.algomaster.io/p/top-5-caching-strategies-explained for caching topology and strategy explanation.
2. https://hazelcast.com/blog/a-hitchhikers-guide-to-caching-patterns/ for the full activity diagram.
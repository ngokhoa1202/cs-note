#functional-programming #high-order-function 

# Definition
- A <mark class="hltr-yellow">pure</mark> function is a function that satisfies the two conditions
	- It always returns the <mark class="hltr-yellow">same output for the same input</mark> (*deterministic* behavior).
	- It produces <mark class="hltr-yellow">no side effects</mark> during its execution. The function's behavior depends solely on its input parameters and nothing else—not on global state, not on external resources, and not on any mutable data outside its scope.
```Java title='Non-deterministic function, thus impure function'
/* Functions that rely on the current system time */
public String generateOrderId(String customerCode) {
    return customerCode + "_" + UUID.randomUUID().toString(); 
}

// Same customer code, different order IDs each time
String id1 = generateOrderId("CUST001"); // "CUST001_a3f4d8e2-1234-..."
String id2 = generateOrderId("CUST001"); // "CUST001_b7e9f3a1-5678-..."

/* Random number generation makes the function impure */
public String generateOrderId(String customerCode) {
    return customerCode + "_" + UUID.randomUUID().toString();
}

// Same customer code, different order IDs each time
String id1 = generateOrderId("CUST001"); // "CUST001_a3f4d8e2-1234-..."
String id2 = generateOrderId("CUST001"); // "CUST001_b7e9f3a1-5678-..."
```

```Typescript title='Functions that rely on external API states, thus impure functions'
// Depends on environment configuration
function getApiEndpoint(serviceName: string): string {
    const baseUrl = process.env.API_BASE_URL || 'http://localhost';
    const port = process.env[`${serviceName.toUpperCase()}_PORT`] || '8080';
    return `${baseUrl}:${port}`;
}

// Output changes based on environment variables
const endpoint = getApiEndpoint("inventory"); // Could be different based on ENV
```

```Java title='Functions that depend on database queries, thus impure functions'
@Repository
public class UserRepository {
    public Optional<User> findActiveUserByEmail(String email) {
        // Database state might change between calls
        return jdbcTemplate.queryForObject(
            "SELECT * FROM users WHERE email = ? AND active = true",
            new UserRowMapper(),
            email
        );
    }
}
```
---
# References
1. 
#faq #http #computer-network #application-layer 

# Definition
- An HTTP method is **idempotent** if the ==intended effect== on the server of making a ==single request== is the ==same as== the effect of making ==several identical requests==.
- Consider only intended effects by client and ==server state==.

# Examples
- All safe HTTP methods are idempotent.
- PUT, and DELETE are idempotent.
- ==POST is not idempotent==.

```HTTP
POST /add_row HTTP/1.1
POST /add_row HTTP/1.1   -> Adds a 2nd row
POST /add_row HTTP/1.1   -> Adds a 3rd row
```
```HTTP
DELETE /idX/delete HTTP/1.1   -> Returns 200 if idX exists
DELETE /idX/delete HTTP/1.1   -> Returns 404 as it just got deleted
DELETE /idX/delete HTTP/1.1   -> Returns 404
```

# References
1. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent
#cybersecurity #web-security #api 

# Concepts
- Each API has two essential components:
	- URL.
	- HTTP Method  [HTTP Methods](HTTP%20Methods.md).
# Intruder's exploitation
## SQL Injection
- Attack the vulnerability of programmers or the programming languages itself.
- Target SQL `WHERE` statement to crawl confidential information.
	- E.g: `SELECT * FROM users WHERE users.username LIKE bob%`
	- Apppends the raw string `OR 1=1` to the query.
- Overwrites crucial information:
	- HTTP `GET` employs raw query string.
# Prevention
## Follow API 3.0 Standards
- Don't be brainless to put everything on `GET`.
## Validation & Encryption
- If it is truly necessary, think about sanitization and encryption.
- Follow strict validation rules.
## Hide sensitive APIs
- Only publicize "safe" API.
- Consider when exposuring "mutable" API.
## Block user
- Intruder crawls vulnerable APIs by automated tools.
- For sensitive applications, block after a fixed times of wrong login.
--- 
# References
1. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods for official documentation about HTTP Methods.
2. 

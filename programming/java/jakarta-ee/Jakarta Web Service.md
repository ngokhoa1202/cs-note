#jakarta-ee #web-service #computer-network #application-layer #http #json #annotation #java #web 

# Data format
## JSON Format
### Syntax
```json
{
	"firstName": "Duke",
	"lastName": "Java",
	"age": 18,
	"streetAddress": "100 Internet Dr",
	"city": "JavaTown",
	"state": "JA",
	"postalCode": "12345",
	"phoneNumbers": [
		{ "Mobile": "111-111-1111" },
		{ "Home": "222-222-2222" }
	]
}
```
### Specify field name in JSON format
- `@JsonProperty(value = "fieldname")` annotation to specify field in DTO class.
***

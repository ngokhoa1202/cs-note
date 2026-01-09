#restful #web #computer-network #application-layer #software-engineering #software-architecture 
# Definition
- HATEOAS is the usage of hypermedia links in the API response contents, thereby allows the client to dynamically navigate to the appropriate resources by traversing the hypermedia links.
- For instance, the given below JSON response may be from an API like `{HTTP}HTTP GET http://api.domain.com/management/departments/10`.
```Json title='HATEOAS usage in response'
{
    "departmentId": 10,
    "departmentName": "Administration",
    "locationId": 1700,
    "managerId": 200,
    "links": [
        {
            "href": "10/employees",
            "rel": "employees",
            "type" : "GET"
        }
    ]
}
```
- JSON does not have any universally accepted format for representing links between two resources; however, HTTP header may be employed.
```HTTP title='HATEOAS in HTTP Header'
HTTP/1.1 200 OK
...
Link: <10/employees>; rel="employees"
```
# Purpose
- HATEOAS allows the server to make URI changes as the API changes without breaking the clients.
-  A REST client can hit an initial API URI and dynamically use the server-provided links to access the resources without hardcoding the URI.
>[!Important]
> Academic REST architecture strongly promotes HATEOAS but the industry pragmatically ignores it.
***

# References
1. 
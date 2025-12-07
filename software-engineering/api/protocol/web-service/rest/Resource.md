#restful #web-service #software-engineering #software-architecture #software-testing #best-practice 
# Definition
- Any information that can be named can be a resource.
## Singleton and Collection resources
- A resource can be a *singleton* or a *collection*. 
- For example, “`customers`” is a collection resource and “`customer`” is a singleton resource in banking domain.
	- `/customers` represents a collection of customer.
	- `/customers/{id}` represents a specific customer.
## Collection and sub-collection resources
- A resource may contain sub-collection resources.
- For example, resource “`accounts`” of a particular “`customer`” can be identified using the URIs
	- `{URI}/customers/{customerId}/accounts` represents a collection of accounts belonging to a specific user.
	- `/customers/{customerId}/accounts/{accountId}` represents a single account belonging to a specific user.
# Uniform Resource Identifier (URI)
- The constraint of a uniform interface is partially addressed by the alignment of *URIs* and *HTTP verbs* with the standards and conventions.
## Represent resources with nouns
- RESTful URI should refer to a resource that is a ***thing (noun)*** instead of referring to an action (verb). For instance,
	- `/device-management/managed-devices`
	- `/device-management/managed-devices/{device-id}`
	- `/user-management/users`
	- `/user-management/users/{id}`
## Categorize resources into one archetype
### Document resource archetype
- A document represents a *singular* instance, analogous to an entity or database record.
- Each document is a standalone resource with its own unique identifier.
```URI title='Document resource archetype URI examples'
/users/12345
/users/12345/profile

/orders/98765

/devices/sensor-alpha-001
```
### Collection resource archetype
- A collection resource is a *server-managed directory* of resources.
- Collections are always *plural nouns* and serve as the parent *container* for multiple related documents.
```URI title='Collection resource archetype example'
/users
/users?role=admin&page=2&size=10

/orders
/orders/?after=8475939201&count=20

/products

/api/v1/customers/789/invoices
```
### Store resource archetype
- A store is a *client-managed resource repository* where *the client*, not the server, determines the resource identifiers and controls what the repository contains.
- A store never automatically generates new URIs. Instead, each stored resource has a URI. The URI was chosen by a client when the resource was initially put into the store.
```URI title='Store resource archetype'
/users/12345/playlists/my-workout-mix

/storage/users/john-doe/documents/tax-2024.pdf

/configurations/environments/production/database-config
```
### Controller resource archetype
- A controller represents an executable function, procedure, or operation that doesn't fit naturally into the document, collection, or store archetypes. It functions as business processes which transcend simple CRUD operations.
- Controller archetype typically use *verbs* in their URI paths because they represent special *actions* rather than entities.
```URI title='Controller resource archetype'
/orders/98765/actions/complete-checkout // payment gateway processing

/search?query=laptops&category=electronics // search functionality

/users/12345/actions/reset-password // reset password

/login // Authentication

/batch-jobs/trigger-daily-sync // Batch updates
```
### Naming convention
- Use forward slash (/) to indicate hierarchical relationships.
```URI title='URL hierarchy are organized with forward slash'
/device-management
/device-management/managed-devices
/device-management/managed-devices/{id}
/device-management/managed-devices/{id}/scripts
/device-management/managed-devices/{id}/scripts/{id}
```
- Do not use trailing forward slash in URIs because it is meaningless.
```URI title='Remove trailing forward slash in URIs'
http://api.example.com/device-management/managed-devices/ 
http://api.example.com/device-management/managed-devices --> better
```
- Use hyphen (-), rather than underscore (\_) to separate lengthy names.
```URL title='Add hyphen if the name is too long to read'
http://api.example.com/devicemanagement/manageddevices/
http://api.example.com/device-management/managed-devices 	--> better
```
- Use lower-case letters.
```URI title='Use lower-case letter instead of upper-case letters'
http://api.example.org/my-folder/my-doc       //1
HTTP://API.EXAMPLE.ORG/my-folder/my-doc     //2
http://api.example.org/My-Folder/my-doc       //3
```
- Do not use file extension on URIs, but use the media type with HTTP Header`Content-Type` instead.
```URI title='Do not use file extension on URIs'
/device-management/managed-devices.xml  /*Do not use it*/

/device-management/managed-devices 	/*This is correct URI*/
```
- Use queries and do not create new APIs for filter functionality.
```URI title='Use queries for filter'
/device-management/managed-devices
/device-management/managed-devices?region=USA
/device-management/managed-devices?region=USA&brand=XYZ
/device-management/managed-devices?region=USA&brand=XYZ&sort=installation-date
```
- Do not use verbs in URIs, except some special cases.
```URI title='Do not use verbs in URIs'
/device-management/managed-devices/{id}/scripts/{id}/execute	//DON't DO THIS!

/device-management/managed-devices/{id}/scripts/{id}/status		//POST request with action=execute
```
***
# References
1. [[software-engineering/api/protocol/web-service/rest/Representational State Transfer (REST)|Representational State Transfer (REST)]]
2. 
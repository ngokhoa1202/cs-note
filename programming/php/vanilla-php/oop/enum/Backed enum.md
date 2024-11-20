#php #vanilla-php #oop 

# Definition
- Enum with backed scalar types: `int` and `string`
```PHP
<?php  
  
namespace App\Enums;  
  
enum HttpMethod: string {  
  case GET = "get";  
  case POST = "post";  
  case PUT = "put";  
  case DELETE = "delete";  
}  
  
?>
```
- Each object is singleton.
- There is no constructor, destructor.
# Note
- Use `value` property to access enum value.
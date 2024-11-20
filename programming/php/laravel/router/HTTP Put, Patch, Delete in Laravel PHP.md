#laravel #php #html #computer-network #application-layer #http #api  #api-tool 

# PHP put bugs
- PHP does not support PUT method perfectly.
- Neither does Laravel.
- If we natively send a PUT or PATCH request, the language ==cannot read data== directly.
# Method
## Web API
- The request method must be ==POST== by default instead of PUT.
- Add `_method: PUT` to the form data.
## HTML Form
- The request method must be ==POST== by default instead of PUT.
- Add HTML attribute `method=_put`.

# References
1. https://medium.com/an-idea/fix-laravels-ajax-put-patch-issue-9eb333b04acb
2. 
#laravel #php #software-architecture 

# Request lifecycle
- ![800](laravel-lifecycle.drawio.png)
- Router is not an explicit class. It is the process of request being handled in `Route.php` $\to$ `app/Providers/RouteServiceProviders.php`.
- View may be replaced with Web API (json, xml format) in case of using Laravel as API implementation.
- 
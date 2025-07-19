#php #software-engineering  #object-oriented-programming #psr-11 #composer 

- A class has information about other class to resolve depencies between classes.
- Specified in PSR-11.

# Set up
- Install `psr/container` package in composer
# Implementation
- PSR-11 does not specify how to implement entries, it depends on frameworks.
- Implements `ContainerInterface`.
- https://youtu.be/78Vpg97rQwE?list=PLr3d3QYzkw2xabQRUpcZ_IBk9W50M9pe-&t=151
```PHP
<?php  
  
namespace App;  
use App\Exception\ClassNotFoundException;  
use Psr\Container\ContainerInterface;  
  
class Container implements ContainerInterface {  
  
  private array $entries = [];  
  
  /**  
   * @param string $id fully qualified name of class  
   * @return mixed  
   */  public function get(string $id) {  
    if (! $this->has($id)) {  
      throw new ClassNotFoundException($id);  
    }  
    $callback = $this->entries[$id];  
    return $callback($this);  
  }  
  
  public function has(string $id): bool {  
    return isset($this->entries[$id]);  
  }  
  
  /**  
   * @param string $id  
   * @param callable $callback function that creates the requested object  
   * @return void  
   */  public function set(string $id, callable $callback): void {  
    $this->entries[$id] = $callback;  
  }  
}
```
- In App, register those dependencies by passing callback as arguments.
```PHP
private function __construct(protected Router $router, protected array $request, protected Configuration $config) {  
  static::$databaseConnection = new Database($config->database);  
  static::$encryption = new Encryption($config->encryption);  
  static::$sessionInterval = $config->session["interval"];  
  
  static::$container = new Container();  
  static::$container->set(MenuModel::class, fn() => MenuModel::make());  
  static::$container->set(MenuService::class, function(Container $container) {  
    return new MenuService($container->get(MenuModel::class));  
  });  
}
```
- In Controller, call `container` from App
```PHP
<?php  
  
namespace App\Controller;  
  
use App\App;  
use App\Service\MenuService;  
use App\View;  
  
class HomeController {  
  
  public function index(): string {  
    //return View:  :make("home");  
    echo App::$container->get(MenuService::class)->getNumberOfMenus();  
  }  
  
  
}  
  
?>
```
# Autorwiring
- Allows classes to ==resolve dependency without explicit binding==.
- ==Recursively resolve== dependency until all dependencies are resolved.
- Employs [Reflection class](Reflection%20class.md)
## Passing callback as argument

```PHP
<?php  
  
namespace App;  
use App\Exception\ClassNotFoundException;  
use App\Exception\ContainerException;  
use Psr\Container\ContainerInterface;  
  
class Container implements ContainerInterface {  
  
  private array $entries = [];  
  
  /**  
   * @param string $id fully qualified name of class  
   * @return mixed  
   */  public function get(string $id) {  
    if ( $this->has($id)) {  
      $callback = $this->entries[$id];  
      return $callback($this);  
    }  
  
    return $this->resolve($id);  
  }  
  
  public function resolve(string $id) {  
    // Inspect class  
    $reflectionClass = new \ReflectionClass($id);  
    // If class has its constructor  
    if (! $reflectionClass->isInstantiable()) {  
      throw new ContainerException();  
    }  
  
    // Inspect its constructor  
    $constructor = $reflectionClass->getConstructor();  
    // if class does not have constructor  
    if (! $constructor) {  
      // return default constructor  
      return $reflectionClass->newInstance();  
    }  
  
    // Inspect constructor param === dependencies  
    $parameters = $constructor->getParameters();  
    // if class constructor does not have parameters  
    if (! $parameters) {  
      return new $id;  
    }  
  
    // If there is any dependency in constructor params, resolve that dependency  
    $dependencies = array_map(function(\ReflectionParameter $param) use ($id) {  
      $name = $param->getName();  
      $type = $param->getType();  
  
      // check if param is type hinted  
      // require type hints to run      if (! $type) {  
        throw new ContainerException("Failed to resolve class because there is no type hints");  
      }  
        
      // do no accept union type  
      if ($type instanceof \ReflectionUnionType) {  
        throw new ContainerException("Failed to resolve class becasue there is a dependency of union type");  
      }  
        
      // if param is of user-defined type => create the instance of that type by recursive call  
      // get -> resolve -> (if user-defined type) get -> ... -> only built-in types -> stop      if ($type instanceof  \ReflectionNamedType && ! $type->isBuiltin()) {  
        return $this->get($type->getName());  
      }  
  
      throw new ContainerException("Failed to resolve class because there is an invalid param " . $name);  
    }, $parameters);  
  
    return $reflectionClass->newInstanceArgs($dependencies);  
  }  
  
  public function has(string $id): bool {  
    return isset($this->entries[$id]);  
  }  
  
  /**  
   * @param string $id  
   * @param callable $callback function that creates the requested object  
   * @return void  
   */  public function set(string $id, callable $callback): void {  
    $this->entries[$id] = $callback;  
  }  
}
```

## Passing classname as argument
```PHP
<?php  
  
namespace App;  
use App\Exception\ClassNotFoundException;  
use App\Exception\ContainerException;  
use Psr\Container\ContainerInterface;  
  
class Container implements ContainerInterface {  
  
  private array $entries = [];  
  
  /**  
   * @param string $id fully qualified name of class  
   * @return mixed  
   */  public function get(string $id) {  
    if ($this->has($id)) {  
      $entry = $this->entries[$id];  
  
      if (is_callable($entry)) {  
        return $entry($this);  
      }  
      // if id is class name => create obj according to class name  
      return $this->resolve($entry);  
    }  
  
    return $this->resolve($id);  
  }  
  
  public function resolve(string $id) {  
    // Inspect class  
    $reflectionClass = new \ReflectionClass($id);  
    // If class has its constructor  
    if (! $reflectionClass->isInstantiable()) {  
      throw new ContainerException("Class " . $id . " is not instantiable");  
    }  
  
    // Inspect its constructor  
    $constructor = $reflectionClass->getConstructor();  
    // if class does not have constructor  
    if (! $constructor) {  
      // return default constructor  
      return $reflectionClass->newInstance();  
    }  
  
    // Inspect constructor param === dependencies  
    $parameters = $constructor->getParameters();  
    // if class constructor does not have parameters  
    if (! $parameters) {  
      return new $id;  
    }  
  
    // If there is any dependency in constructor params, resolve that dependency  
    $dependencies = array_map(function(\ReflectionParameter $param) use ($id) {  
      $name = $param->getName();  
      $type = $param->getType();  
  
      // check if param is type hinted  
      // require type hints to run      if (! $type) {  
        throw new ContainerException("Failed to resolve class because there is no type hints");  
      }  
        
      // do no accept union type  
      if ($type instanceof \ReflectionUnionType) {  
        throw new ContainerException("Failed to resolve class becasue there is a dependency of union type");  
      }  
        
      // if param is of user-defined type => create the instance of that type by recursive call  
      // get -> resolve -> (if user-defined type) get -> ... -> only built-in types -> stop      if ($type instanceof  \ReflectionNamedType && ! $type->isBuiltin()) {  
        return $this->get($type->getName());  
      }  
  
      throw new ContainerException("Failed to resolve class because there is an invalid param " . $name);  
    }, $parameters);  
  
    return $reflectionClass->newInstanceArgs($dependencies);  
  }  
  
  public function has(string $id): bool {  
    return isset($this->entries[$id]);  
  }  
  
  /**  
   * @param string $id  
   * @param callable|string $callback function or class name that creates the requested object  
   * @return void  
   */  public function set(string $id, callable | string $concreteInpl): void {  
    $this->entries[$id] = $concreteInpl;  
  }  
}
```

# References
1. https://php-di.org/ 
2. https://www.youtube.com/watch?v=78Vpg97rQwE&list=PLr3d3QYzkw2xabQRUpcZ_IBk9W50M9pe-&index=72 for DI implementation.
3. https://youtu.be/78Vpg97rQwE?list=PLr3d3QYzkw2xabQRUpcZ_IBk9W50M9pe-&t=914 for Reflection API.
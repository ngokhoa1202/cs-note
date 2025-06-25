#php #interface 

# Characteristics
- Implements `Iterator` interface.
- Employs `yield` keyword, which ==pauses execution== for external use instead of stopping execution.
- Cannot `rewind` during or after traversing.
- Uses `foreach` loop to traverse.
# yield keyword
- `yield` provides a value to the external loop employing the generator and pauses execution of the generator function.
# Example
```PHP title='Generator example in PHP'
<?php  
namespace App\Controller;  

class GeneratorExampleController {  
  public function index() {  
    $numbers = $this->lazyRange(1, 1000);  
    foreach ($numbers as $key => $value) {  
      echo $key . " " . $value . "<br/>";  
    }  
  }  
  
  private function lazyRange(int $start, int $end): \Generator {  
    for ($i = $start; $i <= $end; ++$i) {  
      yield (2*$i + 1) => $i * $i;  
    }  
  }  
}  
  
  
?>
```
# Application
- ==Reduces memory usage== and processing time for generation objects.
# References
1. https://www.php.net/manual/en/language.generators.overview.php for Generator
2. https://www.php.net/manual/en/language.generators.syntax.php#control-structures.yield for yield keyword.

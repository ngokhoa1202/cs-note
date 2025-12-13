#object-oriented-programming #design-pattern 

```Java title='Java employs single dispatch, which happens at compile time'
class Shape { }
class Circle extends Shape { }
class Rectangle extends Shape { }

class CollisionDetector {
    // We want to overload based on BOTH parameters' actual types
    public boolean collides(Circle c1, Circle c2) { /* circle-circle logic */ }
    public boolean collides(Circle c, Rectangle r) { /* circle-rectangle logic */ }
    public boolean collides(Rectangle r, Circle c) { /* rectangle-circle logic */ }
    public boolean collides(Rectangle r1, Rectangle r2) { /* rectangle-rectangle logic */ }
}
```
# References
1. [[software-engineering/software-architecture/design/design-pattern/classical-pattern/behavioral-pattern/Visitor pattern]] 
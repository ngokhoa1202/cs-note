#design-pattern #software-engineering  #software-architecture #object-oriented-programming #behavioral-pattern  #solid #functional-programming  #java 
# Purpose
- Represent an operation to be performed on the elements of an object structure.
- Define a new operation <mark class="hltr-yellow">without changing the classes of the elements</mark> on which it operates.
# Application

# Components
- ![[Pasted image 20250719110605.png]]
- ![[Pasted image 20250719112748.png]]
## Visitor
- Declares a <mark class="hltr-yellow">Visit operation for each class of Concrete Element</mark> in the object structure. The operation's name and signature identifies the class that sends the Visit request to the Visitor.
## Concrete Visitors
- Implements each operation declared by Visitor. Each operation <mark class="hltr-yellow">implements a fragment of the algorithm defined for the corresponding class of object</mark> in the structure.
- Provides the context for the algorithm and stores its local state, which accumulates results during the traversal of the whole object structure.
## Element
- Declares an <mark class="hltr-yellow">Accept operation</mark> that takes a visitor as its argument.
## Concrete elements
- Implements its own Accept operation that takes a visitor as an argument by <mark class="hltr-yellow">redirecting the call to the proper visitor’s method</mark> corresponding to the current element class.
## Object structure
- Represent a complicated business logic or complex data structure that is decomposed into elements.
# Flowchart
- ![[Pasted image 20250719113152.png]]
- A client that uses the Visitor pattern must create a Concrete Visitor object and then traverse the object structure, visiting each element with the visitor.
- When an element is visited, it calls the Visitor operation that corresponds to its class. The element passes itself as an argument to this operation to allow the visitor to access its state.
- ![[Pasted image 20250719143153.png]]
# Examples
## Abstract syntax tree
- `class Expression` is the element defining an abstract `accept` method for all of the concrete elements
```Java title='class Expression is an abstract Element'
public abstract class Expression {
  public abstract <T> T accept(ExpressionVisitor<T> visitor);
}
```

- `interface ExpressionVisitor` declares a visit operation for each concrete type of expression which accepts that type as the method's argument. It implements the `visit` method on its own by redirecting the call to the `accept` method of `Expression`.
```Java title='interface ExpressionVisitor is an abstract Visitor'
public interface ExpressionVisitor<T> {
  default T visit(Expression expr) {
    return expr.accept(this);
  }
  T visitFloatLiteral(FloatLiteral expr);
  T visitIntegerLiteral(IntegerLiteral expr);
  T visitBinaryExpression(BinaryExpression expr);
  T visitUnaryExpression(UnaryExpression expr);
}
```

- `class BinaryExpression`, `class FloatLiteral`, `class IntegerLiteral` and `class UnaryExpression` are the concrete Elements. Every class must define the `accept` method by <mark class="hltr-yellow">delegating the responsibility to its visitor argument</mark>. The visitor object must explicitly invoke the **corresponding method** to its class context and should not call the general `visit` method.
```Java title='Concrete elements of abstract Expression element'
import lombok.Getter;  
import lombok.RequiredArgsConstructor;  
import lombok.Setter;
@Getter
@Setter
@RequiredArgsConstructor
public class FloatLiteral extends Expression {

  private final Float value;

  @Override
  public <T> T accept(ExpressionVisitor<T> visitor) {
    return visitor.visitFloatLiteral(this);
  }
}


@Getter
@Setter
@RequiredArgsConstructor
public class IntegerLiteral extends Expression {

  private final Integer value;

  @Override
  public <T> T accept(ExpressionVisitor<T> visitor) {
    return visitor.visitIntegerLiteral(this);
  }
}

@Getter
@Setter
@RequiredArgsConstructor
public class UnaryExpression extends Expression {

  private final String operator;
  private final Expression operand;


  @Override
  public <T> T accept(ExpressionVisitor<T> visitor) {
    return visitor.visitUnaryExpression(this);
  }
}


@Getter
@Setter
@RequiredArgsConstructor
public class BinaryExpression extends Expression {

  private final Expression left;
  private final Expression right;
  private final String op;


  @Override
  public <T> T accept(ExpressionVisitor<T> visitor) {
    return visitor.visitBinaryExpression(this);
  }
}
```
- `class EvaluationVisitor` and `class PrefixPrintVisitor` are the concrete Visitors. Each class implements its own core algorithm to represent a specific behavior of components of the Object structure. The implementation of each `visit` method is partially simplified by employing the general `visit` method instead of the specific `visit`one.
```Java title='class EvaluationVisitor and class PrefixPrintVisitor are the concrete Visitors'
public class EvaluationVisitor implements ExpressionVisitor<Float> {

  @Override
  public Float visitFloatLiteral(FloatLiteral expr) {
    return expr.getValue();
  }

  @Override
  public Float visitIntegerLiteral(IntegerLiteral expr) {
    return expr.getValue().floatValue();
  }

  @Override
  public Float visitBinaryExpression(BinaryExpression expr) {
    final var left = this.visit(expr.getLeft());
    final var right = this.visit(expr.getRight());
    return (float) switch (expr.getOp()) {
      case "+" -> left + right;
      case "-" -> left - right;
      case "*" -> left * right;
      case "/" -> left / right;
      case "^" -> Math.pow(left, right);
      default -> 0f;
    };
  }

  @Override
  public Float visitUnaryExpression(UnaryExpression expr) {
    final var operand = this.visit(expr.getOperand());
    return switch (expr.getOperator()) {
      case "+" -> operand;
      case "-" -> -operand;
      case "sgn" -> Math.signum(operand);
      default -> 0f;
    };
  }
}


public class PrefixPrintVisitor implements ExpressionVisitor<String> {

  @Override
  public String visitFloatLiteral(FloatLiteral expr) {
    return expr.getValue().toString();
  }

  @Override
  public String visitIntegerLiteral(IntegerLiteral expr) {
    return expr.getValue().toString();
  }

  @Override
  public String visitBinaryExpression(BinaryExpression expr) {
    final var left = this.visit(expr.getLeft());
    final var right = this.visit(expr.getRight());
    return String.format("%s %s %s", expr.getOp(), left, right);
  }

  @Override
  public String visitUnaryExpression(UnaryExpression expr) {
    final var operand = this.visit(expr.getOperand());
    return String.format("%s %s", expr.getOperator(), operand);
  }
}
```
- `class Main` is  a Client class. It has to initialize the Concrete Visitor freely requests the Visitor to do the business logic on its elements.
```Java title='class Main is a Client class'

public class App {

  public static void demoVisitor(ExpressionVisitor<?> visitor, Expression ...expressions) {
    Arrays.stream(expressions).map(e -> e.accept(visitor)).forEach(System.out::println);
  }

  /**
   * Program entry point.
   *
   * @param args command line args
   */
  public static void main(String[] args) {
    final var evalVisitor = new EvaluationVisitor();
    final var prefixPrintVisitor = new PrefixPrintVisitor();

    final var x1 = new IntegerLiteral(3);
    final var x2 = new FloatLiteral(2.0f);
    final var x3 = new BinaryExpression(x1, x2, "^"); // 3 ^ 2 = 9
    final var x4 = new UnaryExpression("-", x3); // -9
    final var x5 = new BinaryExpression(x4, new BinaryExpression(new IntegerLiteral(5), x2, "*"), "-"); // -9 - (5 * x2 = -9 - 5*2 = -19

    demoVisitor(evalVisitor, x1, x2, x3, x4, x5);
    demoVisitor(prefixPrintVisitor, x1, x2, x3, x4, x5);
  }
}

```
# Design

# Consequences
## Visitor makes adding new operations easier
- With visitor, it is simple to define a new operation over an object structure simply by adding a new visitor without making any changes to the current structure. $\implies$ ensure [[SOLID#Open-closed principle.]]
## Visitor centralizes related operations in a single class
- Related behaviors are not dispersed over the classes defining the object structure but instead localized into a Visitor. Unrelated sets of behavior are partitioned in their own visitor.
- The algorithm and the element classes are separated. $\implies$ ensure [[SOLID#Single responsibility principle]]
## Adding a new Concrete Element is hard
- The Object Structure is already a cohesive data structure. The Visitor class hierarchy can be difficult to maintain when new Concrete Element classes are added frequently.
## Accumulating state
- Visitors can accumulate state as they visit each element in the object structure. 
- Without a visitor, this state would be passed as extra arguments to the operations that perform the traversal, or they might appear as global variables.
## Encapsulation may be broken
- Visitor's approach assumes that the Concrete Element interface is powerful enough to let visitors do their job. As a consequence, it can force the Concrete Element to expose public access to some state.
# Design
## Double dispatch
- Double-dispatch simply means the operation that gets executed depends on the kind of request and the types of two receivers.
- `Accept` is a double-dispatch operation. Its meaning depends on two types: the Visitor's and Element's. Double-dispatching lets visitors request different operations on each class of element.
```Java title='Double dispatch analysis'
// First Dispatch (virtual method call):
expr.accept(visitor)  // Calls accept() on the actual expression type
// Second Dispatch (method overloading)
visitor.visitBinaryExpression(this)  // Calls specific visitor method
```
## Object structure traversal

# Real examples
## Compiler's static checking
- https://github.com/ngokhoa1202/hcmut-ppl 

# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
		1. Visitor.
2. https://github.com/ngokhoa1202/hcmut-ppl for Abstract Syntax Tree HCMUT Assignment - Trần Ngọc Bảo Duy.
3. [[SOLID]] for SOLID principles in Software Engineering.
4. 
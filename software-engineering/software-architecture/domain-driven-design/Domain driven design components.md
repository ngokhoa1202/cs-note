#software-engineering #software-architecture #software-testing #design-pattern #microservice 
#dependency-manager #dependency-injection #oop #solid #agile #project-management #ddd 
#erd-diagram #dbms-design 

# Overview picture
- ![](Pasted%20image%2020241117103410.png)
# Associations
## Concepts
### Association
- Association is composed of aggregation and composition exclusively.
	- Class A associates with Class B when Class A owns an object of class B as one of its attributes (maybe a single object of class B or a collection of objects of class B).
### Multiplicity
- There is 3 types of association multiplicity:
	- One-to-one mapping.
	- Many-to-one mapping.
	- Many-to-many mapping.
### Relationship direction
- The association relationship may be either uni-directional or bi-directional.
## Principles
- For every traversable association in the model there is a mechanism with the same properties $\equiv$ Access a model object in the relationship via the internal property.
- Always constrain relationships as much as possible.
- ![](Pasted%20image%2020241117124436.png)
- ![](Pasted%20image%2020241117124645.png)
- Consistently <mark style="background: #e4e62d;">constraining associations in ways that reflect the bias of the domain</mark> makes those associations more communicative and simpler to implement.
# Entities
- An object defined primarily by <mark style="background: #e4e62d;">its identity</mark>  and employed to express a Model is called an Entity.
- ![](Pasted%20image%2020241117142052.png)
- An entity can reference to another entity or a certain value object.

# Value objects
- An object <mark style="background: #e4e62d;">without identity</mark> but employed to directly express a Model is a Value Object.
- A value object can reference to an entity.
- When only the <mark style="background: #e4e62d;">attributes</mark> but not the identity of a model <mark style="background: #e4e62d;">is concerned</mark>, opt for a value object instead of an entity.
- ![](Pasted%20image%2020241117142851.png)
- A value object is an <mark style="background: #e4e62d;">immutable, shared</mark> object among classes via shallow copy mechanism. [Flyweight pattern](Flyweight%20pattern.md)
# Services
- A Service is an operation offered <mark style="background: #e4e62d;">as an interface</mark> that stands alone in the model, without encapsulating state as entities and value objects do.
- A Service tends to be named for <mark style="background: #e4e62d;">an activity</mark>, a “<mark style="background: #e4e62d;">verb</mark>” rather than a “noun”.  
- A Service should still have a <mark style="background: #e4e62d;">defined responsibility</mark>, and that responsibility and the interface fulfilling it should be defined in terms of the domain language. $\implies$ The Service is always <mark style="background: #e4e62d;">stateless</mark>.
- The concept of Service is integrated into the whole layered architecture.
- ![](Pasted%20image%2020241117144933.png)
# Modules - packages
- Each module - package should reflect insight in the domain.
- Short, cohesive importation.
# Lifecycle of domain objects
- ![](Pasted%20image%2020241117152624.png)
- Each domain object has its own lifecycle.
- Domain Driven Design provides three patterns - components for managing the lifecycle:
## Aggregates
### Concepts
- Simple association mechanism is not sufficient to maintain strict business rules.
- An aggregate is a <mark style="background: #e4e62d;">cluster of associated objects</mark> which are treated as a unit for the purpose of <mark style="background: #e4e62d;">data modification</mark>. Each aggregate is defined by a aggregate root and a boundary. The root is the only member of the aggregate to which external objects are allowed to hold references.
### Rules
- The aggregate root has global identity, and is ultimately responsible for checking invariants.
- Entities inside the boundary have local identity, unique only within the aggregate.
- <mark style="background: #ADCCFFA6;">External objects to the aggregate boundary cannot hold a reference to anything inside, except to the root entity.</mark>
- The root entity can hand references to the internal entities to other objects, but those objects can only use them transiently, and may not hold onto the reference. The root may hand a copy of a value to another object.
- <mark style="background: #ADCCFFA6;">Only the aggregate root can be directly obtained with database queries</mark>. All other objects must be found by traversal of associations.
- <mark style="background: #ADCCFFA6;">Any rule which spans aggregates is not expected to be always immediately executed</mark>. This may involve event sourcing, batch processing,...
- However, <mark style="background: #ADCCFFA6;">invariants within an aggregate must be committed</mark> before the end of a transaction.
### Examples
- The car is an <mark style="background: #ADCCFFA6;">entity with global identity</mark> – used to distinguish a certain car with other cars. We can use the Vehicle Identification Number for  this. 
- We might want to track the rotation history of the tires through the four wheel positions. We might want to know mileage and tread wear of each tire. To know which tire is which, the tires must be identified entities also. But it is very <mark style="background: #ADCCFFA6;">unlikely that we care about the identity of those tires outside of the context of that particular car</mark>. 
- More to the point, even while they are attached to the car, no one will try to query the system to find a particular tire and then see which car it is on. They will query the database to find a car and then ask it for a transient reference to the tires. 
- Therefore, the car is the <mark style="background: #ADCCFFA6;">root entity</mark> of the <mark style="background: #ADCCFFA6;">aggregate whose boundary encloses the tires</mark> also. On the other hand, engine blocks have serial numbers engraved on them and are sometimes tracked independently of the car. In some applications, the engine might be the root of its own aggregate .
- ![](Pasted%20image%2020241117160436.png)

## Factories
### Concepts
- Factories pattern assume the responsibility of object construction or object reconstitution.
- Factories is necessary when the construction of objects is complicated or it should be loosely coupling with the client. (e.g: [Factory Method pattern](Factory%20Method%20pattern.md), [Abstract Factory pattern](Abstract%20Factory%20pattern.md))
- ![](Pasted%20image%2020241117165423.png)
### Rules
- Each creation method is <mark style="background: #ADCCFFA6;">atomic</mark> and <mark style="background: #ADCCFFA6;">enforces all invariants</mark> of the created object or aggregate. An exception or some other mechanisms should be raised when there is no proper return.
- The factories should be abstracted - or loosely coupling with their clients.
## Examples
- Factories can be used in an aggregate or among aggregates or as a standalone factory.
- ![](Pasted%20image%2020241117170917.png)
- The Trade Order is not part of the same AGGREGATE as the Brokerage Account because, for a start, it will go on to interact with the trade execution application, where the Brokerage Account would only be in the way. Even so, it seems natural to give it control over the creation of Trade Orders. The Brokerage Account contains information that will be embedded in the Trade Order (starting with its own identity) and also rules that govern what trades are allowed. We might also benefit from hiding the implementation of Trade Order. ![](Pasted%20image%2020241117171146.png)
- ![](Pasted%20image%2020241117171537.png)


---
# References
1. Domain Driven Design - Eric Evans - 2003
	1. A Model Expressed in Software.
	2. The Lifecycle of a Domain Object.
2. https://stackoverflow.com/questions/21967841/aggregation-vs-composition-vs-association-vs-direct-association for aggregation, composition and association concepts in OOP.
3. [ERD](ERD.md) for ERD Mapping and Association in OOP.
4. https://medium.com/@pratik.941/understanding-the-cloneable-interface-shallow-copy-and-deep-copy-in-java-73c45066ecb1 for Shallow copy and Deep copy concepts.
5. [Layered architecture](Layered%20architecture.md) for layered architecture in DDD.
6. https://en.wikipedia.org/wiki/Common_Object_Request_Broker_Architecture for CORBA,.
7. [Design patterns](Design%20patterns.md) for the classic 23 design patterns.
8. 

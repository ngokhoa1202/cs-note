#oop #solid #design-pattern  #software-engineering #creational-pattern #software-architecture 

# Purpose
- Separates the construction of a complex object from its representation so that the same construction can create multiple representations.
# Application
- Parts of the complex object need to be ==created step by step and assembled when necessary==. 
- Allows ==multiple representations== of that object.
# Components
- ![](Pasted%20image%2020240602203427.png)
## Director
- Employs Builder to construct object.
- Must know about the steps to instantiate `product`:
	- Given a run-time Concrete Builder but only knows about Builder interface.
- Usually client.
## Abstract Builder
- Abstracts other Concrete Builders
- Provide interface for BuildPart and Assemble method to other Concrete Builders
- Optional.
## Concrete Builder
- ==Constructs== product step by step and ==assembles final product==.
- Implements `interface Builder`.
## Product
- Final complex `Product` we want to consume.
# Example
- ![](Pasted%20image%2020240602204852.png)
## Requirement
- Client (director) wants to instantiate a `UserDTO` obj from `User` obj.
- `User` and `UserDTO` has complex constructor.
## Implementation
- class `UserWebDTOBuilder` implements interface `UserDTOBuilder`. Method `buildParts` receives arguments from object`User` and  method `build` ==assembles ==these arguments and returning `UserDTO` .
```Java
package com.cpc.dp.builder;

import java.time.LocalDate;
import java.time.Period;

//The concrete builder for UserWebDTO
public class UserWebDTOBuilder implements UserDTOBuilder {
	
	private String firstName;
	private String lastName;
	private String age;
	private String address;
	private UserWebDTO dto;
	
	@Override
	public UserDTOBuilder withFirstName(String fname) {
		firstName = fname;
		return this;
	}

	@Override
	public UserDTOBuilder withLastName(String lname) {
		lastName = lname;
		return this;
	}

	@Override
	public UserDTOBuilder withBirthday(LocalDate date) {
		Period ageInYears = Period.between(date, LocalDate.now());
		age = Integer.toString(ageInYears.getYears());
		return this;
	}

	@Override
	public UserDTOBuilder withAddress(Address address) {
		this.address = address.getHouseNumber() +", " + address.getStreet()
					   +"\n" + address.getCity() +"\n"+address.getState()+" "+address.getZipcode();
		return this;
	}

	@Override
	public UserDTO build() {
		dto = new UserWebDTO(firstName+ " "+lastName, address, age);
		return dto;
	}

	@Override
	public UserDTO getUserDTO() {
		return dto;
	}
	
}

```
- `Client` has to instantiate two objects: a `User` object and a `UserDTOBuilder` object abstracting concrete Builders, then ==pass two objects as arguments== to instantiate a `UserDTO` object.
```Java
package com.cpc.dp.builder;

  

import java.time.LocalDate;

  

//This is our client which also works as "director"

public class Client {

  

	public static void main(String[] args) {
	
		User user = createUser();
		UserDTOBuilder builder = new UserWebDTOBuilder();
		//Client has to provide director with concrete builder
		UserDTO dto = directBuild(builder, user);
		System.out.println(dto);
	}
	
	/**
	* This method serves the role of director in builder pattern.
	*/
	
	private static UserDTO directBuild(UserDTOBuilder builder, User user) {
		return builder.withFirstName(user.getFirstName())
			.withLastName(user.getLastName())
			.withAddress(user.getAddress())
			.withBirthday(user.getBirthday())
			.build();
	}

/**
* Returns a sample user.
*/
	public static User createUser() {
		User user = new User();
		user.setBirthday(LocalDate.of(1960, 5, 6));
		user.setFirstName("Ron");
		user.setLastName("Swanson");
		
		Address address = new Address();
		address.setHouseNumber("100");
		address.setStreet("State Street");
		address.setCity("Pawnee");
		address.setState("Indiana");
		address.setZipcode("47998");
		user.setAddress(address);
	
		return user;
	
	}

}
```

# Design
- Rarely employs `Director`, but instead ==client or consumer of product instance ==
- Can ==directly create concrete builder== without abstract builder.
## Static builder class inside product class
- class `Product` employs `private` setter method.
- For simplicity, create an ==inner static builder class inside a product class==. $\implies$ ==immutable product class==.
- `Builder` inside `Product`:
```Java
package com.cpc.dp.builder2;

import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import com.cpc.dp.builder.Address;

//Product class
public class UserDTO {

	private String name;
	
	private String address;
	
	private String age;

	public String getName() {
		return name;
	}

	public String getAddress() {
		return address;
	}

	public String getAge() {
		return age;
	}
	
	private void setName(String name) {
		this.name = name;
	}

	private void setAddress(String address) {
		this.address = address;
	}

	private void setAge(String age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "name=" + name + "\nage=" + age + "\naddress=" + address ;
	}
	//Get builder instance
	public static UserDTOBuilder getBuilder() {
		return new UserDTOBuilder();
	}
	//Builder
	public static class UserDTOBuilder {
		
		private String firstName;
		
		private String lastName;
		
		private String age;
		
		private String address;
		
		private UserDTO userDTO;
		
		public UserDTOBuilder withFirstName(String fname) {
			this.firstName = fname;
			return this;
		}
		
		public UserDTOBuilder withLastName(String lname) {
			this.lastName = lname;
			return this;
		}
		
		public UserDTOBuilder withBirthday(LocalDate date) {
			age = Integer.toString(Period.between(date, LocalDate.now()).getYears());
			return this;
		}
		
		public UserDTOBuilder withAddress(Address address) {
			this.address = address.getHouseNumber() + " " +address.getStreet()
						+ "\n"+address.getCity()+", "+address.getState()+" "+address.getZipcode(); 

			return this;
		}
		
		public UserDTO build() {
			this.userDTO = new UserDTO();
			userDTO.setName(firstName+" " + lastName);
			userDTO.setAddress(address);
			userDTO.setAge(age);
			return this.userDTO;
		}
		
		public UserDTO getUserDTO() {
			return this.userDTO;
		}
	}
}

```

- `Client`:
```Java
package com.cpc.dp.builder2;

import java.time.LocalDate;

import com.cpc.dp.builder.Address;
import com.cpc.dp.builder.User;
import com.cpc.dp.builder2.UserDTO.UserDTOBuilder;

public class Client {

	public static void main(String[] args) {
		User user = createUser();
		// Client has to provide director with concrete builder
		UserDTO dto = directBuild(UserDTO.getBuilder(), user);
		System.out.println(dto);
	}
}

```
- Allows to call product's private setter method: `UserDTO.build()` .
# Characteristics
- ==Abstracts== object's representation.
- Simple, does not require many interfaces.
- ==Encapsulates== object's construction and representation.
- Constructs product ==step by step==.
# Real examples
- `java.lang.StringBuilder` and buffer classes `ByteBuffer`, `CharBuffer`, ...
	- Do not match 100% Builder pattern
		- But they allow us to build final objects in several steps, providing a part of final object in one step.
- `java.util.Calendar.Builder` in Java 8.
	- Project Lombok `@Builder` annotation.vnh 
# Advantages
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle)
- Reuse construction code, method chaining for convenience.
- Create a complex object step by step.
# Disadvantages
- Requires method chaining.
- Partially initialized object $\implies$ handles missing properties (set by default, throw Exception).

# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Builder pattern.
2. https://www.udemy.com/course/design-patterns-in-java-concepts-hands-on-projects/learn/ 
3. https://projectlombok.org/features/Builder for Project Lombok `@Builder` annotation.

#object-oriented-programming #creational-pattern #design-pattern #solid #software-engineering #software-architecture 

- Sometimes not considered as design pattern.
# Purpose
- The construction has multiple representations. These representation options ==depend on a simple logic==.
- Move the instantiation logic to a ==separate class== or a ==static method==.
# Components
- ![](Pasted%20image%2020240603135103.png)
## `class Client`
- Invokes a construction call.
## `static class SimpleFactory` (optional)
- Provides a ==static method== to create an instance of `Product` subclass.
- Maybe use a a ==incorporated static method== for simplicity, but if reusability is more focused, create a separate class instead.
## `interface Product`
- ==Abstracts== the concrete implementation of `Product`.
## `class ConcreteProduct`
- ==Implements the construction== of specific `Product`.
# Example
- `abstract class Post`
```Java
package com.coffeepoweredcrew.simplefactory;
import java.time.LocalDateTime;
/**
* Abstract post class. Represents a generic post on a web site.
*/
public abstract class Post {
	private Long id;
	private String title;
	private String content;
	private LocalDateTime createdOn;
	private LocalDateTime publishedOn;
}
```
- Three concrete classes `Post`: `NewsPost` and `BlogPost` and `ProductPost`
```Java
package com.coffeepoweredcrew.simplefactory;
/**
* Represents a blog post.
*
*/
public class BlogPost extends Post {
	private String author;
	private String[] tags;
}
```
- `class PostFactory` contains `static` method `createPost`
```Java
package com.coffeepoweredcrew.simplefactory;
public class PostFactory {
	public static Post createPost(String type) {
		switch (type) {
			case "blog":
				return new BlogPost();
			case "news":
				return new NewsPost();
			case "product":
				return new ProductPost();
			default:
				throw new IllegalArgumentException("Unknown Post type");
		}

	}

}
```
- `Client` invokes `createPost` and pass `type` to `createPost` to construct a specific `Post`.
```Java
package com.coffeepoweredcrew.simplefactory;
public class Client {

	public static void main(String[] args) {
	
		Post myPost = PostFactory.createPost("news");
		
		System.out.println(myPost);

	}
}
```

# Real examples
- `java.test.NumberFormat` has `getInstance` method, which is a Simple Factory pattern.
# Disadvantages
- ==Increasingly convoluted== construction due to complex condition $\implies$ use factory method.

#typescript #javascript #object-oriented-programming #solid 

- A typescript's interface has a compile-time behavior.
- Typescript interfaces are not compiled into Javascript interfaces.
# Typescript's interface
- Typescript interface allows both attributes' definition and methods' definition when being compared to OOP language such as Java.
# Readonly properties
- Refers to [Readonly properties](programming/javascript/typescript/Class.md#Readonly%20properties)
- Readonly attributes do not change their value after having been initialized.
```typescript title='Readonly attributes'
interface Company {
	readonly brand: string;
	readonly bestProduct: string;
	revenue: number;
}

const company: Company = {
	brand: 'Microsoft',
	bestProduct: 'Microsoft Windows',
	revenue: 200_000_000
}

company.brand = 'Google';
const anotherCompany = {...company};
anotherCompany.brand = 'Google';

anotherCompany.bestProduct = 'Google Chrome';
```
# Interface's new keyword
- _When a class implements an interface_, _only the instance side of the class is checked_. Since _the constructor sits in the static side_, it is not included in this check.
```ts title='interface constructor signature'
interface ContractConstructor {  
  new (version: number, releaseDate: Date): Contract;  
}  
  
class ContractFactory {  
  static createContract(  
    contractConstructor: ContractConstructor,  
    version: number,  
    releaseDate: Date  
  ) {  
    return new contractConstructor(version, releaseDate);  
  }  
}  
  
interface Contract {  
  version: number;  
  releaseDate: Date;  
  
  sign(): void;  
}  
  
class FakeContract implements Contract {  
  constructor(public version: number, public releaseDate: Date) {}  
  
  public sign(): void {  
    console.log(  
      `This is a fake contract: ${this.version} on ${this.releaseDate}`  
    );  
  }  
}  
  
class RealContract implements Contract {  
  constructor(public version: number, public releaseDate: Date) {}  
  
  sign(): void {  
    console.log(  
      `This is a real contract: ${this.version} on ${this.releaseDate}`  
    );  
  }  
}  
  
const realContract: Contract = ContractFactory.createContract(  
  RealContract,  
  1,  
  new Date()  
);  
const fakeContract: Contract = ContractFactory.createContract(  
  FakeContract,  
  0,  
  new Date()  
);  
  
realContract.sign();  
fakeContract.sign();
```

# Getter - Setter
- Naming convention for access modifier:
	- `public`: do nothing.
	- `private`: add `_` (underscore) prefix.
	- `protected` : do nothing or add `_` prefix.
# Optional properties
- Refers to [Optional properties](programming/javascript/typescript/Type.md#Optional%20properties).
# Functional interface
- Functional interface only has one method signature as a high-order function.
- Function interface can be employed as a function type.
```typescript title='Functional interface in Typescript'
interface Logger {
    (message: string): void;
    level: string;
}

// Example usage
const consoleLogger: Logger = (message: string) => {
    console.log(`[${consoleLogger.level}] ${message}`);
};
consoleLogger.level = "INFO"

consoleLogger("System started"); // Output: [INFO] System started

```
# Typescript's interface cheatsheet
- Everything in Javascript is an object and Typescript's interface is used to <mark style="background: #e4e62d;">match their runtime behavior</mark>.
---
# References
1. https://www.typescriptlang.org/cheatsheets/
2. *https://www.typescriptlang.org/docs/handbook/2/objects.html*
3. [Class](programming/javascript/typescript/Class.md) for Javascript classes.
4. [Class](programming/javascript/typescript/Class.md) for Typescript classes.
5. [Type](programming/javascript/typescript/Type.md) for Typescript type.
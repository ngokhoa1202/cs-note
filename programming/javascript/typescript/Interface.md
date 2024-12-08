#typescript #javascript #oop #solid 

- A typescript's interface has a compile-time behaviour.
# Interface's new keyword
- _When a class implements an interface_, _only the instance side of the class is checked_. Since _the constructor sits in the static side_, it is not included in this check.
```ts
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
# Typescript's interface cheatsheet
- Everything in Javascript is an object and Typescript's interface is used to <mark style="background: #e4e62d;">match their runtime behaviour</mark>.
- ![TypeScript Interfaces](TypeScript%20Interfaces.pdf)
---
# References
1. https://www.typescriptlang.org/cheatsheets/
2. https://www.typescriptlang.org/docs/handbook/2/objects.html
3. 
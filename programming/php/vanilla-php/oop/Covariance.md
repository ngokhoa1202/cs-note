#php #oop #software-engineering #solid

- Only works with PHP $\geq$ 7.4.
- ==Narrowing return type==.
# Definition
- Covariance allows a child method to ==return a more specific type== than the return type of its parent method $\implies$ $T_{child}$ is a $T_{parent}$ $\equiv$ child method specilization.
- PHP only supports ==covariant return type==.
# Note
- Covariant union type is allowed in case of removal
	- `string | int` $\rightarrow$ `string` is ok.
- Covariant intersection type is allowed in case of addition.
	- `A` $\rightarrow$ `A&B` is ok.
- Conforms to [Liskov Substitution principle](SOLID.md#Liskov%20Substitution%20principle)
# References
1. https://www.php.net/manual/en/language.oop5.variance.php for example.
2. 
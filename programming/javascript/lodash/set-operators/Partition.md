#algebra #functional-programming #high-order-function #lodash #vanilla-javascript #javascript #typescript 

# Syntax
```Javascript title='Partition function in Lodash'
_.parition(collection, predicate)
```
# Behavior
- `Partition` creates an array of elements <mark class="hltr-yellow">split into two groups</mark>, the first of which contains elements `predicate` returns **truthy** for, the second of which contains elements `predicate` returns **falsey** for. The predicate is invoked with one argument: _(value)_.
```Javascript title='Partition to separate valid and invalid emails'
const _ = require('lodash');

const emails = [
  'user@example.com',
  'invalid-email',
  'admin@company.org',
  'not.an.email',
  'support@help.com',
  '@missing.com'
];

const [validEmails, invalidEmails] = _.partition(emails, email => 
  /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
);

console.log('Valid:', validEmails);
// Valid: ['user@example.com', 'admin@company.org', 'support@help.com']

console.log('Invalid:', invalidEmails);
// Invalid: ['invalid-email', 'not.an.email', '@missing.com']
```
---
# References
1. https://lodash.com/docs/4.17.15#partition
2. 
#abstract-syntax-tree #compilation #javascript #vanilla-javascript #typescript 

# Type conversion cheatsheet

| Original value   | Number conversion | String conversion | Boolean conversion |     |
| ---------------- | ----------------- | ----------------- | ------------------ | --- |
| true             | 1                 | "true"            | true               |     |
| 0                | 0                 | "0"               | false              |     |
| 1                | 1                 | "1"               | true               |     |
| "0"              | 0                 | "0"               | true               |     |
| "1"              | 1                 | "1"               | true               |     |
| NaN              | NaN               | "NaN"             | false              |     |
| Infinity         | Infinity          | "Infinity"        | true               |     |
| -Infinity        | -Infinity         | "-Infinity"       | true               |     |
| ""               | 0                 | ""                | false              |     |
| "20"             | 20                | "20"              | true               |     |
| "twenty"         | NaN               | "twenty"          | true               |     |
| [ ]              | 0                 | ""                | true               |     |
| [20]             | 20                | "20"              | true               |     |
| [10,20]          | NaN               | "10,20"           | true               |     |
| ["twenty"]       | NaN               | "twenty"          | true               |     |
| ["ten","twenty"] | NaN               | "ten,twenty"      | true               |     |
| function(){}     | NaN               | "function(){}"    | true               |     |
| { }              | NaN               | "[object Object]" | true               |     |
| null             | 0                 | "null"            | false              |     |
| undefined        | NaN               | "undefined"       | false              |     |
# Truthy - falsy values
- All values are considered truthy except`false`, `0`, `-0`, `0n`, `""`, `null`, `undefined`, `NaN` and `document.all`
---
# References
1. https://www.w3schools.com/jsref/jsref_type_conversion.asp for Type conversion cheatsheet
2. https://developer.mozilla.org/en-US/docs/Glossary/Truthy for truthy and falsy value.
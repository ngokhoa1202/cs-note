#php #vanilla-php #data-type #debug 

# NULL in PHP
- By default, some operators in PHP (like `<=, >=` in comparison) try to cast null to other data type to compare.
- But this can lead to unexpected logic and very difficult to debugs.
# Good practice
- Always ==compare with strict equal oprator== `===` in PHP ==before== performing further comparison to prevent any illogical errors.
- Or check with `isset($variable)`, do not use `is_null` function because PHP will perform type casting for comparison.
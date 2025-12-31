#leetcode #string #hash-table  #sorting #array
# Algorithm
- A hash table whose key is a specific function and value is the grouped strings is used to group the string into anagrams.
- Each value of the hash table is organized as a chain to add new strings if the key is found.
## Sorted string as key

## Character frequency table as key

# Implementation
## Java
### Sorted string as key
```Java title='Problem 49 in Java: solution 1'
class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String, LinkedList<String>> map = new HashMap<>();
        for (final var str : strs) {
            final var key = str.chars().sorted()
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
            if (map.containsKey(key)) {
                map.get(key).add(str);
            } else {
                map.put(key, new LinkedList<>());
                map.get(key).add(str);
            }
        }
        return map.values().stream().collect(Collectors.toUnmodifiableList());
    }
}
```
### Character frequency table as key
```Java title='Problem 49 in Java: solution 2'
public class Solution {

    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String, List<String>> map = new HashMap<>();
        for (final var str: strs) {
            final var key = this.hash(str);
            final var value = map.getOrDefault(key, new LinkedList<>());
            value.add(str);
            map.putIfAbsent(key, value);
        }
        return map.values().stream().toList();
    }

    private String hash(String s) {
        int[] frequency = new int[26];
        s.chars().forEach((letter) -> {
            frequency[letter - 'a']++;
        });
        return Arrays.toString(frequency);
    }
}
```
## JavaScript

## TypeScript

# Complexity
## Sorted string as key
- Given $n$ is the length of the string list and $k$ is the length of its element.
### Time complexity
- $O(n \times k\text{log}(k))$
### Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/group-anagrams/description/
2. 
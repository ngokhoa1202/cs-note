#string #algorithm #brute-force #cpp 
# Requirements
- Given a text $t$ and a pattern $p$, find the index of the first occurrence of $p$ in $t$. If $p$ is not found in $t$, return $-1$ otherwise.
- The length of $t$ is far greater than than the length of $p$ $$|t| \gg |p|$$
# Algorithm
## Native string matching

# Implementation
## C++
### Native string matching
```Cpp
#include <iostream>
#include <string>

using namespace std;

int findMatch(std::string pattern, std::string text) {
	size_t patternLength = pattern.length();
	size_t textLength = text.length();
	
	if (patternLength > textLength) {
		return -1;
	}
	
	size_t j = 0;
	for (size_t i = 0; i <= textLength - patternLength; ++i) {	
		j = 0;
		while (j < textLength && pattern[j] == text[i + j]) {
			j++;
		}
		if (j == textLength) {
			return i;
		}
	}
	return -1;
}

int main() {
	return 0;
}
```
## Java
### Native string matching
# Complexity
- Let $n$ and $m$ be the length of the pattern and the text respectively.
## Time complexity
### Native string matching
- $$T(n,m)=O(n+m+(n-m)(m+2))=O(mn-n^2)=O(mn)$$
## Space complexity
## 
***
# References
1. 

#leetcode #bit-manipulation #string 
# Algorithm
## Convert to binary and compare
# Implementation
## Java
```Java title='Problem 141 in Java: Convert to binary and compare solution'
class Solution {
  public int hammingDistance(int x, int y) {
    final var binaryOfX = this.toBinary(x);
    final var binaryOfY = this.toBinary(y);
    int distance = 0;
    for (int i = 0; i < 32; ++i) {
      if (binaryOfX.charAt(i) != binaryOfY.charAt(i))
        distance++;
    }
    return distance;
  }

  private String toBinary(int n) {
    StringBuilder builder = new StringBuilder();
    while (n > 0) {
      builder.append(n % 2);
      n /= 2;
    }
    builder.reverse();
    while (builder.length() < 32) 
      builder.insert(0, "0");
    return builder.toString();
  }
}
```
## JavaScript
```JavaScript title='Problem 461 in JavaScript: convert to binary and compare solution'
function toBinary(n) {
    let binary = "";
    while (n > 0) {
        binary = n % 2 + binary;
        n = Math.floor(n / 2);
    }
    while (binary.length < 32) binary = "0" + binary;
    return binary;
}

function hammingDistance(x, y) {
    const binaryOfX = toBinary(x), binaryOfY = toBinary(y);
    let distance = 0;
    for (let i = 0; i < 32; ++i) {
        if (binaryOfX[i] !== binaryOfY[i]) 
            distance++;
    }
    return distance;
};
```
## TypeScript
```TypeScript title='Problem 461 in TypeScript: convert to binary and compare solution'
function toBinary(n: number): string {
    let binary = "";
    while (n > 0) {
        binary = n % 2 + binary;
        n = Math.floor(n / 2);
    }
    while (binary.length < 32) binary = "0" + binary;
    return binary;
}

function hammingDistance(x: number, y: number): number {
    const binaryOfX = toBinary(x), binaryOfY = toBinary(y);
    let distance = 0;
    for (let i = 0; i < 32; ++i) {
        if (binaryOfX[i] !== binaryOfY[i]) 
            distance++;
    }
    return distance;
};
```
# Complexity
## Time complexity
- $O(\text{log}n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/hamming-distance/
2. 
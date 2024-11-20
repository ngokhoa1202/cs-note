#java #random 

# Requirement
- Generates an integer in the range $[min, max]$ 
# Solution
```Java
Random rand = new Random();  
int randomNum = rand.nextInt(max – min + 1) + min;
```

# References
1. https://www.geeksforgeeks.org/generating-random-numbers-in-java/
2. 
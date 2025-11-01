#cpp #c #operator 

# Assignment to hardware
- An assignment of a built-in type is a <mark class="hltr-yellow">simple machine copy operation</mark>.
```cpp title='Assignment to memory example'
int x = 2;
int y = 3;
x = y;
```
- ![](Pasted%20image%2020250510130841.png)
- Different variables can refer to the same value in memory using either pointer or reference. (See [Alias, dangling references and garbage](Alias,%20dangling%20references%20and%20garbage.md))
```cpp title='Pointer example'
int x = 2;
int y = 3;
int* p = &x;
int∗ q = &y;
p = q;
```
- ![](Pasted%20image%2020250510131449.png)
```cpp title='Reference example'
int x = 2;
int y = 3;
int& r = x; // r refers to x
int& r2 = y; // r2 refers to y
r = r2; // read through r2, write through r: x becomes 3
```

- ![](Pasted%20image%2020250510131740.png)

# References
1. A Tour of C++ - Bjarne Stroustrup - Addison Wesley Professional (2022).
2. [Alias, dangling references and garbage](Alias,%20dangling%20references%20and%20garbage.md)
3. [Copy operation](Copy%20operation.md)
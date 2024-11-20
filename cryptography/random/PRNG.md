#random #cryptography #number-theory #bit-manipulation #cybersecurity  #prng #symmetric-cipher #algorithm #hardware 

- Stands for ==Pseudo Random Number Generators==.

# True Random Numer Generators - TRNG
- The output ==cannot be reproduced== $\iff$ virtually impossible (but still has a probability). $\implies$ distribute ==session key==.
- ==Physically== generated (semiconductor noise, flip flop...).
# General PRNG
- An algorithm specified in ANSI C.
# Cryptographically Secure Pseudo Random Number Generator (CSPRNG)
- ==Unpredictable PRNG== $\iff$ Given $n$ bits of key stream, but cannot compute next bit.
- ==Unpredictability== is crucial to security concerns.
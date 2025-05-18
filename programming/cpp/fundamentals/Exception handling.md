#cpp #c #exception 


> [!NOTE] Error handling mechanism in C++
> An error is detected and it cannot be handled locally in a function, the function must somehow communicate the problem to some caller.
>   *Bjarne Stroustrup*

# When to throw
• An error is so rare that a programmer is likely to forget to check for it. For example, when did you last check the return value of `printf()`?
• An error cannot be handled by an immediate caller. Instead, the error has to percolate back up the call chain to an ‘‘ultimate caller.’’ For example, it is infeasible to have every function in an application reliably handle every allocation failure and network outage. Repeatedly checking an error-code would be tedious, expensive, and error-prone. The tests for errors and passing error-codes as return values can easily obscure the main logic of a function.
• New kinds of errors can be added in lower-modules of an application so that higher-level modules are not written to cope with such errors. For example, when a previously single- threaded application is modified to use multiple threads or resources are placed remotely to be accessed over a network.
• No suitable return path for errors codes is available. For example, a constructor does not have a return value for a ‘‘caller’’ to check. In particular, constructors may be invoked for several local variables or in a partially constructed complex object so that clean-up based on
error codes would be quite complicated. Similarly, an operators don’t usually have an obvious return path for error codes. For example, `a*b+c/d`.
• The return path of a function is made more complicated or more expensive by a need to pass both a value and an error indicator back, possibly leading to the use of out-parameters, non-local error-status indicators, or other workarounds.
• The recovery from errors depends on the results of several function calls, leading to the need to maintain local state between calls and complicated control structures.
• The function that found the error was a callback (a function argument), so the immediate caller may not even know what function was called.
• An error implies that some ‘‘undo action’’ is needed (§5.2.2).

# When to terminate
- An error is of a kind from which we cannot recover. For example, for many – but not all – systems there is no reasonable way to recover from memory exhaustion.
- The system is one where error-handling is based on restarting a thread, process, or computer whenever a non-trivial error is detected.
- One way to ensure termination is to add `noexcept`.
---
# References
1. A Tour of C++ - Bjarne Stroustrup - Addison Wesley Professional (2022).
	1. Chapter 4. Error handling
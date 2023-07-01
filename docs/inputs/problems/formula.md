[<< back](../README.md)

# Formula

In the previous example we saw how to use cases to define several instances of the same base problem. To make it work we had to define the variables N1, N2, S1, S2 with their values.

In some cases it is possible to remove variables that can be calculated. For example the variable S1 is N1 + N2, so we may define it as a formula. Let's see an example:


```
%problem
  %cases { varnames: "N1, N2"}
    %case 3, 2
    %case 7, 3
    %case 13, 11
    %case 4, 4
  %desc We are going to perform calculations with integers.
  %ask
    %text Calculate the sum N1 + N2
    %answer{type: 'formula'} N1 + N2
  %ask
    %text Calculate the subtraction N1 - N2
    %answer{type: 'formula'} N1 - N2
```

* With `%answer S1` the content of the answer attribute is the value of the variable S1.
* With `%answer{type: 'formula'} N1+N2`, the content of the answers attribute is the result of appling the formula `N1+N2` after substituting the corresponding values of N1 and N2.

[>> Learn about steps](steps.md)

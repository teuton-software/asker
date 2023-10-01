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


## Running

Run next command to see an example of Problem running.

```
❯ asker docs/examples/problems/math.haml
==> Loading docs/examples/problems/math.haml
==> Loading docs/examples/problems/statistics.haml

[INFO] Showing PROBLEMs statistics
+---------------+--------------------------+-----------+---------+---------+----+----+
| Problem       | Desc                     | Questions | Entries | xFactor | a  | s  |
+---------------+--------------------------+-----------+---------+---------+----+----+
| mathematical1 | Mathematical operations  | 68        | 7       | 9.71    | 68 | 0  |
| first2        | First degree equations   | 92        | 10      | 9.2     | 8  | 84 |
+---------------+--------------------------+-----------+---------+---------+----+----+
| TOTAL = 2     |                          | 160       | 17      | 9.41    | 76 | 84 |
+---------------+--------------------------+-----------+---------+---------+----+----+

```

[>> Learn about steps](steps.md)

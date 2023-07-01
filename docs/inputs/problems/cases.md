[<< back](../README.md)


# Cases

_Using case values and var names_

Taking advantage of the fact that we have defined a problem structure, we are going to enrich it using "cases" (value sequences).

Each "case" is a set of values that can be used to create a different problem from the same base structure. Let's see:

```
%problem
  %cases { varnames: "N1, N2, S1, S2"}
    %case 3, 2, 5, 1
    %case 7, 3, 10, 4
    %case 13, 11, 24, 2
    %case 4, 4, 8, 0
  %desc We are going to perform calculations with integers.
  %ask
    %text Calculate the sum N1 + N2
    %answer S1
  %ask
    %text Calculate the subtraction N1 - N2
    %answer S2
```

In the above example we have replaced the concrete values (3, 2, 5 and 1) with variables (N1, N2, S1 and S1). The variables can have any name, but not be confused with another word or symbol that appears in the question texts.

Once we replace specific values with their variable names then we create several `case` lines to reflect different combinations of values that will be used with the same problem structure.

In this example, we use the variables N1, N2 to store the numbers and the variables S1, S2 to store the solutions.

In our example we have multiplied by 4 the possibilities of the problem.

> It is recommended to use a minimum of 4 cases to optimize the output.

## Restrictions

### Var names restriction

A variable name cannot be contained within another variable name. For example:
* _Incorrect variable names_: N, NUM (Variable N appears inside the variable NUM)
* _Correct variable names_: N1, N2.

Variable names can be created in upper or lower case. The recommendation is to use capital letters to clearly distinguish from the rest of the text.

### Case values restriction

Each `case` line will have as many values as variable names defined in `varnames` field.

### Fileds separator

By default, the comma (`,`) is used as a field separator. Use `sep` attribute to define a different field separator.

Example problem:
```
Problem:
  We have the following values: 1,2,3,4,5.
  (a) Calculate the maximum
      Answer: 5 
  (b) Calculate minimum
      Answer: 1
  (c) Calculate the average
      Answer 3
```

Asker problem:
```
%problem
  %cases { varnames: "VALUES; MAX; MIN; AVERAGE", sep:";"}
    %case 1,2,3,4,5; 5; 1; 3
  %desc We have the following values: VALUES
  %ask
    %text Calculate the maximum
    %answer MAX
  %ask
    %text Calculate minimum
    %answer MIN
  %ask
    %text Calculate the average
    %answer AVERAGE
```

[>> Learn about formula](formula.md)
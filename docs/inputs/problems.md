[<< back](README.md)

# Problems

Problems are another way of creating knowledge.

While concepts allow us define knowledge, problems allow us define situations where apply knowledge in a practical way is required to obtain answers.

> Problem example files at `docs/examples/problems/`

## 1. Basic problem example

Talking about problems we usually think of mathematical or physics problems, but problems are present in many others domains: engineering, computer science, languages, music, etc.

To begin with, let's take a look at this simple example of a math domain.

```
Problem:
  We are going to perform calculations with integers.
  (a) Calculate the sum 3 + 2
      Answer: 5
  (b) Calculate the subtraction 3 - 2
      Answer: 1
```

The way to capture the problem in Asker's format is as follows:

```
%problem
  %desc We are going to perform calculations with integers.
  %ask
    %text Calculate the sum 3 + 2
    %answer 5
  %ask
    %text Calculate the subtraction 3 - 2
    %answer 1
```

Although this way of defining the problem is correct, it has the drawback of being somewhat rigid. By now, we have a problem with a perfectly defined structure but only works with specific data (the numbers 3 and 2).

## 2. Using case values and var names

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

**Var names restriction**

A variable name cannot be contained within another variable name. For example:
* _Incorrect variable names_: N, NUM (Variable N appears inside the variable NUM)
* _Correct variable names_: N1, N2.

Variable names can be created in upper or lower case. The recommendation is to use capital letters to clearly distinguish from the rest of the text.

**Case values restriction**: Each `case` line will have as many values as variable names defined in `varnames` field.

**Fileds separator**: By default, the comma (`,`) is used as a field separator. Use `sep` attribute to define a different field separator.

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

## 3. Formula

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

## 4. Steps to solve the problem

When students are given a problem, they are expected to carry out a development in several steps to finally arrive at the solution. In most cases these steps are more interesting from the teacher's point of view than the final answer itself.

So we're going to provide a way to outline the steps needed to resolve the issue. Let's see an example:

```
%problem
  %cases{ varnames: 'X' }
    %case x
    %case y
    %case z
    %case t
  %desc First degree equations
  %ask
    %text Solve the equation 2X - 4 = 6
    %step 2X -4 = 6
    %step 2X = 6 +4
    %step 2X = 10
    %step X = 10 / 2
    %step X = 5
```

In this example, this problem requires solving a first degree equation with their steps.

We have to think that we are looking for a way to create questions about problems that Moodle can later correct automatically, so we cannot ask open questions. The questions about the problem have to be closed so that the correct answer is a certain one.

The student is presented the problem with its resolution sequence and must understand it and answer if it is correct or not, or complete a step, or identify an error in the steps, etc.

## 5. Mixing steps and answers

It is posible combine steps and answers defining our problems. Example:

```
%problem
  %cases{ varnames: 'X' }
    %case x
    %case y
    %case z
    %case t
  %desc First degree equations
  %ask
    %text Solve the equation 2X - 4 = 6
    %step 2X -4 = 6
    %step 2X = 6 +4
    %step 2X = 10
    %step X = 10 / 2
    %step X = 5
  %ask
    %text Value of X in the following equation: 2X - 4 = 6
    %answer 5
```

## 6. Example

Run next command to see an example of Problem running.

```
==> Loading docs/examples/problems/math.haml
==> Loading docs/examples/problems/statistics.haml

[INFO] Showing PROBLEMs statistics
+---------------+--------------------------+-----------+---------+---------+
| Problem       | Desc                     | Questions | Entries | xFactor |
+---------------+--------------------------+-----------+---------+---------+
| mathematical1 | Mathematical operations  | 68        | 7       | 9.71    |
| first2        | First degree equations   | 70        | 10      | 7.0     |
+---------------+--------------------------+-----------+---------+---------+
| TOTAL = 2     |                          | 138       | 17      | 8.12    |
+---------------+--------------------------+-----------+---------+---------+
```
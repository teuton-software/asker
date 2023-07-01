[<< back](../README.md)

# Steps

_Steps to solve the problem_

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

## Mixing steps and answers

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

## Running

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

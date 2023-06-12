[<< back](README.md)

# Problems

Problems are another way of defining knowledge.

While the concepts allow us to define knowledge, the problems allow us to define situations in which it is necessary to apply the knowledge in a practical way to obtain answers.

> Example file `docs/examples/problems/math.haml`

## 1. Basic problem example

When talking about problems we usually immediately think of mathematical problems, but problems are present in many domains of knowledge: physics, computer science, language/languages, music, etc.

To begin with, let's look at an simple example of a math domain problem.

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

Although this way of defining the problem is correct, it has the drawback of being somewhat rigid. We have a problem with a perfectly defined structure but it only works to work with the numbers 3 and 2.

## 2. Using case values and var names

Taking advantage of the fact that we have a mathematical problem structure, we are going to enrich it using the "cases".

Each "case" is a set of values that can be used to create a different problem from the same base structure.

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

In the above example we have replaced the concrete values 3, 2, 5 and 0 with variables N1, N2, S1 and S1 (comma separated values). The variables can have any name we want so that they are not confused with another word or symbol that appears in the question texts.

Once we replace the values with their variable names we can create several `cases` to reflect different combinations of values that we can use with the same basic problem structure.

In our example we have multiplied by 4 the possibilities of the problem.

It is recommended to use a minimum of 4 cases to optimize the output.

## 3. Steps to solve the problem

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

In this example, the student is given the task of solving a first degree equation and then the steps necessary to solve the equation are reflected.

You have to think that we are looking for a way to create questions about problems that Moodle can later correct automatically, so we cannot ask open questions. The questions about the problem have to be closed so that the correct answer is a certain one.

The student is presentedthe problem with its resolution sequence and must understand it and answer if it is correct or not, or complete a step, or identify an error in the steps, etc.

## 4. Mix steps and answers

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

## 5. Example

Run next command to see an example of Problem running.

```
❯ asker docs/examples/problems/math.haml

[INFO] Showing PROBLEMs statistics
+-----------+-------------------------+-----------+---------+---------+
| Problem   | Desc                    | Questions | Entries | xFactor |
+-----------+-------------------------+-----------+---------+---------+
| problem1  | Mathematical operations | 72        | 7       | 10.29   |
| problem2  | First degree equations  | 42        | 10      | 4.2     |
+-----------+-------------------------+-----------+---------+---------+
| TOTAL = 2 |                         | 114       | 17      | 6.71    |
+-----------+-------------------------+-----------+---------+---------+
``

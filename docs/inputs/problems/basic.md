[<< back](../README.md)

# Problems

Problems are another way of creating knowledge.

While concepts allow us define knowledge, problems allow us define situations where apply knowledge in a practical way is required to obtain answers.

> Problem example files at `docs/examples/problems/`

## Basic problem example

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

[>> Learn about cases](cases.md)


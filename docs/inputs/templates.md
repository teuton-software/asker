
[<< back](README.md)

# Learn templates

Now, we are going to learn about `template` keyword.

---

# Powerfull tables

Table is usefull keyword to associate information to concepts using table struct (That means with rows and columns scheme).

## Example 01: repetitive rows

Let's see this repetitive row example about OS commands:

```
  %concept
    %names command
    %tags computing,directive,computer,perform,specific,task
    %def In computing, is a directive to a computer program to perform a specific task.
    %table{:action, :description}
      %row
        %col mkdir Endor
        %col Create Endor directory
      %row
        %col mkdir Naboo
        %col Create Naboo directory
      %row
        %col mkdir Dagobah
        %col Create Dagobah directory
```

## Example 02: Using template

To be more productive, we could use `template` keyword. So we replace every repeated rows by one template and row order:

```
  %concept
    %names command
    %tags computing,directive,computer,perform,specific,task
    %def In computing, is a directive to a computer program to perform a specific task.
    %table{:action, :description}
      %template{:DIRNAME => 'Endor,Naboo,Dagobah'}
        %row
          %col mkdir DIRNAME
          %col Create DIRNAME directory
```

We see example 01 produce the same result, but with less input lines.
Template will be apply to every definition inside.

Resume:
* **template**: Begin template definition.
* **DIRNAME**: Token o variable that will be replaced with value list.
* **Endor,Naboo,Dagobah**: Comma separated value list to be replaced when DIRNAME is found.

## Example 03: Going crazy

This example will multiply by three the number of input lines.

```
  %concept
    %names command
    %tags computing,directive,computer,perform,specific,task
    %def In computing, is a directive to a computer program to perform a specific task.
    %table{:action, :description}
      %template{:NAME => 'Endor,Naboo,Dagobah'}
        %row
          %col mkdir NAME
          %col Create NAME directory
        %row
          %col rmdir NAME
          %col Delete NAME directory
        %row
          %col touch NAME
          %col Create NAME file
        %row
          %col rm NAME
          %col Delete NAME file
        %row
          %col useradd NAME
          %col Create user NAME
        %row
          %col userdel NAME
          %col Delete user NAME
```

[>> Learn about code](code.md)

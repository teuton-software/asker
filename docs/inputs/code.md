
[<< back](README.md)

# Learn code

Now, we are going to learn about **EXPERIMENTAL** keyword `code`.

> It's experimental, because it's not finish and we are changing it.
We are not sure how it will looks in the future. We are experimenting but consider it's enought interesting and usefull to be used by now.

---

# Concept limits

We have learn about using: map, concept, names, tags, def, table and template keywords. All of them are usefull to define concepts.

Commonly we use natural lenguages (en, es, fr, de, etc) to talk about them and Asker DSL is a simpler and structured language version. All languages are similar (verbs, subjects, adjective, etc.), but have their own rules.
A poem, for example is writting using special rules.

Exists others kind of human creations, that use other definition languages.
For example, programming languages, file configurations, drawing language, math language, etc,

So we had to create new DSL keyword called `code` to represent this knowledge.

Let's see.

---
# Code

## Example

Example, using `code` keyword to use `files/string.py` as python file:

```
%map{ version: '1', lang: 'en', context: 'python, programming, language' }

  %code
    %type python
    %path files/string.py
```

Resume:
* **code**: Define a new code concept.
* **type**: Content type. Available values: `python`, `ruby`, and `javascript`.
* **path**: Path to content file.

> Experimental type values: python, ruby, javascript, sql

## Full map

Example, using `code` keyword to define several python programs from `files/` folder:

```
%map{ version: '1', lang: 'en', context: 'python, programming, language' }

  %code
    %type python
    %path files/string.py

  %code
    %type python
    %path files/array.py

  %code
    %type python
    %path files/iterator.py
```

Example:
* [python.haml](../examples/code/python.haml)
* [python files](../examples/code/files)

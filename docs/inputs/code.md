
[<< back](README.md)

# Learn code

Now, we are going to learn experimental keywords:
* code

---

# Concept limits

We have learn about using: map, concept, names, tags, def, table and template keywords. All them are usefull to define concepts.

Commonly we use natural lenguages (en, es, fr, de, etc) to talk about them and Asker DSL is a simpler and structured language version. All languages are similar (verbs, subjects, adjective, etc.), but have their own rules.
A poem, for example is writting using those rules.

Exists others kind of human creations, that use other definition languages.
For example, programming languages, file configurations, drawing language, math language, etc,

So we had to create new DSL keyword called `code`.

Let's see.

---
# Code

## Example

Example, using `code`keyword to define a python program from `files/string.py`file:

```
%map{ :version => '1', :lang => 'en', :context=>'python, programming, language' }

  %code
    %type python
    %path files/string.py
```

| Param | Description               |
| ----- | ------------------------- |
| code  | Define a new code concept |
| type  | Content type              |
| path  | Path to content file |

> Experimental type values: python, ruby, javascript, sql

## Full map

Example, using `code`keyword to define several python programs from `files/` folder:

```
%map{ :version => '1', :lang => 'en', :context=>'python, programming, language' }

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
* [python](../examples/code)

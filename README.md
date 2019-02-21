# ASKER

> Some time ago named as "Darts of teacher".

This program use some _"kind of AI"_, to generate a lot of questions from
an _input file with conceptual entities_.

---

# Description

This is a _Free Software multiplatform program_, that helps trainers
to create a huge amount of questions, from a _conceptual entities input file_ (HAML or XML file).

Steps:

1. Create an input file (Usign HAML or XML format) with your _conceptual entities_ and relations.
1. Run _asker_ and get the results. Now we have an output file with the questions.

Features:
* Read HAML/XML input files (It may be other input formats).
* Export format GIFT questions (It may be other output format).
* Multiplatform.
* Free Software [LICENSE](LICENSE).

---

# Usage

To execute ASKER, we use `asker` command, with a path to a input file (HAML/XML) as argument. For example, to run "jedi" example:

```
asker en/starwars/jedi.haml
```

* The program generates your output files into the `output` directory by default.
* In this example, we use a demo input definition file called `en/starwars/jedi.haml`, that contains our conceptual entities about _"Jedi's context"_.
* There are more input HAML/XML files into `github/dvarrui/asker-inputs`  repository.

> Asker generates output on diferents languages, so it's good idea separate them (Now works with English, Spanish and soon with French and German)

---

# Documentation

* [History](./docs/en/history.md)
* [Fundamentals](./doc/en/fundamentals.md)
* [Installation](./docs/en/installation.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Contribute](./docs/en/contribute.md)
* ES - [Spanish documentation](./docs/es/README.md)

---

# Contact

* **Email**: `asker.software@protonmail.com`
* **Twitter**: `@AskerSoftware`

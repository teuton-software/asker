# ASKER

This application use some _"kind of AI"_, to generate a lot of questions
from an _input file_ with your own _definitions_.

> Some time ago, this project was named as "Darts of teacher". But now, it's only ASKER.

---

# Description

_Free Software multiplatform program_, that helps trainers to create
a huge amount of questions, from a definitions (_conceptual entities_) input file.

Steps:

1. Create an input file with your definitons (_conceptual entities_).
1. Run _asker_ and get the results at `output` directory.

Features:

* Free Software [LICENSE](LICENSE).
* Multiplatform.
* Read HAML/XML input files.
* Export questions into GIFT format. Useful to load into Moodle.

---

# Usage

To execute ASKER, we use `asker` command, with a path to a input file as argument. For example, to run "jedi" input file example, we do:

```
asker en/starwars/jedi.haml
```

* The program generates your output files into the `output` directory by default.
* In this example, we use a demo input definition file called `en/starwars/jedi.haml`, that contains our conceptual entities about _"Jedi's context"_.
* There are more input HAML/XML files into `github/dvarrui/asker-inputs`  repository.

> Asker generates output on diferents languages, so it's good idea separate input files on diferent directories. Now works with English, Spanish.

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

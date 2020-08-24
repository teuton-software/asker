
# ASKER (version 2.0.5)

Generate a lot of questions from an _input file_ base on your own _definitions_.

---
# Description

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

Steps:

1. Create an input file with your definitions (_conceptual entities_).
1. Run _asker_ and get the results into `output` directory.

Features:

* Free Software [LICENSE](LICENSE).
* Multiplatform.
* Input file formats: HAML, XML.
* Output file format: GIFT (Moodle cuestionairs).
* Ruby program.

---
# Usage

To execute ASKER, we use `asker` command, with a path to an input file as argument. For example, to run "jedi.haml" input file example, we do:

```
asker en/starwars/jedi.haml
```

* The program generates your output files into the `output` directory by default.
* In this example, we use a demo input definition file `en/starwars/jedi.haml`, that contains conceptual entities about _"Jedi's"_ context.
* [Example input files](doc/examples).
* You can find more examples at `github/dvarrui/asker-inputs` repository.

---
# Documentation

* [Installation](./docs/install/README.md)
* [Inputs](./docs/inputs/README.md)
* [Commands](./docs/commands.md)
* [Contributions](./docs/contributions.md)
* [Base idea](./docs/idea.md)
* [History](./docs/history.md)

---
# Contact

* **Email**: `teuton.software@protonmail.com`
* **Twitter**: `@SoftwareTeuton`

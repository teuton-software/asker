# ASKER

This application generates a lot of questions from an _input file_
with your own _definitions_.

---

# Description

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

Steps:

1. Create an input file with your definitons (_conceptual entities_).
1. Run _asker_ and get the results at `output` directory.

Features:

* Free Software [LICENSE](LICENSE).
* Multiplatform.
* Input files formats: HAML, XML.
* Output file format: GIFT. Useful to load into Moodle cuestionairs.
* Ruby program.

---

# Usage

To execute ASKER, we use `asker` command, with a path to an input file as argument. For example, to run "jedi" input file example, we do:

```
asker en/starwars/jedi.haml
```

* The program generates your output files into the `output` directory by default.
* In this example, we use a demo input definition file called `en/starwars/jedi.haml`, that contains conceptual entities about _"Jedi's context"_.
* More input files into `github/dvarrui/asker-inputs` repository.

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

* **Email**: `asker.software@protonmail.com`
* **Twitter**: `@AskerSoftware`

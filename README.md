# ASKER (version 2.1)

Generate a lot of questions from an _input file_ base on your own _definitions_.

---
# Description

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

Steps:

1. Create an input file with your definitions (_conceptual entities_).
1. Run _asker_ and get the results into `output` directory.

Features:

* Free Software [LICENSE](https://github.com/dvarrui/asker/blob/devel/LICENSE).
* Multiplatform.
* Input file formats: HAML, XML.
* Output file format: GIFT (Moodle cuestionairs).
* Ruby program.

---
# Usage

To execute ASKER, we use `asker` command, with a path to an input file as argument. For example, to run our `jedi.haml` input file example, we do:

```
asker docs/examples/starwars/jedi.haml
```

* The program generates your output files into the `output` directory by default.
* In this example, we use a demo input definition file `docs/examples/starwars/jedi.haml`, that contains conceptual entities about _"Jedi's"_ context.
* [Example input files](https://github.com/dvarrui/asker/blob/devel/docs/examples).
* More examples at `github/dvarrui/asker-inputs` repository.

---
# Documentation

* [Installation](https://github.com/dvarrui/asker/blob/devel/docs/install/README.md)
    1. Install Ruby on your system.
    2. `gem install theory-asker`
* [Inputs](https://github.com/dvarrui/asker/blob/devel/docs/inputs/README.md)
* [Commands](https://github.com/dvarrui/asker/blob/devel/docs/commands.md)
* [Contributions](https://github.com/dvarrui/asker/blob/devel/docs/contributions.md)
* [Base idea](https://github.com/dvarrui/asker/blob/devel/docs/idea.md)
* [History](https://github.com/dvarrui/asker/blob/devel/docs/history.md)

---
# Contact

* **Email**: `teuton.software@protonmail.com`
* **Twitter**: `@SoftwareTeuton`

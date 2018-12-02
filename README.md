# ASKER (Darts of teacher)

This program use some AI, to construct a lot of questions from conceptual map input file.

---

# Description

This application is a Free Source multiplatform program, that helps teachers
to create a huge amount of questions, from a conceptual map (simple definitions input file).

Steps:

1. Create an input file (HAML/XML) with your conceptual map (definitions).
1. Run this tool with input file
1. Now we have created an output file with the questions.

Features:
* Read HAML/XML input files.
* Export format GIFT questions.
* Multiplatform.
* Free Software [LICENSE](LICENSE).

--

# Usage

To execute ASKER, we use `asker` command (`darts` is DEPRECATED), with a path to map file (HAML/XML) as argument.
For example:

* `./asker input/en/starwars/jedi.haml` to run this example, or
* `./asker file input/en/starwars/jedi.haml` do the same or
* `ruby asker file input/en/starwars/jedi.haml`, to run on Windows.

Then, program saves your output files into the `output` directory.

In this example, we use a demo input definition file (`input/en/starwars/jedi.haml`),
that contains our conceptual map (definitions) about Jedi's theme map.

There are more input HAML/XML files into `input/en` and `input/es` directories.

---

# Documentation

* [History](./docs/en/history.md)
* [Fundamentals](./doc/en/fundamentals.md)
* [Installation](./docs/en/installation.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./docs/es/README.md)

---

# Contributions

* Talk about this tool with your colleagues.
* Use this tool.
* Report bugs.
* Report us, your ideas for new features.
* Share with us, your own contents files (HAML/XML). Let's see input directory.
* If you like `ruby`, you also could help us with the [TO-DO list](./docs/TODO.md) or work with our issues.

---

# Contact

* **Email**: `asker.software@protonmail.com`
* **Twitter**: `@AskerSoftware`

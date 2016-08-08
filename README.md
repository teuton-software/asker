#Darts of teacher

This program use some AI, to construct a lot of questions from conceptual map input file.

##Description

This application is a Free Source multiplatform program, that helps teachers
to create a huge amount of questions, from a simple definitions input file.

Two Steps:

1. Create an input file (HAML/XML) with your conceptual map (definitions).
1. Run this tool, that creates an output file with the questions.

Features:
* Read HAML/XML input files.
* Export format GIFT questions.
* multiplatform.
* Free Software.

##Installation

* Install `ruby` (Tested on 2.1.3 version) and `rake` (`gem install rake`).
* Download the project, and go into the main directory (`cd darts-of-teacher`).
* Install gems required for this tool (execute `rake gems`).

##Usage

To execute Dart, we use `darts` command with a HAML/XML file as argument.
For example, execute `./darts input/en/starwars/jedi.haml` to run this example.

> On Windows try with `ruby darts input/en/starwars/jedi.haml`

At the end, we'll have our output files into the `output` directory.

In our example, we use sample input definition file, saved on `input/en/starwars`.
This file contains our input definitions in a HAML text file.

> There are more input HAML/XML files into `input` directory.

##Documentation

* [History](./docs/en/history.md)
* [Fundamentals](./doc/en/fundamentals.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./docs/es/README.md)

##Contributing

* Talk about this tool with your colleagues.
* Use this tool.
* Report bugs.
* Report us, your ideas for new features.
* Share with us, your own contents files (HAML/XML). Let's see input directory.
* If you like `ruby`, you also could help us with the [TO-DO list](./docs/TODO.md).

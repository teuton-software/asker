#Introduction

This application is an Open Source ruby program, that helps teachers
to create a huge amount of questions, from a simple definitions input file,
in an easy way.

Two Steps:

1. Create an input HAML/XML text file with the conceptual map (definitions).
1. Run this tool, that creates an output file with the questions.

#Installation

* Install `ruby` (Tested on 2.1.3 version) on your specific platform.
* Install rake utility (`gem install rake`).
* Download the project.
* Go into the main directory (`cd darts-of-teacher`).
* Install gems required for this ruby tool (run `rake gems`).

#Run demo

Execute `./darts input/en/starwars/jedi.haml` to run this demo.
> On Windows try with `ruby darts input/en/starwars/jedi.haml`

> Prefix:
> * Use `en` prefix for the English demo.
> * Use `es` prefix for the Spanish demo.

You will see messages on the screen, while the tool is working.
At the end we'll have our output files into the `output` directory.

In our example, we use sample input definition file, saved on `input/en/starwars`.
This file contains our input definitions in a HAML text file.

#Documentation
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./docs/es/README.md)

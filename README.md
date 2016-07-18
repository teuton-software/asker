#Introduction

**darts-of-teacher** is an Open Source ruby program, that helps teachers 
to create a huge amount of questions, from a simple definitions input file, 
in an easy way.

Two Steps:

1. The teacher create a input HAML text file with the conceptual map (definitions).
1. And run tool, that creates an output files with the questions.

#Installation
* Install `ruby` (Tested on 2.1.3 version) on your specific platform.
* `gem install rake`: Install rake utility.
* `rake gems`: Install gems required for this ruby tool.

#Run demo project
Run the demo project we executing `./run input/en/starwars/jedi.haml`.
You will see messages on the screen. The tool is working.

> **NOTICE**
>
> * Use `en` prefix for the English demo.
> * Use `es` prefix for the Spanish demo.
>
> To execute on Windows do `ruby run input/en/starwars/jedi.haml`

Now we have our output files, created into the `output` directory.

In our example, we use sample input definition file, saved on `input/en/starwars`.
This file contains our input definitions in a HAML text file.

#Documentation
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./docs/es/README.md)

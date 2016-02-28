#Introduction

**darts-of-teacher** is a ruby program, that helps teachers creating a huge amount 
of questions from a simple definitions input file, in an easy way.

Two Steps:

1. The teacher create a input text file with their definitions.
1. And run the tool that create an output file with the questions.

#Installation
* Install `ruby` (Tested on 2.1.3 version) on your specific platform.
* `gem install rake`: Install rake utility.
* `rake install`: Install gems required for this tool.

#Run demo project
Run the demo project we executing `./run projects/en/starwars/jedi.yaml`.
You will see messages into the screen when the tool is working.

> **NOTICE**
>
> * Use `en` prefix for the English demo.
> * Use `es` prefix for the Spanish demo.
>
> To execute on Windows do `ruby run projects/en/starwars/jedi.yaml`

Now we have our output files, created into the `output` directory.

>**USED FILES**
> 
>**1. Input definition files**
> * In our example, we use sample input definition files. These files are saved into the 
path `input/en/starwars`. We have two definitions files: one for jedis and other for siths.
>
>
> **2. Proyect configuration**
> * We have created a config file defining our new project. For example, let's 
see `projects/en/starwars/jedi.yaml`:
>
>```
>---
>:inputdirs: 'input/en/starwars'
>:process_file: 'jedi.haml'
>```
> This defines two params:
> 1. The *directory path* where we could find the *input files* we want use and
> 2. The *input file* from we want to generate *the questions*.

#Documentation
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./docs/es/README.md)

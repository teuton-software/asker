#Introduction

**darts** is a ruby program, to help teachers creating a huge amount 
of questions from a simple definitions input file, in an easy way.

Two Steps:

1. The teacher create a input text file with their definitions.
1. And run the tool that create an output file with the questions.

#Installation
* Install `ruby` (Tested on 2.1.3 version) on your specific platform.
* `gem install rake`: Install rake utility.
* `rake install`: Install gems required for this tool.

> Optional software:
> * git (*update the project*)
> * shoes (*GUI tool, under development*)

#Run demo project
We can run our starwars demo.

> * Use `es` prefix for the Spanish demo.
> * Use `en` prefix for the English demo.

To run the project we execute this `./run projects/starwars/es/config-jedi.yaml`.
You will see messages into the screen when the tool is working.

> On Windows, `ruby run projects/starwars/es/config-jedi.yaml`

Now we have our output files, created into `output` directory.

> **1. Input definition files**
> In our example, we use sample input definition files. These files are saved into the 
path `input/starwars/es`. We have two definitions files: one for jedis and other for siths.


> **2. Proyect configuration**
> We have created a config file defining our new project. For example, let's 
see `projects/starwars/es/config-jedi.yaml`:
>```
>---
>:inputdirs: 'input/starwars/es' 
>:process_file: 'jedi.haml'
>```
>
>For now this define two params:
>1. The *directory path* where we could find the *input files* we want use and
>2. The *input file* from we want to generate *the questions*.


#Documentation
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./doc/es/README.md)

#Introduction

**darts** is a ruby program, to help teachers creating a huge amount 
of questions from a simple definitions input file, in an easy way.

Two Steps:

1. The teacher create a input text file with their definitions.

2. And run the tool that create an output file with the questions.

> **Output file format**
>
> * At this moment, the output text file format is GIFT. But in the
future will be posible to choose between several output formats.
> * The GIFT format is very common format in elearning software as Moodle.

#Installation

Required software:
* ruby (=> 2.1.3 version)
* rake
* git
* shoes

Do installation executing this command `rake install`.

#Documentation
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)
* [Spanish documentation](./doc/es/README.md)


#Run it quickly

##1 Input definition files
We will use our sample input definition files. Those are saved in the 
path `input/demo/starwars`.

We have two definitions files: one for jedis and other for siths.

## 2. Proyect configuration
We create a config file defining our new project. For example, let's 
see `projects/demo/starwars/config-jedi.yaml`:

```
---
:inputdirs: 'input/demo/starwars' 
:process_file: 'jedi.haml'
```

For now this establish two params:

1. The directory path where we could find the input files we want and
2. The input file from we want to generate the questions.

## 3. Run the project

To run the project we execute this
* `./run projects/demo/starwars/config-jedi.yaml` or 
* `ruby run projects/demo/starwars/config-jedi.yaml`.

You will see something like this on the screen. The tool is working...

```
[INFO] Loading input data...
* HAML/XML files from maps/demo/starwars: jedi.haml, sith.haml 
[INFO] Showing concept data...
 <sidious(3)> lang=es
  .context    = personaje, starwars
  .tags       = humano, maestro, sith, alumno, plagueis
  .text       = Sith, maestro de todos los siths...
  .tables     = [$característica$descripción]
  .neighbors  = maul(50.0), obiwan(50.0), yoda(37.5)
 <maul(4)> lang=es
  .context    = personaje, starwars
  .tags       = lord, sith, alumno, emperador
  .text       = Lord Sirve como el aprendiz de Darth Sidious. Portando un sab...
  .tables     = [$característica$descripción]
  .neighbors  = sidious(57.14), obiwan(42.85), yoda(28.57)

[INFO] Creating output files...
[INFO] Showing concept stats...
* Concept: name=sidious -----------------------(Q=42, E=10, %=400)
* Concept: name=maul --------------------------(Q=32, E=8, %=400)
* TOTAL(2) -----------------------------------(Q=74, E=18, %=400)

```

## 4. Output files
The output files generated ara saved into `output` directory.


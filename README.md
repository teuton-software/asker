**Introduction**
================
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

**Installation**
================
Required software:
* ruby (=> 2.1.3 version)
* rake
* git
* shoes

Do installation executing this command `rake install`.

**Documentation**
==================
* [History](./docs/en/history.md)
* [Directories description](./docs/en/dirtree.md)
* [Input definitions](./docs/en/inputs.md)


Run it
======
First we need to create a config file. Let's see `projects/demo/starwars/config-jedi.yaml`:

```
---
:inputdirs: 'input/demo/starwars' 
:process_file: 'jedi.haml'

```

To run the tool we do `./run projects/demo/starwars/config-jedi.yaml` or 
`ruby run projects/demo/starwars/config-jedi.yaml`, and we'll see something 
like this on the screen.


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
It's only brief resume of the process.


Output files
============
Let's see output files (*.txt) into `output` directory.

> Let's see docs directory for more details.


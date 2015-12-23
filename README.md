**Introduction**
================
**creating-questions** is a ruby program, that help teachers to easily 
create a huge amount of questions from a simple definitions file.

Steps:

1. The teacher create a text file with our input definitions.

2. And run the tool that create an output file with questions.

> At this moment, the output text file contains questions in GIFT format.
> The GIFT format is very common format, in elearning software as Moodle.
> In the future, it will be posible export to other formats.

**Installation**
================
Required software:
* ruby (1.9.3 version)
* rake

Install required gems with `rake install_gems`.

**More documents**
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


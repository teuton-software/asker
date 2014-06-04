**Interviewer**
===============
*tt-interviewer** is a ruby tool, that helps teacher to easly build a huge
amount of questions from a simple conceptual map.

Steps:
1) The teacher create a text file with our conceptual map.
2) The tool read it and create a file with GIFT questions.
> The GIFT format is very common format, in elearning software as Moodle.

**History**
===========
As a teacher, one of the most boring taks is check the same exercises
again and again, for every student, and for ever year. The test questions
allow as to create activities that are automaticaly checked/resolved by 
software application (For example: Moodle cuestionairs). In this case
the teacher has time to waste analising the results. And apply that 
knowledge to improve his work, to try new ways of doing his job, to
find or redefined the activities or lessons contents, just to find
a better way of teaching. And an easier way of learning for the students.

The big problem with test questions are that only are usefull to evaluate
measurable features. So it could be very limited if we want measure abstract
features. But we could do this with other view. I mean.

If I get an open and abstract problem, their resolution will have several
steps or measurable milestones. So we could transform an open problem, 
into a close one. And I have to focus on measure this aspects.

Besides, if I "bomb" the student with a huge amount of diferent questions
about one concept, probably I could be near of knowing and measuring, the
student asimilation of this concepts.

**Installation**
================
Required software:
* ruby (1.9.3 version)
* rake

Install required gems with `rake install_gems`.

**Directories description**
===========================

This is the directory tree:

```
.
├── docs
├── lib
├── LICENSE
├── MANTAINERS.md
├── maps
│   └── demo
│       └── starwars
│           ├── jedi.haml
│           └── sith.haml
├── projects
│   └── demo
│       └── starwars
│           ├── config.yaml
│           └── sith.yaml
├── Rakefile
├── README.md
├── run
└── spec

```

* *README.es.md*: This help file
* *run*: This is the script file that will build our questions file 
from conceptual map files.
* *lib*: Directory that contains the ruby classes and modules of this project.
* *maps*: Directories where we save our own conceptual maps (using HAML or XML file format).
* *projects*: Directory that contains config files for every project. This config 
file are necessary to easily group parameters used by this tool. Also, 
into this directory will be created the reports and output files (as GIFT, etc.)
of every project.
* *spec*: Directory that will contain the test units in the next future. I hope!.

Conceptual Map
==============
Into *maps* directory we save our own concept map files. We could use subdirectories to
better organization. As example we have the file `maps/demo/starwars/jedi.haml`, that
contains one concept map about Jedi characters of StarWars film into HAML format.

Let's take a look (Spanish example, I know. Soon I'll write the english version):
```
%map{ :version => '1', :lang => 'es' }
  %concept
    %names obiwan
    %context personaje, starwars
    %tags maestro, jedi, profesor, annakin, skywalker, alumno, quigon-jinn
    %text Jedi, maestro de Annakin Skywalker
    %text Jedi, alumno de Quigon-Jinn
    %table{ :fields => 'característica, descripción' }
      %title Asocia cada característica con su valor
      %row
        %col raza
        %col humano
      %row
        %col color sable laser
        %col verde
      %row
        %col color-del-pelo
        %col pelirojo

  %concept
    %names yoda
    %context personaje, starwars
    %tags maestro, jedi
    %text Jedi, maestro de todos los jedis
    %text Midiendo 65 centímetros, fue el Gran Maestro de la Orden Jedi y uno de los miembros más importantes del Alto Consejo Jedi en los últimos días de la República Galáctica.
    %text Tenía habilidades excepcionales en el combate con sables de luz, empleando técnicas acrobáticas del Ataru.
    %text Era un maestro en todas las formas del combate con sables de luz y era considerado por muchos como un Maestro de Espadas.    
    %table{ :fields => 'característica, descripción' }
      %title Asocia cada característica con su valor
      %row
        %col color sable laser
        %col verde
      %row
        %col color-del-pelo
        %col blanco
      %row
        %col color-de-piel
        %col verde
...
```
As we see, we defined 2 concepts about Jedi characters. This are "obiwan" and "yoda". And
we use special sintax (tags) to define it.

At now we have a this list of tags to define our own sintax for build conceptual maps:
* **names**: List of one or more names that identify the concept. At least one is requiered, of course!.
* **context**: List of comma separated words, that identify the context where this concept "lives" or "exists".
* **tags**: List of comma separated words, that briefly describe the concept. I mean, a short list of words
that came in mind when we think in it, and are useful for their identification.
* **text**: We use this tags as many times we need. In it, we write using natural language descriptions
asssociated to the concept. Descriptions that are uniques for this concept, but don't write the name of
the concept into the text.
* **table**: Other way to build more sofisticated definitions/schemas is using "tables". It's similar
to HTML tag. I mean, with this "table", we build tables of knowledge into the concept. We use "row",
ans "col", to defines table-rows and row-cols, of course. We could see an 
example into `maps/demo/starwars/jedi.haml`.


Run it
======
First we need to create a config file. Let see `projects/demo/starwars/config-jedi.yaml`:

```
---
:inputdirs: 'maps/demo/starwars' 
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
It's only brief screen report the building process.


Output files
============
Let's see output files (*.txt) into `projects/demo/starwars` directory.

> Let's see docs directory for more details.


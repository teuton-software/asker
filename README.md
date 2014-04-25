**Interviewer**
===============
*tt_interviewer** is a ruby tool, that helps teacher to easly build a huge
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

Besides, if I bomb the student with a huge amount of diferent questions
of the same concept. Probably I will be near to know and measure, the
student asimilation of this concepts.

**Installation**
================
Required software:
* ruby (1.9.3 version)
* rake

Install required gems with `rake install_gems`.

**Directories description**
===========================

This tool contains the next directory tree:

```
.
├── build
├── config
│   └── starwars.yaml
├── input
│   ├── etc
│   └── starwars
│       ├── personajes.haml
│       └── personajes.xml
├── lib
│   ├── concept.rb
│   ├── interviewer.rb
│   └── question.rb
├── LICENSE
├── MANTAINERS.md
├── output
│   ├── starwars-gift.txt
│   ├── starwars-lesson.txt
│   └── starwars.log
├── Rakefile
├── README.md
└── spec
    ├── demo_spec.rb
    ├── question_spec.rb
    └── README
```

* *README.es.md*: This help file.
* *input*: Directory where we put our own conceptual maps (HAML or XML file format).
* *ouput*: Directory where create the reports or output files (as GIFT, etc.)
* *lib*: Directory that contains the ruby classes and modules of this project.
* *spec*: Directory that will contain the test units in the next future. I hope!.
* *config*: Directory that for now contains config files. This config files are necessary
to easily groups a huge amount of parameters used by this tool. NOTE: We 
are planning to change this. So we could use only default params (from main input file),
with need configfile creation.
* *build*: This file will "build" our questions from de input files.

Conceptual Map
==============
Into *input* directory we save our own concept map files. We could use subdirectories to
better organization. As example we have the file `input/starwars/jedi.haml`, that
contains one concept map about Jedi characters of StarWars film into HAML format.

Let's take a look:
```
%map{ :version => '1' }
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
example into `input/starwars/jedi.haml`.


*Run it*
========
First we need to create a config file. Let see `config/starwars.yaml`:

```
---
:logname: starwars.log
:outputname: starwars-gift.txt
:lesson_file: starwars-lesson.txt
:lesson_separator: ' |'
:inputdirs: 'input/starwars' 
:process_file: 'jedi.haml'

```

To run the tool we do `./build config/starwars.yaml` or `ruby build config/starwars.yaml`.

```
[INFO] Loading input data...
* HAML/XML files: ["jedi.haml", "sith.haml"] from input/starwars
[INFO] Showing concept data...
 <obiwan(1)>
  .context    = ["personaje", "starwars"]
  .tags       = ["maestro", "jedi", "profesor", "annakin", "skywalker", "alumno", "quigon-jinn"]
  .text       = Jedi, maestro de Annakin Skywalker...
  .tables     = [$característica$descripción]
  .neighbors  = sidious(40.0) yoda(40.0) maul(30.0) 
 <yoda(2)>
  .context    = ["personaje", "starwars"]
  .tags       = ["maestro", "jedi"]
  .text       = Jedi, maestro de todos los jedis...
  .tables     = [$característica$descripción]
  .neighbors  = obiwan(80.0) sidious(60.0) maul(40.0) 

[INFO] Creating output files...
[INFO] Showing concept stats...
* Concept: name=obiwan ------------------------(Q=32, E=8, %=400)
* Concept: name=yoda --------------------------(Q=42, E=10, %=400)
* TOTAL(2) -----------------------------------(Q=74, E=18, %=400)
```

*Output files*
==============
Let's see one output file `output/starwars-gift.txt`.

*Extra configuration params*
===========================

=begin
lConfig={ 
	#category => :none,
	#formula_weights => [1,1,1],
	#outputdir => 'output',
	#logname => 'default.log',
	#verbose => true,
	#:show_mode => :default
	:outputname => 'asir1-idp1314-gift.txt',
	:lesson_file => 'asir1-idp1314-lesson.txt',
	:lesson_separator => ' |',
	:inputdirs => 'input/idp', 
	:process_file => 'idp-u1.xml'
}
=end


Los parámetros más importantes son:
* **:inputdirs**: Una lista de todos los directorios de entrada separados
  por comas. Por defecto será *input*. Se aconseja hacer subdirectorios
  dentro de input para organizar los ficheros XML, e incluir los subdirectorios
  dentro de este parámetro. 
* **:process_file**: Como los directorios de entrada pueden contener un número
  elevado de ficheros XML (Cosa además muy recomendable), este parámetro
  indica el nombre del fichero XML que se desea procesar en este momento.

El resto no es obligatorio especificarlos, y de podrían dejar los valores por defecto.

Ejemplo de script con más parámetros:

	require_relative 'sys/interviewer'

	lConfig={ 
		:category => :none,
		:formula_weights => [1,1,1],
		:outputdir => 'output',
		:outputname => 'default.txt',
		:logname => 'default.log',
		:verbose => true,
		:show_mode => :full
		:lesson_file => 'lesson.txt',
		:lesson_separator => ' |',
		:inputdirs => 'input/idp,input/etc', 
		:process_file => 'commands.xml'
	}

	Interviewer.instance.run(lConfig)

Pero si quieres saber más, ahí van otros parámetros que podemos configurar 
al ejecutar la herramienta:
* **:outputdir**: Nombre del directorio de salida. Por defecto será *output*.
* **:outputname**: Nombre del fichero de salida donde se guardarán las preguntas
  generadas.
* **:lesson_file**: Cuando se indica este parámetro se crea un fichero de 
  salida con el contenido de los conceptos en modo texto.
* **:lesson_separator**: Por defecto es |. Es un caracter separador para las
  distintas columnas de las tablas.
* **:category**: Nombre de la categoría Moodle donde se cargarán las preguntas.
  Por defecto no se establece ninguna categoría Moodle.
* **:formula_weights**: Son pesos que se utilizarán en la fórmula que calcula
  la proximidad o cercanía entre dos conceptos diferentes.
* **:logname**: Nombre del fichero de log. Este fichero registra las acciones
  realizadas por script. Por defecto toma el valor *default.log*.
* **:verbose**: Si es *true* se emiten mensajes por pantalla de los pasos
  realizados. Por defecto toma el valor *true*.
* **:show_mode**: Cuando la herramienta termina muestra por pantalla un resumen
  de los datos procesados. El valor por defecto es *:default*. Además acepta
  los valores *:none* para no mostrar salida, y *:resume* que muestra un
  breve resumen.


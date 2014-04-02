**Interviewer**
===============

As a teacher, one of the most boring taks is check the same exercises
again and again, for every student, and for ever year. The test questions
allow as to create activities that are automaticaly checked/resolved by 
software application (For example: Moodle cuestionairs). In this case
the teacher has time to waste analising the results. And apply that 
knowledge to improve his work, to try new ways of doing his job, to
find or redefined the activities or lessons contents, just to find
a better way of teaching. And an easier way of learning for the students.

El problema de las preguntas tipo test es que sólo sirven para evaluar un
aspecto muy concreto y facilmente medible y/o cuantizable. De modo que es 
un poco limitado, puesto que la mayoría del conocimiento y habilidades
más interesantes son poco cuantizables y muy abiertas. Los problemas abiertos 
son más ricos en cuanto a las habilidades que deben emplearse para su 
resolución, pero por contra no puede automatizarse su evaluación/medición.

Pero si a un problema abierto inicialmente, lo bombardeamos/descomponemos
en una cantidad enorme de problemas cerrados se podría realizar una evaluación
automática. Claro que, el número de problemas cerrados debe ser muy grande
para cubrir lo mejor posible todos los aspectos del problema abierto inicial.

Según lo anterior, el problema se reduce ahora a generar un número suficientemente
elevado de preguntas cerradas a partir de un problema abierto.

Aparte de las preguntas uqe el profesor pueda idear, aparte de todas las dudas
de los alumnos (que las convertiremos en preguntas cerradas también), podemos
usar la herramienta Interviewer de TeacherTools.

Interviewer lee una plantillas en XML para generar preguntas en formato
GIFT que pueden cargarse directamente en platamformas de elearning como
Moodle.

**Descripción**
===============

La herramienta debe tener la siguiente estructura de directorios y ficheros.

	interviewer.tool/
	├── build
	├── input
	│   └── demo.xml
	├── output
	├── README.es.md
	└── lib
		├── concept.rb
		├── interviewer.rb
		└── question.rb

* El fichero *README.es.md* es este documento de ayuda.
* El directorio *input* es para colocar los ficheros XML que definamos con
  nuestros contenidos.
* El directorio *ouput* es donde se crearán los ficheros de salida.
* El directorio *lib* contiene las clases de la herramienta. La principal
  es Interviewer.
* El fichero *demo.rb* es un ejemplo que procesa los datos de *input/demo.xml*.

Documentos XML de entrada
=========================
Dentro del directorio *input* creamos todos los ficheros XML donde definimos
los conceptos según un formato concreto. Veamos un ejemplo de fichero XML
donde se definen comandos del sistema. Este fichero es *'input/demo.xml'*:

	<map version='1'>	
	<concept>
		<names>cd</names>
		<context>sistemas operativos, comando</context>
		<tags>cambiar, directorio, actual, mover</tags>
		<text>Es un comando del sistema operativo GNU/Linux, que permite cambiar nuestro directorio actual.</text>
		<text>Es un comando del sistema operativo GNU/Linux, que permite movernos a otro directorio del sistema de ficheros.</text>
		<table fields='acción, resultado'>
			<title>Asocia cada acción con su resultado.</title>
			<row>
				<col>cd</col>
				<col>Nos movemos a nuestro directorio HOME.</col>
			</row>
			<row>
				<col>cd ..</col>
				<col>Nos movemos al directorio padre de nuestro directorio actual.</col>
			</row>
			<row>
				<col>cd DIRNAME</col>
				<col>Nos movemos al directorio DIRNAME que está en nuestro directorio actual.</col>
			</row>
		</table>
	</concept>
	</map>

En mismo fichero podemos definir todos los conceptos que queramos. Para cada concepto
podemos indicar la siguiente información:
* **names**: Una lista de los posibles nombres del concepto separados por comas. 
  Como mínimo debemos indicar un nombre.
* **context**: Una lista de tags separados por comas que nos indican dentro de 
  que contexto tiene lugar esta definición.
* **tags**: Una lista de tags que dan una idea de la definición del concepto.
* **text**: Una descripción en lenguaje natural de nuestro concepto.
  Se pueden tener varias etiquetas de este tipo.
* **table**: Define una estructura de datos en formato de tabla. A su vez
  dentro de ésta se definen etiquetas para las filas (*row*), y las columnas
  dentro de cada tabla (*col). En cada tabla es obligatorio definir un atributo
  *fields* que contendrá los nombres de las columnas separados por comas.
  
Las etiquetas mínimas para definir un concepto son. *names, context, tags*, y
al menos un *text*.

Ejecutar la herramienta
=======================

Creamos el siguiente script demo.rb con nuestra configuración personalizada:

	#!/usr/bin/ruby
	# encoding: utf-8
	require_relative 'sys/interviewer'

    lConfig={ 
		:inputdirs => 'input', 
		:process_file => 'demo.xml'
	}
	
	Interviewer.instance.run(lConfig)

Ejecutamos el script con ./build o *ruby ./build*.

	interviewer.tool$ ./build config/demo.yaml 

	[INFO] Loading input data...
	* XML files: ["demo.xml"] from input/idp
	[INFO] Showing concept data...
	<cd(1)>
	.context    = ["sistemas operativos", "comando"]
	.tags       = ["cambiar", "directorio", "actual", "mover"]
	.text       = Es un comando del sistema operativo GNU/Linux, que permite ca...
	.tables     = [$acción$resultado]
	.neighbors  = chmod(42.85) rmdir(28.57) mkdir(28.57) rm(28.57) 
	...
	(Más datos)
	...
	


Ejemplo de los resultados obtenidos
===================================

Extracto del fichero *output/demo.xml* que se genera con las preguntas
en formato gift:

	// File: output/demo.txt
	// Time: 2013-08-16 15:51:38 +0100
	// Create automatically by David Vargas
	// Concept: cd

	::cd1-desc1::[html]Definición: "Es un comando del sistema operativo GNU/Linux, que permite cambiar
	nuestro directorio actual."<br/>Elige la opción que mejor se corresponda con la definición anteri
	or.<br/>
	{
	=cd
	~chmod
	~rmdir
	~Ninguna es correcta
	}

	::cd2-desc2::[html]Definición: "Es un comando del sistema operativo GNU/Linux, que permite cambiar
	nuestro directorio actual."<br/>Elige la opción que mejor se corresponda con la definición anteri
	or.<br/>
	{
	=Ninguna es correcta
	~chmod
	~rmdir
	~mkdir
	}

	::cd3-desc3::[html]Definición de cd:<br/> "Es un comando del sistema operativo GNU/Linux, que perm
	ite cambiar nuestro directorio actual."<br/>
	{TRUE}


Más parámetros de configuración
===============================

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


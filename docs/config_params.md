
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


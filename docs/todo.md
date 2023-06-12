
# TO-DO

* Reemplazar las apariciones de "names" dentro de cada "def" por "[\*]"
* Comprobar el funcionamiento de las tablas N > 2 fields
  Por ejemplo cada tabla con fields: (f1,f2,f3,etc) se reemplaza por
  varias tablas tipo: (f1,f2), (f1,f3), (f1,etc)
* Definir tablas que contienen un conjunto cerrado finito.
  Por defecto el campo clave es f1. Pero también podría ser f2 ¿?
  El campo clave pueden ser varios campos (f1,f2) ¿?
* Check Asker analizer lexical, syntax and semantic
* Split Concept into Concept and ConceptLoader
* Move puts to logger object. Then remove Rainbow import from other classes

# 1. Nuevo formato de input

* ISSUE: Revisar el número de columnas por cada tabla...
* Template multivariable con match: true or match: false
* Template multivariable combinando valores para aumentar las salidas geenradas

# 2. Entorno gráfico

Creación de `asker-editor`
* Front-end gráfico. Aplicación de escritorio autocontenida.
* Abre fichero de input (texto plano), lo edita y graba.
* Botón de salir
* Botón de check y botón de generar output.
* Subventana que muestre los resultados (salida del comando asker)

# 4. Frikada

* Frases célebres
* Prolog (nueva entidad conceptual) o nuevo campo para inducir estructura lógica a las entidades
* Conexión OpenAI? problemas al usar la gema openai

# 5. Moodle XML

Aprovechar las posibilidades que ofrece el fichero de importación Moodle XML
para crear nuevos tipos de preguntas.

Aumentar la IA y sus stages.

# 6. R y Wiris

* Buscar la integración de Asker con R y con Wiris.
* Estudiar los tipos de pregunta Wiris que ofrece Moodle.

# 7. Más idiomas

Introducir más idiomas...

# 8. Code

* Add code/features to every code input
* Use code/fetures to find neighbours and improve questions
* Identify code type using filepath extension

Incorporar lógica para
* XML
* Json
* /etc/hosts
* /etc/hostname
* /etc/samba/smb.conf
...

# 9. Test

* Problem/sanitize
* Code/sanitize

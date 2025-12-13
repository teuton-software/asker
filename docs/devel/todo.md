
# TO-DO

* Definir tablas que contienen un conjunto cerrado finito.
* Por defecto el campo clave es f1. Pero también podría ser f2 ¿?
* El campo clave pueden ser varios campos (f1,f2) ¿?

# 1. Nuevo formato de input

* ISSUE: Revisar el número de columnas por cada tabla...
* Template multivariable con match: true or match: false
* Template multivariable combinando valores para aumentar las salidas geenradas

# 2. GUI: Entorno gráfico

Create a graphic fron end to execute asker and edit input files. `asker-editor`
* Front-end gráfico. Aplicación de escritorio autocontenida.
* Abre fichero de input (texto plano), lo edita y graba.
* Botón de salir
* Botón de check y botón de generar output.
* Subventana que muestre los resultados (salida del comando asker)

# 4. Frikada

* Frases célebres
* Prolog (nueva entidad conceptual) o nuevo campo para inducir estructura lógica a las entidades
* Conexión AI?

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
* New questions types: gapfill

# 10. TO-DO

* Apply standard linter to code
* DOC or FIX: table only works with 4 columns? revise stage_t.rb
* FIX: check asker.ini version
* FIX: question f3filtered type. There are not usefull filtered sequence of row values from concept table.
* NEW: User asker configuration to add new local languages or change existing one.
* NEW: Language support: Adding Esperanto.

# 11. Videos

* Documentation: Revise documentation
* Perhaps, videos on youtube explaining all this: (1) Get documentation, (2) Installation, (3) Consult demo input, (4) Create our input file usign def, (5) Add tables to our input file.

# 12. info keyword

* Add new keyword called info. Example:
```
%map{ :lang => 'en', :context => 'rock, bands', :version => '1'}
  %info Generic text about music, rock, bands, concerts, etc.
  %info more...
```
* When AI create new question may use (randomly) info text to be included into it. Example:
```
Rock music style was created for ....

Definition of [*]: Australian rock band formed by Scottish-born brothers Malcolm and Angus Young.

Select right option:
a. Led Zepellin
b. Beatles
c. ACDC
d. None
```

# 14. Etc

* Question types
    * crossword
    * type hangmann
* Dictionary
    * Diccionario de sinónimos, antónimos
    * Learn about the words or better download dictionary from RAE?

---

# Development

* Check Asker analizer lexical, syntax and semantic
* Split Concept into Concept and ConceptLoader
* Refactor Application singleton to Settings class.

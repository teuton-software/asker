
# Roadmap v3.0.0 (2026)

Propuestas para 2026:
* [NEW] **Entorno gráfico GUI**: gema asker-panel como front-end gráfico para asker
    - cargar fichero input(xml, haml)
    - ejecutar asker sobre el fichero input(xml, haml)
    - mostrar resultado del check del input(xml, haml)
    - mostrar los resultados de la ejecución
    - Quizás editar el contenido del input en la ventana gráfica
* [CHORE] **doc "problem" data**
    - Crear exportador a fichero doc.
* [DEPRECATED] Pasar a deprecated.
    - "code" data.
* [NEW] **"example" data**
    - Nuevo tag "example" para introducir información de ejemplos (ExampleData)

```xml
map...
  example{uuid: 'UID', type: 'TYPE'}
    content{type: 'url'} PATH/TO/FILE
    content RAW TEXT
    table
      row
        col
    table
      row
```
* [NEW] **etiqueta "noise"**: noise apunta a un fichero donde tendremos "ruido"
    - El ruido son mensajes, frases, etc que se usarán aleatoriamente para introducir "ruido" en los enunciados de las preguntas para confundir o distraer.
    - Ejemplo: Frases célebres

```xml
map...
  noise PATH/TO/FILE
```

* [NEW] **word-cross-puzzle questions**: Añadir preguntas de tipo sopa de letras usando la gema word-cross-puzzle.
* [NEW] **logic**: Nueva etiqueta para añadir lógica o reglas al estilo de prolog en el mapa.
    - Prolog (nueva entidad conceptual) o nuevo campo para inducir estructura lógica a las entidades
    - gema ruby-prolog (https://github.com/preston/ruby-prolog)
    - logic debería asociarse a un contexto determinado
    - Es posible definir logic que sea global o de context=global

```xml
map...
  logic
    facts
      fact padre(anakin, luke)
      fact padre(anakin, leia)
    rules
      rule 
        if padre(A, B)
        if padre(A, C)
        then hermano(B, C)
      rule
        if hermano(A, B)
        then hermano(B, A)
```

---

# TO-DO list


## Ideas sueltas

* Definir tablas que contienen un conjunto cerrado finito.
* Por defecto el campo clave es f1. Pero también podría ser f2 ¿?
* El campo clave pueden ser varios campos (f1,f2) ¿?

## Nuevo formato de input

* ISSUE: Revisar el número de columnas por cada tabla...
* Template multivariable con match: true or match: false
* Template multivariable combinando valores para aumentar las salidas geenradas
* Fichero rb usado como map input similar al input xml o haml.

## Frikada

* Conexión AI?

## R y Wiris

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

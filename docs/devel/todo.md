
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
* [DEPRECATED] **"code" data**: Pasar a deprecated.
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

```text
Ejemplos:
  moodle.xml
  project-config.json
  /etc/hosts
  /etc/hostname
  /etc/samba/smb.conf
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

## 1. IA y asker new

* Conexión AI: `asker new --using-ai foo`
* La IA que nos sugiere el contenido para el fichero input
* Antes de crear el input foo
    * Se solicita una descripción de lo que se quiere al usuario
    * Configurar la IA que vamos a usar ¿cómo?

## 2. Mejorar las tablas

* Definir tablas que contienen un conjunto cerrado finito.
* Por defecto el campo clave es f1. Pero también podría ser f2 ¿?
* El campo clave pueden ser varios campos (f1,f2) ¿?
* DOC or FIX: table only works with 4 columns? revise stage_t.rb

## 3. Nuevo formato de input

* ISSUE: Revisar el número de columnas por cada tabla...
* Template multivariable con match: true or match: false
* Template multivariable combinando valores para aumentar las salidas geenradas
* Fichero rb usado como map input similar al input xml o haml.

## 4. R y Wiris

* Buscar la integración de Asker con R y con Wiris.
* Estudiar los tipos de pregunta Wiris que ofrece Moodle.

## 5. Más idiomas

* Introducir más idiomas...
* NEW: Language support: Adding Esperanto.

## 6. Test

* Problem/sanitize
* New questions types: gapfill

## 7. Configuración local

* FIX: check asker.ini version
* FIX: question f3filtered type. There are not usefull filtered sequence of row values from concept table.
* NEW: User asker configuration to add new local languages or change existing one.

## 8. Videos

* Documentation:
    - Revise documentation
    - asker-book/docs/asker book
* Perhaps, videos on youtube explaining all this:
    - (1) Get documentation
    - (2) Installation
    - (3) Consult demo input
    - (4) Create our input file usign def,
    - (5) Add tables to our input file.

## 9. Question types

* crossword
* type hangmann
* Dictionary
    * Diccionario de sinónimos, antónimos
    * Learn about the words or better download dictionary from RAE?

## 10. Internals

* Check Asker analizer lexical, syntax and semantic
* Split Concept into Concept and ConceptLoader
* Refactor Application singleton to Settings class.

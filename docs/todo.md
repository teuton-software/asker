
# TO-DO

* Reemplazar las apariciones de "names" dentro de cada "def" por "[\*]"
* Comprobar el funcionamiento de las tablas N > 2 fields
  Por ejemplo cada tabla con fields: (f1,f2,f3,etc) se reemplaza por
  varias tablas tipo: (f1,f2), (f1,f3), (f1,etc)
* Definir tablas que contienen un conjunto cerrado finito.
  Por defecto el campo clave es f1. Pero también podría ser f2 ¿?
  El campo clave pueden ser varios campos (f1,f2) ¿?
* Check Asker analizer lexical, syntax and semantic

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

# 9. Nuevo tipo de entidad conceptual "Problem"

Actualmente tenemos los tipos
* Concept -> defs y tables
* Code -> files y features

La idea es crear un nuevo tipo
* Problem

El problem tendrá varias partes

```
problem
  inputs
    names PRODUCTO, PRECIO, MONEDA, DINERO
    cases
      case manzana, 1, euro, 10
      case pera, 1, dolar, 13
      case plátanos, 0.5, euros, 5
    descripcion Quiero comprar PRODUCTO en el supermercado. Resulta que mirando los precios veo que cada PRODUCTO cuesta PRECIO.
    question
      step
        text ¿Cuántas PRODUCTO puedo comprar si tengo DINERO MONEDA?
        formula DINERO / PRECIO
        varname F1
        feedback Puedo comprar F1 PRODUCTO
```

```      
problem
  varnames X, Y, PRODUCTO, Z, PERSONA
  cases
    case 3, 4, manzanas, 2, Caperucita
    case 6, 7, juegos de la PS4, 5, PlayerOne
    case 9, 8, libros de Anime, 6, Akira
  description Tengo X PRODUCTO en la mochila, y también tengo Y PRODUCTO en mi casa.
  question
    step
      text ¿Cuántos/as PRODUCTO tengo en total?
      formula X + Y
      varname F1
      feedback En total tengo F1 PRODUCTO
    step
      text Si regalo Z a PERSONA ¿Cuántos/as PRODUCTO me quedan ahora?
      formula X + Y - Z
      varname F2
      feedback En total me quedan F2 PRODUCTO
```


# TO-DO

# 1. Nuevo formato de input (rb)

* ISSUE: Revisar el número de columnas por cada tabla...
* Template multivariable con match: true or match: false

# 2. Entorno gráfico

Creación de `asker-panel`
* Front-end gráfico. Aplicación de escritorio autocontenida.
* Abre fichero de input (texto plano), lo edita y graba.
* Botón de salir
* Botón de check y botón de generar output.
* Subventana que muestre los resultados (salida del comando asker)

# 3. Configurar

* Incluir las penalizaciones en el fichero de configuración "asker.ini".

# 4. Frikada

* Frases célebres
* Prolog (nueva entidad conceptual)

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
  inputs
    names X, Y, PRODUCTO
    cases
      case 3, 4, manzanas
      case 6, 7, juegos de la PS4
      case 9, 8, libros de Anime
    descripcion Tengo X PRODUCTO en la mochila, y también tengo Y PRODUCTO en mi casa.
    question
      step
        text ¿Cuántos/as PRODUCTO tengo en total?
        formula X + Y
        varname F1
        feedback En total tengo F1 PRODUCTO
```


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

## 11. CodeRunner

Evaluar la integración de Asker con el módulo `coderuner` de moodle. Para crear, por ejemplo, preguntas del tipo: resolver la función "factorial(number)"

Código XML para importar en Moodle
    - definición del enunciado
    - la respuesta modelo del profesor
    - los casos de prueba (tanto públicos como ocultos)
    - la configuración del tipo de ejecución.

```xml`
<?xml version="1.0" encoding="UTF-8"?>
<quiz>
  <question type="coderunner">
    <name>
      <text>Función Factorial (Python)</text>
    </name>
    <questiontext format="html">
      <text><![CDATA[<p>Escribe una función en Python llamada <code>factorial(number)</code> que reciba un número entero no negativo y devuelva su factorial.</p>
<p><strong>Ejemplos:</strong></p>
<ul>
  <li><code>factorial(5)</code> debe retornar <code>120</code></li>
  <li><code>factorial(0)</code> debe retornar <code>1</code></li>
</ul>]]></text>
    </questiontext>
    <generalfeedback format="html">
      <text><![CDATA[<p>El factorial de un número entero n se define como el producto de todos los números enteros positivos desde 1 hasta n. El factorial de 0 es 1 por definición matemática.</p>]]></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>0.3333333</penalty>
    <hidden>0</hidden>
    <idnumber></idnumber>
    <coderunnertype>python3</coderunnertype>
    <prototypetype>0</prototypetype>
    <allornothing>1</allornothing>
    <penaltyregime>10, 20, ...</penaltyregime>
    <precheck>0</precheck>
    <stash>0</stash>
    <answer>
      <text><![CDATA[def factorial(number):
    if number == 0 or number == 1:
        return 1
    resultado = 1
    for i in range(2, number + 1):
        resultado *= i
    return resultado]]></text>
    </answer>
    <useace>1</useace>
    <boxwidth></boxwidth>
    <boxlines></boxlines>
    <answerboxlines>10</answerboxlines>
    <answerboxcols>100</answerboxcols>
    <template></template>
    <iscombinatortemplate>0</iscombinatortemplate>
    <allowmultiplestart>0</allowmultiplestart>
    <answerpreload></answerpreload>
    <globalextra></globalextra>
    <useast>0</useast>
    <testcases>
      <!-- Caso de prueba 1: Visible como ejemplo -->
      <testcase>
        <testcode>print(factorial(5))</testcode>
        <stdin></stdin>
        <expected>120</expected>
        <extra></extra>
        <display>SHOW</display>
        <answerpreload></answerpreload>
        <hideuntil></hideuntil>
        <useasexample>1</useasexample>
        <marks>1.0000000</marks>
      </testcase>
      <!-- Caso de prueba 2: Visible como ejemplo (Caso Base) -->
      <testcase>
        <testcode>print(factorial(0))</testcode>
        <stdin></stdin>
        <expected>1</expected>
        <extra></extra>
        <display>SHOW</display>
        <answerpreload></answerpreload>
        <hideuntil></hideuntil>
        <useasexample>1</useasexample>
        <marks>1.0000000</marks>
      </testcase>
      <!-- Caso de prueba 3: Oculto para validación general -->
      <testcase>
        <testcode>print(factorial(1))</testcode>
        <stdin></stdin>
        <expected>1</expected>
        <extra></extra>
        <display>HIDE</display>
        <answerpreload></answerpreload>
        <hideuntil></hideuntil>
        <useasexample>0</useasexample>
        <marks>1.0000000</marks>
      </testcase>
      <!-- Caso de prueba 4: Oculto con número mayor -->
      <testcase>
        <testcode>print(factorial(6))</testcode>
        <stdin></stdin>
        <expected>720</expected>
        <extra></extra>
        <display>HIDE</display>
        <answerpreload></answerpreload>
        <hideuntil></hideuntil>
        <useasexample>0</useasexample>
        <marks>1.0000000</marks>
      </testcase>
    </testcases>
  </question>
</quiz>
```

Detalles clave de esta configuración:

Casos de prueba (testcases):

- Los dos primeros tienen `<display>SHOW</display>` y `<useasexample>1</useasexample>` para que los estudiantes puedan ver el comportamiento esperado antes de calificar.
- Los dos últimos están configurados como `<display>HIDE</display>` para evaluar con rigor los envíos finales del alumnado.
- Respuesta modelo (answer): Incluye una solución estándar iterativa óptima en Python para calcular el factorial.

Observación:

* Esta forma de corregir no tiene en cuenta el "interior" de la función, sólo se valida la correspondencia INPUT->OUTPUT.
* Si se quiere "afinar" más entonces habría que descomponer la solución en más funciones pero seguiríamos evaluando sólo el comportamiento de cada función y no el interior de la misma.

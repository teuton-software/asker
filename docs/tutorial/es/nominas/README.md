
# Tutorial Nominas: Caso de uso Asker en Español

Vamos a realizar un caso de uso completo de Asker en español, aprovechando a la IA generativa.

# 1. Elegir un tema

Empezamos eligiendo un tema que "dominemos" y sobre el cual queremos generar una batería de preguntas con Asker. Por motivos didácticos vamos a escoger el tema de las "nóminas".

# 2. Prompt para la IA generativa

Como estamos en la época de la IA generativa, vamos a aprovecharnos de ella y la vamos a pasar el siguiente prompt:

```
PROMPT PARA LA IA:

A partir de la siguiente plantilla de ejmplo:

// Asker example about AC/DC band
%map{ lang: 'en', context: 'music, band', version: '1'}

  %concept
    %names AC/DC, ACDC
    %tags rock, band, australia
    %def Australian rock band formed by Scottish-born brothers Malcolm and Angus Young

    %table{ fields: 'members'}
      %row Bon Scott
      %row Angus Young
      %row Malcolm Young
      %row Phil Rudd
      %row Cliff Williams

    %table{ fields: 'attribute, value'}
      %row
        %col Genres
        %col Hard rock, blues rock, rock and roll
      %row
        %col Years active
        %col 1973–present
      %row
        %col Formed in
        %col Sydney
    %table{ fields: 'Albums', sequence: 'Albums sorted by date'}
      %row Albums High Voltage
      %row Powerage
      %row Highway to Hell
      %row Back in Black
      %row Ballbreaker
      %row Rock or Bust

Crea un fichero con estructura similar pero usando como contenidos,
los conceptos más significativos sobre "Las nóminas".

Manten las etiquetas de la estructura como están, pero pon los contenidos en español.
```

Obtenemos como respuesta el siguiente fichero [v01/nominas.haml](v01/nominas.haml).

_Para empezar desde cero está muy bien, pero vamos a mejorarlo._


# 3. Refinamiento

## 3.1 Ampliamos las definiciones

**Recordatorio**: Las definiciones de un concepto son texto, o imagen, o sonido, o fichero de texto que define de forma inequívoca e única a nuestro concepto. Dicho de otra forma, la definición de un concepto X nunca puede valer para otro concepto Y (por lo menos, del mismo conexto o mapa).

* Vamos a intentar que nuestro concepto tenga más de una definición, le pédimos a la IA añadir más definiciones de nómina, obeniendo lo siguiente:

```
%concept
    %names Nómina, Recibo de Salarios, Paga
    %tags contrato, salario, trabajador, empresa, IRPF, Seguridad Social
    %def Documento justificativo que la empresa entrega al trabajador para reflejar las cantidades que percibe y las deducciones aplicadas por el trabajo realizado.
    %def Título legal que acredita la percepción de las retribuciones por parte del trabajador y el cumplimiento por parte del empleador de las obligaciones de cotización y retención de impuestos.
```

> **OJO**: Por supuesto, debemos ir revisando lo que nos devuelve la IA porque puede "inventarse" algunas respuestas.

## 3.2 Ampliamos las columnas de alguna tabla

**Recordatorio**: Las tablas de un concepto se pueden ver como características extra que ayudan a ampliar la definición del concepto. El contenido de las tablas de una concepto X se pueden repetir en otro concepto Y.

Si nos fijamos en la tabla `partes principales`, la IA no da una lista de opciones que "casi" todas tienen un texto junto con una aclaración entre paréntesis. Esto tiene la pinta de que se puede convertir en dos columnas separadas.
* En la tabla **partes principales** parece que se puede reorganizar como una tabla de dos columnas: `parte principal` y `descripción`, y se lo pedimos a la IA.

```
PROMPT PARA LA IA:

La tabla siguiente:

   %table{ fields: 'partes principales'}
      %row Encabezado (Datos de la empresa y del trabajador)
      %row Devengos (Percepciones salariales y no salariales)
      %row Deducciones (Retenciones y aportaciones)
      %row Líquido a percibir (Neto)
      %row Bases de cotización y de retención

reconstrúyela de modo que tenga dos columnas: parte principal y su descripción
```

y obtenemos lo siguiente:
```
  %table{ fields: 'parte principal, descripción'}
    %row
      %col Encabezado
      %col Contiene los datos de identificación de la empresa (nombre, CIF, código de cuenta de cotización) y del trabajador (nombre, DNI, número de Seguridad Social, categoría profesional, grupo de cotización).
    %row
      %col Devengos (Percepciones)
      %col Suma de todas las retribuciones que recibe el trabajador, incluyendo el salario base, los complementos salariales y las percepciones no salariales. Es el Salario Bruto.
    %row
      %col Deducciones
      %col Cantidades que se restan al total devengado. Incluyen las aportaciones del trabajador a la Seguridad Social (Contingencias Comunes, Desempleo, etc.) y la retención del IRPF.
    %row
      %col Líquido a Percibir (Neto)
      %col Es la cantidad final resultante de restar el total de las Deducciones al total de los Devengos. Es el dinero que el trabajador recibe realmente.
    %row
      %col Bases de Cotización y de Retención
      %col Son las magnitudes económicas sobre las que se aplican los porcentajes para calcular las aportaciones a la Seguridad Social (Bases de Cotización) y las retenciones de IRPF (Base de Retención).
```

## 3.3 Reconvertir tablas a conceptos

Algunas tablas tienen un contenido que puede ser relevante para el tema actual, y por tanto puede tener mucho sentido reconvertir las filas de dicha a tabla a conceptos con entidad propia. Este es el caso con la tabla `concepto, definición`.

* Parece que el contenido de esta tabla dentro de Nómina hace referencia a conceptos
relacionados con el tema que tienen entidad propia y por tanto, es más apropiado separarlos a su
propia estructura de concepto independiente:

```
PROMPT PARA LA IA:

El contenido de esta tabla, reconviértelo a elementos de tipo concept con su propio contenido

    %table{ fields: 'concepto, definición'}
      %row
        %col Salario Base
        %col Retribución fijada por unidad de tiempo u obra.
      %row
        %col Complementos Salariales
        %col Pagos adicionales (antigüedad, nocturnidad, etc.).
      %row
        %col IRPF (Impuesto sobre la Renta)
        %col Retención a cuenta del impuesto sobre la renta del trabajador.
      %row
        %col Seguridad Social (SS)
        %col Aportación del trabajador a la Tesorería General de la SS.
      %row
        %col Salario Neto (Líquido)
        %col Cantidad final que recibe el trabajador tras las deducciones.

y añade almenos dos definiciones def a estos últimos conceptos
```

* El resultado obtenido lo tenemos en el fichero [v02/nominas.haml](v02/nominas.haml).
* Podemos comprobar que el resultado está bien construido con `asker v02/nominas.haml`.
* Y podemos ver las preguntas que se pueden generar con `asker v02/nominas.haml`.

```
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| Concept                 | Questions | Entries | xFactor | d   | b  | f | i | s | t  |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| Nómina                  | 81        | 16      | 5.06    | 26  | 12 | 3 | 0 | 2 | 38 |
| Salario Base            | 23        | 2       | 11.5    | 23  | 0  | 0 | 0 | 0 | 0  |
| Complementos Salariales | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| IRPF                    | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Seguridad Social        | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Salario Neto            | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Excluded questions      | 0         | -       | -       | 0   | 0  | 0 | 0 | 0 | 0  |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| 6 concept/s             | 200       | 26      | 7.69    | 145 | 12 | 3 | 0 | 2 | 38 |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
```

_!Genera un total de 200 preguntas!_. Podemos ver la salida en la carpeta [output](output), pero estos son los ficheros principales (por ahora):
* XML o [output/nominas-moodle.xml](output/nominas-moodle.xml): Fichero de preguntas listas para importar en Moodle.
* TXT o [output/nominas.txt](output/nominas.txt): Contenido del mapa conceptual de Asker (fichero haml) convertido a formato de texto más legible para las personas.

## 3.4 La tabla con filas en secuencia

Las tablas con sus filas y columnas, permiten ampliar la semántica de un concepto añadiendole "tablas" de información asociada. Las tablas contienen filas y éstas a su vez pueden tener una o varias columnas.

En alguna ocasión, puede ocurrir que las filas de la tabla presenten una secuencia de valores o que tengan algún criterio por el cuál aparecen ordenadas. Por ejemplo, en el caso de la plantilla de AC/CD vemos una tabla asociada que son los títulos de sus álbumes que podemos ordenar por su fecha de publicación. En estos casos la tabla además del campo `fields:` tiene definido el campo `sequence:`. Ejemplo:

```
   %table{ fields: 'Albums', sequence: 'Albums sorted by date'}
      %row Albums High Voltage
      %row Powerage
      %row Highway to Hell
      %row Back in Black
      %row Ballbreaker
      %row Rock or Bust
```

En nuestro caso de las nóminas, la IA nos puso la siguiente tabla con secuencia. Como no soy experto del tema de nóminas y no me queda claro esta información, le pregunta nuevamente a la IA:

```
PROMPT PARA LA IA:

En relación a esta informacion

    %table{ fields: 'tipos de deducciones', sequence: 'Deducciones obligatorias'}
      %row Deducción IRPF
      %row Deducción Contingencias Comunes
      %row Deducción Desempleo
      %row Deducción Formación Profesional

por que motivo las filas tienen un orden o secuencia llamada 'Deducciones obligatorias'
Me lo puedes explicar si tienen un orden?
```

La respuesta es no. Por lo tanto, procedo a eliminar el parámetro `sequence:` de la tabla, ya que no tiene sentido. La IA no entendió bien este parámetro. No tenía suficiente información de las secuencias con sólo leer la plantilla que le pasamos inicialmente. Esto necesitaría un prompt más detallado.

Eliminamos la secuencia de la tabla y nos queda de la siguiente forma:

```
    %table{ fields: 'Deducciones obligatorias'}
      %row IRPF
      %row Contingencias Comunes
      %row Desempleo
      %row Formación Profesional
```

> PISTA: Quizás podría ser adecuado convertir las filas de esta tabla a conceptos individuales con sus definiciones propias y tablas asociadas. Esto aumentaría significactivamente el número de preguntas generadas, pero hay que preguntarse si se consideran estos elementos como conceptos importantes para nuestro tema.

# 4. Más refinamiento con la IA

Podríamos seguir refinando este mapa de Nóminas, pidíendole a la IA que nos ayude a crear tablas para los nuevos conceptos, esto haría un efecto multiplicador en el número de preguntas que se van a generar con Asker.

```
PROMPT PARA LA IA:

 Ampliame el concepto "Salario base" con alguna tabla
```

Resultado obtenido:
```
// Concepto: Salario Base
%concept
  %names Salario Base, Base Salarial
  %tags devengos, nómina, básico, fijo
  %def Retribución económica mínima fijada por la empresa que el trabajador recibe por la jornada laboral realizada.
  %def Es el punto de partida del cálculo del total devengado y se establece en función del convenio colectivo aplicable o, en su defecto, en el contrato individual.

  %table{ fields: 'característica, descripción clave'}
    %row
      %col Naturaleza
      %col Salarial, fija y garantizada.
    %row
      %col Forma de Cálculo
      %col Se fija generalmente por unidad de tiempo (hora, día o mes).
    %row
      %col Mínimo Legal
      %col Nunca puede ser inferior al Salario Mínimo Interprofesional (SMI) vigente.
    %row
      %col Instrumento regulador
      %col Determinado principalmente por el Convenio Colectivo del sector o la empresa.
    %row
      %col Distinción
      %col Se diferencia de los complementos, ya que estos dependen de circunstancias variables o personales.

¿Te gustaría que aplicara esta misma ampliación al concepto de Complementos Salariales o IRPF?
```

Si generamos las preguntas vemos cómo han aumentado un 26,5%.

```
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| Concept                 | Questions | Entries | xFactor | d   | b  | f | i | s | t  |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| Nómina                  | 81        | 16      | 5.06    | 26  | 12 | 3 | 0 | 2 | 38 |
| Salario Base            | 76        | 12      | 6.33    | 25  | 12 | 0 | 0 | 0 | 39 |
| Complementos Salariales | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| IRPF                    | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Seguridad Social        | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Salario Neto            | 24        | 2       | 12.0    | 24  | 0  | 0 | 0 | 0 | 0  |
| Excluded questions      | 0         | -       | -       | 0   | 0  | 0 | 0 | 0 | 0  |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
| 6 concept/s             | 253       | 36      | 7.03    | 147 | 24 | 3 | 0 | 2 | 77 |
+-------------------------+-----------+---------+---------+-----+----+---+---+---+----+
```

* Le pedimos a la IA que nos añada tablas para el resto de los conceptos que faltaban. Básicamente le digo `Sí, sigue con el siguiente concepto`. Al final genero las preguntas y obtenemos.... 659.

```
+-------------------------+-----------+---------+---------+-----+-----+---+---+---+-----+
| Concept                 | Questions | Entries | xFactor | d   | b   | f | i | s | t   |
+-------------------------+-----------+---------+---------+-----+-----+---+---+---+-----+
| Nómina                  | 79        | 16      | 4.94    | 26  | 12  | 3 | 0 | 0 | 38  |
| Salario Base            | 76        | 12      | 6.33    | 25  | 12  | 0 | 0 | 0 | 39  |
| Complementos Salariales | 126       | 17      | 7.41    | 27  | 24  | 0 | 0 | 0 | 75  |
| IRPF                    | 123       | 17      | 7.24    | 25  | 24  | 0 | 0 | 0 | 74  |
| Seguridad Social        | 126       | 17      | 7.41    | 26  | 24  | 0 | 0 | 0 | 76  |
| Salario Neto            | 129       | 17      | 7.59    | 25  | 24  | 0 | 0 | 0 | 80  |
| Excluded questions      | 0         | -       | -       | 0   | 0   | 0 | 0 | 0 | 0   |
+-------------------------+-----------+---------+---------+-----+-----+---+---+---+-----+
| 6 concept/s             | 659       | 96      | 6.86    | 154 | 120 | 3 | 0 | 0 | 382 |
+-------------------------+-----------+---------+---------+-----+-----+---+---+---+-----+
```

El efecto multiplicador total que hemos conseguido por ahora es de 6.89. Esto es, de cada línea que hemos escrito en el mapa de entrada de nóminas hemos obtenido un x7 de salidas. Además, nosotros sólo nos hemos tenido que enfocar en los contenidos no en las preguntas lo cual ayuda a tener menos carga cognitiva durante el proceso.

Podemos comprobar en esta salida como los últimos conceptos que hemos añadido "Complementos Salariales", "Seguridad Social", "Salario Neto", tienen el mayor número de preguntas generadas (126). A su vez mirando la columna "t" (table) tienen los mayores valores (64, 75, 76 y 80). De modo que las tablas de estos conceptos son las que están actualmente aportando el mayor número de preguntas. Cada tabla de 3 columnas (a-b-c) a efectos prácticos es como si tuviéramos varias tablas de 2 columnas (a-b y a-c).

Puedes consulta como ha quedado el mapa conceptual de Nóminas en el fichero [v03/nominas.haml](v03/nominas.haml). 

> **OJO**: _Todo este proceso lo he ido haciendo, sin saber bien de qué va el tema de las nóminas. Un experto del tema, manejando la IA y usando Asker puede hacer maravillas._

# 5. Imágenes

## 5.1 Imágenes de acompñamamiento

Cuando se generan las preguntas, de forma aleatoria se insertan en los enunciados imágenes asociadas al concepto pero que nada tienen que ver con la pregunta y su respuesta. Son imágenes de acompañamiento y para distraer de la misma forma que nos hacían en las preguntas tipo test del carnet de conducir. Nos ponían imágenes que no tenían que ver con lo que teníamos que responder. Sólo debíamos fijarnos en la imagen cuando explicitamente el enunciado de la pregunta hacía referencia a la imagen asociada.

## 5.2 Imágenes para ampliar el concepto

Sin embargo, también podemos incluir imágenes seleccionadas por nosotros para expandir la información de nuestros conceptos. En nuestro tema de nóminas, quizás las imágenes no son el soporte adecuado para este tipo de conocimiento pero a partir de la tabla "parte principal" de la tabla de nóminas... se me ocurre añadir imágenes de nóminas donde se resaltaría cada parte de la nómina.

## 5.3 Generar imágenes con la IA

Usé el siguiente prompt para pedirla a la IA que nos genere la imagen:

```
PROMPT PARA LA IA:

genera una imagen de una nómina con datos inventados 
y resalta la parte de devengos 
```

Me costó un poco refinar el prompt para que saliera una imagen más o menos como esperaba. Pero estoy seguro que los profesores de nóminas tienen ejemplos a los que le pueden sacar la imagen sin necesidad de pedírselo a la IA.

De momento sólo he generado la siguientes [imágenes](v04/images/):
```
v04/images
├── nomina-devengos.png
├── nomina-encabezado.png
└── nomina-neto.png
```

## 5.4 Enlazar conceptos con las imágenes

Ahora vamos a necesitar los conceptos siguientes para poder asociarles su imagen correspondiente:

| Concepto                          | Hay que crearlo |
| --------------------------------- | --------------- |
| Devengos                          | Sí |
| Encabezado de la nómina           | Sí |
| Salario Neto o líquido a percibir | No |

Modificamos salario neto añadiendo la siguiente línea de definición:

```
  // Concepto: Salario Neto (Líquido)
  ...
    %def { type: 'file' } v04/images/nomina-neto.png
  ...
```


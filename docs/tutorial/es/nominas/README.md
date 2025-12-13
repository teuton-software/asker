
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

* El resultado obtenido lo tenemos en el fichero [v02/nominas.haml]
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

# 4. Más refinamiento


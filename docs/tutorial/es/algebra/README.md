
# Tutorial Álgebra: Caso de uso Asker en Español

Vamos a realizar un caso de uso completo de Asker en español, aprovechando a la IA generativa.

# 1. Elegir un tema

Empezamos eligiendo un tema que "dominemos" y sobre el cual queremos generar una batería de preguntas con Asker. Por motivos didácticos vamos a escoger el tema de "álgebra" (nivel de la ESO).

# 2. Prompt para la IA generativa

Como estamos en la época de la IA generativa, vamos a aprovecharnos de ella y la vamos a pasar el siguiente prompt:

```
PROMPT PARA LA IA:

A partir de la siguiente plantilla de ejemplo:

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
los conceptos más significativos sobre "Álgebra" (nivel de la ESO).

Mantén las etiquetas de la estructura como están, pero pon los contenidos en español.
```

Le tengo que pedir que añada la propia definición de Álgebra:

```
PROMPT PARA LA IA:

incluye como concepto Álgebra (que es el álgebra) 
```

Obtenemos como respuesta el siguiente fichero [v01/algebra.haml](v01/algebra.haml).

_Es un comienzo pero vamos a necesitar corregir el contenido generado por la IA._

# 3. Refinamiento

## 3.1 Refinando el concepto 0: Álgebra

Contenido antes del refinamiento:
```
  // Concepto 0: Álgebra (Definición)
  %concept
    %names Álgebra, Definición de Álgebra
    %tags matemáticas, rama, variables, generalización
    %def Rama de las matemáticas que estudia las estructuras, las relaciones y las cantidades.
    %def Se centra en la generalización de las operaciones aritméticas, empleando letras para representar números desconocidos (incógnitas) o valores generales.
```

* Quitamos de %names "Definicion de Álgebra", porque no es un nombre que identique al concepto 0.
* En la segunda definición tenemos que añadir el siguiente texto "Área de las matemáticas que se centra..." para que entienda de forma clara e inequívoca que nos estamos refiriendo a la definiópn del concepto "Álgebra". Es importante eliminar las posibles ambigüedades del contenido de las definiciones.

Contenido después del refinamiento:
```
  // Concepto 0: Álgebra (Definición)
  %concept
    %names Álgebra
    %tags matemáticas, rama, variables, generalización
    %def Rama de las matemáticas que estudia las estructuras, las relaciones y las cantidades.
    %def Área de las matemáticas que se centra en la generalización de las operaciones aritméticas, empleando letras para representar números desconocidos (incógnitas) o valores generales.
```

* Elimino la tabla `'atributo, descripción'` porque no aporta información relevante para el concepto.

## 3.2 Refinando el concepto 1: Expresión

Contenido antes del refinamiento:
```
  // Concepto 1: Expresión Algebraica
  %concept
    %names Expresión Algebraica, Expresión Matemática
    %tags variable, números, operaciones, letra
    %def Combinación de números y letras (variables) unidos por signos de operaciones matemáticas.
    %def Las letras suelen representar cantidades desconocidas (variables).

    %table{ fields: 'componente, descripción'}
      %row
        %col Variable (Parte Literal)
        %col Las letras que representan un valor desconocido (ej: x, y, a).
      %row
        %col Coeficiente (Parte Numérica)
        %col El número que multiplica a la variable (ej: el 3 en 3x).
      %row
        %col Signo Operacional
        %col El símbolo que une los términos (+, -, *, /).
```

* El nombre del concepto entiendo que se puede quedar como "expresión" porque ya estamos dentro de un mapa de "Álgebra" y el nombre "expresión algebraica" es redundante. Otra cosa sería que hubieran varios conceptos de expresión dentro de este mapa, entonces sí habría que incluir la coletilla aclaratoria.
* Como no domino el tema, le pregunto lo siguiente a la IA:
```
PROMPT PARA LA IA:

como se define una expresión en algebra 
```
* Y me genera la siguiente salida:
```
// Concepto: Expresión Algebraica
%concept
  %names Expresión Algebraica, Expresión Matemática
  %tags variable, números, operaciones, letra
  %def Combinación de números y letras (variables) unidos por signos de operaciones matemáticas.
  %def Las letras suelen representar cantidades desconocidas (variables) y permiten generalizar la aritmética.

  %table{ fields: 'componente, descripción, ejemplo'}
    %row
      %col Parte Literal (Variable)
      %col Las letras que representan un valor que puede variar (incógnitas).
      %col $x$, $y$, $a^2$
    %row
      %col Coeficiente (Parte Numérica)
      %col El número que multiplica a la variable. Si no aparece, es 1.
      %col El 5 en $5x^3$.
    %row
      %col Signo Operacional
      %col Los símbolos que unen los términos: suma (+), resta (-), multiplicación (implícita) o división (/).
      %col El '+' en $2x + 3y$.
```

Me vuelve a poner %names de forma redundante (lo tengo que volver a cambiar), y curiosamente la tabla que la genera esta vez con 3 columnas, en lugar de 2 como estaba inicialmente. Sin embargo, esta nueva estructura me parece más precisa porque separa los ejemplos de la descripción en dos columnas diferentes.

* Me surge una duda y le pregunto a la IA:

```
PROMPT PARA LA IA:

Por qué motivo las expresiones las devuelves entre $, Por ejemplo $2x + 3y$ en lugar de poner solamente 2x + 3y? 
```

Respuesta:
```
La razón por la que coloco las expresiones algebraicas como $2x + 3y$ (es decir, entre signos de dólar $) es para indicar que se debe utilizar formato LaTeX o un formato similar que permita una visualización matemática clara y correcta.
```

> Sin embargo, lo he probado en el Moodle del Campus Virtual que tenemos en FP de Canarias y no se visualiza en formato LaTeX, De modo que procedo a eliminar los símbolos $ del contenido.

## 3.3 Refinando el concepto 2 (Monomio y polinomio)

En la definición del concepto 2, vemos que la IA se ha confundido y ha fusionado tres conceptos diferentes (Término algebraico, monimio y polinomio) como si fueran uno solo. Nos podemos dar cuenta porque en el atributo `%names` aparecen como si fueran sinómimos y no es el caso.


```
PROMPT PARA LA IA:

Este contenido sebe separase en 3 conceptos: uno para término algebraico, otro para monomio y otro para polinomio.

  // Concepto 2: Monomio y Polinomio
  %concept
    %names Monomio, Polinomio, Término Algebraico
    %tags grado, suma, resta, términos
    %def Un Monomio es el tipo más simple de expresión algebraica, formado por el producto de un número y una o varias variables.
    %def Un Polinomio es la suma o resta de dos o más monomios.

    %table{ fields: 'tipo, definición, ejemplo'}
      %row
        %col Monomio
        %col Expresión de un solo término.
        %col $5x^2$
      %row
        %col Binomio
        %col Polinomio de dos términos.
        %col $3x - 2y$
      %row
        %col Polinomio
        %col Suma o resta de varios monomios.
        %col $4x^3 + 2x - 1$

    %table{ fields: 'Atributo, Descripción'}
      %row
        %col Grado de un Monomio
        %col Suma de los exponentes de sus variables.
      %row
        %col Grado de un Polinomio
        %col El mayor grado de todos los monomios que lo componen.
```

Se renumeran los conceptos.

## 3.4 Refinando el concepto: Ecuación de primer grado

```  // Concepto 5: Ecuación de Primer Grado
  %concept
    %names Ecuación de Primer Grado, Ecuación Lineal
    %tags igualdad, incógnita, solución, ecuación, grado 1
    %def Una igualdad matemática entre dos expresiones algebraicas que contiene una o más incógnitas, cuyo exponente es 1.
```

* Se quita la segunda definición porque realmente no identifca al concepto de forma inequívoca.
* Se quitan las tablas porque no aportan información significativa, más bien aportan confusión a la hora de ampliar la semántica del concepto.

## 3.5 Crear concepto Grado

Hemos visto que es conveniente crear el concepto "Grado, grsado de un polinomio" y lo añadimos al mapa conceptual.

Podemos ver el resultado final el el fichero [v02/algebra.haml](v02/algebra.haml)

# 3. Reorganizando los comntenidos

```
Dame la relación entre expresión, termino, monomio, polinomio y ecuación 
en lenguaje natural español y de forma resumida 
```

Relación entre Expresión, Término, Monomio, Polinomio y Ecuación
* Término Algebraico: Es la pieza fundamental. Es cada parte de una expresión separada por un signo de suma o resta (ej: 5x2).
* Monomio: Es una expresión de un solo término. Por lo general, se usan como sinónimos de "Término Algebraico".
* Polinomio: Es una expresión formada por la suma o resta de varios Monomios.
* Expresión Algebraica: Es el nombre general que abarca a todos los anteriores (términos, monomios y polinomios).
* Ecuación: No es una expresión, sino una igualdad que pone en relación dos Expresiones Algebraicas.

Con esto en mente lo reorganizado todo

```
+---------------------+-----------+---------+---------+-----+---+----+---+---+----+
| Concept             | Questions | Entries | xFactor | d   | b | f  | i | s | t  |
+---------------------+-----------+---------+---------+-----+---+----+---+---+----+
| Álgebra             | 24        | 2       | 12.0    | 24  | 0 | 0  | 0 | 0 | 0  |
| expresión           | 11        | 1       | 11.0    | 11  | 0 | 0  | 0 | 0 | 0  |
| término algebraico  | 47        | 10      | 4.7     | 11  | 0 | 0  | 0 | 0 | 36 |
| monomio             | 23        | 2       | 11.5    | 23  | 0 | 0  | 0 | 0 | 0  |
| monomios semejantes | 16        | 4       | 4.0     | 11  | 0 | 5  | 0 | 0 | 0  |
| polinomio           | 56        | 12      | 4.67    | 33  | 0 | 5  | 0 | 0 | 18 |
| ecuación            | 11        | 1       | 11.0    | 11  | 0 | 0  | 0 | 0 | 0  |
| ecuación lineal     | 10        | 1       | 10.0    | 10  | 0 | 0  | 0 | 0 | 0  |
| grado               | 54        | 11      | 4.91    | 24  | 0 | 0  | 0 | 0 | 30 |
| Excluded questions  | 0         | -       | -       | 0   | 0 | 0  | 0 | 0 | 0  |
+---------------------+-----------+---------+---------+-----+---+----+---+---+----+
| 9 concept/s         | 252       | 44      | 5.73    | 158 | 0 | 10 | 0 | 0 | 84 |
+---------------------+-----------+---------+---------+-----+---+----+---+---+----+
```

Hemos conseguido generar 252 a partir de 9 conceptos. Sin embargo, teniendo en cuenta que estamos trabajando con contenidos de matemáticas, deberíamos tener "problemas" (ejercicios para resolver de forma práctica), no sólo definiciones teóricas.

# 5. Creando problemas

Hasta ahora habíamos utilizado las siguientes etiquetas para describir el conocimiento del tema: `%concept`, `%def`, `%table`, `%row`,  `%col`. Y están muy bien, pero están orientadas a describir conceptos teóricos y no a plantear problemas prácticos. Así que vamos a usar otras nuevas etiquetas.


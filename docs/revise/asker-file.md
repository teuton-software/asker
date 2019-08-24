
> **Output file format**
>
> * At this moment, the output text file format is GIFT. But in the
future will be posible to choose between several output formats.
> * The GIFT format is very common format in elearning software as Moodle.

# Demo

Vamos a ver un ejemplo.

---

## Input (Mapa conceptual)

Primero hay que crear un fichero de entrada con el mapa conceptual que queremos
trabajar. Vamos a usar de ejemplo [`input/es/demo/jedi.haml`](../../../input/es/demo/jedi.haml)

---

## Ejecutar el programas

Para ejecutar el programa *darts* con este fichero de entrada hacemos:
```
$ ./darts input/es/demo/jedi.yaml
```

Veremos en pantalla la siguiente [información](./jedi-log.txt).

Este informe muestra qué tal ha ido el proceso de generación, mostrando
estadísticas al final.

---

## Output

En el directorio `output` se guardan los ficheros de salida.

* [Fichero con las preguntas](./jedi-gift.txt) en formato GIFT.
* [Fichero con log del proceso](./jedi-log.txt).
* [Fichero con los contenidos](./jedi-doc.txt) en formato TXT más legible.

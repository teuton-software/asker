
# Demo

Vamos a ver un ejemplo.

## Input (Mapa conceptual)

Primero hay que crear un fichero de entrada con el mapa conceptual que queremos
trabajar. Vamos a usar de ejemplo [`input/es/demo/jedi.haml`](../../../input/es/demo/jedi.haml)

## Ejecutar el programas

Para ejecutar el programa *darts* con este fichero de entrada hacemos:
```
$ ./darts file input/es/demo/jedi.yaml
```

Veremos en pantalla la siguiente [información](./demo-log.txt).

Ests información muestra qué tal ha ido el proceso de generación, mostrando
estadísticas al final.

## Output

En el directorio `output` se guardan los ficheros de salida.

* [Fichero con las preguntas](./demo-gift.txt) en formato GIFT.
* [Fichero con log del proceso](./demo-log.txt).
* [Fichero con los contenidos](./demo-doc.txt) en formato TXT más legible.


# Ejemplo 02

Vamos a ampliar las definiciones del concepto `obiwan`.

## Input

Hemos modificado el fichero [`starwars.haml`](./starwars.haml),
ampliando las definiciones del concepto `obiwan`.

Además hemos incluido
una definición de tipo `image_url`. Esto es, un URL a una imagen, la cual
identifica de forma inequívoca el conceto al cual se refiere.

> Por tanto, podemos tener definiciones de texto y URL a una imagen.

## Ejecución

Para ejecutar *darts* usando como entrada el fichero con los conceptos, hacemos:

`./darts file docs/es/ejemplos/02/starwars.haml`

Vemos que aparece en pantalla la siguiente [información](./starwars-log.txt).

## Output

Se ha generado este [fichero](./starwars-gift.txt) con las preguntas en
format Gift, preparadas para cargarse en Moodle.

> Podemos comprobar como al aumentar las definiciones aumenta significativamente
el número de preguntas que se generan.


# Ejemplo 02

En el ejemplo anterior usamos un fichero en formato XML, en este ejemplo vamos
a usar el mismo contenido pero usando formato HAML.

HAML produce un XML equivalente. La diferencia está en que no hay etiquetas
de cierre, las etiquetas comenzan por % y para crear anidamiento se usan 2 espacios.

## Input

Vamos ahora el fichero fichero del ejercicio anterior [`starwars.haml`](./starwars.haml)
pero en formato HAML, con el concepto `obiwan` con una definición.

> Entendemos por `definición` una descripción textual que identifica de
forma inequívoca al concepto al que se refiere.

## Ejecución

Para ejecutar *darts* usando como entrada el fichero las definiciones del concepto,
hacemos:

`./darts file docs/es/ejemplos/02/starwars.haml`,

Vemos que aparece en pantalla la siguiente [información](./starwars-log.txt).

## Output

Se ha generado este [fichero](./starwars-gift.txt) con las preguntas en
format Gift, preparadas para cargarse en Moodle.


# Ejemplo 01

Vamos crear un concepto sobre los personajes de StarWars.

## Input

Creamos el fichero [`starwars.xml`](./starwars.xml),
con el concepto `obiwan` con una definición.

> Entendemos por `definición` una descripción textual que identifica de
forma inequívoca al concepto al que se refiere.

## Ejecución

Para ejecutar *darts* usando como entrada el fichero las definiciones del concepto,
hacemos:

`./darts file docs/es/ejemplos/01/starwars.xml`,

Vemos que aparece en pantalla la siguiente [información](./starwars.xml-log.txt).

## Output

Dentro del directorio `output`, se han creado varios ficheros de salida.
Entre ellos, el fichero [starwars-gift.txt](./starwars-gift.txt) con las preguntas
en formato Gift, preparadas para cargarse en un cuestionario como los de Moodle.

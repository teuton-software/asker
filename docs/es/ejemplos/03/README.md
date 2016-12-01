
# Ejemplo 03

Vamos a incluir más conceptos que tengan que ver con personajes de starwars
dentro del mismo mapa.

## Input

Consultar el fichero [`starwars.haml`](./starwars.haml) de entrada,
con los nuevos conceptos.

Hemos incluido en cada concepto una etiqueta con el nombre "tags". tags es una
lista de términos que ayuda a definir el concepto. Es como una nube de palabras.
Esta lista (tags) se usa para evaluar cuańto de cerca está la definición de un
concepto con respecto a otro semánticamente. Bueno, es una aproximación.

Esta valor de distancia semántica entre conceptos ayuda a formar preguntas
más difíciles para el alumno, proponiéndole varias alternativas, no al azar, sino
aquellas que tengan una "semántica" más parecida.

Cuantos más conceptos tenga el mapa, más complejas serán las preguntas y más
difícil responder al alumno.

## Ejecución

Para ejecutar *darts* usando como entrada el fichero con los conceptos, hacemos:

`./darts file docs/es/ejemplos/03/starwars.haml`

Vemos que aparece en pantalla la siguiente [información](./starwars-log.txt).

## Output

Se ha generado este [fichero](./starwars-gift.txt) con las preguntas en
format Gift, preparadas para cargarse en Moodle.

Podemos comprobar como al incluir más conceptos aumentan las preguntas.

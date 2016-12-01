
# Ejemplo 03

Vamos a ampliar aún más el concepto `obiwan`, pero ahora vamos a incluir
nueva información en forma de "tablas".

## Input

Hemos modificado el fichero [`starwars.haml`](./starwars.haml),
ampliando la información del concepto `obiwan` con "tablas". Éstas sirven
para incluir nueva información que acompaña al concepto pero
que no puede ser "definición" porque no identifica al concepto
(No es un valor único de dicho concepto).

> Usamos definiciones para reflejar información que sólo posee dicho concepto.
Es informacion única para él.
> Usamos las tablas para reflajar información del concepto pero que se pueden
repetir en otros conceptos del mapa conceptual.

Por ejemplo, vamos a añadir "tabla" con información de "atributo,valor".
Esto es un conjunto de atributos del personaje "obiwan" junto con el valor de
cada uno.

Las "tablas" pueden tener tienen uno o dos campos. Cada campo tiene que tener
un nombre.

> En el futuro se podrán hacer tablas con más de 2 campos. Por ahora, no.

## Ejecución

Para ejecutar *darts* usando como entrada el fichero con los conceptos, hacemos:

`./darts file docs/es/ejemplos/03/starwars.haml`

Vemos que aparece en pantalla la siguiente [información](./starwars-log.txt).

## Output

Se ha generado este [fichero](./starwars-gift.txt) con las preguntas en
format Gift, preparadas para cargarse en Moodle.

> Podemos comprobar como al incluir las tablas sigue aumentando
el número de preguntas que se generan.

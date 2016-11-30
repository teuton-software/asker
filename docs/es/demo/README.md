
# Demo

Vamos a ver un ejemplo.

## Input (Mapa conceptual)

Primero hay que crear un fichero de entrada con el mapa conceptual que queremos
trabajar. Vamos a usar de ejemplo [`input/es/demo/jedi.haml`](../../input/es/demo/jedi.haml)

## Ejecutar el programas

Para ejecutar el programa *darts* con este fichero de entrada hacemos:
```
$ ./darts file input/es/demo/jedi.yaml
```

Veremos en pantalla la siguiente [información](./)
 or
`ruby build projects/demo/starwars/config-jedi.yaml`, and we'll see something
like this on the screen.


```
[INFO] Loading input data...
* HAML/XML files from maps/demo/starwars: jedi.haml, sith.haml
[INFO] Showing concept data...
 <sidious(3)> lang=es
  .context    = personaje, starwars
  .tags       = humano, maestro, sith, alumno, plagueis
  .text       = Sith, maestro de todos los siths...
  .tables     = [$característica$descripción]
  .neighbors  = maul(50.0), obiwan(50.0), yoda(37.5)
 <maul(4)> lang=es
  .context    = personaje, starwars
  .tags       = lord, sith, alumno, emperador
  .text       = Lord Sirve como el aprendiz de Darth Sidious. Portando un sab...
  .tables     = [$característica$descripción]
  .neighbors  = sidious(57.14), obiwan(42.85), yoda(28.57)

[INFO] Creating output files...
[INFO] Showing concept stats...
* Concept: name=sidious -----------------------(Q=42, E=10, %=400)
* Concept: name=maul --------------------------(Q=32, E=8, %=400)
* TOTAL(2) -----------------------------------(Q=74, E=18, %=400)

```
It's only brief screen report the building process.


Output files
============
Let's see output files (*.txt) into `projects/demo/starwars/*.txt` directory.

> Let's see docs directory for more details.

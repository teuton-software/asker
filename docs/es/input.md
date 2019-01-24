
# Inputs o las definiciones de conceptos

En el directorio *asker* podemos ir guardando los ficheros de entrada con
nuestros propios mapas conceptuales. Podemos usar subdirectorios para tenerlo todo más organizado.

A modo de ejemplo podemos consultar el ficheros `input/es/demo/jedi.haml`,
que contiene varios conceptos de personajes de Starwars, definidos
dentro de un fichero con formato HAML.

> El formato HAML es XML pero escrito de forma que no hacen falta las etiquetas de cierre.

Echemos un vistazo a este ejemplo:

```
%map{ :lang => 'es', :context => 'personaje, starwars', :version => '1'}

  %concept
    %names obiwan
    %tags maestro, jedi, profesor, anakin, skywalker, alumno, quigon-jinn
    %def Jedi, maestro de Anakin Skywalker
    %def Jedi, alumno de Quigon-Jinn
    %def Vive en Tatooine, cerca de la casa de Luke Skywalker
    %def{:type => 'image_url'} https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQgYLLr0mmBtdMoqqzxWT6OGWKeBBeTqGAQPgEkmVGIIKNKb8Yv
    %table{ :fields => 'atributo, valor' }
      %row
        %col raza
        %col humano
      %row
        %col color sable laser
        %col verde
      %row
        %col color del pelo
        %col pelirojo

  %concept
    %names yoda
    %tags maestro, jedi
    %def Jedi, maestro de todos los jedis
    %def Fue el Gran Maestro de la Orden Jedi y uno de los miembros más importantes del Alto Consejo Jedi en los últimos días de la República Galáctica.
    %def Tenía habilidades excepcionales en el combate con sables de luz, empleando técnicas acrobáticas del Ataru.
    %def Era un maestro en todas las formas del combate con sables de luz y era considerado por muchos como un Maestro de Espadas.
    %def{:type=>'image_url'}https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR3UZKfQH3kY7HUgPJyV5B2h4YgCfg338QXJbvPtAkQ4JdTxWFUlQ
    %table{ :fields => 'atributo, valor' }
      %row
        %col color sable laser
        %col verde
      %row
        %col color del pelo
        %col blanco
      %row
        %col color de piel
        %col verde
      %row
        %col altura
        %col 65 centímetros
```

Podemos ver que tenemos definidos 2 conceptos sobre personajes Jedi. Estos son "obiwan" y "yoda". Se usan unos tags (etiquetas) especiales para definir los conceptos. Esto se explicará más adelante.


At now we have a this list of tags to define our own sintax for build conceptual maps:
* **names**: List of one or more names that identify the concept. At least one is requiered, of course!.
* **context**: List of comma separated words, that identify the context where this concept "lives" or "exists".
* **tags**: List of comma separated words, that briefly describe the concept. I mean, a short list of words
that came in mind when we think in it, and are useful for their identification.
* **def**: We use this tags as many times we need. In it, we write using natural language descriptions
asssociated to the concept. Descriptions that are uniques for this concept, but don't write the name of
the concept into the text.
* **table**: Other way to build more sofisticated definitions/schemas is using "tables". It's similar
to HTML tag. I mean, with this "table", we build tables of knowledge into the concept. We use "row",
ans "col", to defines table-rows and row-cols, of course. We could see an
example into `maps/demo/starwars/jedi.haml`.

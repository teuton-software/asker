
Inputs
======
Into *maps* directory we save our own concept map files. We could use subdirectories to
better organization. As example we have the file `maps/demo/starwars/jedi.haml`, that
contains one concept map about Jedi characters of StarWars film into HAML format.

Let's take a look (Spanish example, I know. Soon I'll write the english version):
```
%map{ :version => '1', :lang => 'es', :context => 'personaje, starwars' }
  %concept
    %names obiwan
    %tags maestro, jedi, profesor, annakin, skywalker, alumno, quigon-jinn
    %text Jedi, maestro de Annakin Skywalker
    %text Jedi, alumno de Quigon-Jinn
    %table{ :fields => 'característica, descripción' }
      %row
        %col raza
        %col humano
      %row
        %col color sable laser
        %col verde
      %row
        %col color-del-pelo
        %col pelirojo

  %concept
    %names yoda
    %tags maestro, jedi
    %text Jedi, maestro de todos los jedis
    %text Midiendo 65 centímetros, fue el Gran Maestro de la Orden Jedi y uno de los miembros más importantes del Alto Consejo Jedi en los últimos días de la República Galáctica.
    %text Tenía habilidades excepcionales en el combate con sables de luz, empleando técnicas acrobáticas del Ataru.
    %text Era un maestro en todas las formas del combate con sables de luz y era considerado por muchos como un Maestro de Espadas.    
    %table{ :fields => 'característica, descripción' }
      %row
        %col color sable laser
        %col verde
      %row
        %col color-del-pelo
        %col blanco
      %row
        %col color-de-piel
        %col verde
...
```
As we see, we defined 2 concepts about Jedi characters. This are "obiwan" and "yoda". And
we use special sintax (tags) to define it.

At now we have a this list of tags to define our own sintax for build conceptual maps:
* **names**: List of one or more names that identify the concept. At least one is requiered, of course!.
* **context**: List of comma separated words, that identify the context where this concept "lives" or "exists".
* **tags**: List of comma separated words, that briefly describe the concept. I mean, a short list of words
that came in mind when we think in it, and are useful for their identification.
* **text**: We use this tags as many times we need. In it, we write using natural language descriptions
asssociated to the concept. Descriptions that are uniques for this concept, but don't write the name of
the concept into the text.
* **table**: Other way to build more sofisticated definitions/schemas is using "tables". It's similar
to HTML tag. I mean, with this "table", we build tables of knowledge into the concept. We use "row",
ans "col", to defines table-rows and row-cols, of course. We could see an 
example into `input/en/starwars/jedi.haml`.


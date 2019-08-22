
[<< back](README.md)

# Learn

How to build our asker input files?
We need to learn only 8 keywords:
* map, concept, names, tags
* def, table, row and col

Let's start.

---

# Text plain editor

* Create a text file, called for example: `demo/forniture.haml`.
* **map**: Once, at first line, we write keyword `map`. Example:

```ruby
%map{ :lang => 'en', :context => 'furniture, home', :version => '1'}
```

| Attribute | Description                                    |
| --------- | ---------------------------------------------- |
| lang      | Output texts will be created in English        |
| context   | Comma separated labels that define map content |
| version   | Input file format version |

This input file will contain concepts about furniture context.

* **concept, names, tags**: Now we define our first concept, like this:

```ruby
  %concept
    %names chair
    %tags single, seat, leg, backrest
```

| Param | Description |
| ----- | ----------- |
| names | Comma separated concept's names |
| tags  | Comma separated tags that help to identify this concept |

* **def**: Use def keyword to add concept meaning. The `def` content must uniquely identifies our concept. You can use more than one `def`.

```ruby
  %concept
    %names chair
    %tags single, seat, leg, backrest
    %def Single seat with legs and backrest
    %def Furniture that is placed around the table to sit
```

At this time, we may generate questions from this file.

# Format

HAML is a special format. It's necesary write exactly:
* 0 spaces before map.
* 2 spaces before concept.
* 4 spaces before names, tags and def.

It's posible write the same using XML format instead. Take a look:

```xml
<map lang='en' context='furniture, home' version='1'>
  <concept>
    <names>chair</names>
    <tags>single, seat, leg, backrest</tags>
    <def>Single seat with legs and backrest</def>
    <def>Furniture that is placed around the table to sit</def>
  </concept>
</map>
```

Notice that `demo/furniture.haml` is HAML file and  `demo/furniture.xml` a XML file. Both are valid.

> HAML format files are the same as XML format files.
Internaly HAML files are translated automaticaly to an XML equivalent.
>
> Why write into HAML instead of XML? HAML It's easier (for me).
You don't have to close every tag, only be carefuly with indentation.
>
> If you prefer, you could write your input files using XML.


Inputs
======

Into *maps* directory we save our own concept map files. We could use subdirectories to
better organization. As example we have the file `maps/demo/starwars/jedi.haml`, that
contains one concept map about Jedi characters of StarWars film into HAML format.

Let's take a look (Spanish example, I know. Soon I'll write the english version):
```
%map{ :lang => 'en', :context => 'character, starwars', :version => '1'}

  %concept
    %names obiwan
    %tags jedi, teacher, annakin, skywalker, pupil, quigon-jinn
    %def Jedi, teacher of Annakin  Skywalker
    %def Jedi, pupil of Quigon-Jinn
    %table{ :fields => 'attribute, value' }
      %title Associate every attribute with their value
      %row
        %col race
        %col human
      %row
        %col laser sabel color
        %col green
      %row
        %col hair color
        %col red

  %concept
    %names yoda
    %tags teacher, jedi
    %def Jedi, teacher of all jedis
    %def The Main Teacher of Jedi and one of the most important members of the Main Jedi Council, in the last days of Star Republic.
    %def He has exceptional combat abilities with light sable, using acrobatics tecnics from Ataru.
    %def He was master of all light sable combat styles and was considered during years as a Sword Master.    
    %table{ :fields => 'attribute, value' }
      %row
        %col color laser sabel
        %col green
      %row
        %col hair color
        %col white
      %row
        %col skin color
        %col green
      %row
        %col high
        %col 65 centimetres
...
```
As we see, we defined 2 concepts about Jedi characters. This are `obiwan` and `yoda`.
And we use special sintax (tags) to define it.

At now we have a this list of tags to define our own sintax for build conceptual maps:
* **context**: List of comma separated words, that identify the context where this concept "lives" or "exists".
* **names**: List of one or more names that identify the concept. At least one is requiered, of course!.
* **tags**: List of comma separated words, that briefly describe the concept. I mean, a short list of words
that came in mind when we think in it, and are useful for their identification.
* **def**: We use this tags as many times we need. In it, we write using natural language descriptions
asssociated to the concept. This are definitions/descriptions that are uniques
for this concept, but don't write the name of the concept into the text.
* **table**: Other way to build more sofisticated definitions/schemas is using "tables". It's similar
to HTML tag. I mean, with this "table", we build tables of knowledge into the concept. We use "row",
and "col", to defines table-rows and row-cols, of course. We could see an
example into `input/en/starwars/jedi.haml`.

---


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

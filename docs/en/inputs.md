
Format
======

HAML format files are the same as XML format files.
HAML files are translated automaticaly to an XML equivalent.

Why write into HAML instead of XML? HAML It's more easy. You don't have to 
close every tag, only be carefuly with indentation.

If you prefer, you could write your input files using XML.


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
        %col laser_sabel_color
        %col green
      %row
        %col hair_color
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
        %col color_laser_sabel
        %col green
      %row
        %col hair_color
        %col white
      %row
        %col skin_color
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


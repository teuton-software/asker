
# TO-DO

* Apply standard linter to code
* DOC or FIX: table only works with 4 columns? revise stage_t.rb
* FIX: check asker.ini version
* FIX: question f3filtered type. There are not usefull filtered sequence of row values from concept table.

* NEW: Graphic front end.
* NEW: User asker configuration to add new local languages or change existing one.
* NEW: Language support: Adding Esperanto.

## GUI

Create a graphic fron end to execute asker and edit input files.

## Videos

* Documentation: Revise documentation
* Perhaps, videos on youtube explaining all this: (1) Get documentation, (2) Installation, (3) Consult demo input, (4) Create our input file usign def, (5) Add tables to our input file.

## info keyword

* Add new keyword called info. Example:
```
%map{ :lang => 'en', :context => 'rock, bands', :version => '1'}
  %info Generic text about music, rock, bands, concerts, etc.
  %info more...
```
* When AI create new question may use (randomly) info text to be included into it. Example:
```
Rock music style was created for ....

Definition of [*]: Australian rock band formed by Scottish-born brothers Malcolm and Angus Young.

Select right option:
a. Led Zepellin
b. Beatles
c. ACDC
d. None
```

## Etc

* Texts
    * Concept name drop and fill...
* Question types
    * crossword
    * type hangmann
* Dictionary
    * Diccionario de sinónimos, antónimos
    * Learn about the words or better download dictonary from RAE?

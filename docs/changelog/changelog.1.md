
## [2.1.0]

* ADD: Language support: Adding French(fr) and Dutch(du).
* ADD: Process tables definitions with more than 2 fields.
* ADD: More output formats. Embeded images into question texts
* NEW: Export questions to YAML format then use them with app quizzer to create PDF exams.

## Code inputs

Let's take a look at the [issues](https://github.com/dvarrui/asker/issues)

Actually we are experimenting with new keywords: code, type, path, features.

Example:

```
  %code
    %type ruby
    %path files/string1.rb
    %features
      %row Muestra en pantalla "Hola Mundo!"
```

Where `type` could be: ruby, python or sql.

> Also bash, math, crontab, fstab, etc.

## [2.2.0] dic2021

* NEW: definition tag type: `def{:type => :file} PATH-TO-FILE`. This could use external files to work as concept definitions. We could use local text file, local image file and remote (URL) image.
* NEW: The tag `code` is experimental but it's usefull to generate questions from code file from JS, Python and Ruby by now.
* NEW: export file format (Moodle XML). This export file include more questions than GIFT one. In the next future will be more new questions type into this file.

## [2.3.0]

* DEPRECATED: Use of yaml projects scheme as asker inputs.
* NEW: It is posible configure question fractions into `asker.ini` config file. Fractions are penalties apply when select bad answer.
* NEW: The tag `code` is experimental but it's usefull to generate questions from code file from JS, Python and Ruby by now.
* UPDATE: Use asker.ini to configure score questions. Previos versions had score questions hardcored.

## [2.4.0]

* NEW: Adding language "ca" (Catalán).

## [2.4.5]

* Remove question `f3filtered` type. There are not usefull filtered sequence of row values from concept table.

## [2.5.0]

* NEW: Inside concept.def it is posible to put audio, image and video filepath.
* NEW: Asker import audio/image/video files into questions.

## [2.5.2]

* FIX bug exporting YAML questions file. Only affects to matching type questions.

## [2.5.3]

* FIX: Deprecated gem show warning

## [2.5.4]

* FIX: Sometimes, spaces at the end of line where detected as malformed input. Replace check function and now we have smarter checker by using Regexp instead of String comparisons.

## [2.5.6]

* UPDATE: Screen output.

## [2.5.9]

* ADD: asker check detects and warns about def with no content
* FIX: def without content is skipped and do not raise Nil exception

## [2.6.0] 20230531

* UPDATE: asker check function. Now advised when exits a tag `%tags` with no text and when exists a tag `%row` with text and containing `%col`.

## [2.7.0] 20230531

* UPDATE: change output file log name and doc name.
* ADD: Copy all stdout and stderr screen messages to log
* ADD: asker now reads "problem" data
* ADD: ordering type questions to Problems
* ADD: ordering type questions to Concept sequence.
* FIX: sanitize pre content into gift questions

## [2.8.0] 20230711

* UPDATE: problem answer contains text value or formula (type: 'formula')
* UPDATE: check validates problem answer{type: 'formula'}

## [2.9.0] unreleased

* UPDATE: by default, configure asker.ini to no export gift and yaml output.

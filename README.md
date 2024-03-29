# ASKER

[![Gem Version](https://badge.fury.io/rb/asker-tool.svg)](https://badge.fury.io/rb/asker-tool)
![GitHub](https://img.shields.io/github/license/dvarrui/asker)

Generate a lot of questions from an _input_ text file with on your own _definitions_. In a way, this _input file_ is a concept map.

Asker helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

![logo](./docs/images/logo.png)

# Installation

At first install Ruby and then:

```
gem install asker-tool
```

> REMEMBER: Update Asker with `gem update asker-tool`

# Usage

| Step | Action                | Tool | Description |
| ---: | --------------------- | ---- | ----------- |
| 1    | Define your concepts | Text plain editor | Create input file with your contents (_conceptual map_). Here are some [examples](https://github.com/teuton-software/asker/tree/master/docs/examples). And more examples at this [repository](https://github.com/dvarrui/asker-inputs).
| 2    | Generate questions | `asker PATH/TO/INPUT` | **Run `asker`** to process input file. Output files are saved into the `output` folder |

Let's see an example creating questions from ACDC input example file:

```console
❯ asker docs/examples/bands/acdc.haml

+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| Concept            | Questions | Entries | xFactor | d | b | f  | i | s | t  |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| AC/DC              | 46        | 18      | 2.5     | 7 | 0 | 15 | 0 | 4 | 20 |
| Excluded questions | 0         | -       | -       | 0 | 0 | 0  | 0 | 0 | 0  |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| 1 concept/s        | 46        | 18      | 2.5     | 7 | 0 | 15 | 0 | 4 | 20 |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
```

# Features

* [Free Software License](LICENSE).
* Multiplatform.
* Input files formats: XML, HAML.
* Output formats: GIFT, Moodle XML, YAML.
* Question types: true/false, multiple choice, short answer, matching and ordering.
* Embeded files: mp3, ogg, wav, jpg, jpeg, png, mp4, ogv and plain text files.

# Documentation

* [Installation](docs/install/README.md)
* [Videos](docs/videos.md)
* [Get started](docs/inputs/README.md)
* [Usage](docs/usage.md)
* [Reference](docs/reference.md)
* [Contributions](docs/contributions.md)
* [Problem to solve](docs/idea.md)
* [History](docs/history.md)

# Contact

* **Email**: `teuton.software@protonmail.com`

# Contributing

1. Make sure you have Ruby installed
1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request.

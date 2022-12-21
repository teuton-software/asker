# ASKER

[![Gem Version](https://badge.fury.io/rb/asker-tool.svg)](https://badge.fury.io/rb/asker-tool)
![GitHub](https://img.shields.io/github/license/dvarrui/asker)

Generate a lot of questions from an _input_ text file with on your own _definitions_. In a way, this _input file_ is a concept map.

![logo](./docs/images/logo.png)

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

* Free Software [LICENSE](LICENSE).
* Multiplatform.

## Installation

First install Ruby and then:

```
gem install asker-tool
```

> REMEMBER: Update Asker with `gem update asker-tool`

## Usage

1. **Create input file** with your contents (_conceptual map_). [Here are some examples](./docs/examples).
2. **Run `asker PATH/TO/INPUT`**. Let's see an example creating questions from ACDC input example file:

```
❯ asker docs/examples/bands/acdc.haml

+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| Concept            | Questions | Entries | xFactor | d | b | f  | i | s | t  |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| AC/DC              | 45        | 18      | 2.5     | 7 | 0 | 15 | 0 | 3 | 20 |
| Excluded questions | 0         | -       | -       | 0 | 0 | 0  | 0 | 0 | 0  |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
| TOTAL = 1          | 45        | 18      | 2.5     | 7 | 0 | 15 | 0 | 3 | 20 |
+--------------------+-----------+---------+---------+---+---+----+---+---+----+
```

3. **Output files** are saved into the `output` folder.

> More input examples at [asker-input  repository](https://github.com/dvarrui/asker-inputs).

## Documentation

* [Installation](docs/install/README.md)
* [Videos](docs/videos.md)
* [Inputs](docs/inputs/README.md)
* [Usage](docs/usage.md)
* [Reference](docs/reference.md)
* [Contributions](docs/contributions.md)
* [Problem to solve](docs/idea.md)
* [History](docs/history.md)

## Contact

* **Email**: `teuton.software@protonmail.com`

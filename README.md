[![Gem Version](https://badge.fury.io/rb/asker-tool.svg)](https://badge.fury.io/rb/asker-tool)
![Gem](https://img.shields.io/gem/dv/asker-tool/2.2.1)

# ASKER (devel 2.3)

Generate a lot of questions from an _input_ text file with on your own _definitions_. In a way, this _input file_ is a concept map.

![logo](./docs/images/logo.png)

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

* Free Software [LICENSE](https://github.com/dvarrui/asker/blob/devel/LICENSE.txt).
* Multiplatform.
* Ruby program.

## Installation

1. Install Ruby on your system.
2. `gem install asker-tool`

## Usage

Steps:

1. Create an input file with your definitions (_conceptual entities_).
1. Run _asker_ and get the results into `output` directory.

Example: Running `asker` with our example input file as argument (`acdc.haml`):

```
asker docs/examples/bands/acdc.haml
```

* Output files created into the `output` folder.
* More [example input files](./docs/examples).
* More asker input files at `github/dvarrui/asker-inputs` repository.

## Documentation

* [Installation](https://github.com/dvarrui/asker/blob/devel/docs/install/README.md)
* [Inputs](https://github.com/dvarrui/asker/blob/devel/docs/inputs/README.md)
* [Usage](https://github.com/dvarrui/asker/blob/devel/docs/usage.md)
* [Contributions](https://github.com/dvarrui/asker/blob/devel/docs/contributions.md)
* [Base idea](https://github.com/dvarrui/asker/blob/devel/docs/idea.md)
* [History](https://github.com/dvarrui/asker/blob/devel/docs/history.md)

## Contact

* **Email**: `teuton.software@protonmail.com`
* **Twitter**: `@SoftwareTeuton`

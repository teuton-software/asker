[![Gem Version](https://badge.fury.io/rb/asker-tool.svg)](https://badge.fury.io/rb/asker-tool)
![GitHub](https://img.shields.io/github/license/dvarrui/asker)

# ASKER

Generate a lot of questions from an _input_ text file with on your own _definitions_. In a way, this _input file_ is a concept map.

![logo](./docs/images/logo.png)

ASKER helps trainers to create a huge amount of questions, from a definitions (_conceptual entities_) input file.

* Free Software [LICENSE](LICENSE).
* Multiplatform.
* [Ruby program](https://rubygems.org/gems/asker-tool)

## Installation

1. Install Ruby on your system.
2. Install Asker on your system: `sudo gem install asker-tool`

> REMEMBER: To update Asker execute `sudo gem update asker-tool`

## Usage

Steps:

1. Create an input file with your inputs (_conceptual map_).
1. Run _asker_ and get the results into `output` directory.

Example: Running `asker` with our example input file as argument (`acdc.haml`):

```
asker docs/examples/bands/acdc.haml
```

* Output files created into the `output` folder.
* More [example input files](./docs/examples).
* More asker input files at [github/dvarrui/asker-inputs](https://github.com/dvarrui/asker-inputs) repository.

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
* **Twitter**: `@SoftwareTeuton`

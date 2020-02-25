
[<< back](../../README.md)

# Installation

* Installation process:
    1. Install Ruby on your system.
    2. `gem install theory-asker`
* Run `asker version` to check that your installation is ok.

> **PROBLEMS**: If you have problems to find `asker`command (OpenSUSE distro), try this:
> * `find / -name asker`, to find absolute path to teuton command.
> * As superuser do `ln -s /PATH/TO/bin/asker /usr/local/bin/asker`, to create symbolic link to asker command.
> * Try again as normal user.

* **Update** Asker with `gem asker update`.
* **Uninstall** Asker with `gem uninstall asker`

> Others ways to install Asker:
> * [Installation scripts](scripts.md)
>* [Manual installation](manual.md)

---
# Configuring Asker

There exist `config.ini`file, into Asker base directory with some configurable options.

| Section     | Param    | Default | Values    | Description |
| ----------- | -------- | ------- | --------- | ----------- |
| [global]    | internet | no      | yes or no | Accept to connect Google and download find images URLs |
| [questions] | exclude  |         | Comma separated strings| Exclude questions with this texts into their names |

---
# Download input examples

If you want to download our repository with asker input files:

`git clone https://github.com/dvarrui/asker-inputs.git`

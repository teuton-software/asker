
[<< back](../../README.md)

# Installation

**Install** Asker:
1. Install Ruby on your system.
2. Install Asker on your system. Two ways:
    * (a) `sudo gem install asker-tool` as superuser (root) or
    * (b) `gem install --user-install asker-tool` as regular user.

Run `asker version` to check that your installation is ok.

> **Warning**: in the OpenSUSE operating system you have to look for the command with another name. For example, if you have `ruby2.5` installed, then the command is called `asker.ruby2.5` instead of `asker`.

**Update** Asker with `gem update asker-tool`.

**Uninstall** Asker with `gem uninstall asker-tool`

# Download input examples

If you want to have a lot of free asker inputs examples into your machine,
you can download them.

Download `asker-inputs` repository:
```
git clone https://github.com/dvarrui/asker-inputs.git
```

# Advanced: Others ways to install Asker

* [Vagrant](../../install/vagrant/README.md). Vagranfiles to build VM that includes asker tool and asker inputs.
* [Installation scripts](scripts.md)
* [Manual installation](manual.md)


[<< back](../../README.md)

# Installation

1. **Install Ruby** on your system.
2. **Install Asker** on your system.

## 1. Install Ruby

| Plataform     | Installation |
| ------------- | ------------ |
| OpenSUSE      | Done! |
| Debian/Ubuntu | `sudo apt install ruby` |
| Windows       | https://rubyinstaller.org/ |
| MacOS         | Done! |

## 2. Install Asker

| Action | Description |
| ------ | ----------- |
| `gem install --user-install asker-tool` | Regular installation |
| `sudo gem install asker-tool` | Superuser installation |
| `gem update asker-tool` | Update Asker gem |
| `gem uninstall asker-tool` | Uninstall Asker gem |

Run `asker version` to check that your installation is ok.

> **Warning**: in the OpenSUSE operating system you have to look for the command with another name. For example, if you have `ruby2.5` installed, then the command is called `asker.ruby2.5` instead of `asker`.

# Input examples

If you want to have a lot of free asker inputs examples into your machine,
you can download them.

Download `asker-inputs` repository:
```
git clone https://github.com/dvarrui/asker-inputs.git
```

# Advanced installations

* [Vagrant](../../install/vagrant/README.md). Vagranfiles to build VM that includes asker tool and asker inputs.
* Docker `docker pull dvarrui/asker:latest`
* [Installation scripts](scripts.md)
* [Manual installation](manual.md)

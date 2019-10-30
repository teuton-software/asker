
[<< back](../../README.md)

# Install Asker Software

Ways to install:

* [Installation scripts](scripts.md) **RECOMMENDED**
* [Manual installation](manual.md)

---

# Configuring Asker software

There exist `config.ini`file, into Asker base directory with some configurable options.

| Section     | Param    | Default | Values    | Description |
| ----------- | -------- | ------- | --------- | ----------- |
| [global]    | internet | yes     | yes or no | Accept to connect Google and download find images URLs |
| [questions] | exclude  |         | Comma separated strings| Exclude questions with this texts into their names |

---

# Download Asker input examples

If you want to download our repository with asker input files:

1. Open sesión as normal user. Not root.
1. `cd`
1. `asker download`

> Like a `git clone https://github.com/dvarrui/asker-inputs.git`

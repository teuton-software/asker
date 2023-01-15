
[<<back](../README.md)

# Usage

1. Commands from shell
2. Config file
3. Call API from Ruby program

## 1. Commands from Shell

The simplest way of using Asker is using `asker` command.
Available `asker` command functions:

| Command | Description |
| ------- | ----------- |
| `asker` | Show available functions |
| `asker help` | It's the same as `asker` |
| `asker version` | Show current version |
| `asker PATH/TO/INPUTFILE` | Create questions for selected input file |
| `asker file PATH/TO/INPUTFILE` | It's the same as `asker PATH/TO/INPUTFILE`. `file` keyword is optional |
| `asker check PATH/TO/INPUTFILE` | Check HAML file syntax |
| `asker init` | Create default config.ini file into current folder |
| `asker new FOLDER` | Create FOLDER with input example file |

# 2. Config file

Configuration file is only required when you want to change default values.
* First, run `asker init` to create a `config.ini` into your current folder.
* Then use plain text editor to change default values.

Resume:

| Section     | Param    | Default | Values    | Description |
| ----------- | -------- | ------- | --------- | ----------- |
| [global]    | internet | no      | yes or no | Accept to connect Google and download find images URLs |
| [questions] | exclude  |         | Comma separated strings| Exclude questions with this texts into their names |

## 3. Call Asker API from Ruby program

Example, how to call Asker functions from Ruby program:

```ruby
# First load asker gem
require 'asker'

# Create questions from input file
Asker.start(filename)
```

# Download input examples

Download repository with asker input files:
```
git clone https://github.com/dvarrui/asker-inputs.git
```


[<<back](../README.md)

# Usage

1. Commands from shell
2. Call API into Ruby program

---
## Commands from Shell

The simplest way of using Asker is running `asker` as CLI command.
These are available command functions:

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

---
## Call Asker API from Ruby program

Example, how to call Asker functions from Ruby program:

```ruby
# First load asker gem
require 'asker'

# Create questions from input file
Asker.start(filename)
```

> Read docs to know more about Asker class.

# Installation

## Required software

Check current versions:
```
$ ruby -v
ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux-gnu]
$ rake --version
rake, version 10.4.2
```

* Install `ruby` (Tested on 2.1.3 version)
    * `sudo zypper install ruby` install ruby on OpenSUSE.
    * `sudo apt-get install ruby`, install ruby on Debian/Ubuntu.

* Install `rake` (Tested on 10.4.2).
    * `sudo gem install rake`, install rake gem.

## Download the project

Download the project `darts-of-teacher` from GitHub repositories.
```
$ git --version
git version 2.1.4
$ git clone git@github.com:dvarrui/darts-of-teacher.git
```

## Libraries installation

* `cd darts-of-teacher`, move into the proyect main directory.
* `sudo rake gems`, to install libraries (gems) required for this tool.

## Final test

* `rake check`, test everything is fine.
* `./darts -v`, show proyect version.

Now we are readey to work with *darts*!

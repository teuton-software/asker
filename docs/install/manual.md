
[<< back](README.md)

# Manual installation

1. Git installation
    * Install Git.
    * Run `git --version` to show current version
1. Ruby installation
    * Install ruby.
    * Run `ruby -v` to show current version
1. Rake installation
    * Run `gem install rake`, then
    * `rake --version` to show current version.
1. Download this project
    * (a) `git clone https://github.com/dvarrui/asker.git` or
    * (b) Download and unzip [file](https://github.com/dvarrui/asker/archive/master.zip).
1. Move into repo folder.
    * Run `cd asker`
1. Gems installation.
    * `rake install:gems`, to install required gems.
1. Only for developers
    * Run `rake install:debian` or
    * `rake install:opensuse`, install gem for developers.
1. Final check
    * `rake`

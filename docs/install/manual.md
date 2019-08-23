
[<< back](README.md)

# Manual installation

As `root` user do the next:

| Step | Acction        | Details              |
| ---- | ---------------- | -------------------- |
|  1   | Install git      | Versión >=2.1.4      |
|  2   | Install ruby     | Versión >=2.1.3      |
|  3   | Install rake     | Versión >=10.4.2     |
|  4   | Download project | github/dvarrui/asker |
|  5   | cd asker         | |
|  6   | Install gems     | rake gems |
|  7   | Final check      | rake |

---

## Steps 1-2-3: git, ruby and rake

Checking software versions:
```
$ git --version
git version 2.1.4
$ ruby -v
ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux-gnu]
$ rake --version
rake, version 10.4.2
```

For example, to install on OpenSUSE we do:
1. `zypper install git`, Install git.
1. Ruby is preinstalled.
1. `gem install rake`, Install rake.

To install on Debian:
1. `apt-get install git`, Install git.
1. `apt-get install ruby`, Install ruby.
1. `gem install rake`, Install rake.

---

## Step 4: Download project

```
git clone https://github.com/dvarrui/asker.git
```

## Step 5-6: Install gems (libraries and dependencies)

```
cd asker       # Move to project directory
sudo rake gems # Install required gems
```

## Step 7: Final check

```
rake           # Test files and show program version
```

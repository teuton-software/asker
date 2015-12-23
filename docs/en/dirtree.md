**Directories description**
===========================

This is the directory tree:

```
.
├── docs
├── lib
├── LICENSE
├── MANTAINERS.md
├── input
│   └── demo
│       └── starwars
│           ├── jedi.haml
│           └── sith.haml
├── projects
│   └── demo
│       └── starwars
│           ├── config.yaml
│           └── sith.yaml
├── Rakefile
├── README.md
├── run
└── spec

```

* *README.es.md*: This help file
* *run*: This is the script file that will build our questions file 
from conceptual map files. Execute `./run --help` to know how to use it.
* *lib*: Directory that contains the ruby classes and modules of this project.
* *maps*: Directories where we save our own conceptual maps (using HAML or XML file format).
* *projects*: Directory that contains config files for every project. This config 
file are necessary to easily group parameters used by this tool. Also, 
into this directory will be created the reports and output files (as GIFT, etc.)
of every project.
* *spec*: Directory that will contain the test units in the next future. I hope!.


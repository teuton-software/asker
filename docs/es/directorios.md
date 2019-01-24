
# Directorios

Éste es el árbol de directorios del proyecto:

```
.
├── asker
├── docs
│   ├── en
│   ├── es
│   ├── images
│   └── TODO.md
├── input
│   ├── en
│   ├── es
│   └── files
├── lib
├── LICENSE
├── output
├── projects
│   ├── en
│   └── es
├── Rakefile
├── README.md
└── tests
```

* *README.md*: Es el documento en Inglés, principal del proyecto.
El correspondiente en español es `docs/es/README.md`.
* *asker*: Este es el script/comando que usamos para dar la orden de
construir/generar las preguntas. Le pasamos como argumento el fichero con el
mapa conceptual que queremos procesar.
* *lib*: Contiene las clases y módulos Ruby de la aplicación.
* *input*: Directorio que usamos para guardar nuestros mapas conceptuales.
Dichos ficheros tienen formato XML o HAML.
* *projects*: Directory that contains config files for every project. This config
file are necessary to easily group parameters used by this tool. Also,
into this directory will be created the reports and output files (as GIFT, etc.)
of every project.
* *tests*: Unidades de prueba de las clases de la aplicación.

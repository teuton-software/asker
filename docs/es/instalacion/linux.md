
# Instalación en GNU/Linux

## Software requerido

Software requerido:
* ruby (version >= 2.1.3)
* rake (version >= 10.4.2)

Para comprobar las versiones
```
$ ruby -v
ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux-gnu]
$ rake --version
rake, version 10.4.2
```

## Descarga del proyecto

Vamos a descargar el proyecto `darts-of-teacher` desde los repositorios de GitHub.
```
$ git --version
git version 2.1.4
$ git clone https://github.com/dvarrui/darts-of-teacher.git
```

## Instalación de las librerías

* `$ cd darts-of-teacher`, para situarnos en el directorio del proyecto.
* `$ sudo rake gems`, para instalar las librerías (gemas) que nos hacen falta.

## Comprobaciones finales

* `$ rake check`, para comprobar que está todo correctamente instalado.
* `$ ./darts -v`, nos muestra la versión del proyecto.

¡Ya estamos listos para empezar a usar *darts*!

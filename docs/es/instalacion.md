
# Instalación

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
$ git clone git@github.com:dvarrui/darts-of-teacher.git
```

## Instalación de las librerías

* `$ cd darts-of-teacher`, para situarnos en el directorio del proyecto.
* `$ sudo rake gems`, para instalar las librerías (gemas) que nos hacen falta.

## Comprobaciones finales

* `$ rake check`, para comprobar que está todo correctamente instalado.
* `$ ./darts -v`, nos muestra la versión del proyecto.

¡Ya estamos listos para empezar a usar *darts*!

---

# Windows

Instalación de Ruby:
* Ir a https://rubinstaler.org/downloads
* Descargar ruby versión 2.2.X. Esta versión es la recomendada por todas las gemas actualizadas.
* Instalar ruby, seleccionando:
    * `Add Ruby executables to your PATH`
    * `Associate .rb and .rbw files with this Ruby installation`
* Comprobamos:
    * Abrimos una consulta
    * Ejecutamos `ruby -v` y nos debe mostrar la versión instalada.

Instalación de git:
* Ir a https://git-scm.com/download/Windows
* Descargar la versión que nos ofrecen (2.13.2).
    * `Use Git from Windows Command Prompt`
    * `Use the OpenSSL library`
    * `Chekout Windows-style, commit Unix-style line endings`
    * `Use MinTTY`
    * `Enable File system caching`
* Comprobamos:
    * Abrimos una consola.
    * Ejecutamos `git --version`

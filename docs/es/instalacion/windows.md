
# Instalación en Windows

## Instalar ruby y rake

* Ir a https://rubinstaler.org/downloads
* Descargar ruby versión 2.2.X.

> Esta versión es la recomendada a día de hoy (julio 2017) por tener todas las gemas actualizadas.

* Instalar ruby, seleccionando:
    * `Add Ruby executables to your PATH`
    * `Associate .rb and .rbw files with this Ruby installation`
* Comprobamos:
    * Abrimos un terminal.
    * Ejecutamos `ruby --version` y nos debe mostrar la versión instalada.
    * Comprobamos que `rake` también está instalado con `rake --version`.

## Instalar git

* Ir a https://git-scm.com/download/Windows
* Descargar la versión que nos ofrecen (2.13.2).
    * `Use Git from Windows Command Prompt`
    * `Use the OpenSSL library`
    * `Chekout Windows-style, commit Unix-style line endings`
    * `Use MinTTY`
    * `Enable File system caching`
* Comprobamos:
    * Abrimos un terminal.
    * Ejecutamos `git --version`

## Descargar el proyecto

* Abrir una consola.
* `git clone https://github.com/dvarrui/darts-of-teacher.git`

## Instalar las librerías

* Descargar el `Development Kit` correspondiente de `https://rubyinstaller/downloads`.

> El DevKit es requerido por algunas gemas de ruby. Rainbow en nuestro caso.
> Este Kit incluye las herramientas necesarias para la construcción de la gema para
adaptarse al SO Windows.

* `cd darts-of-teacher`, para situarnos en el directorio del proyecto.
* `rake gems`, para instalar las librerías (gemas) que nos hacen falta.

## Comprobaciones finales

* `rake check`, para comprobar que está todo correctamente instalado.
* `./darts -v`, nos muestra la versión del proyecto.

¡Ya estamos listos para empezar a usar *darts*!

---

# Windows

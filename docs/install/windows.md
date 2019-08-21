
# Instalación en Windows

Resumen del proceso de Instalación

| ID | Paso                  |
| -- | --------------------- |
|  1 | Instalar git          |
|  2 | Instalar ruby         |
|  3 | sudo gem install rake |
|  4 | git clone https://github.com/dvarrui/asker.git |
|  5 | cd asker              |
|  6 | sudo rake gems        |
|  7 | rake check            |

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
* `git clone https://github.com/dvarrui/asker.git`

## Instalar DevKit

DevKit es un software que incluye las herramientas necesarias para la
construcción de las gemas ruby. Algunas gemas lo requieren (rainbow) y otras no.

> Enlace de interés: http://jekyll-windows.juthilo.com/1-ruby-and-devkit/

* Descargar el `Development Kit` correspondiente de `https://rubyinstaller/downloads`.
* Descomprimir el fichero en `C:\RubyDevKit`.
* `cd C:\RubyDevKit`
* `ruby dk.rb init`, busca donde se encuentra la instalación de Ruby.
* `ruby dk.rb install`, instala DevKit, enlazándola con nuestra instalación actual de Ruby.

## Instalar las librerías

* `cd asker`, para situarnos en el directorio del proyecto.
* `rake gems`, para instalar las librerías (gemas) que nos hacen falta.

## Comprobaciones finales

* `copy asker asker.rb`.
* `rake check`, para comprobar que está todo correctamente instalado.

¡Ya estamos listos para empezar a usar *asker*!

---

# Para descargar los ejemplos:
* Inicar sesión como tu usuario normal.
* Muévete a tu directorio de trabajo.
* `asker download`

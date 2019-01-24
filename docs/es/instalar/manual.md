
# Instalación en GNU/Linux

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

---

# Software requerido

Software requerido:
* git (versión >=2.1.4)
* ruby (version >= 2.1.3)
* rake (version >= 10.4.2)

Para comprobar las versiones
```
$ git --version
git version 2.1.4
$ ruby -v
ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux-gnu]
$ rake --version
rake, version 10.4.2
```

---

# Descarga del proyecto

Vamos a descargar el proyecto desde los repositorios de GitHub.
```
$ git clone https://github.com/dvarrui/asker.git
```

# Instalación de las librerías (gemas)

* `$ cd asker`, para situarnos en el directorio del proyecto.
* `$ sudo rake gems`, para instalar las librerías (gemas) que nos hacen falta.

# Comprobación final

* `$ rake`, para comprobar que está todo correctamente instalado.

¡Ya estamos listos para empezar a usar *asker*!

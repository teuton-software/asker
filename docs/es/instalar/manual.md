
# Instalación en GNU/Linux

En rasgos generales los pasos son los siguientes:

| ID | Paso                  | extra                |
| -- | --------------------- | -------------------- |
|  1 | Instalar git          | Versión >=2.1.4      |
|  2 | Instalar ruby         | Versión >=2.1.3      |
|  3 | Instalar rake         | Versión >=10.4.2     |
|  4 | Descargar repositorio | github/dvarrui/asker |
|  5 | cd asker              | |
|  6 | Instalar las gemas    | rake gems |
|  7 | Comprobación          | rake |

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

---

# Para descargar los ejemplos
* Inicar sesión como tu usuario normal.
* Muévete a tu directorio de trabajo.
* `asker download`

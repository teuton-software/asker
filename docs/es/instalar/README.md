
# Instalación

Los detalle del proceso de instalación son distintos dependiendo del sistema
operativo.

* [Instalación en Debian](debian.md)
* [Instalación en OpenSUSE](opensuse.md)
* [Instalación en GNU/Linux](linux.md)
* [Instalación en Windows](windows.md)

Pero en rasgos generales los pasos son los siguientes:

| ID | Paso                  | extra                |
| -- | --------------------- | -------------------- |
|  1 | Instalar git          | Versión >=2.1.4      |
|  2 | Instalar ruby         | Versión >=2.1.3      |
|  3 | Instalar rake         | Versión >=10.4.2     |
|  4 | Descargar repositorio | github/dvarrui/asker |
|  5 | cd asker              | |
|  6 | Instalar las gemas    | rake gems |
|  7 | Comprobación          | rake check |

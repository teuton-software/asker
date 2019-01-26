
# Instalación

Los detalle del proceso de instalación son distintos dependiendo del sistema
operativo:
* OpenSUSE
* Debian
* [Windows](./windows.md)
* [Manualmente](./manual.md)

---

# OpenSUSE: Proceso de Instalación

* Iniciar sesión como usuario `root`.
* `curl https://raw.githubusercontent.com/dvarrui/asker/master/bin/asker_opensuse_installer.sh | sh`, para descargar y ejecutar el instalador.

> **Recuerda**
>
> Para ejecutar una prueba de ASKER (Por ejemplo con el fichero input/es/demo/jedi.haml, hacemos lo siguiente:
> * `asker input/es/demo/jedi.haml`
>
> Los resultados guardan en el directorio local `output`.

---

# Debian: Proceso de Instalación

* Iniciar sesión como usuario `root`.
* `apt install curl`, instalar _curl_.
* `curl https://raw.githubusercontent.com/dvarrui/asker/master/bin/asker_debian_installer.sh | sh`, para descargar y ejecutar el instalador.

> **Recuerda**
>
> Para ejecutar una prueba de ASKER (Por ejemplo con el fichero input/es/demo/sith.haml, hacemos lo siguiente:
> * `asker input/es/demo/sith.haml`
>
> Los resultados guardan en el directorio local `output`.

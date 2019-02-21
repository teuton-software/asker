
# Instalación

El proceso de instalación es distinto, dependiendo del sistema
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
> Para ejecutar una prueba de ASKER (Por ejemplo con el fichero es/starwars/jedi.haml, hacemos lo siguiente:
> * `asker es/starwars/jedi.haml`
>
> Los resultados guardan en el directorio local `output`.

---

# Debian: Proceso de Instalación

* Iniciar sesión como usuario `root`.
* `apt install curl`, instalar _curl_.
* `curl https://raw.githubusercontent.com/dvarrui/asker/master/bin/asker_debian_installer.sh | sh`, para descargar y ejecutar el instalador.

> **Recuerda**
>
> Para ejecutar una prueba de ASKER (Por ejemplo con el fichero es/starwars/sith.haml, hacemos lo siguiente:
> * `asker es/starwars/sith.haml`
>
> Los resultados guardan en el directorio local `output`.


[<< back](README.md)

# Using installation scripts

## OpenSUSE script

* Open sesion as `root` user.
* `curl https://raw.githubusercontent.com/dvarrui/asker/master/bin/asker_opensuse_installer.sh | sh`, to download and execute installation script.

> Run `asker` to final check.

---

# Debian: Proceso de Instalación

* Iniciar sesión como usuario `root`.
* `apt install curl`, instalar _curl_.
* `curl https://raw.githubusercontent.com/dvarrui/asker/master/bin/asker_debian_installer.sh | sh`, para descargar y ejecutar el instalador.
* Para descargar los ejemplos:
    * Inicar sesión como tu usuario normal.
    * Muévete a tu directorio de trabajo.
    * `asker download`

> **Recuerda**
>
> Para ejecutar una prueba de ASKER (Por ejemplo con el fichero es/starwars/sith.haml, hacemos lo siguiente:
> * `asker es/starwars/sith.haml`
>
> Los resultados guardan en el directorio local `output`.

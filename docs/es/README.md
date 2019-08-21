
# ASKER

**asker** es un programa con licencia Free Software,
que ayuda al profesor a crear una gran cantidad de preguntas
de forma sencilla, a partir de un fichero con entidades conceptuales.

Los pasos son:
1. El profesor crea un fichero con las _entidades conceptuales_ que quiere trabajar.
2. Ejecutamos el programa *asker*. La aplicación lee el fichero de entrada y crea un ficheros de salida con las preguntas del tema o unidad didáctica.

Características:
* Acepta ficheros HAML/XML de entrada (por ahora).
* Exporta las preguntas en formato GIFT (por ahora).
* Multiplataforma.
* [Software Libre](../LICENSE).

---

# Modo de uso

Para ejecutar ASKER, usamos el comando `asker`, y como argumento indicamos la ruta a un fichero de entrada (HAML/XML). Por ejemplo, para ejecutar el ejemplo "jedi":

```
asker es/starwars/jedi.haml
```

* Por defecto, el programa genera los ficheros de salida en el directorio  `output`.
* En este ejemplo, se usa como entrada el fichero `es/starwars/jedi.haml`, que contiene las definiciones de entidades conceptuales sobre el tema de los _"Personajes Jedi"_.
* Hay más ejemplos de ficheros de entrada HAML/XML en el respositorio `github/dvarrui/asker-inputs`.

> Asker genera la salida en diferentes idiomas, de modo, que es buena idea mantenerlos separados por comodidad (Por ahora permite trabajar con Inglés y Español, pero actualmente estamos trabajando para incluir Francés y Alemán)

---

# Documentación

* [Ontología](./ontologia.md) de las entradas de ASKER.
* Mi primera [Demo](./demo/README.md)
* Aprender con [ejemplos](./ejemplos/README.md)
* [Directorios de proyecto](./directorios.md)
* [Inputs o mapas conceptuales](./input.md)

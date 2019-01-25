
# Ontología de las entradas de ASKER

Esto es, términos usados para definir las entradas en asker.

# Un fichero, un contexto

* Cada fichero de entrada an Asker es un contexto (**context**).
* Los contextos de definen por una lista de tags (etiquetas) y por los conceptos que contienen.
* Los contextos son necesarios puesto que distintos conceptos pueden usar la misma identificación. Por ejemplo "barco". Estos dos conceptos difieren en su definición y por el contexto que los contiene. Por tanto, es posible repetir tener identificadores de conceptos repetidos siempre que sean de contextos diferentes.

---

# Los conceptos (concept)

* Dentro del fichero de contexto tendremos los conceptos (**concept**). Cada concepto representa una entidad relevante para dicho contexto. Por ejemplo, en en contexto de `Comandos del sistema` podemos tener conceptos como `pwd`, `whoami`, `ls`, `cd`, etc.
* A su vez, cada concepto tiene unos campos obligatorios y otros opcionales. Veamos:
    * [Obligatorios] Campos de identificación del concepto como : `names` y `tags`.
    * [Opcionales] Campos que definen el concepto como: `def` y `tables`.

---

`EN CONSTRUCCIÓN!!!`

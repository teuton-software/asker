
# TO-DO

Actualmente tenemos los tipos
* Concept -> defs y tables
* Code -> files y features

La idea es crear un nuevo tipo
* Problem

El problem tendrá varias partes

problem
  inputs
    names PRODUCTO, PRECIO, MONEDA, DINERO
    cases
      case manzana, 1, euro, 10
      case pera, 1, dolar, 13
      case plátanos, 0.5, euros, 5
    descripcion Quiero comprar PRODUCTO en el supermercado. Resulta que mirando los precios veo que cada PRODUCTO cuesta PRECIO.
    question
      step
        text ¿Cuántas PRODUCTO puedo comprar si tengo DINERO MONEDA?
        formula DINERO / PRECIO
        varname F1
        feedback Puedo comprar F1 PRODUCTO
        
problem
  inputs
    names X, Y, PRODUCTO
    cases
      case 3, 4, manzanas
      case 6, 7, juegos de la PS4
      case 9, 8, libros de Anime
    descripcion Tengo X PRODUCTO en la mochila, y también tengo Y PRODUCTO en mi casa.
    question
      step
        text ¿Cuántos/as PRODUCTO tengo en total?
        formula X + Y
        varname F1
        feedback En total tengo F1 PRODUCTO


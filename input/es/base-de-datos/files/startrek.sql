// Ejemplo para crear el esquema de la práctica de Startrek.
// Se crean 2 tablas: Actores y Personajes relaciondas entre sí.

CREATE TABLE Actores(
  Codigo INTEGER PRIMARY KEY,
  Nombre VARCHAR(40),
  Fecha DATE,
  Nacionalidad VARCHAR(20),
  CodigoPersonaje INTEGER REFERENCES PERSONAJES(Codigo)
);

CREATE TABLE Personajes(
  CodigoPersonaje INTEGER,
  Nombre VARCHAR(30),
  Raza DATE,
  Grado VARCHAR(20),
  CodigoActor INTEGER REFERENCES Actores(Codigo),
  CodigoSuperior INTEGER REFERENCES Personajes(Codigo)
);

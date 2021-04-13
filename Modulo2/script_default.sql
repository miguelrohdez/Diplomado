-- Script que pone a prueba las instrucciones "DEFAULT"
-- Se deben insertar comentarios de las operaciones en el SCRIPT

-- Deberá documentar cada instrucción y modificará el código empleando mayúsculas para 
-- Palabras reservadas



-- Por ejemplo:
-- Si existe la tabla libros, se borra

DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;

\c biblioteca

DROP TABLE if exists libros;


--  Se crea la tabla libros 
 
 CREATE TABLE libros(
  codigo SERIAL,
  titulo VARCHAR(40),
  autor VARCHAR(30) NOT NULL DEFAULT 'Desconocido', 
  editorial VARCHAR(20),
  precio DECIMAL(5,2),
  cantidad SMALLINT DEFAULT 0,
 PRIMARY KEY(codigo)
 );

 
 
 INSERT INTO libros (titulo,editorial,precio)
  VALUES('Java en 10 minutos','Paidos',50.40);



 SELECT * FROM libros;


 INSERT INTO libros (titulo,editorial)
  VALUES('Aprenda PHP','Siglo XXI');

 SELECT * FROM libros;

--Selecciona el squema de los atributos de la tabla libros
 SELECT *
  FROM information_schema.columns 
  WHERE table_name = 'libros';

 INSERT INTO libros (titulo,autor,precio,cantidad)
  VALUES ('El gato con botas',DEFAULT,DEFAULT,100);
 SELECT * FROM libros;

 

 INSERT INTO libros DEFAULT VALUES;
 SELECT * FROM libros;
 
 
 INSERT INTO libros (titulo,autor,cantidad)
  VALUES ('Alicia en el pais de las maravillas','Lewis Carroll',NULL);

  
 SELECT * FROM libros;


 CREATE SCHEMA sesion4;
 CREATE TABLE sesion4.libros(
    codigo SERIAL,
    titulo VARCHAR(40),
    autor VARCHAR(30) NOT NULL DEFAULT 'Desconocido', 
    editorial VARCHAR(20),
    precio DECIMAL(5,2),
    cantidad SMALLINT DEFAULT 0,
    PRIMARY KEY(codigo)
  );

 INSERT INTO sesion4.libros (titulo,editorial,precio)
  VALUES('Java en 10 minutos','Paidos',50.40);



 SELECT * FROM sesion4.libros;


 INSERT INTO sesion4.libros (titulo,editorial)
  VALUES('Aprenda PHP','Siglo XXI');

 SELECT * FROM sesion4.libros;

--Selecciona el squema de los atributos de la tabla libros
 SELECT *
  FROM information_schema.columns 
  WHERE table_name = 'libros';

 INSERT INTO libros (titulo,autor,precio,cantidad)
  VALUES ('El gato con botas',DEFAULT,DEFAULT,100);
 SELECT * FROM sesion4.libros;

 

 INSERT INTO sesion4.libros DEFAULT VALUES;
 SELECT * FROM sesion4.libros;
 
 
 INSERT INTO sesion4.libros (titulo,autor,cantidad)
  VALUES ('Alicia en el pais de las maravillas','Lewis Carroll',NULL);

  
 SELECT * FROM sesion4.libros;
SELECT  table_catalog, table_schema, table_name, column_name, ordinal_position, column_default, data_type 
  FROM information_schema.columns 
  WHERE table_name = 'libros' AND table_schema='sesion4';

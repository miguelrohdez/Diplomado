CREATE DATABASE TRABAJADORES;
CREATE DATABASE COLECCIONES;
\c TRABAJADORES

CREATE TABLE empleado(
  emp_id_trabajador INT,
  emp_nombre VARCHAR(30),
  emp_apaterno VARCHAR(30),
  emp_amaterno VARCHAR(30),
  emp_genero VARCHAR(30),
  emp_id_area VARCHAR(30)
);

CREATE TABLE area(
  area_id_area INT,
  area_nombre VARCHAR(30)
);

\c COLECCIONES

CREATE TABLE cancion(
  can_id_cancion INT,
  can_nombre VARCHAR(30),
  can_id_autor INT
);

CREATE TABLE autor(
  aut_id_autor INT,
  aut_nombre VARCHAR(30),
  aut_apaterno VARCHAR(30),
  aut_amaterno VARCHAR(30)
);

\c TRABAJADORES
INSERT INTO empleado (emp_id_trabajador, emp_nombre, emp_apaterno, emp_amaterno, emp_genero, emp_id_area)
 	VALUES 
 	(1,'Miguel','Rojas','Trejo','Hombre',1),
 	(2,'Raul','Rodriguez','Cuellar','Hombre',1),
 	(3,'Manuel','Villa','Leon','Hombre',2),
 	(4,'Oscar','Castro','Conde','Hombre',4),
 	(5,'Elba','Medrano','Esquivel','Mujer',3);
INSERT INTO area (area_id_area, area_nombre) 
	VALUES 
	(1,'Sistemas'),
	(2,'Contaduria'),
	(3,'Ventas'),
	(4,'Administracion'),
	(5,'Mantenimiento');

\c COLECCIONES
INSERT INTO cancion (can_id_cancion, can_nombre, can_id_autor) 
	VALUES (1, 'The scientits','Coldplay')
INSERT INTO autor (aut_id_autor, aut_nombre, aut_apaterno, aut_amaterno )
	VALUES (1, 'Juan', 'Salinas', 'López')

---5 Consultas
--Punto 3
--5 consultas que se consideren utiles a partir de los datos que se almacenan en pg_class


--Punto 4
--5 consultas que se consideren utiles a partir de los datos que se obtienen con pg_language
SELECT * 
FROM pgpg_language
WHERE nombre = 'c';

SELECT COUNT(*) 	
FROM pg_language;


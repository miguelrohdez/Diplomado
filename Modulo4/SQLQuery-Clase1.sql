CREATE DATABASE pruebas;

CREATE TABLE clientes(
	idClientes INT PRIMARY KEY, 
    nombre VARCHAR(50),
	apellidoaterno VARCHAR(50),
	apellidoMaterno VARCHAR(50),
	correo VARCHAR(80)
  );

  SELECT * FROM clientes;

  INSERT INTO clientes	VALUES 
	(001, 'Haydee', 'Meza', 'Herrera', 'haydeek.meza@gmail.com'),
	(002, 'Miguel', 'Rojas', 'Hernandez', 'miguerohdez@gmail.com'),
	(003, 'Ingrid', 'Sanchez', 'Ruiz', 'ingrid45@gmail.com'),
	(004, 'Omar', 'Diaz', 'López', 'compean.trabajo@gmail.com'),
	(005, 'Rene', 'Compean', 'Salinas', 'renex10@gmail.com');

UPDATE clientes
	SET nombre = 'Miguel'
	WHERE idclientes BETWEEN 3 AND 5; 

DELETE FROM clientes
	WHERE idclientes IN (4,5); 

INSERT INTO clientes VALUES (4,'Alejandro2','Castro','Jimenez','alex.casto@gmail.com')

--Crear un SP sin parámetros 
--Crear SP_crear_libros
create or alter procedure SP_crear_libros
as
-- Elimina si existe la tabla de libros
  if object_id('libros')is not null
   drop table libros
--Crea la tabla de libros
  create table libros(
   idcodigolibro int identity,
   titulo varchar(40),
   autor varchar(30),
   editorial varchar(20),
   precio decimal(5,2),
   cantidad smallint,
   primary key(idcodigolibro)
  )
  insert into libros values('Uno','Richard Bach','Planeta',15,5)
  insert into libros values('Ilusiones','Richard Bach','Planeta',18,50)
  insert into libros values('El aleph','Borges','Emece',25,9)
  insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,100)
  insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12,50)
  insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35,300);
--Agregar punto y coma (;) en la última instrucción del SP

--Ejecutar el procedimiento:
 exec SP_crear_libros;

--Verificar si se creo la tabla "libros", generada por el SP
 select * from libros;

--Ejecutar el SP del sistema "sp_help" y el nombre del procedimiento almacenado para --verificar que existe el procedimiento creado recientemente:
 exec sp_help SP_crear_libros;
--Aparece el nombre, propietario, tipo y fecha/hora de creación.




--2. Generar un SP que muestre los libros de los cuales hay menos de 10.
--Eliminar si existe el SP: SP_libros_limite_stock
 if object_id('SP_libros_limite_stock') is not null
  drop procedure SP_libros_limite_stock;

--Crear el SP:

 create proc SP_libros_limite_stock
  as
   select * from libros
   where cantidad <=10;
--Ejecutar el SP del sistema "sp_help" junto al nombre del procedimiento creado recientemente para verificar que existe:

 exec sp_help SP_libros_limite_stock;
--Aparece el nombre, propietario, tipo y fecha/hora de creación.

--Lo ejecutamos:
 exec SP_libros_limite_stock;

--Modificamos algún registro y volvemos a ejecutar el procedimiento:
 update libros set cantidad=2 where idcodigolibro=4;
 exec SP_libros_limite_stock;


 --Creacion de procedimiento tabla clientes-Ejecicio clase
  create or alter procedure SP_alta_clientes
as
-- Elimina si existe la tabla de libros
  if object_id('clientes')is not null
   drop table clientes

--Crea la tabla de clientes
  create table clientes(
	idClientes INT IDENTITY, 
    nombre VARCHAR(50),
	apellidoaterno VARCHAR(50),
	apellidoMaterno VARCHAR(50),
	correo VARCHAR(80),
   primary key(idClientes)
  );

	INSERT INTO clientes VALUES ('Haydee', 'Meza', 'Herrera', 'haydeek.meza@gmail.com')
	INSERT INTO clientes VALUES ('Miguel', 'Rojas', 'Hernandez', 'miguerohdez@gmail.com')
	INSERT INTO clientes VALUES ('Ingrid', 'Sanchez', 'Ruiz', 'ingrid45@gmail.com')
	INSERT INTO clientes VALUES ('Omar', 'Diaz', 'López', 'compean.trabajo@gmail.com')
	INSERT INTO clientes VALUES ('Rene', 'Compean', 'Salinas', 'renex10@gmail.com')
	
;
--Agregar punto y coma (;) en la última instrucción del SP

--Ejecutar el procedimiento:
 exec SP_alta_clientes;

 SELECT * FROM clientes;

 --EJEMPLO SP2

 --Crear un SP con un parámetro de entrada
create procedure pa_libros_autor
  @autor varchar(30)  
 as
  select titulo, editorial,precio
   from libros
   where autor= @autor;
--El procedimiento se ejecuta colocando "execute" (o "exec") seguido del nombre del procedimiento y un valor para el parámetro:
 exec pa_libros_autor 'Borges';

--Crear un SP con 2 parámetros de entrada
 create procedure pa_libros_autor_editorial
  @autor varchar(30),
  @editorial varchar(20) 
 as
  select titulo, precio
   from libros
   where autor= @autor and
   editorial=@editorial;

--Ejecutar el SP (siguiendo el orden)
exec pa_libros_autor_editorial 'Richard Bach','Planeta';

--Ejecutar el SP (por nombre del parámetro, no importa el orden)
 exec pa_libros_autor_editorial @editorial='Planeta', @autor='Richard Bach';

--Crear un SP con 2 parámetros de entrada utilizando comodines como valores por defecto
create proc pa_libros_autor_editorial3
  @autor varchar(30) = '%',
  @editorial varchar(30) = '%'
 as 
  select titulo,autor,editorial,precio
   from libros
   where autor like @autor and
   editorial like @editorial;
--La sentencia siguiente ejecuta el procedimiento almacenado "pa_libros_autor_editorial3" enviando un valor por posición, se asume que es el primero.
 exec pa_libros_autor_editorial3 'P%';

--La sentencia siguiente ejecuta el procedimiento almacenado "pa_libros_autor_editorial3" enviando un valor para el segundo parámetro, para el primer parámetro toma el valor por defecto:
 exec pa_libros_autor_editorial3 @editorial='P%';

--Enviar parámetro por default:
 exec pa_libros_autor_editorial3 default, 'P%';


 --Ejecicio2 clase
CREATE PROC sp_libros_limite_stock_var
@cantidad SMALLINT
  AS
   SELECT * FROM libros
   WHERE cantidad <=@cantidad;

EXEC sp_libros_limite_stock_var 5;
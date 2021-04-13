INSERT INTO clientes (idclientes, nombre, apellidopaterno,correo)
	VALUES ('001', 'Haydee', 'Meza', 'Herrera', 'haydeek.meza@gmail.com'),
	VALUES ('002', 'Miguel', 'Rojas', 'Hernandez', 'miguerohdez@gmail.com'),
	VALUES ('003', 'Ingrid', 'Sanchez', 'Ruiz', 'ingrid45@gmail.com'),
	VALUES ('004', 'Omar', 'Diaz', 'López', 'compean.trabajo@gmail.com'),
	VALUES ('005', 'Rene', 'Compean', 'Salinas', 'renex10@gmail.com');

UPDATE clientes
	SET nombre = 'Miguel'
	WHERE idclientes BETWEEN 3 AND 5; 

DELETE FROM clientes
	WHERE idclientes IN (4,5); 


CREATE PROC sp_libros_limite_stock_var
@cantidad SMALLINT
  AS
   SELECT * FROM libros
   WHERE cantidad <=@cantidad;
--EJECUTAR EL SP DEL SISTEMA "SP_HELP" JUNTO AL NOMBRE DEL PROCEDIMIENTO CREADO RECIENTEMENTE PARA VERIFICAR QUE EXISTE:

 EXEC sp_help sp_libros_limite_stock_var;
--APARECE EL NOMBRE, PROPIETARIO, TIPO Y FECHA/HORA DE CREACIÓN.

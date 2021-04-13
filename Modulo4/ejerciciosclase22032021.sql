Create or alter trigger tr_mensajeEmpleados
on Empleados
for insert, update
as
BEGIN
    IF EXISTS(SELECT * FROM inserted) AND EXISTS (SELECT *FROM deleted)
 	BEGIN
		PRINT 'Empleado actualizado correctamente'
	END
    ELSE IF EXISTS(SELECT * FROM inserted)
	BEGIN
	  PRINT 'Empleado registrado'
    END;
END;

Insert into empleados values ('101', 'Luke', '01/09/1977',  'SKWL770900', '5588556655')
Update empleados set telefono = '555555555' where documento = 100

/*CREATE TABLE ClientesRespaldo (
  idClientes INTEGER , 
  nombre VARCHAR(50),
  apellidopaterno VARCHAR(50),
  apellidomaterno VARCHAR(50),
  correo VARCHAR(80)
  --fechaAccion date
);
*/

CREATE TABLE ClientesRespaldo (
  ID INTEGER , 
  Accion VARCHAR(10),
  fecha date
);

--drop table ClientesRespaldo

select * from ClientesRespaldo

CREATE OR ALTER TRIGGER tr_Clientes ON clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @pid INT;
    IF EXISTS(SELECT * FROM inserted) AND EXISTS (SELECT *FROM deleted)
 	BEGIN
		SELECT @pid = idClientes FROM inserted
		INSERT INTO ClientesRespaldo VALUES (@pid,'Updated', getdate())
	END
    ELSE IF EXISTS(SELECT * FROM INSERTED)
	BEGIN
	    SELECT @pid = idClientes FROM inserted
	    INSERT INTO ClientesRespaldo VALUES (@pid,'Insert', getdate())
    END;
 	IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT *FROM inserted)
 	BEGIN
	    SELECT @pid = idClientes FROM deleted
	    INSERT INTO ClientesRespaldo VALUES (@pid,'Delete', getdate())
    END;
END;

INSERT INTo clientes VALUES('Juan','Lopez','Salinas','correo@hotmail.com')
UPDATE clientes set nombre = 'Rau2l' where idClientes= 11
DELETE from clientes where idClientes = 11

select * from clientes
select * from ClientesRespaldo

DROP TABLE LibrosRespaldo;
CREATE TABLE LibrosRespaldo (
  idcodigolibro INTEGER , 
  titulo VARCHAR(40),
  autor VARCHAR(30),
  editorial VARCHAR(20),
  precio DECIMAL(5,2),
  cantidad SMALLINT,
  --fechaIns	DATE
);

/*Ejercicio Trigger 2. 
Implementar un trigger que cree una replica
de los registros insertados de la tabla Libros
Para ello, se debe de generar una nueva tabla
llamada LibrosRespaldo que considere los mismos campos
Tomar en cuenta lo siguiente:
Insert LibrosRespaldo select * from insert
*/
CREATE TRIGGER tr_Libros_Insert ON libros
FOR INSERT AS
BEGIN
	DECLARE @pid INT;
	SELECT @pid = idcodigolibro FROM inserted
	INSERT INTO LibrosRespaldo SELECT * FROM inserted WHERE idcodigolibro = @pid 
END;

INSERT INTO libros VALUES ('hola','rojas','alfa', 10.5, 5)
INSERT INTO libros VALUES ('Libro C','Richard','omega', 250, 2)

select * from libros
select * from LibrosRespaldo


---------------------------------------------------
---Clase parte 2-----------------------------------
---------------------------------------------------

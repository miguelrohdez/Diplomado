/*	Ejercicio 4
============================================
Autor:   Rojas Hernandez, Miguel Alejandro
Fecha de Creación: 25/03/2021
Descripción: Procedimiento almacenado agregando
	una transaccion 
============================================
*/
--Para poder agrega otra intruccion a la transaccion
CREATE TABLE t_bitacoraemp(
   idBit INT IDENTITY,
   idEmp VARCHAR(40),
   accion VARCHAR(30),
   fechaAccion DATETIME,
   PRIMARY KEY(idBit)
  )

CREATE OR ALTER PROCEDURE SP_AltaEmpleado
	@nombre VARCHAR(50),
	@apPaterno VARCHAR(50),
	@apMaterno VARCHAR(50),
	@area VARCHAR(50),
	@email VARCHAR(50),
	@fechaNacimiento VARCHAR(10)
AS
	--Variables locales
	DECLARE @idEmp NUMERIC(6);

		SELECT @idEmp = MAX(NumEmpleado)
		FROM empleados;
		
		BEGIN
		IF @idEmp IS NULL
		
			SELECT @idEmp = 1;
		ELSE
			SELECT @idEmp = MAX(NumEmpleado)+1
			FROM empleados;
		END;

	BEGIN TRANSACTION
		INSERT INTO empleados VALUES(@idEmp, @nombre, @apPaterno, @apMaterno, @area, @email, @AUX1, NULL);
		INSERT INTO t_bitacoraEmp VALUES(@idEmp, 'Alta', SYSDATETIME())

		--TRANS
		IF @@error <> 0
		BEGIN
			PRINT 'Hubo un error al realizar la transaccion'
			ROLLBACK
		END
	COMMIT
;


EXEC SP_AltaEmpleado 'Miguel', 'Rojas', 'Hernandez','sistemas', 'miguel@gmail.com','17/06/1994'


SELECT * FROM t_bitacoraemp

SELECT * FROM empleados
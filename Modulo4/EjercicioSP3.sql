EJECICIO 1

/*Una empresa almacena los datos de sus empleados en una tabla llamada "empleados".
1- Eliminamos la tabla, si existe y la creamos:*/
 IF OBJECT_ID('empleados') IS NOT NULL
  DROP TABLE EMPLEADOS;
 
 CREATE TABLE EMPLEADOS(
	  documento CHAR(8),
	  nombre VARCHAR(20),
	  apellido VARCHAR(20),
	  sueldo DECIMAL(6,2),
	  cantidadhijos TINYINT,
	  seccion VARCHAR(20),
	  PRIMARY KEY(documento)
 );

--2- Ingrese algunos registros:
 INSERT INTO empleados VALUES('22222222','Juan','Perez',300,2,'Contaduria');
 INSERT INTO empleados VALUES('22333333','Luis','Lopez',350,0,'Contaduria');
 INSERT INTO empleados VALUES ('22444444','Marta','Perez',500,1,'Sistemas');
 INSERT INTO empleados VALUES('22555555','Susana','Garcia',NULL,2,'Secretaria');
 INSERT INTO empleados VALUES('22666666','Jose Maria','Morales',460,3,'Secretaria');
 INSERT INTO empleados VALUES('22777777','Andres','Perez',580,3,'Sistemas');
 INSERT INTO empleados VALUES('22888888','Laura','Garcia',400,3,'Secretaria');

--3- Elimine el procedimiento llamado "pa_seccion" si existe:
 IF OBJECT_ID('pa_seccion') IS NOT NULL
  DROP PROCEDURE pa_seccion;

/*4- Cree un procedimiento almacenado llamado "pa_seccion" al cual le enviamos el nombre de una sección 
y que nos retorne el promedio de sueldos de todos los empleados de esa sección 
y el valor mayor de sueldo (de esa sección)*/
CREATE OR ALTER PROCEDURE pa_seccion
	@SECCION VARCHAR(20) = '%',
	@SALIDA VARCHAR(80) output
AS
	DECLARE @PROM_SUELDO VARCHAR(10)
	DECLARE @MAX_SUELDO VARCHAR(10)

	SELECT @PROM_SUELDO = AVG(sueldo)
	FROM empleados
	WHERE seccion LIKE @SECCION;

	SELECT @MAX_SUELDO = MAX(sueldo)
	FROM empleados
	WHERE seccion LIKE @SECCION;

	SELECT @SALIDA = CONCAT('El promedio es: ',@PROM_SUELDO, ', El sueldo maximo es ', @MAX_SUELDO ) 
;

--5- Ejecute el procedimiento creado anteriormente con distintos valores.
DECLARE @VARIABLE VARCHAR(80)
EXEC pa_seccion 'Contaduria', @VARIABLE output
SELECT @VARIABLE;

EXEC pa_seccion 'Si%', @VARIABLE output
SELECT @VARIABLE;

EXEC pa_seccion 'Se%', @VARIABLE output
SELECT @VARIABLE;

/*6- Ejecute el procedimiento "pa_seccion" sin pasar valor para el parámetro "sección". Luego muestre 
los valores devueltos por el procedimiento.
Calcula sobre todos los registros porque toma el valor por defecto.*/
DECLARE @VARIABLE VARCHAR(80)
EXEC pa_seccion , @VARIABLE output
SELECT @VARIABLE;

/*DECLARE @VARIABLE VARCHAR(80);
EXEC pa_seccion 'Contaduria', @VARIABLE output;
SELECT @VARIABLE AS "**************************RESULTADO*******************************";
*/

----------------------------------------------------------------------Ejecicio complemento
CREATE TABLE Empleados
(
	NumEmpleado NUMERIC(6),
	Nombre VARCHAR(50),
	ApPaterno VARCHAR(50), 
	ApMaterno VARCHAR(50),
	Area VARCHAR(50),
	Email VARCHAR(50),
	FechaNacimiento DATE,
	RFC  VARCHAR(10)
	PRIMARY KEY(NumEmpleado)
);



--Crear procedimiento ejercicio
CREATE PROCEDURE SP_AltaEmpleado
	@nombre VARCHAR(50),
	@apPaterno VARCHAR(50),
	@apMaterno VARCHAR(50),
	@area VARCHAR(50),
	@email VARCHAR(50),
	@fechaNacimiento DATE
AS
	--Variables locales
	DECLARE @idEmp NUMERIC(6)

	SELECT @idEmp = MAX(NumEmpleado)
	FROM empleados;

	IF @idEmp IS NULL
	BEGIN
		@idEmp = 1
	ELSE
		SELECT @idEmp = MAX(NumEmpleado)+1
		FROM empleados;
	END;

	INSERT INTO empleados VALUES(@idEmp, @nombre, @apPaterno, @apMaterno, @area, @email, @fechaNacimiento, NULL)

	
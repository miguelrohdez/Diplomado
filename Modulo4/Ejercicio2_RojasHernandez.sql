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
	DECLARE @AUX1 DATE;
	SELECT @AUX1=CONVERT(date,@fechaNacimiento, 105);
	
	SELECT @idEmp = MAX(NumEmpleado)
	FROM empleados;
	BEGIN
	IF @idEmp IS NULL
	
		SELECT @idEmp = 1;
	ELSE
		SELECT @idEmp = MAX(NumEmpleado)+1
		FROM empleados;
	END;

	INSERT INTO empleados VALUES(@idEmp, @nombre, @apPaterno, @apMaterno, @area, @email, @AUX1, NULL);
;


EXEC SP_AltaEmpleado 'PAMELA', 'ARIZAGA', 'GONZALEZ', 'Administración', 'pamm.gla@gmail.com', '01/08/1997';
EXEC SP_AltaEmpleado 'GIOVANNI', 'ALMAZAN', 'GARCIA', 'Sistemas', 'gio.almazan.garcia@gmail.com', '02/08/1997';
EXEC SP_AltaEmpleado 'ROSA ELENA', 'ANAYA', 'BADILLO', 'Mecatrónica', 'rosa.elena1996@hotmail.com', '03/08/1997';
EXEC SP_AltaEmpleado 'RAMSES', 'BENAVIDEZ', 'DURAN', 'Computación', '123ization@gmail.com', '04/08/1997';
EXEC SP_AltaEmpleado 'CASSANDRA', 'CEBALLOS', 'TEJADA', 'Administración de Empresas', 'tejada.cassandra12@gmail.com', '05/08/1997';
EXEC SP_AltaEmpleado 'RAUL ADRIAN', 'DOMINGUEZ', 'BADILLO', 'Computación', 'adriansilverslatter@gmail.com', '06/08/1997';
EXEC SP_AltaEmpleado 'LUIS DIEGO', 'DIAZ', 'CORTES', 'Informática', 'dieli.2131@gmail.com', '07/08/1997';
EXEC SP_AltaEmpleado 'ERICK VIRGILIO', 'DIAZ', 'FRANCO', 'Computación', 'diazf.erick@gmail.com', '08/08/1997';
EXEC SP_AltaEmpleado 'JOSE CARLOS', 'GUERRERO', 'SANCHEZ', 'Electrónica', 'jc.guesa@gmail.com', '09/08/1997';
EXEC SP_AltaEmpleado 'IRAIS', 'HERNANDEZ', 'PEREZ', 'Sistemas', '', '10/08/1997';
EXEC SP_AltaEmpleado 'JOSUE DANIEL', 'HERNANDEZ', 'SANTIAGO', 'Computación', 'danielhs.gunner@gmail.com', '11/08/1997';
EXEC SP_AltaEmpleado 'ELSA XIMENA', 'HERRERA', 'GARCIA', 'Informática', 'elxihg@gmail.com', '12/08/1997';
EXEC SP_AltaEmpleado 'SANDRA CECILIA', 'ISLAS', 'ORTEGA', 'Computación', 'sandracislas@gmail.com', '13/08/1997';
EXEC SP_AltaEmpleado 'ALEXIS GABRIEL', 'JIMENEZ', 'VILLEGAS', 'Geomatica', 'alexis.villegas.j@gmail.com', '15/03/1995';
EXEC SP_AltaEmpleado 'FRANCISCO EDER', 'MENDOZA', 'SANTOS', 'Computación', 'elite_eder30@hotmail.com', '16/03/1995';
EXEC SP_AltaEmpleado 'JOSE LEONARDO', 'OCHOA', 'NAVA', 'Computación', 'leo8aeva01@hotmail.com', '17/03/1995';
EXEC SP_AltaEmpleado 'OMAR', 'OROZCO', 'CALDERON', 'Computación', 'omar.oro.oc@gmail.com', '18/03/1995';
EXEC SP_AltaEmpleado 'MARIANO', 'ORTEGA', 'PLASCENCIA', 'Informática', 'marianosftp@gmail.com', '19/03/1995';
EXEC SP_AltaEmpleado 'ATONATIUH IVAN', 'QUIÑONES', 'VARGAS', 'Informática', 'ivanov@live.com.mx', '20/03/1995';
EXEC SP_AltaEmpleado 'JORGE NATHANIEL', 'RADILLA', 'MALDONADO', 'Mecatrónica', 'nathaniel.radilla@gmail.com', '10/10/1996';
EXEC SP_AltaEmpleado 'JULIO RAUL', 'RODRIGUEZ', 'RUIZ', 'Computación', 'super_rulaz@hotmail.com', '11/10/1996';
EXEC SP_AltaEmpleado 'MARIO ALBERTO', 'RODRIGUEZ', 'MARIN', 'Computación', 'marioa_bros@hotmail.com', '12/10/1996';
EXEC SP_AltaEmpleado 'LUIS FERNANDO', 'ROJAS', 'FLORES', 'Computación', 'lfernandorojasf@gmail.com', '25/12/1985';
EXEC SP_AltaEmpleado 'CLEMENTE DAVID', 'VALENCIA', 'ROMERO', 'Informática', 'dvidvlencia@gmail.com', '20/05/1985';
EXEC SP_AltaEmpleado 'JORGE', 'VARGAS', 'VALENCIA', 'Mecánica', '96vjrg@gmail.com', '01/01/2000';


/*4. Creación de SP para obtener los empleados que nacieron en un año en específico. Pueden resolver la opción 4.1 o 4.2
Opción 4.1
Generar Stored Procedure con el nombre SP_AñoNacimiento con los parámetros de entrada: 
Año, donde se enviará solamente el año de nacimiento del empleado (ejemplo: 1998) y 
traerá todos los registros que cumplan con ese criterio. Los campos que se mostrarán son: 
NumEmpleado, Nombre, ApPaterno, ApMaterno, Area y FechaNacimiento. 
Si no existen empleados para ese criterio mostrará el siguiente mensaje: "No existen empleados para el año 1998"*/
CREATE OR ALTER PROCEDURE SP_AnioNacimiento
	@ANIO INT 
AS
	DECLARE @CONTADOR INT
	
	SELECT @CONTADOR = COUNT(*)
	FROM Empleados
	WHERE YEAR(FechaNacimiento)=@ANIO

	BEGIN
	IF @CONTADOR < 1
		--SELECT CONCAT('No se encontraron registros para el año ', @ANIO)
		PRINT  CONCAT('No se encontraron registros para el año ',@ANIO)
	ELSE
		SELECT NumEmpleado, Nombre, ApPaterno, ApMaterno, Area, FechaNacimiento
		FROM Empleados
		WHERE YEAR(FechaNacimiento)=@ANIO
	END;
;

EXEC SP_AnioNacimiento 1997

/*Opción 4.2
Generar Stored Procedure SP_RangoAñoNacimiento con dos parámetros de entrada (FechaInicial y FechaFinal), ejemplo:
 01/01/1998 y 31/12/1998) y traerá todos los registros que cumplan con ese criterio. Los campos que se mostrarán son:
  NumEmpleado, Nombre, ApPaterno, ApMaterno, Area y FechaNacimiento. Si no existen empleados para ese criterio mostrará 
  el siguiente mensaje:  "No existen empleados para el año 1998"*/
CREATE OR ALTER PROCEDURE SP_RangoAnioNacimiento
	@FECHA_IN VARCHAR(10),
	@FECHA_FIN VARCHAR(10)
AS
	DECLARE @CONTADOR INT;
	DECLARE @AUX1 DATE;
	DECLARE @AUX2 DATE;

	SELECT @AUX1=CONVERT(date,@FECHA_IN, 105);
	SELECT @AUX2=CONVERT(date,@FECHA_FIN, 105);

	SELECT @CONTADOR = COUNT(*)
	FROM Empleados
	WHERE FechaNacimiento BETWEEN @AUX1 AND @AUX2

	BEGIN
	IF @CONTADOR < 1
		--SELECT CONCAT('No se encontraron registros entre ',@FECHA_IN,' al ',@FECHA_FIN)
		PRINT  CONCAT('No se encontraron registros entre ',@FECHA_IN,' al ',@FECHA_FIN)
	ELSE
		SELECT NumEmpleado, Nombre, ApPaterno, ApMaterno, Area, FechaNacimiento
		FROM Empleados
		WHERE FechaNacimiento BETWEEN @AUX1 AND @AUX2
	END;
;
--DATE FORMART DD/MM/YYYY
EXEC SP_RangoAnioNacimiento '01/01/1997', '31/12/1997'

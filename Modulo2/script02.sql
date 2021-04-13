-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Ejercicio de Scripts 02				Febrero, 2021.
--		Rojas Hernandez Miguel Alejandro
-- ***************************************************************



CREATE TABLE empleados( 
	empleadoid INT NOT NULL, 
	nombre CHAR(30) NULL, 
	apellido CHAR(30) NULL, 
	fecha_nac DATE NULL, 
	reporta_a INT NULL, 
	extension INT NULL 
);


CREATE TABLE proveedores( 
	proveedorid INT NOT NULL, 
	nombreprov CHAR(50) NOT NULL, 
	contacto CHAR(50) NOT NULL, 
	celuprov CHAR(12) NULL, 
	fijoprov CHAR(12) NULL 
);


CREATE TABLE clientes( 
	clienteid INT NOT NULL, 
	rfc CHAR(10) NOT NULL, 
	nombre CHAR(30) NOT NULL, 
	contacto CHAR(50) NOT NULL, 
	direccion CHAR(50) NOT NULL, 
	fax CHAR(12) NULL, 
	email CHAR(50) NULL, 
	celular CHAR(12) NULL, 
	fijo CHAR(12) NULL 
);

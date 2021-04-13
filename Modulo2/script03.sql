-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Ejercicio de Scripts 03				Febrero, 2021.
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

CREATE TABLE invoice(
	id SERIAL PRIMARY KEY,
	product_id INT NOT NULL,
	qty NUMERIC NOT NULL CHECK(qty > 0),
	net_price NUMERIC CHECK(net_price > 0)
);

CREATE TABLE production_orders(
	id SERIAL PRIMARY KEY,
	desciption VARCHAR(40) NOT NULL,
	material_id VARCHAR(16) NOT NULL,
	qty NUMERIC NOT NULL,
	start_date DATE NOT NULL,
	finish_date DATE NOT NULL
);

DROP TABLE IF EXISTS empleados;

CREATE TABLE empleados( 
	id SERIAL PRIMARY KEY, 
	first_name VARCHAR(50) NULL, 
	last_name VARCHAR(50) NULL, 
	birth_date DATE CHECK (birth_date > '1900-01-01'), 
	joined_date DATE CHECK (joined_date > birth_date),
	salary NUMERIC CHECK (salary > 0)
);

INSERT INTO empleados (first_name, last_name, birth_date ,joined_date, salary)
VALUES ('John', 'Doe', '1972-01-01', '2015-07-01', -100000));


CREATE TABLE persona( 
	id SERIAL PRIMARY KEY, 
	first_name VARCHAR(50) NULL, 
	last_name VARCHAR(50) NULL,
	email VARCHAR(50) UNIQUE
); 
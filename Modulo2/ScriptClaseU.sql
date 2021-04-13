-- ********** Facultad de Contaduría y Administración *************
--                   Diplomado de BASES DE DATOS
--    Ejercicio de Scripts				Mayo, 2020.
-- 	  restricciones
--    Realizado por: Esther Martinez
-- *****************************************************/

-- /*CREACIÓN DE LA BASE DE DATOS 'PEDIDOS' */

DROP DATABASE IF EXISTS pedidos;
CREATE DATABASE pedidos;

\c pedidos

--
--  NOT NULL
--


CREATE TABLE invoice(
  id serial PRIMARY KEY,
  product_id int NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'invoice';
\d+ invoice

CREATE TABLE production_orders (
 ID serial PRIMARY KEY,
 description VARCHAR (40) NOT NULL,
 material_id VARCHAR (16),
 qty NUMERIC,
 start_date DATE,
 finish_date DATE
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'production_orders';

\d+ production_orders


INSERT INTO production_orders (description)
VALUES
 ('make for infosys inc.');

-- Luego, desea asegurarse de que el campo qty no sea nulo, así que agregue la restricción de no nulo 
-- a la columna qty. Sin embargo, la tabla ya tiene datos en ella. Si intenta agregar la restricción no nula, 
-- PostgreSQL emitirá un mensaje de error.

ALTER TABLE production_orders ALTER COLUMN qty
SET NOT NULL;

-- Los valores en la columna qty se actualizaron a uno.


  UPDATE production_orders
SET qty = 1;


ALTER TABLE production_orders ALTER COLUMN qty
SET NOT NULL;

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'production_orders';
\d+ production_orders

-- Actualizar las restricciones a no nulas para las columnas material_id, start_date y finish_date:

UPDATE production_orders
SET material_id = 'ABC',
    start_date = '2015-09-01',
    finish_date = '2015-09-01';



-- CHECK
	

CREATE TABLE empleados (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 birth_date DATE CHECK (birth_date > '1900-01-01'),
 joined_date DATE CHECK (joined_date > birth_date),
 salary numeric CHECK(salary > 0)
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'empleados';
\d+ empleados
  
  
-- Intentemos insertar una nueva fila en la tabla de empleados:

INSERT INTO empleados (
 first_name,
 last_name,
 birth_date,
 joined_date,
 salary
)
VALUES
 (
 'John',
 'Doe',
 '1972-01-01',
 '2015-07-01',
 - 100000
 );

 
-- Creamos una tabla  la base de datos llamada prices_list:

CREATE TABLE prices_list (
 id serial PRIMARY KEY,
 product_id INT NOT NULL,
 price NUMERIC NOT NULL,
 discount NUMERIC NOT NULL,
 valid_from DATE NOT NULL,
 valid_to DATE NOT NULL
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'prices_list';
\d+ prices_list

  
-- Añadimos restricciones 

ALTER TABLE prices_list 
	ADD CONSTRAINT price_discount_check CHECK (
											 price > 0
											 AND discount >= 0
											 AND price > discount
);


ALTER TABLE prices_list 
ADD CONSTRAINT valid_range_check CHECK (valid_to >= valid_from);


-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'prices_list';
\d+ prices_list
 
-- UNIQUE

-- PRIMERA ALTERNATIVA

CREATE TABLE persona (
		id serial PRIMARY KEY,
		first_name VARCHAR(50),
		last_name VARCHAR(50),
		email VARCHAR(50) UNIQUE
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'persona';
\d+ persona

-- DROP TABLE persona;

-- SEGUNDA ALTERNATIVA

-- CREATE TABLE persona (
	-- id SERIAL 	PRIMARY KEY,
	-- first_name 	VARCHAR(50),
	-- last_name	VARCHAR(50),
	-- email		VARCHAR(50),
--         UNIQUE(email)
-- );

INSERT INTO persona(first_name,last_name,email)
VALUES
 (
 'john',
 'doe',
 'j.doe@postgresqltutorial.com'
 );
 
-- Añadimos un segundo registro : Genera un error
 
 
 INSERT INTO persona(first_name,last_name,email)
VALUES
 (
 'jack',
 'doe',
 'j.doe@postgresqltutorial.com'
 );
 
--PRIMARY KEY
 
 
-- Creamos una tabla de encabezado de orden de compra (PO) con el nombre po_headers.

CREATE TABLE po_headers (
 po_no INTEGER  PRIMARY KEY,
 vendor_no INTEGER,
 description TEXT,
 shipping_address TEXT
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'po_headers';

 \d+ po_headers
  

-- Creamos una tabla de artículos de línea de orden de compra cuya clave principal es una combinación 
-- de número de orden de compra (po_no) y número de artículo de línea (item_no).

CREATE TABLE po_items (
 po_no INTEGER,
 item_no INTEGER,
 product_no INTEGER,
 qty INTEGER,
 net_price NUMERIC,
 PRIMARY KEY (po_no, item_no)
);

-- SELECT *
  -- FROM information_schema.columns 
  -- WHERE table_name = 'po_items';

\d+ po_items

\c postgres
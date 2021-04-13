*********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Ejercicios clase				Febrero, 2021.
--		Rojas Hernandez Miguel Alejandro
-- ***************************************************************


-- En tabla clientes
INSERT INTO usuarios (nombre,clave) VALUES ('EstherMartinez','FCA');
INSERT INTO usuarios (nombre,clave) VALUES ('SusanaPerez','FI');
INSERT INTO usuarios (nombre,clave) VALUES ('CarlosFuentes','FC');
INSERT INTO usuarios (nombre,clave) VALUES ('FedericoLopez','FC');

DELETE FROM usuarios WHERE nobmre = "EstherMartinez";
DELETE FROM usuarios WHERE clave = "FC";
DELETE FROM usuarios 

UPDATE usuarios SET clave = 'ClaveNueva'

INSERT INTO production_orders (description)
VALUES ('make for infosys inc.');

UPDATE production_orders SET qty = 0;
UPDATE production_orders SET material_id = '1';
UPDATE production_orders SET start_date = '21/02/1999';
UPDATE production_orders SET finish_date = '03/02/2021';

ALTER TABLE production_orders ALTER COLUMN qty SET NOT NULL;
ALTER TABLE production_orders ALTER COLUMN material_id SET NOT NULL;
ALTER TABLE production_orders ALTER COLUMN start_date SET NOT NULL;
ALTER TABLE production_orders ALTER COLUMN finish_date SET NOT NULL;

---------------------CLASE ULTIMA
CREATE TABLE libros(

);


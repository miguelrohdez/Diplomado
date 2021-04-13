-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Ejercicio de Scripts 01				Febrero, 2021.
--		Rojas Hernandez Miguel Alejandro
-- ***************************************************************

DROP DATABASE IF EXISTS pedidos;
CREATE DATABASE pedidos;

\c pedidos

CREATE TABLE usuarios(
	clave VARCHAR(10),
	nombre VARCHAR(30)
);



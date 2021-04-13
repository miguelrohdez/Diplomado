-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Scripts de Sistema de Congresos				Febrero, 2021.
--		Rojas Hernandez Miguel Alejandro
-- ***************************************************************


DROP DATABASE IF EXISTS congresos;
CREATE DATABASE congresos;

\c congresos

--Se crea esquema para las tablas de ponentes y ponente
CREATE SCHEMA ponentes;

--Crea la tabla para las instituciones/universidades
CREATE TABLE ponentes.institucion(
	institucion_id VARCHAR(5),
	institucion_nombre VARCHAR(50) NOT NULL,
	institucion_pais VARCHAR(25) NOT NULL DEFAULT 'México',
	institucion_ciudad VARCHAR(20) NOT NULL,
	institucion_carrera VARCHAR(30),
	CONSTRAINT institucion_PK PRIMARY KEY(institucion_id)
);


--Crea un indice unico para la busqueda de Instituciones/Univeridades ya que se considera que no se puede repetir el nombre de la institucion
CREATE INDEX I_institucion_nombre ON ponentes.institucion(institucion_nombre);

--Se crea la tabla para ponentes
CREATE TABLE ponentes.ponente(
	ponente_id VARCHAR(5),
	ponente_nombre VARCHAR(30) NOT NULL,
	ponente_ap_paterno VARCHAR(20) NOT NULL,
	ponente_ap_materno VARCHAR(20) NULL,
	ponente_pais VARCHAR(15) NOT NULL DEFAULT 'México',
	ponente_ciudad VARCHAR(30),
	ponente_email VARCHAR(50) NOT NULL,
	ponente_tel_movil NUMERIC(10) NOT NULL,
	ponente_tel_oficina NUMERIC(10)NULL,
	institucion_id VARCHAR(5), 
	CONSTRAINT ponente_PK PRIMARY KEY(ponente_id),
	CONSTRAINT institucion_FK FOREIGN KEY(institucion_id) REFERENCES ponentes.institucion(institucion_id)
	ON DELETE RESTRICT
);

--SECUENCIA para llevar las ponencias
CREATE SEQUENCE sec_ponencias
	START WITH 00001
	INCREMENT BY 1
	MINVALUE 1
	NO CYCLE;

--Se crea la tabla para ponencias y se asocian los valores
CREATE TABLE ponentes.ponencia(
	ponencia_id VARCHAR(5),
	ponente_id VARCHAR(5),
	ponencia_nombre VARCHAR(30) NOT NULL,
	ponencia_fecha DATE NOT NULL,
	ponencia_duracion NUMERIC(5) NOT NULL DEFAULT 60, --Tiempo en minutos
	ponencia_numero INT DEFAULT NEXTVAL('sec_ponencias'),
	CONSTRAINT ponencia_PK PRIMARY KEY(ponencia_id,ponente_id),
	CONSTRAINT ponente_FK 
		FOREIGN KEY(ponente_id) REFERENCES ponentes.ponente(ponente_id)
);


--Crea un indice para buscar la ponencia por nombre mas rapido
CREATE INDEX I_ponenicia_nombre ON ponentes.ponencia(ponencia_nombre);

--Se crea esquema para las tablas de congreso, auditorio, empresa y auditorio
CREATE SCHEMA congreso;

--Se crea la tabla para el congreso
CREATE TABLE congreso.congreso(
	congreso_id VARCHAR(5),
	congreso_nombre VARCHAR(30) NOT NULL,
	congreso_fecha_inicio DATE NOT NULL,
	congreso_fecha_termino DATE NOT NULL,
	CONSTRAINT congreso_PK PRIMARY KEY (congreso_id)
);


--Crea un indice para buscar el congreso por nombre mas rapido
CREATE INDEX I_congreso_nombre ON congreso.congreso(congreso_nombre);

--Se crea la tabla para las empresas
CREATE TABLE congreso.empresa(
	empresa_id VARCHAR(5),
	empresa_nombre VARCHAR(50) NOT NULL,
	empresa_pais VARCHAR(15) NOT NULL,
	empresa_ciudad VARCHAR(30) NULL,
	CONSTRAINT empresa_PK PRIMARY KEY (empresa_id)
);


--Crea un indice para buscar la empresa por nombre mas rapido
CREATE INDEX I_empresa_nombre ON congreso.empresa(empresa_nombre);

--Se crea la tabla para los auditorios
CREATE TABLE congreso.auditorio(
	auditorio_id VARCHAR(5),
	auditorio_nombre VARCHAR(30) NOT NULL,
	auditorio_ciudad VARCHAR(30) NOT NULL,
	auditorio_calle VARCHAR(30) NOT NULL,
	CONSTRAINT auditorio_PK PRIMARY KEY (auditorio_id)	
);

--Se crea la tabla se_dara que relaciona que ponencia se dara en el auditorio, de que congreso y quien la imparte
CREATE TABLE congreso.se_dara(
	ponencia_id VARCHAR(5),
	ponente_id VARCHAR(5),
	congreso_id VARCHAR(5),
	auditorio_id VARCHAR(5),
	CONSTRAINT se_dara_pk PRIMARY KEY (ponencia_id, ponente_id, congreso_id, auditorio_id),
	CONSTRAINT dara_ponencia_fk FOREIGN KEY (ponencia_id,ponente_id) REFERENCES ponentes.ponencia(ponencia_id,ponente_id),
	CONSTRAINT dara_congreso_fk FOREIGN KEY (congreso_id) REFERENCES congreso.congreso(congreso_id),
	CONSTRAINT dara_auditorio_fk FOREIGN KEY (auditorio_id) REFERENCES congreso.auditorio(auditorio_id)
);

--Se crea la tabla se_presenta que relaciona que ponente se va a presentar y cuales congresos
CREATE TABLE congreso.se_presenta(
	congreso_id VARCHAR(5),
	ponente_id VARCHAR(5),
	CONSTRAINT se_presenta_pk PRIMARY KEY (congreso_id, ponente_id),
	CONSTRAINT presenta_congreso_fk FOREIGN KEY (congreso_id) REFERENCES congreso.congreso(congreso_id),
	CONSTRAINT presenta_ponente_fk FOREIGN KEY (ponente_id) REFERENCES ponentes.ponente(ponente_id)
);


--Se crea la tabla financia que relaciona el dinero que aportaran las empreasas para algun congreso
CREATE TABLE congreso.financia(
	congreso_id VARCHAR(5),
	empresa_id VARCHAR(5),
	monto MONEY NOT NULL,
	CONSTRAINT financia_pk PRIMARY KEY (congreso_id, empresa_id),
	CONSTRAINT financia_congreso_fk FOREIGN KEY (congreso_id) REFERENCES congreso.congreso(congreso_id),
	CONSTRAINT financia_empresa_fk FOREIGN KEY (empresa_id) REFERENCES congreso.empresa(empresa_id)
);

CREATE SCHEMA diplomado;
--Se crea la tabla financia que relaciona el dinero que aportaran las empreasas para algun congreso
CREATE TABLE diplomado.participante(
	Nombre VARCHAR(25),
	ApellidoP VARCHAR(25),
	ApellidoM VARCHAR(25),
	Comentario VARCHAR(250),
	Evaluacion NUMERIC(2)
);

--Insertando valores para institucion
INSERT INTO ponentes.institucion (institucion_id,institucion_nombre,institucion_pais,institucion_ciudad,institucion_carrera) 
	VALUES ('UN001','Universidad Nacional Autónoma de México','México','Coyoacán','Ingenieria en Computación');
INSERT INTO ponentes.institucion (institucion_id,institucion_nombre,institucion_ciudad,institucion_carrera) 
	VALUES ('UN002','Universidad Autonoma Metropolitana','Tlalpan','Informatica');
INSERT INTO ponentes.institucion (institucion_id,institucion_nombre,institucion_pais,institucion_ciudad,institucion_carrera) 
	VALUES ('UN003','Universidad de Barcelona','España','Barcelona','Ingenieria en Tecnologías');

--Inserta valores para ponentes
INSERT INTO ponentes.ponente (ponente_id, ponente_nombre, ponente_ap_paterno, ponente_ap_materno, ponente_pais, ponente_ciudad,ponente_email, ponente_tel_movil, ponente_tel_oficina, institucion_id ) 
	VALUES ('PT001','Miguel','Rojas','Hernandez','México','Tlalpan','miguel.ro@outlook.com',5537226405,5566465216,'UN001');
INSERT INTO ponentes.ponente (ponente_id, ponente_nombre, ponente_ap_paterno, ponente_pais, ponente_ciudad,ponente_email, ponente_tel_movil, ponente_tel_oficina, institucion_id ) 
	VALUES ('PT002','Peter','Smith','Inglaterra','Liverpool','peter.smt@gmail.com',7987654321, 7957374321,'UN003');

--Inserta valores a la tabla ponenetes
INSERT INTO ponentes.ponencia (ponencia_id, ponente_id, ponencia_nombre, ponencia_fecha, ponencia_duracion)
	VALUES ('PC001','PT001','Python','2021-03-01',120);
INSERT INTO ponentes.ponencia (ponencia_id, ponente_id, ponencia_nombre, ponencia_fecha, ponencia_duracion)
	VALUES ('PC002','PT002','Python','2021-03-02',120);
INSERT INTO ponentes.ponencia (ponencia_id, ponente_id, ponencia_nombre, ponencia_fecha)
	VALUES ('PC003','PT001','Ciencia de datos','2021-03-01');

--Inserta valores a la tabla congreso
INSERT INTO congreso.congreso (congreso_id, congreso_nombre, congreso_fecha_inicio, congreso_fecha_termino)
	VALUES ('CN001', 'Punto y coma', '2021-03-01', '2021-03-16');
INSERT INTO congreso.congreso (congreso_id, congreso_nombre, congreso_fecha_inicio, congreso_fecha_termino)
	VALUES ('CN002', 'Congreso de Database', '2021-05-01', '2021-05-21');

--Inserta valores a la tabla empresa
INSERT INTO congreso.empresa (empresa_id, empresa_nombre, empresa_pais, empresa_ciudad)
	VALUES ('EM001', 'IBM', 'USA', 'New York');
INSERT INTO congreso.empresa (empresa_id, empresa_nombre, empresa_pais, empresa_ciudad)
	VALUES ('EM002', 'Oracle', 'USA', 'Califirnia');

--Inserta valores a la tabla auditorio
INSERT INTO congreso.auditorio (auditorio_id, auditorio_nombre, auditorio_ciudad, auditorio_calle)
	VALUES ('AU001', 'Aula Magna', 'Ciudad Universitaria', 'Facultad de Ingeniería');
INSERT INTO congreso.auditorio (auditorio_id, auditorio_nombre, auditorio_ciudad, auditorio_calle)
	VALUES ('AU002', 'Sotero Prieto', 'Ciudad Universitaria', 'Facultad de Ingeniería');

--Inserta valores a la tabla se dara
INSERT INTO congreso.se_dara (ponencia_id, ponente_id, congreso_id, auditorio_id)
	VALUES ('PC001', 'PT001', 'CN001', 'AU001');
INSERT INTO congreso.se_dara (ponencia_id, ponente_id, congreso_id, auditorio_id)
	VALUES ('PC003', 'PT001', 'CN001', 'AU002');

--Inserta valores a la tabla se presenta
INSERT INTO congreso.se_presenta (congreso_id, ponente_id)
	VALUES ('CN001', 'PT001');
INSERT INTO congreso.se_presenta (congreso_id, ponente_id)
	VALUES ('CN001', 'PT002');

--Inserta valores a la tabla se financia
INSERT INTO congreso.financia(congreso_id,empresa_id,monto)
	VALUES('CN001','EM001',3000.00);
INSERT INTO congreso.financia(congreso_id,empresa_id,monto)
	VALUES('CN001','EM002',10000.00);
INSERT INTO congreso.financia(congreso_id,empresa_id,monto)
	VALUES('CN002','EM002',10000.00);

--Inserta valores en la tabla diplomado
INSERT INTO diplomado.participante (Nombre,ApellidoP,ApellidoM,Comentario,Evaluacion) 
	VALUES ('Miguel Alejandro', 'Rojas', 'Hernández','La clase me pareció con buen contenido, quiza me hubiera gustado ir mas rapido
	 y no detenernos tanto en dudas sensillas. En ocasiones se me hizo pesado por el tiempo. En general me gusto este modulo.',10);

--Muestra las tablas
\dt ponentes.

\dt congreso.

\dt diplomado.


SELECT 
	institucion_id,
	institucion_nombre AS nombre,
	institucion_pais AS pais,
	institucion_ciudad AS ciudad,
	institucion_carrera AS estudia
FROM ponentes.institucion;

SELECT 
	ponente_id AS clave,
	ponente_nombre AS nombre,
	ponente_ap_paterno AS Ap_paterno,
	ponente_ap_materno AS Ap_materno,
	ponente_pais AS pais,
	ponente_ciudad AS ciudad,
	ponente_email AS Email,
	ponente_tel_movil AS Celular,
	ponente_tel_oficina AS Tel_Oficina,
	institucion_id AS Estudio_En
FROM ponentes.ponente;

SELECT 
	ponente_id,
	ponencia_nombre AS nombre,
	ponencia_fecha AS fecha,
	ponencia_duracion AS duracion,
	ponencia_numero AS conferenciastotales
FROM ponentes.ponencia;

SELECT 
	congreso_id,
	congreso_nombre AS nombre,
	congreso_fecha_inicio AS fecha_inicio,
	congreso_fecha_termino AS fecha_termino
FROM congreso.congreso;

SELECT 
	empresa_id,
	empresa_nombre AS nombre,
	empresa_pais AS pais,
	empresa_ciudad AS ciudad
FROM congreso.empresa;

SELECT 
	auditorio_id,
	auditorio_nombre AS auditorio,
	auditorio_ciudad AS ciudad,
	auditorio_calle AS calle
FROM congreso.auditorio;

SELECT 
	ponencia_id,
	ponente_id,
	congreso_id,
	auditorio_id
FROM congreso.se_dara;

SELECT 
	congreso_id,
	ponente_id
FROM congreso.se_presenta;

SELECT
	congreso_id,
	empresa_id,
	monto
FROM congreso.financia;

SELECT
	Nombre,
	ApellidoP,
	ApellidoM,
	Comentario,
	Evaluacion
FROM diplomado.participante;




--\c postgres
--DROP DATABASE IF EXISTS congresos;
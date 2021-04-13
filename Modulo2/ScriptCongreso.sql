-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Scripts de Sistema de Congresos				Febrero, 2021.
--		Rojas Hernandez Miguel Alejandro
-- ***************************************************************

DROP DATABASE IF EXISTS congresos;
CREATE DATABASE congresos;

\c congresos

CREATE TABLE intitucion(
	instuticion_id VARCHAR(5),
	intitucion_nombre VARCHAR(30) NOT NULL,
	instuticion_pais VARCHAR(15) NOT NULL,
	instuticion_ciudad VARCHAR(20) NOT NULL,
	instuticion_localidad VARCHAR(20) NOT NULL,
	instuticion_calle VARCHAR(20) NULL,
	instuticion_carrera VARCHAR(20),
	CONSTRAINT intitucion_PK PRIMARY KEY(instuticion_id)
);

CREATE TABLE ponente(
	ponente_id VARCHAR(5),
	ponente_nombre VARCHAR(30) NOT NULL,
	ponente_ap_paterno VARCHAR(20) NOT NULL,
	ponente_ap_materno VARCHAR(20) NULL,
	ponente_pais VARCHAR(15) NOT NULL,
	ponente_ciudad VARCHAR(30),
	ponente_email VARCHAR(50) NOT NULL,
	ponente_tel_movil NUMERIC(10) NOT NULL,
	ponente_tel_oficina NUMERIC(10)NULL,
	instuticion_id VARCHAR(5), 
	CONSTRAINT ponente_PK PRIMARY KEY(ponente_id),
	CONSTRAINT intitucion_FK FOREIGN KEY(instuticion_id) REFERENCES intitucion(instuticion_id)
);

CREATE TABLE ponencia(
	ponencia_id VARCHAR(5),
	ponente_id VARCHAR(5),
	ponencia_nombre VARCHAR(30) NOT NULL,
	ponencia_fecha DATE NOT NULL,
	ponencia_duracion NUMERIC(5) NOT NULL,
	CONSTRAINT ponencia_PK PRIMARY KEY(ponencia_id,ponente_id),
	CONSTRAINT ponente_FK FOREIGN KEY(ponente_id) REFERENCES ponente(ponente_id)
);


CREATE TABLE congreso(
	congreso_id VARCHAR(5),
	congreso_nombre VARCHAR(30) NOT NULL,
	congreso_fecha_inicio DATE NOT NULL,
	congreso_fecha_termino DATE NOT NULL,
	CONSTRAINT congreso_PK PRIMARY KEY (congreso_id)
);

CREATE TABLE empresa(
	empresa_id VARCHAR(5),
	empresa_nombre VARCHAR(30) NOT NULL,
	empresa_pais VARCHAR(15) NOT NULL,
	empresa_ciudad VARCHAR(30) NULL,
	CONSTRAINT empresa_PK PRIMARY KEY (empresa_id)
);

CREATE TABLE auditorio(
	auditorio_id VARCHAR(5),
	auditorio_ciudad VARCHAR(30) NOT NULL,
	auditorio_localidad VARCHAR(30) NOT NULL,
	auditorio_calle VARCHAR(30) NOT NULL,
	CONSTRAINT auditorio_PK PRIMARY KEY (auditorio_id)	
);

CREATE TABLE se_dara(
	ponencia_id VARCHAR(5),
	ponente_id VARCHAR(5),
	congreso_id VARCHAR(5),
	auditorio_id VARCHAR(5),
	CONSTRAINT se_dara_pk PRIMARY KEY (ponencia_id, ponente_id, congreso_id, auditorio_id),
	CONSTRAINT dara_ponencia_fk FOREIGN KEY (ponencia_id,ponente_id) REFERENCES ponencia(ponencia_id,ponente_id),
	CONSTRAINT dara_congreso_fk FOREIGN KEY (congreso_id) REFERENCES congreso(congreso_id),
	CONSTRAINT dara_auditorio_fk FOREIGN KEY (auditorio_id) REFERENCES auditorio(auditorio_id)
);

CREATE TABLE se_presenta(
	congreso_id VARCHAR(5),
	ponente_id VARCHAR(5),
	CONSTRAINT se_presenta_pk PRIMARY KEY (congreso_id, ponente_id),
	CONSTRAINT presenta_congreso_fk FOREIGN KEY (congreso_id) REFERENCES congreso(congreso_id),
	CONSTRAINT presenta_ponente_fk FOREIGN KEY (ponente_id) REFERENCES ponente(ponente_id)
);
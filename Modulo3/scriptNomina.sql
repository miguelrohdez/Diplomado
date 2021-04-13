--Creando tablespace y usuario
CREATE TABLESPACE PRUEBAS DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\TEMP01.DAT' SIZE 51200K;

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE  USER  PRUEBA  IDENTIFIED  BY  PRUEBA  DEFAULT  TABLESPACE PRUEBAS;

GRANT UNLIMITED TABLESPACE TO PRUEBA;

--Tabla regiones
CREATE TABLE regions
    ( region_id      NUMBER 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR2(25) 
    );

CREATE UNIQUE INDEX reg_id_pk
ON regions (region_id);

ALTER TABLE regions
ADD ( CONSTRAINT reg_id_pk
       		 PRIMARY KEY (region_id)
    ) ;

--Tabla paises
CREATE TABLE countries 
    ( country_id      CHAR(2) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , region_id       NUMBER 
    , CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX; 

ALTER TABLE countries
ADD ( CONSTRAINT countr_reg_fk
        	 FOREIGN KEY (region_id)
          	  REFERENCES regions(region_id) 
    ) ;

--Tabla localizacion
CREATE TABLE locations
    ( location_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    , city       VARCHAR2(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)
    , country_id     CHAR(2)
    ) ;

CREATE UNIQUE INDEX loc_id_pk
ON locations (location_id) ;

ALTER TABLE locations
ADD ( CONSTRAINT loc_id_pk
       		 PRIMARY KEY (location_id)
    , CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id) 
    ) ;
CREATE SEQUENCE locations_seq
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 NOCACHE
 NOCYCLE;

--Tabla departamentos
CREATE TABLE departments
    ( department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
	CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMBER(6)
    , location_id      NUMBER(4)
    ) ;

CREATE UNIQUE INDEX dept_id_pk
ON departments (department_id) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_id_pk
       		 PRIMARY KEY (department_id)
    , CONSTRAINT dept_loc_fk
       		 FOREIGN KEY (location_id)
        	  REFERENCES locations (location_id)
     ) ;

Rem 	Useful for any subsequent addition of rows to departments table
Rem 	Starts with 280 

CREATE SEQUENCE departments_seq
 START WITH     280
 INCREMENT BY   10
 MAXVALUE       9990
 NOCACHE
 NOCYCLE;

--Tabla trabajos
CREATE TABLE jobs
    ( job_id         VARCHAR2(10)
    , job_title      VARCHAR2(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMBER(6)
    , max_salary     NUMBER(6)
    ) ;

CREATE UNIQUE INDEX job_id_pk 
ON jobs (job_id) ;

ALTER TABLE jobs
ADD ( CONSTRAINT job_id_pk
      		 PRIMARY KEY(job_id)
    ) ;

--Tabla empleados
CREATE TABLE employees(
	employee_id    NUMBER(6),
    first_name     VARCHAR2(20),
    last_name      VARCHAR2(25) CONSTRAINT emp_last_name_nn  NOT NULL,
    rfc 		   VARCHAR2(13) CONSTRAINT emp_rfc_nn	NOT NULL,
    nss 		   VARCHAR2(12) CONSTRAINT emp_nss_nn	NOT NULL,
    email          VARCHAR2(25)	CONSTRAINT emp_email_nn  NOT NULL, 
    phone_number   VARCHAR2(20), 
    hire_date      DATE	CONSTRAINT     emp_hire_date_nn  NOT NULL, 
    job_id         VARCHAR2(10)	CONSTRAINT     emp_job_nn  NOT NULL, 
    salary         NUMBER(8,2), 
    commission_pct NUMBER(2,2), 
    manager_id     NUMBER(6), 
    department_id  NUMBER(4), 
    CONSTRAINT     emp_salary_min
                     CHECK (salary > 0),  
    CONSTRAINT     emp_email_uk
                     UNIQUE (email)
    );

CREATE UNIQUE INDEX emp_emp_id_pk
ON employees (employee_id) ;


ALTER TABLE employees
ADD ( CONSTRAINT     emp_emp_id_pk
                     PRIMARY KEY (employee_id)
    , CONSTRAINT     emp_dept_fk
                     FOREIGN KEY (department_id)
                      REFERENCES departments
    , CONSTRAINT     emp_job_fk
                     FOREIGN KEY (job_id)
                      REFERENCES jobs (job_id)
    , CONSTRAINT     emp_manager_fk
                     FOREIGN KEY (manager_id)
                      REFERENCES employees
    ) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_mgr_fk
      		 FOREIGN KEY (manager_id)
      		  REFERENCES employees (employee_id)
    ) ;



CREATE SEQUENCE employees_seq
 START WITH     207
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

--Tabla historial trabajos
CREATE TABLE job_history
    ( employee_id   NUMBER(6)
	 CONSTRAINT    jhist_employee_nn  NOT NULL
    , start_date    DATE
	CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE
	CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        VARCHAR2(10)
	CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id NUMBER(4)
    , CONSTRAINT    jhist_date_interval
                    CHECK (end_date > start_date)
    ) ;

CREATE UNIQUE INDEX jhist_emp_id_st_date_pk 
ON job_history (employee_id, start_date) ;

ALTER TABLE job_history
ADD ( CONSTRAINT jhist_emp_id_st_date_pk
      PRIMARY KEY (employee_id, start_date)
    , CONSTRAINT     jhist_job_fk
                     FOREIGN KEY (job_id)
                     REFERENCES jobs
    , CONSTRAINT     jhist_emp_fk
                     FOREIGN KEY (employee_id)
                     REFERENCES employees
    , CONSTRAINT     jhist_dept_fk
                     FOREIGN KEY (department_id)
                     REFERENCES departments
    ) ;

--Tabla ISR
CREATE TABLE isr(
	employee_id    NUMBER(6),
	deducciones 	INTEGER 	NOT NULL,
	utilidad_fiscal INTEGER		NOT NULL,
	isr 			NUMBER(8,3) NOT NULL,
	impuesto 		NUMBER(6,3) NOT NULL,
	coeficiente_utilidad INTEGER NOT NULL,
	pagos_provisional NUMBER(8,2)	NOT NULL,
	CONSTRAINT isr_PK 
		PRIMARY KEY (employee_id),
	CONSTRAINT isr_empleado_fk 
		FOREIGN KEY (employee_id) 
			REFERENCES employees
);

--Tabla imss
CREATE TABLE imss(
	employee_id    NUMBER(6),
	id_imss 				INTEGER,
	curp 					VARCHAR2(18) NOT NULL,
	semanas_cotizadas 		INTEGER NOT NULL,
	nombre_patron 			VARCHAR2(100) NOT NULL,
	registro_patronal 		DATE NOT NULL,
	tipo_movimiento 		VARCHAR2(50) NOT NULL,
	fecha_movimiento 		DATE NOT NULL,
	salario_base 			NUMBER(6,2) NOT NULL,
	num_seguro_social		VARCHAR2(12) NOT NULL,
	CONSTRAINT imss_PK
		PRIMARY KEY (employee_id),
	CONSTRAINT imss_empleado_fk 
		FOREIGN KEY (employee_id) 
			REFERENCES employees

);

--Crear tabla afore
CREATE TABLE afore(
	employee_id    NUMBER(6),
	saldo_ant		NUMBER(6,2)	NOT NULL, 
	rendimientos	INTEGER		NOT NULL, 
	comisiones		NUMBER(8,6)	NOT NULL,
	aportaciones	INTEGER		NOT NULL, 
	retiros			INTEGER		NOT NULL, 
	saldo final		NUMBER(6,2)	NOT NULL,
	CONSTRAINT afore_pk
		PRIMARY KEY (employee_id),
	CONSTRAINT afore_empleado_fk 
		FOREIGN KEY (employee_id) 
			REFERENCES employees
);

CREATE TABLE nomina(
	employee_id		NUMBER(6),
	quincena		NUMBER(6,2) 	NOT NULL,
	anio			DATE 			NOT NULL,
	sueldo_bruto 	NUMBER(6,2) 	NOT NULL,
	sueldo_neto		NUMBER(6,2) 	NOT NULL,
	CONSTRAINT nomina_pk 
		PRIMARY KEY (employee_id),
	CONSTRAINT nomina_empleado_fk 
		FOREIGN KEY (employee_id) 
			REFERENCES employees

);

CREATE TABLE Nomina2 AS (
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, 
     SALARY,
     SALARY/2 SAL_BRUTO,
     SALARY*0.052 IMSS,
     SALARY*0.04 INFONAVIT,
     SALARY*0.28 ISR,
     (SALARY-((SALARY*0.052)+(SALARY*0.04)+(SALARY*0.28)))/2 SAL_NETO
  FROM EMPLOYEES
);

CREATE SEQUENCE sec_nomina
    START WITH 00001
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE nominaNueva(
    nomina_id NUMBER(6) PRIMARY KEY,
    employee_id NUMBER(6),
    salary NUMBER(8,2) NOT NULL,
    sal_bruto NUMBER(8,2) NOT NULL,
    imss NUMBER(8,2) NOT NULL,
    infonavit NUMBER(8,2) NOT NULL,
    isr NUMBER(8,2) NOT NULL,
    sueldo_neto NUMBER(8,2) NOT NULL);

INSERT INTO nominaNueva(employee_id, salary, sal_bruto, imss, infonavit, isr, sueldo_neto)
SELECT EMPLOYEE_ID,  
     SALARY,
     SALARY/2 SAL_BRUTO,
     SALARY*0.052 IMSS,
     SALARY*0.04 INFONAVIT,
     SALARY*0.28 ISR,
     (SALARY-((SALARY*0.052)+(SALARY*0.04)+(SALARY*0.28)))/2 SAL_NETO
FROM EMPLOYEES
)
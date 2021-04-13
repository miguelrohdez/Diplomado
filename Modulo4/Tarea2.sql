/*Ejericio 1
Rojas Hernandez Miguel Alejandro*/

--Una empresa almacena los datos de sus empleados en una tabla llamada "empleados".
--1- Eliminamos la tabla, si existe y la creamos:

CREATE PROCEDURE sp_tabla_empleados
AS
  IF OBJECT_ID('empleados') IS NOT NULL
  DROP TABLE empleados;
 
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
   INSERT INTO empleados VALUES('22333333','Luis','Lopez',300,0,'Contaduria');
   INSERT INTO empleados VALUES ('22444444','Marta','Perez',500,1,'Sistemas');
   INSERT INTO empleados VALUES('22555555','Susana','Garcia',400,2,'Secretaria');
   INSERT INTO empleados VALUES('22666666','Jose Maria','Morales',400,3,'Secretaria');
;

exec sp_tabla_empleados;

--3- Elimine el procedimiento llamado "pa_empleados_sueldo" si existe:
  IF OBJECT_ID('pa_empleados_sueldo') IS NOT NULL
    DROP PROCEDURE pa_empleados_sueldo;

--4- Cree un procedimiento almacenado llamado "pa_empleados_sueldo" que seleccione los nombres, apellidos y sueldos de los empleados.
CREATE PROCEDURE pa_empleados_sueldo
AS
  SELECT nombre, apellido, sueldo
  FROM empleados;
;

--5- Ejecute el procedimiento creado anteriormente.
exec pa_empleados_sueldo;

--6- Elimine el procedimiento llamado "pa_empleados_hijos" si existe:
 IF OBJECT_ID('pa_empleados_hijos') IS NOT NULL
  DROP PROCEDURE pa_empleados_hijos;

--7- Cree un procedimiento almacenado llamado "pa_empleados_hijos" que seleccione los nombres, apellidos y cantidad de hijos de los empleados con hijos.
CREATE PROCEDURE pa_empleados_hijos
AS
  SELECT nombre,apellido, cantidadhijos
  FROM empleados
  WHERE cantidadhijos>0;
;

--8- Ejecute el procedimiento creado anteriormente.
exec pa_empleados_hijos;

--9- Actualice la cantidad de hijos de algún empleado sin hijos y vuelva a ejecutar el procedimiento para verificar que ahora si aparece en la lista.
UPDATE empleados
  SET cantidadhijos = 3
  WHERE documento = '22222222';

/******** Segunda parte de la Tarea 2*******
-- Una empresa almacena los datos de sus --empleados en una tabla llamada  empleados".
*/
--1- Eliminamos la tabla, si existe y la creamos:
 CREATE PROCEDURE sp_tabla_empleados
AS
  IF OBJECT_ID('empleados') IS NOT NULL
  DROP TABLE empleados;
 
  CREATE TABLE empleados(
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
   INSERT INTO empleados VALUES('22333333','Luis','Lopez',300,0,'Contaduria');
   INSERT INTO empleados VALUES ('22444444','Marta','Perez',500,1,'Sistemas');
   INSERT INTO empleados VALUES('22555555','Susana','Garcia',400,2,'Secretaria');
   INSERT INTO empleados VALUES('22666666','Jose Maria','Morales',400,3,'Secretaria');
;

exec sp_tabla_empleados;

--3- Elimine el procedimiento llamado "pa_empleados_sueldo" si existe:
  IF OBJECT_ID('pa_empleados_sueldo') IS NOT NULL
    DROP PROCEDURE pa_empleados_sueldo;

/*4- Cree un procedimiento almacenado llamado "pa_empleados_sueldo" que seleccione los nombres, apellidos y 
  sueldos de los empleados que tengan un sueldo superior o igual al enviado como parámetro.*/
CREATE PROCEDURE pa_empleados_sueldo
  @sueldo DECIMAL(6,2)
AS
  SELECT nombre, apellido, sueldo
  FROM empleados
  WHERE sueldo >= @sueldo;
;

--5- Ejecute el procedimiento creado anteriormente con distintos valores:
 exec pa_empleados_sueldo 400;
 exec pa_empleados_sueldo 500;

/*6- Ejecute el procedimiento almacenado "pa_empleados_sueldo" sin parámetros.
Mensaje de error. - El procedimiento necesita un parametro
Msg 201, Level 16, State 4, Procedure pa_empleados_sueldo, Line 0 [Batch Start Line 8]
Procedure or function 'pa_empleados_sueldo' expects parameter '@sueldo', which was not supplied.*/


--7- Elimine el procedimiento almacenado "pa_empleados_actualizar_sueldo" si existe:
IF OBJECT_ID('pa_empleados_actualizar_sueldo') IS NOT NULL
  DROP PROCEDURE pa_empleados_actualizar_sueldo;

/*8- Cree un procedimiento almacenado llamado "pa_empleados_actualizar_sueldo" que actualice los sueldos iguales 
al enviado como primer parámetro con el valor enviado como segundo parámetro.*/
CREATE OR ALTER PROCEDURE pa_empleados_actualizar_sueldo
  @sueldoanterior DECIMAL(6,2),
  @sueldonuevo DECIMAL(6,2)
AS
  UPDATE empleados
    SET sueldo = @sueldonuevo
    WHERE sueldo = @sueldoanterior;
;

--9- Ejecute el procedimiento creado anteriormente y verifique si se ha ejecutado correctamente:
 exec pa_empleados_actualizar_sueldo 300,350;
 SELECT * FROM empleados;

/*10- Ejecute el procedimiento "pa_empleados_actualizar_sueldo" enviando un solo parámetro.
Error. - El procedimiento espera dos parametros 
Msg 201, Level 16, State 4, Procedure pa_empleados_actualizar_sueldo, Line 0 [Batch Start Line 0]
Procedure or function 'pa_empleados_actualizar_sueldo' expects parameter '@sueldonuevo', which was not supplied.
*/

/*11- Ejecute el procedimiento almacenado "pa_empleados_actualizar_sueldo" enviando en primer lugar el parámetro 
@sueldonuevo y en segundo lugar @sueldoanterior (parámetros por nombre).*/
exec pa_empleados_actualizar_sueldo @sueldonuevo=300, @sueldoanterior=350;

--12- Verifique el cambio:
 SELECT * FROM empleados;

--13- Elimine el procedimiento almacenado "pa_sueldototal", si existe:
IF OBJECT_ID('pa_sueldototal') IS NOT NULL
  DROP PROCEDURE pa_sueldototal;

/*14- Cree un procedimiento llamado "pa_sueldototal" que reciba el documento de un empleado 
y muestre su nombre, apellido y el sueldo total (resultado de la suma del sueldo y salario por hijo, que es de
$200 si el sueldo es menor a $500 y $100, si el sueldo es mayor o igual a $500). Coloque como valor por defecto para el 
parámetro el patrón "%".*/
CREATE PROCEDURE pa_sueldototal
  @documento VARCHAR(8) = '%'
AS
  SELECT nombre, apellido, 
    CASE
        WHEN sueldo < 500 THEN sueldo+200
        ELSE sueldo + 100
    END AS "Sueldo total"
  FROM empleados
  WHERE documento like @documento;
;

--15- Ejecute el procedimiento anterior enviando diferentes valores:
 exec pa_sueldototal '22333333';
 exec pa_sueldototal '22444444';
 exec pa_sueldototal '22666666';

--16-  Ejecute el procedimiento sin enviar parámetro para que tome el valor por defecto.
--Muestra los 5 registros.
exec pa_sueldototal;
--o especificando
exec pa_sueldototal default;
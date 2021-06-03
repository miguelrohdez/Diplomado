--Obtener el nombre completo del empleado cuyo sueldo es mayor al de todos
SELECT nombre, apellido_paterno, apellido_materno 
FROM empleado
WHERE sueldo = (SELECT MAX(sueldo) FROM empleado);
--Obtener el nombre completo del empleado cuyo sueldo es menor al de todos.
SELECT nombre, apellido_paterno, apellido_materno
FROM empleado
WHERE sueldo = (SELECT MIN(sueldo) FROM empleado);
--Obtener el total de cuando gasta la empresa en sus empleados por concepto de sueldos.
SELECT SUM(sueldo) "Gasto total sueldos"
FROM empleado
--Obtener el sueldo promedio de los empleados.
SELECT AVG(sueldo)
FROM empleado
--Obtener el nombre del empleado y la fecha de contratación del empleado cuyo ingreso es el más antiguo en la empresa.
SELECT nombre, fecha_contratacion
FROM empleado
WHERE fecha_contratacion = (SELECT MIN(fecha_contratacion) 
							FROM empleado)


COPY (SELECT nombre, apellido_paterno, apellido_materno FROM empleado
WHERE sueldo = (SELECT MIN(sueldo) FROM empleado)) TO '/var/lib/postgresql/exp_2.txt' WITH DELIMITER '|';

COPY (SELECT SUM(sueldo) "Gasto total sueldos" FROM empleado) TO '/var/lib/postgresql/exp_3.txt' WITH (FORMAT csv, HEADER, DELIMITER ',');

COPY (SELECT AVG(sueldo) FROM empleado) TO '/var/lib/postgresql/exp_4.txt' WITH (FORMAT csv, HEADER, DELIMITER E'\t');


--Muestra el nombre, id y el tipo de constraint que existen
SELECT connamespace,conname,contype FROM pg_constraint;
--Muestra el nombre, la tabla a la que pertenece y a la que hace referencia
SELECT conname,conrelid, confrelid FROM pg_constraint;
--Muestra el nombre y la columa en la tabla
SELECT conname, conkey FROM pg_constraint;
--Muestra el nombre y el check que revisa
SELECT conname, conbin FROM pg_constraint WHERE contype = 'c' ;
--Muestra el nombre y si tiene alguna accion al actualizar o eliminar
SELECT conname, confupdtype, confdeltype FROM pg_constraint;

--Muestra el nombre y el id del propietario de tablespace
SELECT spcname,spcowner FROM pg_tablespace;
--Muestra el nombre y la ruta del tablespace
SELECT spcname,spcoptions FROM pg_tablespace;
--Muestra el nombre, id del propietario y los privilegios
SELECT spcname,spcowner,spcacl FROM pg_tablespace;
--Muesta el nombre, propietario y ubicacion
SELECT spcname, pg_authid.rolname, spcoptions 
FROM pg_tablespace
INNER JOIN pg_authid
ON pg_tablespace.spcowner = pg_authid.oid;
-- Muestra los tablespace creados por un usuario, en este caso postgres 
SELECT spcname 
FROM pg_tablespace
WHERE spcowner = (SELECT oid FROM pg_authid WHERE rolname = 'postgres');

--Muesta nombre, categoria y unidad del parametro de todas las configuraciones
SELECT name, category, unit FROM pg_settings;
--Muesta el nombre y valor actual
SELECT name, setting FROM pg_settings;
--Muesta el nombre y una descripcion 
SELECT name, short_desc FROM pg_settings;
--Muesta el nombre y datos extra solamente de las configuraciones que poseen uno
SELECT name, extra_desc FROM pg_settings WHERE extra_desc <> '';
--Muesta el nombre, ruta donde se encuentra y numero de linea si tiene ruta valida
SELECT name, sourcefile,sourceline FROM pg_settings WHERE sourcefile <> '';
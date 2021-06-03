CREATE TABLESPACE usuaurios DATAFILE 'usuaurios_data.dbf' SIZE 1m;

SELECT tablespace_name TABLESPACE, file_name, bytes/1024/1024 MB
FROM dba_data_files;

COLUMN file_name HEADING 'Nombre del|Archivo' /

ALTER DATABASE DATAFILE 'usuaurios_data.dbf' RESIZE 10m;
--error ora 516

DROP TABLESPACE usuaurios;

CREATE TABLESPACE usuaurios DATAFILE 'usuaurios.dbf' SIZE 1m AUTOEXTEND ON NEXT 20m;

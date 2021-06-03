sqlcmd -S MARH-10\SQLEXPRESS

SELECT name FROM sys.databases;

SELECT * FROM empleado;

--HEADER,COMA
BULK INSERT empleado
FROM 'D:\MegaNube\Bases\Diplomado\Modulo5\Video\datos_header_coma.txt'
WITH(FIELDTERMINATOR = ',',
	FIRSTROW = 2)
--COMA
BULK INSERT empleado
FROM 'D:\MegaNube\Bases\Diplomado\Modulo5\Video\datos_coma.txt'
WITH(FIELDTERMINATOR = ',')
--PIPE
BULK INSERT empleado
FROM 'D:\MegaNube\Bases\Diplomado\Modulo5\Video\datos_pipe.txt'
WITH(FIELDTERMINATOR = '|')	

--COMA_QUOTE
BULK INSERT empleado
FROM 'D:\MegaNube\Bases\Diplomado\Modulo5\Video\datos_coma_quote.txt'
WITH(FIELDTERMINATOR = ',',
	FORMAT='CSV')


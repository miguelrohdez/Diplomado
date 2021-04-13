/*	Proyecto
============================================
Autor:   Rojas Hernandez, Miguel Alejandro
Fecha de Creación: 25/03/2021
Descripción: Proyecto Final del Modulo 4 
============================================
*/

--Parte 1
CREATE DATABASE FACTURACION --Cambiar a facturacion
GO

USE FACTURACION
GO

--Parte 2
CREATE TABLE Clientes(
	idCliente	INT,
	Nombre	VARCHAR(50) NOT NULL,
	ApellidoPaterno	VARCHAR(50) NOT NULL,
	ApellidoMaterno	VARCHAR(50) NOT NULL,
	Direccion	VARCHAR(200) NOT NULL,
	Telefono	VARCHAR(15) NOT NULL,
	Correo	VARCHAR(20) NOT NULL,
	FechaNacimiento	DATE NOT NULL,
	RFC	VARCHAR(13) NULL,
	PRIMARY KEY(idCliente)
);

CREATE TABLE Factura(
	NumFactura INT NOT NULL,
	Fecha DATE NOT NULL,
	PRIMARY KEY (NumFactura),
	idCliente INT FOREIGN KEY
	REFERENCES Clientes(idCliente)
);

CREATE TABLE FacturaDetalle(
	NumDetalle INT NOT NULL,
	DescripcionProducto VARCHAR(30) NOT NULL,
	Cantidad INT NOT NULL,
	Precio DECIMAL(5,2) NOT NULL,
	PRIMARY KEY (NumDetalle),
	NumFactura INT FOREIGN KEY
		REFERENCES Factura(NumFactura)
);

--Creacion de la tabla respaldo
CREATE TABLE BitacoraCliente(
	idBitacora	INT,
	idCliente	INT NOT NULL,
	Nombre	VARCHAR(50),
	ApellidoPaterno	VARCHAR(50),
	ApellidoMaterno	VARCHAR(50),
	Direccion	VARCHAR(200),
	Telefono	VARCHAR(15),
	Correo	VARCHAR(20),
	FechaNacimiento	DATE,
	RFC	VARCHAR(13) NULL,
	Accion VARCHAR(20) NOT NULL,
	FechaAccion	DATETIME
	PRIMARY KEY(idBitacora)
);

--Parte 3
/*Generar un Stored Procedure SP_AltaClientes con los parámetros de entrada
Nombre, ApellidoPaterno, ApellidoMaterno, Direccion, Telefono, Correo y
FechaNacimiento. (1 punto)
*El valor del campo IdCliente, deberá de ser generado automáticamente por el SP, será
un número consecutivo.
*El valor del campo RFC, NO deberá de ser agregado en ese momento.*/
CREATE PROCEDURE SP_AltaEmpleado
	@Nombre VARCHAR(50),
	@ApellidoPaterno VARCHAR(50),
	@ApellidoMaterno VARCHAR(50),
	@Direccion VARCHAR(200),
	@Telefono VARCHAR(15),
	@Correo VARCHAR(20),
	@FechaNacimiento DATE
AS
	--Variables locales
	DECLARE @idCliente INT;
	--DECLARE @AUX1 DATE;
	--SELECT @AUX1=CONVERT(date,@fechaNacimiento, 105);
	
	SELECT @idCliente = MAX(idCliente)
	FROM Clientes;
	BEGIN
	IF @idCliente IS NULL
			SELECT @idCliente = 1;
	ELSE
		SELECT @idCliente = MAX(idCliente)+1
		FROM Clientes;
	END;

	INSERT INTO Clientes 
		VALUES(@idCliente, @Nombre, @ApellidoPaterno, 
			@ApellidoMaterno, @Direccion, @Telefono, 
			@Correo, @FechaNacimiento, NULL);
;
SET DATEFORMAT dmy;
GO
EXEC SP_AltaEmpleado 'Miguel','Rojas','Hernandez','San Jeronimo,CDMX','5531624042','miguel.ro@outlook.com','17/06/1994'
SELECT * FROM Clientes


--Parte 4
/*Crear un Trigger TR_AltaRFCCliente que calcule automáticamente el RFC del cliente (sin
homoclave) en base a la información generada de SP_AltaClientes. (1 punto)*/
CREATE OR ALTER TRIGGER TR_AltaRFCCliente
ON Clientes 
AFTER INSERT AS
BEGIN
	DECLARE @AP VARCHAR(50)
	DECLARE @AM VARCHAR(50)
	DECLARE @NO VARCHAR(50)
	DECLARE @FECHANAC varchar(10)
	DECLARE @RFC VARCHAR(10)
	SET @AP = (SELECT ApellidoPaterno FROM INSERTED)
	SET @AM = (SELECT ApellidoMaterno FROM INSERTED)
	SET @NO = (SELECT Nombre FROM INSERTED)
	SET @FECHANAC = (SELECT FechaNacimiento FROM INSERTED)
	SET @RFC = UPPER(SUBSTRING (@AP,1,2)) + UPPER(SUBSTRING (@AM,1,1)) + UPPER(SUBSTRING(@NO,1,1))
	 + SUBSTRING(@FECHANAC,3,2) + SUBSTRING(@FECHANAC,6,2) + SUBSTRING(@FECHANAC,9,2)
	UPDATE Clientes 
		SET RFC = @RFC
		WHERE idCliente=(SELECT idCliente FROM INSERTED);
END;

--Parte 5
/*Crear un Stored Procedure SP_AltaFacturaMaestro, tendrá 2 parámetros (idCliente,
CadenaFacturaDetalle)
Generará un registro en la tabla de Factura. El valor del campo NumFactura, deberá de ser
generado automáticamente por el SP, es decir, no va como parámetro, deberá de ser
consecutivo. Y el campo fecha deberá de ser la del sistema. (1 punto)*/
CREATE OR ALTER PROCEDURE SP_AltaFacturaMaestro
	@idCliente INT,
	@CadenaFacturaDetalle VARCHAR(400)
AS
	DECLARE @NumFactura INT
	SELECT @NumFactura = MAX(NumFactura)
	FROM Factura;
	IF @NumFactura IS NULL
			SELECT @NumFactura = 1;
	ELSE
		SELECT @NumFactura = MAX(NumFactura)+1
		FROM Factura;
	
	INSERT INTO Factura	VALUES(@NumFactura,GETDATE(),@idCliente)
	PRINT 'Se agrego la facutura: ' + STR(@NumFactura)+CHAR(10)+
		'Con la siguiente información: ' + CHAR(10)+
		'Cliente: '+ STR(@idCliente) +CHAR(10)+
		'Fecha: ' + CONVERT(varchar, getdate(),23)
;

EXEC SP_AltaFacturaMaestro 1,'cuaderno,5,100|lapices,10,9|gomas,50,5'
SELECT * FROM Factura

--Parte 6
/*Crear un Trigger TR_BitacoraClientes, en donde por cada registro en la tabla de clientes
genere una bitácora de respaldo en la tabla BitacoraClientes que guardará el registro que
fue modificado, insertado o borrado. (1 punto)*/
--Que registro fue modificado y que campo
--registro completo antes de alguna modificacion, guardar el viejo
CREATE TRIGGER TR_BitacoraCliente
ON Clientes
AFTER INSERT, UPDATE, DELETE AS
BEGIN
	--Variables
	DECLARE @idBit INT
	DECLARE @idCli INT
	DECLARE @Nom VARCHAR(50)
	DECLARE @APat VARCHAR(50)
	DECLARE @AMat VARCHAR(50)
	DECLARE @Dir VARCHAR(200)
	DECLARE @Tel VARCHAR(15)
	DECLARE @Email VARCHAR(20)
	DECLARE @FecNac DATE
	DECLARE @RFC VARCHAR(13)
	DECLARE @Accion VARCHAR(20)
	DECLARE @FecAcc DATETIME

	--Inicializar idBitacora
	SELECT @idBit = MAX(idBitacora)
	FROM BitacoraCliente;
	IF @idBit IS NULL
			SELECT @idBit = 1;
	ELSE
		SELECT @idBit = MAX(idBitacora)+1
		FROM BitacoraCliente;

	--Update(Guarda el registro viejo)
    IF EXISTS(SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
 	BEGIN
		SELECT @idCli = idCliente FROM deleted;
		SELECT @Nom 	= Nombre FROM deleted;
		SELECT @APat	= ApellidoPaterno FROM deleted;
		SELECT @AMat	= ApellidoMaterno FROM deleted;
		SELECT @Dir	= Direccion FROM deleted;
		SELECT @Tel	= Telefono FROM deleted;
		SELECT @Email	= Correo FROM deleted;
		SELECT @FecNac	= FechaNacimiento FROM deleted;
		SELECT @RFC	= RFC FROM deleted;
		
		INSERT INTO BitacoraCliente VALUES (@idBit,
			@idCli, @Nom, @APat, @AMat, @Dir,
			@Tel, @Email, @FecNac, @RFC,
			'Updated', SYSDATETIME());
		PRINT 'Log-Update'
	END;
    ELSE IF EXISTS(SELECT * FROM INSERTED)
    --Insert
	BEGIN
	    
	    SELECT @idCli = idCliente FROM inserted;
		SELECT @Nom 	= Nombre FROM inserted;
		SELECT @APat	= ApellidoPaterno FROM inserted;
		SELECT @AMat	= ApellidoMaterno FROM inserted;
		SELECT @Dir	= Direccion FROM inserted;
		SELECT @Tel	= Telefono FROM inserted;
		SELECT @Email	= Correo FROM inserted;
		SELECT @FecNac	= FechaNacimiento FROM inserted;
		SELECT @RFC	= RFC FROM inserted;
		
		INSERT INTO BitacoraCliente VALUES (@idBit,
			@idCli, @Nom, @APat, @AMat, @Dir,
			@Tel, @Email, @FecNac, @RFC,
			'Insert', SYSDATETIME() );
		PRINT 'Log-Insert'
    END;
    --Delete
 	IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT *FROM inserted)
 	BEGIN
	    SELECT @idCli = idCliente FROM deleted;
		SELECT @Nom 	= Nombre FROM deleted;
		SELECT @APat	= ApellidoPaterno FROM deleted;
		SELECT @AMat	= ApellidoMaterno FROM deleted;
		SELECT @Dir	= Direccion FROM deleted;
		SELECT @Tel	= Telefono FROM deleted;
		SELECT @Email	= Correo FROM deleted;
		SELECT @FecNac	= FechaNacimiento FROM deleted;
		SELECT @RFC	= RFC FROM deleted;
		
		INSERT INTO BitacoraCliente VALUES (@idBit,
			@idCli, @Nom, @APat, @AMat, @Dir,
			@Tel, @Email, @FecNac, @RFC,
			'Delete', SYSDATETIME() );
		PRINT 'Log-Delete'
    END;
END;
--UPDATE Clientes SET Correo ='correo@hotmail.com' Where idCliente = 1
--EXEC SP_AltaEmpleado 'Zulema','Hernandez','Salinas','San Jeronimo,CDMX','5531624042','miguel.ro@outlook.com','17/06/1994'
--DELETE FROM Clientes where idCliente = 4


--Parte 7
/*Generar un Stored Procedure SP_AltaFacturaDetalle, tendrá 2 parámetros (NumFactura,
CadenaFacturaDetalle). Generará de uno a n registros, en la tabla FacturaDetalle.
Generará de uno a n registros, en la tabla FacturaDetalle. (2 puntos)*/
CREATE OR ALTER PROCEDURE SP_AltaFacturaDetalle
	@NumFactura INT,
	@CadenaFacturaDetalle VARCHAR(1000)
AS
CREATE TABLE #SplitFacturas(
	DetallesFactura VARCHAR(250))
	
--Cursor Divide las facturas
DECLARE @DetallesFac VARCHAR(250)
DECLARE SplitFactura CURSOR 
FOR SELECT value 
	FROM string_split(@CadenaFacturaDetalle,'|')
OPEN SplitFactura
	FETCH NEXT FROM SplitFactura INTO @DetallesFac

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		PRINT @DetallesFac
		Insert into #SplitFacturas 
			Select * from string_split(@DetallesFac,',')
		
		FETCH NEXT FROM SplitFactura INTO @DetallesFac
	END	
CLOSE SplitFactura
DEALLOCATE SplitFactura

--Cursor Inserta Productos
DECLARE @Prod VARCHAR(30)
DECLARE @Cant INT
DECLARE @Precio DECIMAL(5,2)
DECLARE @Cursor VARCHAR(30)

DECLARE @Cont INT SET @Cont=1
DECLARE @Aux INT
DECLARE @NumDetalle INT

DECLARE InsertaProducto CURSOR SCROLL
FOR SELECT DetallesFactura 
	FROM #SplitFacturas

OPEN InsertaProducto
	FETCH NEXT FROM InsertaProducto
	SELECT @Aux = COUNT(*) From #SplitFacturas
	WHILE @Cont < @Aux
	BEGIN

		
	SELECT @NumDetalle = MAX(NumDetalle)
	FROM FacturaDetalle;
	IF @NumDetalle IS NULL
			SELECT @NumDetalle = 1;
	ELSE
		SELECT @NumDetalle = MAX(NumDetalle)+1
		FROM FacturaDetalle;

		--Selecciona y asigna la el producto
		FETCH ABSOLUTE @Cont FROM InsertaProducto INTO @Cursor;
		SELECT @Prod = @Cursor
		PRINT @Prod
		--Selecciona y convierte al tipo de dato la cantidad
	    FETCH RELATIVE 1 FROM InsertaProducto INTO @Cursor;
		SELECT @Cant = CONVERT(INT,@Cursor)
		PRINT STR(@Cant)
		--Selecciona y convierte al tipo de dato el precio
	    FETCH RELATIVE 1 FROM InsertaProducto INTO @Cursor;
		SELECT @Precio = CONVERT(decimal(5,2),@Cursor)
		PRINT STR(@Precio)
		INSERT INTO FacturaDetalle(NumDetalle, DescripcionProducto,Cantidad,Precio,NumFactura) 
			VALUES (@NumDetalle, @Prod, @Cant, @Precio, @NumFactura)
	    --Incrementa Contador
	    SELECT @Cont = @Cont + 3
		PRINT '-----------------'
	END	
CLOSE InsertaProducto
DEALLOCATE InsertaProducto

DELETE #SplitFacturas
;

--EXEC SP_AltaFacturaDetalle 1,'cuaderno,5,100|lapices,10,9|gomas,50,5'
--Parte 8
/*Integrar el SP_AltaFacturaDetalle, al SP_AltaFacturaMaestro, de tal manera que al ejecutar
el SP_AltaFacturaMaestro, se inserte una factura y sus detalles en FacturaDetalle.*/
CREATE OR ALTER PROCEDURE SP_AltaFacturaMaestroCompeto
	@idCliente INT,
	@CadenaFacturaDetalle VARCHAR(400)
AS
	DECLARE @NumFactura INT
	SELECT @NumFactura = MAX(NumFactura)
	FROM Factura;
	IF @NumFactura IS NULL
			SELECT @NumFactura = 1;
	ELSE
		SELECT @NumFactura = MAX(NumFactura)+1
		FROM Factura;
	
	INSERT INTO Factura	VALUES(@NumFactura,GETDATE(),@idCliente)
	PRINT 'Se agrego la facutura: ' + STR(@NumFactura)+CHAR(10)+
		'Con la siguiente información: ' + CHAR(10)+
		'Cliente: '+ STR(@idCliente) +CHAR(10)+
		'Fecha: ' + CONVERT(varchar, getdate(),23)

	EXEC SP_AltaFacturaDetalle @NumFactura,@CadenaFacturaDetalle
;

EXEC SP_AltaFacturaMaestroCompeto 1,'carro,2,500|juan,6,2';
--Parte 9
/*Generar una transacción que englobe a la factura y los registros de FacturaDetalle*/
CREATE OR ALTER PROCEDURE SP_AltaFacturaMaestroCompetoTrans
	@idCliente INT,
	@CadenaFacturaDetalle VARCHAR(400)
AS
	DECLARE @NumFactura INT
	SELECT @NumFactura = MAX(NumFactura)
	FROM Factura;
	IF @NumFactura IS NULL
			SELECT @NumFactura = 1;
	ELSE
		SELECT @NumFactura = MAX(NumFactura)+1
		FROM Factura;
	BEGIN TRANSACTION
		INSERT INTO Factura	VALUES(@NumFactura,GETDATE(),@idCliente)
		PRINT 'Se agrego la facutura: ' + STR(@NumFactura)+CHAR(10)+
			'Con la siguiente información: ' + CHAR(10)+
			'Cliente: '+ STR(@idCliente) +CHAR(10)+
			'Fecha: ' + CONVERT(varchar, getdate(),23)

		EXEC SP_AltaFacturaDetalle @NumFactura,@CadenaFacturaDetalle
	IF @@error <> 0
	BEGIN
			PRINT 'Hubo un error al realizar la transaccion'
			ROLLBACK
	END
	COMMIT
;


--Parte 10
/*Generar función F_SumaFactura que reciba como parámetro el número de factura y que
regrese el total de esa factura. --500,90,250 = 840*/
CREATE FUNCTION F_SumaFactura(@NoFactura INT)
	RETURNS DECIMAL(5,2) AS
BEGIN
DECLARE @Total DECIMAL(5,2);
		SELECT @Total = SUM(Precio*Cantidad)
		FROM FacturaDetalle
		WHERE NumFactura = @NoFactura;
 RETURN @Total
END;

--Parte 11
/*Generar una vista V_TotalFacturas que sume el total de todas las facturas generadas.
Ejemplo: Factura, MontoTotal*/
CREATE VIEW V_TotalFacturas AS
	SELECT DISTINCT NumFactura AS [Factura],
	dbo.F_SumaFactura(NumFactura) AS [Monto Total]
	FROM FacturaDetalle;
--Datos de prueba
SELECT * FROM Clientes;
SELECT * FROM Factura;
SELECT * FROM FacturaDetalle;
SELECT * FROM BitacoraCliente;
SET DATEFORMAT dmy;
GO
--Prueba SP_AltaEmpleado
EXEC SP_AltaEmpleado 'Miguel','Rojas','Hernandez','San Jeronimo,CDMX','5531624042','miguel.ro@outlook.com','17/06/1994'
EXEC SP_AltaEmpleado 'Juan','Lopez','Ruiz','San Francisco,CDMX','5531655642','juan.loru@outlook.com','19/09/1998'

--Prueba SP_AltaFacturaMaestro @idcliente, @cadenafactura
EXEC SP_AltaFacturaMaestro 1,'cuaderno,5,100|lapices,10,9|gomas,50,5'
EXEC SP_AltaFacturaMaestro 2,'pluma,5,15|sacapuntas,10,3'
EXEC SP_AltaFacturaMaestro 3,'calculadora,2,300'

--Prueba Trigger TR_BitacoraCliente
UPDATE Clientes SET Correo ='correo@hotmail.com' Where idCliente = 1;
EXEC SP_AltaEmpleado 'Zulema','Hernandez','Salinas','San Jeronimo,CDMX','5514454042','zulemahsal@outlook.com','21/09/1993'
DELETE FROM Clientes where idCliente = 2;

--Prueba SP_AltaFacturaDetalle @NumFacura, @cadenafactura
EXEC SP_AltaFacturaDetalle 1,'cuaderno,5,100|lapices,10,9|gomas,50,5'
EXEC SP_AltaFacturaDetalle 2,'pluma,5,15|sacapuntas,10,3'
EXEC SP_AltaFacturaDetalle 3,'calculadora,2,300'

--Prueba Funcion
SELECT dbo.F_SumaFactura(1);
SELECT dbo.F_SumaFactura(2);

--Prueba Vista
SELECT * FROM V_TotalFacturas;

/*
DROP DATABASE pruebas2
*/
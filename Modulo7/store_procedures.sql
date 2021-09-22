-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Scripts de Lalos Burger				Junio, 2021.
-- ***************************************************************

--Procedimiento para ingresar a un nuevo cliente
CREATE PROCEDURE SP_AltaCliente (
	IN nombre VARCHAR(100),
	IN aPaterno VARCHAR(100),
	IN aMaterno VARCHAR(100),
	IN direccion VARCHAR(200),
	IN telefono VARCHAR(15),
	IN correo VARCHAR(100),
    IN contrasenia VARCHAR(255),
	IN fechaNac DATE)
	
	INSERT INTO cliente(cliente_nombre,cliente_apaterno,cliente_amaterno,
                cliente_direccion,cliente_correo,cliente_contrasenia,
                cliente_telefono, cliente_fechaNac) 
        VALUES (nombre, aPaterno, aMaterno, direccion, telefono, correo,contrasenia, fechaNac)
;

--Actualizar los datos del usuario
CREATE PROCEDURE SP_ActualizarCliente(
	in sp_NoCliente int(11),
	in sp_nombre VARCHAR(100),
	in sp_aPaterno VARCHAR(100),
	in sp_aMaterno VARCHAR(100),
	in sp_direccion VARCHAR(200),
    in sp_correo VARCHAR(100),
    in sp_contrasenia VARCHAR(255),
	in sp_telefono VARCHAR(15),
	in sp_fechaNac DATE)
update cliente
	set
    	cliente_nombre = sp_nombre,
    	cliente_apaterno = sp_aPaterno,
    	cliente_amaterno = sp_aMaterno,
    	cliente_direccion = sp_direccion,
    	cliente_correo = sp_correo,
   		cliente_contrasenia = sp_contrasenia,
    	cliente_telefono = sp_telefono,
    	cliente_fechaNac = sp_fechaNac
	where NoCliente = sp_NoCliente
;

CREATE PROCEDURE SP_BorrarCliente(in sp_correo VARCHAR(100))
    delete from cliente where cliente_correo = sp_correo;

--Hice este compa por si el que esta arriba no te funciona por que a mi no me jalaba jajaja
/*
CREATE PROCEDURE SP_AltaCliente(
	in sp_nombre VARCHAR(100),
	in sp_aPaterno VARCHAR(100),
	in sp_aMaterno VARCHAR(100),
	in sp_direccion VARCHAR(200),
    in sp_correo VARCHAR(100),
    in sp_contrasenia VARCHAR(255),
	in sp_telefono VARCHAR(15),
	in sp_fechaNac DATE)
INSERT INTO cliente(cliente_nombre,cliente_apaterno,cliente_amaterno,
                cliente_direccion,cliente_correo,cliente_contrasenia,
                cliente_telefono, cliente_fechaNac) 
	VALUES (sp_nombre, sp_aPaterno, sp_aMaterno, sp_direccion,sp_correo,sp_contrasenia, sp_telefono, sp_fechaNac);
;
*/

-- Creacion de PS para llenar tabla pedidos
-- CURDATE()
CREATE PROCEDURE lb_addPedido ( IN client INT(11),
                                IN code INT(11),
                                IN cant INT(11),
                                IN total FLOAT ) 
    INSERT INTO pedidoDetalle( NoPedido, pedido_fecha, cliente, codigo, cantidad, precioTotal)
    VALUES ( "", CURDATE(), client, code, cant, total);
--
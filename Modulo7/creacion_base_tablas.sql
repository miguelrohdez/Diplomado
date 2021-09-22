-- *********** Facultad de Contaduria y Administracion ***********
-- 					Diplomado de BASES DE DATOS
-- 		Scripts de Lalos Burger				Junio, 2021.
-- ***************************************************************


CREATE DATABASE lalos_burger;

USE lalos_burger;

CREATE TABLE cliente(
    NoCliente INT(11) AUTO_INCREMENT,
    cliente_nombre VARCHAR(100) NOT NULL,
    cliente_apaterno VARCHAR(100) NOT NULL,
    cliente_amaterno VARCHAR(100),
    cliente_direccion VARCHAR(200),
    cliente_correo VARCHAR(100) NOT NULL,
    cliente_contrasenia VARCHAR(255),
    cliente_telefono INT(10) NOT NULL,
    cliente_fechaNac DATE NOT NULL,
    PRIMARY KEY(NoCliente)
    );

CREATE TABLE menu(
    codigo INT(11) AUTO_INCREMENT,
    menu_nombre VARCHAR(100) NOT NULL,
    menu_precio DECIMAL(8,2) NOT NULL,
    menu_tipo VARCHAR(100) NOT NULL,
    menu_descripcion VARCHAR(100) NOT NULL,
    menu_imagen VARCHAR(255),
    PRIMARY KEY(codigo)
    );

/* corregir para hacer una sola 
CREATE TABLE pedido(
    NoPedido INT(11) AUTO_INCREMENT,
    pedido_fecha DATE NOT NULL,
    cliente INT(11) NOT NULL,
    PRIMARY KEY (NoPedido),
    FOREIGN KEY (cliente)
	    REFERENCES cliente(NoCliente)
);

CREATE TABLE pedidoDetalle(
    ticket INT(11) AUTO_INCREMENT,
    producto INT(11),
    cantidad INT(5),
    total DECIMAL(8,2),
    pedido INT(11),
    PRIMARY KEY(ticket),
    FOREIGN KEY(producto)
        REFERENCES menu(codigo),
    FOREIGN KEY (pedido)
        REFERENCES pedido(NoPedido)
);
*/

CREATE TABLE pedidoDetalle(
    NoPedido INT(11) AUTO_INCREMENT,
    pedido_fecha DATE NOT NULL,
    cliente INT(11) NOT NULL,
    codigo INT (11) NOT NULL,
    cantidad INT (11) NOT NULL,
    precioTotal FLOAT NOT NULL,
    PRIMARY KEY (NoPedido),
    FOREIGN KEY (cliente) REFERENCES cliente(NoCliente),
    FOREIGN KEY (codigo) REFERENCES menu(codigo)
);

INSERT INTO `menu` (`codigo`, `menu_nombre`, `menu_precio`, `menu_tipo`, `menu_descripcion`, `menu_imagen`) VALUES
(1, 'Pedido normal', '20.50', 'Menu', 'Hamburguesa sencilla', ' '),
(2, 'Pedido extra', '30.50', 'Menu', 'Hamburguesa con queso', ' '),
(3, 'Pedido pesado', '50.50', 'Menu', 'Hamburguesa doble queso y tosino', ' '),
(4, 'Pedido infarto', '200.50', 'Combo', 'Hamburguesa doble queso, tosino y papas', ' ');
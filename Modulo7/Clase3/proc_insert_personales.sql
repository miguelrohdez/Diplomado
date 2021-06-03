CREATE PROCEDURE Pa_personalesAdd ( IN Nombre VARCHAR( 255 ) , IN Apellidos VARCHAR( 255 ) , IN Direccion VARCHAR( 255 ) , IN Telefono INT( 10 ), IN Edad INT( 2 ), IN Altura DECIMAL(5,2) ) 
INSERT INTO personales( Nombre, Apellidos, Direccion, Telefono, Edad, Altura )
VALUES (Nombre, Apellidos, Direccion, Telefono, Edad, Altura, "");
CALL Pa_personalesAdd ('Raul' , 'Lopez' , 'Pedregal' , 553489442 , 30 , 1.70);

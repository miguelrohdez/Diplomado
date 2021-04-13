
DECLARE @cad VARCHAR(1000);
--SET @cad = 'cuaderno,5,100|lapices,10,9|gomas,50,5'
--SET @cad='carro,2,50|juan,6,2';
SET @cad='calc,60,2';
--select @cad;

declare @delimFactura CHAR(1) 
SET @delimFactura='|'
--select @delimFactura;

/*CREATE TABLE #SplitFalturas(
	DetallesFactura VARCHAR(250))*/


/*CREATE TABLE #Detalle(
	NumDetalle INT,
	DescripcionProducto VARCHAR(30),
	Cantidad INT,
	Precio DECIMAL(5,2),
	NumFactura INT 
)	*/
	
--Cursor Divide las facturas
DECLARE @DetallesFac VARCHAR(250)
DECLARE SplitFactura CURSOR 
FOR SELECT value 
	FROM string_split(@cad,'|')
OPEN SplitFactura
	FETCH NEXT FROM SplitFactura INTO @DetallesFac

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		PRINT @DetallesFac
		Insert into #SplitFalturas 
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

DECLARE InsertaProducto CURSOR SCROLL
FOR SELECT DetallesFactura 
	FROM #SplitFalturas

OPEN InsertaProducto
	FETCH NEXT FROM InsertaProducto
	SELECT @Aux = COUNT(*) From #SplitFalturas
	WHILE @Cont < @Aux
	BEGIN
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
		INSERT INTO #Detalle(DescripcionProducto,Cantidad,Precio) VALUES (@Prod, @Cant, @Precio)
	    --Incrementa Contador
	    SELECT @Cont = @Cont + 3
		PRINT '-----------------'
	END	
CLOSE InsertaProducto
DEALLOCATE InsertaProducto

DELETE #SplitFalturas



--select * from #SplitFalturas
--select * from #Detalle
--delete #Detalle
--delete #SplitFalturas
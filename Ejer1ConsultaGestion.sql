--1. C�digo, fecha y doble del descuento de las facturas con iva cero.
SELECT f.CODFAC, f.FECHA, NVL(f.DTO * 2, 0) AS DOBLEDTO
FROM FACTURAS f
WHERE f.IVA = 0;

--2. C�digo de las facturas con iva nulo.
SELECT f.CODFAC 
FROM FACTURAS f 
WHERE f.IVA IS NULL;

--3. C�digo y fecha de las facturas sin iva (iva cero o nulo).
SELECT f.CODFAC, f.FECHA 
FROM FACTURAS f 
WHERE f.IVA = 0 OR f.IVA IS NULL;

--4. C�digo de factura y de art�culo de las l�neas de factura en las que la cantidad solicitada 
--es menor de 5 unidades y adem�s se ha aplicado un descuento del 25% o mayor.
SELECT lf.CODFAC, lf.CODART
FROM LINEAS_FAC lf
WHERE lf.CANT < 5 AND lf.DTO >= 25;

--5. Obtener la descripci�n de los art�culos cuyo stock est� por debajo del stock m�nimo, 
--dado tambi�n la cantidad en unidades necesaria para alcanzar dicho m�nimo.
SELECT a.DESCRIP, (a.STOCK_MIN - a.STOCK) AS DIFERENCIA 
FROM ARTICULOS a 
WHERE a.STOCK < a.STOCK_MIN;

--6. Ivas distintos aplicados a las facturas.
SELECT DISTINCT NVL(f.IVA, 0) 
FROM FACTURAS f;

--7. C�digo, descripci�n y stock m�nimo de los art�culos de los que se desconoce la cantidad de stock. 
--Cuando se desconoce la cantidad de stock de un art�culo, el stock es nulo.
SELECT a.CODART, a.DESCRIP, a.STOCK_MIN 
FROM ARTICULOS a 
WHERE a.STOCK IS NULL;

--8. Obtener la descripci�n de los art�culos cuyo stock es m�s de tres veces 
--su stock m�nimo y cuyo precio supera los 6 euros.
SELECT a.DESCRIP 
FROM ARTICULOS a 
WHERE a.STOCK > (3 * a.STOCK_MIN) AND a.PRECIO > 6;

--9. C�digo de los art�culos (sin que salgan repetidos) comprados 
--en aquellas facturas cuyo c�digo est� entre 8 y 10.
SELECT DISTINCT lf.CODART 
FROM LINEAS_FAC lf  
WHERE lf.CODFAC BETWEEN 8 AND 10;

--10. Mostrar el nombre y la direcci�n de todos los clientes.
SELECT c.NOMBRE, c.DIRECCION 
FROM CLIENTES c;

--11. Mostrar los distintos c�digos de pueblos en donde tenemos clientes.
SELECT DISTINCT c.CODPUE 
FROM CLIENTES c;

--12. Obtener los c�digos de los pueblos en donde hay clientes con c�digo de 
--cliente menor que el c�digo 25. No deben salir c�digos repetidos.
SELECT DISTINCT c.CODPUE 
FROM CLIENTES c 
WHERE c.CODCLI < 25;

--13. Nombre de las provincias cuya segunda letra es una 'O' (bien may�scula o min�scula).
SELECT p.NOMBRE 
FROM PROVINCIAS p
WHERE UPPER(p.NOMBRE) LIKE '_O%';

--14. C�digo y fecha de las facturas del a�o pasado para aquellos 
--clientes cuyo c�digo se encuentra entre 50 y 100.
SELECT f.CODFAC, f.FECHA 
FROM FACTURAS f
WHERE EXTRACT(YEAR FROM f.FECHA) = EXTRACT(YEAR FROM SYSDATE)-1 AND f.CODCLI BETWEEN  50 AND 100;

--15. Nombre y direcci�n de aquellos clientes cuyo c�digo postal empieza por �12�.
SELECT c.NOMBRE, c.DIRECCION 
FROM CLIENTES c
WHERE c.CODPOSTAL LIKE '12%';

--16. Mostrar las distintas fechas, sin que salgan repetidas, 
--de las factura existentes de clientes cuyos c�digos son menores que 50.
SELECT DISTINCT f.FECHA 
FROM FACTURAS f
WHERE f.CODCLI < 50
AND f.CODCLI IS NOT NULL;

--17. C�digo y fecha de las facturas que se han 
--realizado durante el mes de junio del a�o 2004
SELECT f.CODFAC, f.FECHA 
FROM FACTURAS f
WHERE EXTRACT(MONTH FROM f.FECHA) = 6
AND EXTRACT(YEAR FROM f.FECHA) = 2004;

--18. C�digo y fecha de las facturas que se han realizado durante el mes de junio del a�o 2004 
--para aquellos clientes cuyo c�digo se encuentra entre 100 y 250.
SELECT f.CODFAC, f.FECHA 
FROM FACTURAS f
WHERE EXTRACT(MONTH FROM f.FECHA) = 6
AND EXTRACT(YEAR FROM f.FECHA) = 2004
AND f.CODCLI BETWEEN 100 AND 250;

--19. C�digo y fecha de las facturas para los clientes cuyos c�digos est�n entre 90 y 100 
--y no tienen iva. NOTA: una factura no tiene iva cuando �ste es cero o nulo.
SELECT f.CODFAC, f.FECHA 
FROM FACTURAS f
WHERE f.CODCLI BETWEEN 90 AND 100
AND (f.IVA = 0 OR f.IVA IS NULL);

--20. Nombre de las provincias que terminan con la letra 's' (bien may�scula o min�scula).
SELECT p.NOMBRE 
FROM PROVINCIAS p
WHERE UPPER(p.NOMBRE) LIKE '%S';

--21. Nombre de los clientes cuyo c�digo postal empieza por �02�, �11� � �21�.
SELECT c.NOMBRE
FROM CLIENTES c
WHERE c.CODPOSTAL LIKE '02%'
OR c.CODPOSTAL LIKE '11%'
OR c.CODPOSTAL LIKE '21%';

--22. Art�culos (todas las columnas) cuyo stock sea mayor que el stock m�nimo  
--y no haya en stock m�s de 5 unidades del stock_min.
SELECT a.*
FROM ARTICULOS a
WHERE a.STOCK > a.STOCK_MIN
AND (a.STOCK - a.STOCK_MIN) BETWEEN 1 AND 5;

--23. Nombre de las provincias que contienen el texto �MA� (bien may�sculas o min�sculas).
SELECT p.NOMBRE 
FROM PROVINCIAS p
WHERE UPPER(p.NOMBRE) LIKE '%MA%';

--24. Se desea promocionar los art�culos de los que se posee un stock grande. 
--Si el art�culo es de m�s de 6000 � y el stock supera los 60000 �, se har� un descuento del 10%.
--Mostrar un listado de los art�culos que van a entrar en la promoci�n, con su c�digo de art�culo, 
--nombre del articulo, precio actual y su precio en la promoci�n.
SELECT a.CODART, a.DESCRIP, a.PRECIO, a.PRECIO * 0.1 AS PRECIODESCUENTO
FROM ARTICULOS a
WHERE a.STOCK * a.PRECIO > 60000
AND a.PRECIO > 6000;




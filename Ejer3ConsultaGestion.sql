--1. Descuento medio aplicado en las facturas.
SELECT AVG(f.DTO)
FROM FACTURAS f;

--2. Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(f.DTO)
FROM FACTURAS f
WHERE f.DTO IS NOT NULL;

--3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT AVG(NVL(f.DTO,0))
FROM FACTURAS f;

--4. N�mero de facturas.
SELECT COUNT(f.CODFAC)
FROM FACTURAS f;

--5. N�mero de pueblos de la Comunidad de Valencia.
SELECT COUNT(p.CODPUE)
FROM PUEBLOS p 
WHERE p.CODPRO IN (03,12,46);

--6.Importe total de los art�culos que tenemos en el almac�n. 
--Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(a.STOCK * a.PRECIO) AS IMPORTE_TOTAL
FROM ARTICULOS a;

--7. N�mero de pueblos en los que residen clientes cuyo c�digo postal empieza por �12�.
SELECT COUNT(c.CODPUE)
FROM CLIENTES c
WHERE c.CODPOSTAL LIKE '12%';

--8. Valores m�ximo y m�nimo del stock de los art�culos cuyo precio oscila entre 9 y 12 � y diferencia entre ambos valores
SELECT MAX(a.STOCK), MIN(a.STOCK), MAX(a.STOCK) - MIN(a.STOCK) AS DIFERENCIA
FROM ARTICULOS a 
WHERE a.PRECIO BETWEEN 9 AND 12;

--9. Precio medio de los art�culos cuyo stock supera las 10 unidades.
SELECT AVG(NVL(a.PRECIO,0))
FROM ARTICULOS a 
WHERE a.STOCK > 10;

--10. Fecha de la primera y la �ltima factura del cliente con c�digo 210.
SELECT MAX(f.FECHA), MIN(f.FECHA) 
FROM FACTURAS f
WHERE f.CODCLI = 210;

--11. N�mero de art�culos cuyo stock es nulo.
SELECT COUNT(a.CODART)
FROM ARTICULOS a 
WHERE a.STOCK IS NULL;

--12. N�mero de l�neas cuyo descuento es nulo (con un decimal)
SELECT ROUND(COUNT(f.DTO),1)
FROM FACTURAS f 
WHERE f.DTO IS NULL;

--13. Obtener cu�ntas facturas tiene cada cliente.
SELECT COUNT(f.CODFAC), f.CODCLI 
FROM FACTURAS f
GROUP BY f.CODCLI;

--14. Obtener cu�ntas facturas tiene cada cliente, pero s�lo si tiene dos o m�s facturas.
SELECT COUNT(f.CODFAC), f.CODCLI 
FROM FACTURAS f
GROUP BY f.CODCLI
HAVING COUNT(f.CODFAC) >= 2;

--15. Importe de la facturaci�n (suma del producto de la cantidad por el precio de las l�neas de factura) de los art�culos.
SELECT SUM(lf.CANT * lf.PRECIO)
FROM LINEAS_FAC lf;

--16. Importe de la facturaci�n (suma del producto de la cantidad por el precio de las l�neas de factura)
--de aquellos art�culos cuyo c�digo contiene la letra �A� (bien may�scula o min�scula).
SELECT SUM(lf.CANT * lf.PRECIO)
FROM LINEAS_FAC lf
WHERE lf.CODART LIKE '%A%'
OR lf.CODART LIKE '%a%';

--17. N�mero de facturas para cada fecha, junto con la fecha
SELECT f.FECHA, COUNT(f.CODFAC)
FROM FACTURAS f
GROUP BY f.FECHA;

--18. Obtener el n�mero de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que m�s clientes tengan.
SELECT COUNT(c.CODCLI), p.NOMBRE 
FROM PUEBLOS p, CLIENTES c
WHERE p.CODPUE = c.CODPUE
GROUP BY p.NOMBRE
ORDER BY COUNT(c.CODCLI) DESC;

--19. Obtener el n�mero de clientes del pueblo junto con el nombre del pueblo mostrando 
--primero los pueblos que m�s clientes tengan, siempre y cuando tengan m�s de dos clientes.
SELECT COUNT(c.CODCLI), p.NOMBRE 
FROM PUEBLOS p, CLIENTES c
WHERE p.CODPUE = c.CODPUE
GROUP BY p.NOMBRE
HAVING COUNT(c.CODCLI) > 2
ORDER BY COUNT(c.CODCLI) DESC;

--20. Cantidades totales vendidas para cada art�culo cuyo c�digo empieza por �P", mostrando tambi�n la descripci�n de dicho art�culo
SELECT COUNT(a.CODART), a.DESCRIP 
FROM ARTICULOS a
WHERE a.CODART LIKE 'P%'
GROUP BY a.DESCRIP;

--21. Precio m�ximo y precio m�nimo de venta (en l�neas de facturas) para cada art�culo cuyo c�digo empieza por �c�.
SELECT MAX(lf.PRECIO), MIN(lf.PRECIO) 
FROM LINEAS_FAC lf 
WHERE lf.CODART LIKE 'c%';

--22. Igual que el anterior pero mostrando tambi�n la diferencia entre el precio m�ximo y m�nimo.
SELECT MAX(lf.PRECIO), MIN(lf.PRECIO), MAX(lf.PRECIO) - MIN(lf.PRECIO) AS DIFERENCIA
FROM LINEAS_FAC lf 
WHERE lf.CODART LIKE 'c%';

--23. Nombre de aquellos art�culos de los que se ha facturado m�s de 10000 euros.
SELECT a.DESCRIP 
FROM LINEAS_FAC lf, ARTICULOS a 
WHERE lf.CODART = a.CODART AND lf.PRECIO > 10000;

--24. N�mero de facturas de cada uno de los clientes cuyo c�digo est� entre 150 y 300 (se debe mostrar este c�digo), con cada IVA distinto que se les ha aplicado.
SELECT DISTINCT f.IVA, COUNT(f.CODFAC)
FROM FACTURAS f 
WHERE f.CODCLI BETWEEN 150 AND 300
GROUP BY f.IVA;

--25. Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.
SELECT AVG(lf.PRECIO)
FROM LINEAS_FAC lf; 



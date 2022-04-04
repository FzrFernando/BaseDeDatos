--1.	Mostrar el nombre de los clientes junto al nombre de su pueblo.
SELECT DISTINCT C.NOMBRE, A.DESCRIP  
FROM CLIENTES C, ARTICULOS A, FACTURAS F, LINEAS_FAC L
WHERE C.CODCLI = F.CODCLI 
AND F.CODFAC = L.CODFAC 
AND L.CODART = A.CODART;

--2.	Mostrar el nombre de los pueblos junto con el nombre de la provincia correspondiente.
SELECT DISTINCT PU.NOMBRE,PRO.NOMBRE 
FROM PUEBLOS PU ,PROVINCIAS PRO 
WHERE PRO.CODPRO=PU.CODPRO;

--3.	Mostrar el nombre de los clientes junto al nombre de su pueblo y el de su provincia.
SELECT DISTINCT C.NOMBRE,PU.NOMBRE,PRO.NOMBRE 
FROM CLIENTES C , PUEBLOS PU,PROVINCIAS PRO 
WHERE PRO.CODPRO=PU.CODPRO 
AND PU.CODPUE=C.CODPUE;

--4.	Nombre de las provincias donde residen clientes sin que salgan valores repetidos.
SELECT DISTINCT PRO.NOMBRE 
FROM CLIENTES C , PUEBLOS PU,PROVINCIAS PRO
WHERE PRO.CODPRO=PU.CODPRO 
AND PU.CODPUE=C.CODPUE;

--5.	Mostrar la descripci�n de los art�culos que se han vendido en una cantidad superior a 10 unidades. 
--Si un art�culo se ha vendido m�s de una vez en una cantidad superior a 10 s�lo debe salir una vez.
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A ,LINEAS_FAC L  
WHERE A.CODART=L.CODART 
AND L.CANT>10;

--6.	Mostrar la fecha de factura junto con el c�digo del art�culo y la cantidad vendida por cada art�culo 
--vendido en alguna factura. Los datos deben salir ordenado por fecha, primero las m�s reciente,
-- luego por el c�digo del art�culos, y si el mismo art�culo se ha vendido varias veces en la misma fecha los m�s vendidos primero.
SELECT DISTINCT F.FECHA ,A.CODART,L.CANT 
FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F 
WHERE A.CODART=L.CODART 
AND L.CODFAC=F.CODFAC
ORDER BY F.FECHA DESC,A.CODART,L.CANT ASC; 

--7.	Mostrar el c�digo de factura y la fecha de las mismas de las facturas que se han facturado a un cliente que tenga en su c�digo postal un 7.
SELECT F.CODFAC,F.FECHA FROM FACTURAS F , CLIENTES C
WHERE F.CODCLI=C.CODCLI
AND  CODPOSTAL LIKE '%7%';

--8.	Mostrar el c�digo de factura, la fecha y el nombre del cliente de todas las facturas existentes en la base de datos.
SELECT DISTINCT  F.CODFAC,F.FECHA,C.NOMBRE 
FROM FACTURAS F ,CLIENTES C 
WHERE F.CODCLI=C.CODCLI;

--9.	Mostrar un listado con el c�digo de la factura, la fecha, el iva, el dto y el nombre del cliente
-- para aquellas facturas que o bien no se le ha cobrado iva (no se ha cobrado iva si el iva es nulo o cero), o bien el descuento es nulo.
SELECT DISTINCT F.CODFAC,F.FECHA,F.IVA,F.DTO,C.NOMBRE
FROM FACTURAS F, CLIENTES C 
WHERE F.CODCLI=C.CODCLI 
AND (IVA IS NULL OR IVA=0) OR DTO IS NULL;

--10.	Se quiere saber que art�culos se han vendido m�s baratos que el precio que actualmente tenemos almacenados en la tabla de art�culos, 
--para ello se necesita mostrar la descripci�n de los art�culos junto con el precio actual. 
--Adem�s deber� aparecer el precio en que se vendi� si este precio es inferior al precio original.
SELECT DISTINCT A.DESCRIP ,A.PRECIO,L.PRECIO,L.PRECIO
FROM ARTICULOS A,LINEAS_FAC L 
WHERE L.CODART=A.CODART
AND L.PRECIO<A.PRECIO;

--11.	Mostrar el c�digo de las facturas, junto a la fecha, iva y descuento. 
--Tambi�n debe aparecer la descripci�n de los art�culos vendido junto al precio de venta, la cantidad y el descuento de ese art�culo,
-- para todos los art�culos que se han vendido.
SELECT DISTINCT F.CODFAC,F.FECHA,F.IVA,F.DTO,A.DESCRIP,L.PRECIO,L.CANT,L.DTO
FROM FACTURAS F ,LINEAS_FAC L , ARTICULOS A 
WHERE F.CODFAC=L.CODFAC
AND L.CODART=A.CODART;

--12.	Igual que el anterior, pero mostrando tambi�n el nombre del cliente al que se le ha vendido el art�culo.
SELECT F.CODFAC,F.FECHA,F.IVA,F.DTO,A.DESCRIP,L.PRECIO,L.CANT,L.DTO,C.NOMBRE
FROM FACTURAS F, LINEAS_FAC L, ARTICULOS A, CLIENTES C
WHERE C.CODCLI=F.CODCLI
AND F.CODFAC=L.CODFAC
AND L.CODART=A.CODART;

--13.	Mostrar los nombres de los clientes que viven en una provincia que contenga la letra ma.
SELECT C.NOMBRE 
FROM CLIENTES C,PUEBLOS PU,PROVINCIAS PRO 
WHERE C.CODPUE=PU.CODPUE
AND PU.CODPRO=PRO.CODPRO
AND UPPER(PRO.NOMBRE) LIKE '%MA%';

--14.	Mostrar el c�digo del cliente al que se le ha vendido un art�culo que tienen un stock menor al stock m�nimo.
SELECT F.CODCLI 
FROM FACTURAS F,LINEAS_FAC L,ARTICULOS A 
WHERE  F.CODFAC=L.CODFAC
AND L.CODART=A.CODART
AND NVL(A.STOCK,0)<NVL(A.STOCK_MIN,0);

--15.	Mostrar el nombre de todos los art�culos que se han vendido alguna vez. (no deben salir valores repetidos)
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A,LINEAS_FAC L
WHERE A.CODART=L.CODART
AND L.CANT>1;

--16.	Se quiere saber el precio real al que se ha vendido cada vez los art�culos. Para ello es necesario mostrar el nombre del art�culo,
-- junto con el precio de venta (no el que est� almacenado en la tabla de art�culos) menos el descuento aplicado en la l�nea de descuento.
SELECT DISTINCT A.DESCRIP,L.PRECIO-(L.PRECIO * L.DTO / 100) 
FROM ARTICULOS A ,LINEAS_FAC L
WHERE L.CODART=A.CODART;       

--17.	Mostrar el nombre de los art�culos que se han vendido a clientes que vivan en una provincia cuyo nombre termina  por a.
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F, CLIENTES C ,PUEBLOS PU,PROVINCIAS PRO 
WHERE A.CODART=L.CODART
AND L.CODFAC=F.CODFAC
AND F.CODCLI=C.CODCLI
AND C.CODPUE=PU.CODPUE
AND PU.CODPRO=PRO.CODPRO
AND UPPER(PRO.NOMBRE) LIKE '%A';

--18.	Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas.
SELECT DISTINCT C.NOMBRE 
FROM CLIENTES C, FACTURAS F 
WHERE C.CODCLI=F.CODCLI 
AND  F.DTO>10; 

--19.	Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna 
--de sus facturas o en alguna de las l�neas que componen la factura o en ambas.
SELECT DISTINCT C.NOMBRE
FROM CLIENTES C,FACTURAS F,LINEAS_FAC L  
WHERE C.CODCLI=F.CODCLI 
AND F.CODFAC=L.CODFAC 
AND(F.DTO>10  OR L.DTO>10)
OR (F.DTO>10 AND L.DTO>10);

--20.	Mostrar la descripci�n, la cantidad y el precio de venta de los art�culos vendidos al cliente con nombre MARIA MERCEDES
SELECT A.DESCRIP ,L.CANT,A.PRECIO FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F,CLIENTES C
WHERE A.CODART=L.CODART 
AND L.CODFAC=F.CODFAC 
AND F.CODCLI=C.CODCLI 
AND UPPER(C.NOMBRE) LIKE '%MARIA MERCEDES%';



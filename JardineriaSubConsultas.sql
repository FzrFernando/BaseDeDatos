--Consultas multitabla (composición interna)
--1. Obtén un listado con el nombre de cada cliente y el nombre 
--y apellido de su representante de ventas.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, e.APELLIDO1 
FROM CLIENTE c, EMPLEADO e
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;

--2. Muestra el nombre de los clientes que hayan realizado pagos junto 
--con el nombre de sus representantes de ventas.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE 
FROM CLIENTE c, EMPLEADO e, PAGO p 
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;

--3. Muestra el nombre de los clientes que no hayan realizado pagos junto con 
--el nombre de sus representantes de ventas.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE 
FROM CLIENTE c, EMPLEADO e
WHERE c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE
								FROM CLIENTE c2, PAGO p
								WHERE c2.CODIGO_CLIENTE = p.CODIGO_CLIENTE)
AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;

--4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto 
--con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD 
FROM CLIENTE c, EMPLEADO e, PAGO p, OFICINA o 
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;

--5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes 
--junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD 
FROM CLIENTE c, EMPLEADO e, OFICINA o
WHERE c.CODIGO_CLIENTE != p.CODIGO_CLIENTE 
AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;

--6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT o.LINEA_DIRECCION1, o.LINEA_DIRECCION2 
FROM OFICINA o, EMPLEADO e, CLIENTE c
WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA 
AND e.CODIGO_EMPLEADO = c.CODIGO_EMPLEADO_REP_VENTAS 
AND UPPER(c.CIUDAD) LIKE 'FUENLABRADA';

--7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la 
--ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD 
FROM OFICINA o, EMPLEADO e, CLIENTE c
WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA 
AND e.CODIGO_EMPLEADO = c.CODIGO_EMPLEADO_REP_VENTAS; 

--8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT e.NOMBRE, e2.NOMBRE AS JEFE
FROM EMPLEADO e, EMPLEADO e2
WHERE e.CODIGO_EMPLEADO = e2.CODIGO_JEFE;

--9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.NOMBRE_CLIENTE 
FROM CLIENTE c, PEDIDO p 
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND p.FECHA_ENTREGA > p.FECHA_ESPERADA;

--10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT p.GAMA 
FROM PRODUCTO p, DETALLE_PEDIDO dp, PEDIDO p2, CLIENTE c 
WHERE p.CODIGO_PRODUCTO = dp.CODIGO_PRODUCTO 
AND dp.CODIGO_PEDIDO = p2.CODIGO_PEDIDO 
AND p2.CODIGO_CLIENTE = c.CODIGO_CLIENTE;


--Consultas multitabla (composición externa)
--1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c, PAGO p 
WHERE c.CODIGO_CLIENTE != p.CODIGO_CLIENTE;

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PEDIDO P
WHERE C.CODIGO_CLIENTE<>P.CODIGO_CLIENTE;

--3 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PAGO PA,PEDIDO P
WHERE C.CODIGO_CLIENTE<>P.CODIGO_CLIENTE
AND C.CODIGO_CLIENTE<>PA.CODIGO_CLIENTE;

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT DISTINCT E.NOMBRE
FROM EMPLEADO E,OFICINA O
WHERE E.CODIGO_OFICINA<>O.CODIGO_OFICINA;

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT DISTINCT E.NOMBRE
FROM EMPLEADO E
WHERE E.CODIGO_EMPLEADO  NOT IN (SELECT C.CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE C);

--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT DISTINCT E.NOMBRE
FROM EMPLEADO E,OFICINA O,CLIENTE C
WHERE E.CODIGO_OFICINA<>O.CODIGO_OFICINA
AND C.CODIGO_EMPLEADO_REP_VENTAS<>E.CODIGO_EMPLEADO; 

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido
SELECT DISTINCT P.NOMBRE
FROM PRODUCTO P
WHERE P.CODIGO_PRODUCTO NOT IN (SELECT dp.CODIGO_PRODUCTO FROM DETALLE_PEDIDO dp);

--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los 
--representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT DISTINCT  O.CODIGO_OFICINA
FROM OFICINA O , EMPLEADO E ,CLIENTE C ,PEDIDO P ,DETALLE_PEDIDO DP,PRODUCTO PR
WHERE O.CODIGO_OFICINA<>E.CODIGO_OFICINA
AND E.CODIGO_EMPLEADO=C.CODIGO_EMPLEADO_REP_VENTAS
AND C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
AND P.CODIGO_PEDIDO=DP.CODIGO_PEDIDO
AND DP.CODIGO_PRODUCTO=PR.CODIGO_PRODUCTO
AND UPPER(PR.GAMA) LIKE 'FRUTALES';

--9 Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.
SELECT DISTINCT C.NOMBRE_CLIENTE
FROM CLIENTE C,PAGO PA,PEDIDO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
AND C.CODIGO_CLIENTE<>PA.CODIGO_CLIENTE;

--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT E.NOMBRE,C.NOMBRE_CONTACTO
FROM EMPLEADO E , CLIENTE C
WHERE E.CODIGO_EMPLEADO<>C.CODIGO_EMPLEADO_REP_VENTAS;


--Consultas resumen
--1 ¿Cuántos empleados hay en la compañía?
SELECT DISTINCT  COUNT (NVL(E.NOMBRE,0)) FROM EMPLEADO E;

--2 ¿Cuántos clientes tiene cada país?
SELECT COUNT(C.NOMBRE_CLIENTE), C.PAIS
FROM CLIENTE C
GROUP BY C.PAIS;

--3 ¿Cuál fue el pago medio en 2009?
SELECT AVG(P.TOTAL) FROM PAGO P
WHERE EXTRACT(YEAR FROM P.FECHA_PAGO)=2009;

--4 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT COUNT(P.CODIGO_PEDIDO), P.ESTADO
FROM PEDIDO P
GROUP BY P.ESTADO
ORDER BY COUNT(P.CODIGO_PEDIDO) DESC;

--5 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(PRECIO_VENTA), MIN(PRECIO_VENTA) FROM PRODUCTO;

--6 Calcula el número de clientes que tiene la empresa.
SELECT DISTINCT  COUNT (NVL(C.NOMBRE_CLIENTE,0)) FROM CLIENTE C;

--7 ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(C.NOMBRE_CLIENTE), C.CIUDAD
FROM CLIENTE C
WHERE UPPER(C.CIUDAD) LIKE 'MADRID'
GROUP BY C.CIUDAD;

--8 ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT COUNT(C.NOMBRE_CLIENTE), C.CIUDAD
FROM CLIENTE C
WHERE UPPER(C.CIUDAD) LIKE 'M%'
GROUP BY C.CIUDAD;

--9 Devuelve el código de empleado y el número de clientes al que atiende cada representante de ventas.
SELECT C.CODIGO_EMPLEADO_REP_VENTAS ,COUNT(C.NOMBRE_CLIENTE)
FROM CLIENTE C
GROUP BY C.CODIGO_EMPLEADO_REP_VENTAS ;

--10 Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(C.NOMBRE_CLIENTE)
FROM CLIENTE C
WHERE C.CODIGO_EMPLEADO_REP_VENTAS IS NULL;

--11 Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
SELECT MIN(P.FECHA_PEDIDO) ,MAX(P.FECHA_PEDIDO) FROM PEDIDO P
GROUP BY P.CODIGO_CLIENTE;

--12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT DISTINCT COUNT(P.CODIGO_PRODUCTO) FROM PRODUCTO P,DETALLE_PEDIDO DP
WHERE P.CODIGO_PRODUCTO=DP.CODIGO_PRODUCTO
GROUP BY DP.CODIGO_PEDIDO;

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT SUM(DP.CANTIDAD) FROM DETALLE_PEDIDO DP
GROUP BY DP.CODIGO_PEDIDO;

--14 Devuelve un listado de los 20 códigos de productos más vendidos y el número total de unidades que se han vendido de cada uno.
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT MAX(DP.CANTIDAD),SUM(DP.CANTIDAD) FROM DETALLE_PEDIDO DP
GROUP BY DP.CODIGO_PEDIDO
ORDER BY SUM(DP.CANTIDAD);

--15 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible,
-- el IVA y el total facturado. La base imponible se calcula sumando 
--el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS BASE_IMPONIBLE,(SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD))*0.21+ SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS IVA 
FROM DETALLE_PEDIDO DP;

--16 La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS BASE_IMPONIBLE,(SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD))*0.21+ SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS IVA
FROM DETALLE_PEDIDO DP
GROUP BY DP.CODIGO_PRODUCTO;

--17 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
SELECT SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS BASE_IMPONIBLE,(SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD))*0.21+ SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD)  AS IVA
FROM DETALLE_PEDIDO DP
WHERE UPPER(DP.CODIGO_PRODUCTO) LIKE 'OR%'
GROUP BY DP.CODIGO_PRODUCTO;

--18 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
SELECT COUNT(DP.CANTIDAD), P.NOMBRE ,(SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD))*0.21+ SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD) AS TOTAL_FACTURADO
FROM PRODUCTO P, DETALLE_PEDIDO DP
WHERE DP.CODIGO_PRODUCTO=P.CODIGO_PRODUCTO
GROUP BY P.NOMBRE
HAVING COUNT(DP.CANTIDAD) > 3000;


--Subconsultas
--1 Devuelve el nombre del cliente con mayor límite de crédito.
SELECT NOMBRE_CLIENTE 
FROM CLIENTE
WHERE LIMITE_CREDITO = (SELECT MAX(LIMITE_CREDITO) FROM CLIENTE);

--2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT NOMBRE,APELLIDO1,PUESTO 
FROM EMPLEADO 
WHERE CODIGO_EMPLEADO_REP_VENTAS=(SELECT NOMBRE  FROM EMPLEADO WHERE CODIGO_JEFE IS NULL);

--3 Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT NOMBRE 
FROM PRODUCTO 
WHERE PRECIO_VENTA=(SELECT MAX(PRECIO_VENTA) FROM PRODUCTO);

--4 Devuelve el nombre del producto del que se han vendido más unidades. 
--(Ten en cuenta que tendrás que calcular cuál es el número total de unidades 
--que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido.
-- Una vez que sepas cuál es el código del producto, puedes obtener su nombre fácilmente.)
SELECT NOMBRE
FROM PRODUCTO
WHERE CODIGO_PRODUCTO=(SELECT CODIGO_PRODUCTO FROM DETALLE_PEDIDO WHERE MAX(CANTIDAD));

--5 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado.
SELECT NOMBRE_CLIENTE
FROM CLIENTE c
WHERE LIMITE_CREDITO > (SELECT SUM(TOTAL) FROM PAGO p WHERE p.CODIGO_CLIENTE = c.CODIGO_CLIENTE);

--6 El producto que más unidades tiene en stock y el que menos unidades tiene.
SELECT NOMBRE
FROM PRODUCTO
WHERE CANTIDAD_EN_STOCK = (SELECT MAX(CANTIDAD_EN_STOCK ),MIN(CANTIDAD_EN_STOCK) FROM PRODUCTO);

--7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.
SELECT NOMBRE,APELLIDO1,APELLIDO2,EMAIL
FROM EMPLEADO e
WHERE e.CODIGO_JEFE=(SELECT e2.CODIGO_EMPLEADO  
					FROM EMPLEADO e2 
					WHERE UPPER(e2.NOMBRE) LIKE '%ALBERTO%'
					AND UPPER(e2.APELLIDO1) LIKE '%SORIA%');


--Consultas variadas
--1 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
SELECT  C.NOMBRE_CLIENTE,DP.CANTIDAD FROM CLIENTE C ,PEDIDO P ,DETALLE_PEDIDO DP
WHERE (C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
AND P.CODIGO_PEDIDO=DP.CODIGO_PEDIDO) OR C.CODIGO_CLIENTE<>P.CODIGO_CLIENTE;

--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
SELECT C.NOMBRE_CLIENTE,P.TOTAL FROM CLIENTE C, PAGO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
OR C.CODIGO_CLIENTE<>P.CODIGO_CLIENTE;

--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT C.NOMBRE_CLIENTE FROM CLIENTE C,PEDIDO P
WHERE C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
AND EXTRACT(YEAR FROM FECHA_PEDIDO)=2008
ORDER BY C.NOMBRE_CLIENTE DESC;

--4 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y
-- el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
SELECT DISTINCT C.NOMBRE_CLIENTE,C.NOMBRE_CONTACTO,C.APELLIDO_CONTACTO,O.TELEFONO FROM EMPLEADO E , OFICINA O,CLIENTE C,PAGO P
WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND E.CODIGO_EMPLEADO=C.CODIGO_EMPLEADO_REP_VENTAS
AND C.CODIGO_CLIENTE<>P.CODIGO_CLIENTE;

--5 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y
-- primer apellido de su representante de ventas y la ciudad donde esta? su oficina.
SELECT DISTINCT C.NOMBRE_CLIENTE,C.NOMBRE_CONTACTO,C.APELLIDO_CONTACTO,O.CIUDAD FROM EMPLEADO E , OFICINA O,CLIENTE C
WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND E.CODIGO_EMPLEADO=C.CODIGO_EMPLEADO_REP_VENTAS;

--6 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados 
--que no sean representante de ventas de ningún cliente.
SELECT DISTINCT E.NOMBRE,E.APELLIDO1,E.APELLIDO2,E.PUESTO,O.TELEFONO FROM EMPLEADO E , OFICINA O,CLIENTE C
WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
AND E.CODIGO_EMPLEADO<>C.CODIGO_EMPLEADO_REP_VENTAS;

--7 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT COUNT(E.CODIGO_EMPLEADO) ,O.CIUDAD
FROM EMPLEADO E,OFICINA O
WHERE E.CODIGO_OFICINA=O.CODIGO_OFICINA
GROUP BY O.CIUDAD;





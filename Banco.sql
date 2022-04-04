--1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria con dos decimales y
--suma de los saldos de todas las cuentas bancarias.
SELECT ROUND(AVG(c.SALDO),2), SUM(c.SALDO) 
FROM CUENTA c;

--2. Mostrar el saldo m�nimo, m�ximo y medio de todas las cuentas bancarias.
SELECT MIN(c.SALDO), MAX(c.SALDO), AVG(c.SALDO)
FROM CUENTA c;

--3. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias por cada
--c�digo de sucursal.
SELECT SUM(c.SALDO), AVG(NVL(c.SALDO,0))
FROM CUENTA c
GROUP BY c.COD_SUCURSAL;

--4. Para cada cliente del banco se desea conocer su c�digo, la cantidad total que tiene
--depositada en la entidad y el n�mero de cuentas abiertas.
SELECT COD_CLIENTE, SUM(SALDO), COUNT(COD_CUENTA) 
FROM CUENTA 
GROUP BY COD_CLIENTE;

--5. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en
--vez de su c�digo de cliente.
SELECT c.NOMBRE, c.APELLIDOS, SUM(c2.SALDO), COUNT(c2.COD_CUENTA) 
FROM CLIENTE c, CUENTA c2
WHERE c.COD_CLIENTE = c2.COD_CLIENTE
GROUP BY c.NOMBRE, c.APELLIDOS;

--6. Para cada sucursal del banco se desea conocer su direcci�n, el n�mero de cuentas que
--tiene abiertas y la suma total que hay en ellas.
SELECT s.DIRECCION, COUNT(c.COD_CUENTA), SUM(c.SALDO)  
FROM SUCURSAL s, CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL
GROUP BY s.DIRECCION;

--7. Mostrar el saldo medio y el inter�s medio de las cuentas a las que se le aplique un
--inter�s mayor del 10%, de las sucursales 1 y 2.
SELECT AVG(c.SALDO), AVG(c.INTERES) 
FROM SUCURSAL s, CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
AND c.INTERES > 10
AND s.COD_SUCURSAL = 1 OR s.COD_SUCURSAL = 2;

--8. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el
--volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT tm.COD_TIPO_MOVIMIENTO, tm.DESCRIPCION, SUM(m.IMPORTE) 
FROM TIPO_MOVIMIENTO tm, MOVIMIENTO m
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO
GROUP BY tm.COD_TIPO_MOVIMIENTO, tm.DESCRIPCION;

--9. Mostrar cu�l es la cantidad media que los clientes de nuestro banco tienen en el
--ep�grafe �Retirada por cajero autom�tico�
SELECT AVG(m.IMPORTE)
FROM TIPO_MOVIMIENTO tm, MOVIMIENTO m
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO
AND tm.DESCRIPCION LIKE 'Retirada por cajero autom�tico';

--10. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada seg�n los
--tipos de movimientos de salida.
SELECT SUM(m.IMPORTE)
FROM MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND tm.SALIDA LIKE 'Si';

--11. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada seg�n
--los tipos de movimientos de entrada mostrando adem�s la descripci�n del tipo de
--movimiento.
SELECT SUM(m.IMPORTE), tm.DESCRIPCION 
FROM MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND tm.SALIDA LIKE 'No'
GROUP BY tm.DESCRIPCION;

--12. Calcular la cantidad total de dinero que sale de la sucursal de Paseo Castellana.
SELECT SUM(m.IMPORTE)
FROM TIPO_MOVIMIENTO tm, MOVIMIENTO m, CUENTA c, SUCURSAL s
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO 
AND m.COD_CUENTA = c.COD_CUENTA AND c.COD_SUCURSAL = s.COD_SUCURSAL 
AND UPPER(s.DIRECCION) LIKE '%PASEO CASTELLANA%'
AND tm.SALIDA LIKE 'No';

--13. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes
--del banco. Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta,
--descripci�n del tipo movimiento y el total acumulado de los movimientos de un
--mismo tipo.
SELECT c2.APELLIDOS, c2.NOMBRE, c.COD_CUENTA, tm.DESCRIPCION, COUNT(tm.COD_TIPO_MOVIMIENTO) 
FROM TIPO_MOVIMIENTO tm, MOVIMIENTO m, CUENTA c, CLIENTE c2
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO 
AND m.COD_CUENTA = c.COD_CUENTA AND c.COD_CLIENTE = c2.COD_CLIENTE
GROUP BY c2.APELLIDOS, c2.NOMBRE, c.COD_CUENTA, tm.DESCRIPCION;

--14. Contar el n�mero de cuentas bancarias que no tienen asociados movimientos.
SELECT COUNT(c.COD_CUENTA) 
FROM CUENTA c, MOVIMIENTO m
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO IS NULL;

--15. Por cada cliente, contar el n�mero de cuentas bancarias que posee sin movimientos. Se
--deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento
SELECT c.COD_CLIENTE, COUNT(c2.COD_CUENTA) AS num_cuentas_sin_movimiento
FROM CLIENTE c, CUENTA c2, MOVIMIENTO m 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
AND c2.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO IS NULL
GROUP BY c.COD_CLIENTE;

--16. Mostrar el c�digo de cliente, la suma total del dinero de todas sus cuentas y el n�mero
--de cuentas abiertas, s�lo para aquellos clientes cuyo capital supere los 35.000 euros.
SELECT c.COD_CLIENTE, SUM(c2.SALDO), COUNT(c2.COD_CUENTA)
FROM CLIENTE c, CUENTA c2
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
AND c2.SALDO > 35000
GROUP BY c.COD_CLIENTE;

--17. Mostrar los apellidos, el nombre y el n�mero de cuentas abiertas s�lo de aquellos
--clientes que tengan m�s de 2 cuentas.
SELECT c.APELLIDOS, c.NOMBRE, COUNT(c2.COD_CUENTA) 
FROM CLIENTE c, CUENTA c2 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
GROUP BY c.APELLIDOS, c.NOMBRE
HAVING COUNT(c2.COD_CUENTA) > 2;

--18. Mostrar el c�digo de sucursal, direcci�n, capital del a�o anterior y la suma de los
--saldos de sus cuentas, s�lo de aquellas sucursales cuya suma de los saldos de las
--cuentas supera el capital del a�o anterior ordenadas por sucursal
SELECT s.*, SUM(c.SALDO) 
FROM SUCURSAL s, CUENTA c
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
GROUP BY s.COD_SUCURSAL, s.DIRECCION, s.CAPITAL_ANIO_ANTERIOR 
HAVING SUM(c.SALDO) > s.CAPITAL_ANIO_ANTERIOR 
ORDER BY s.COD_SUCURSAL;

--19. Mostrar el c�digo de cuenta, su saldo, la descripci�n del tipo de movimiento y la suma
--total de dinero por movimiento, s�lo para aquellas cuentas cuya suma total de dinero
--por movimiento supere el 20% del saldo.
SELECT c.COD_CUENTA, c.SALDO, tm.DESCRIPCION, SUM(m.IMPORTE)
FROM CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE c.COD_CUENTA = m.COD_CUENTA
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
GROUP BY c.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING SUM(m.IMPORTE) > (c.SALDO * 0.2);

--20. Mostrar los mismos campos del ejercicio anterior pero ahora s�lo de aquellas cuentas
--cuya suma de importes por movimiento supere el 10% del saldo y no sean de la
--sucursal 4.
SELECT c.COD_CUENTA, c.SALDO, tm.DESCRIPCION, SUM(m.IMPORTE)
FROM CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE c.COD_CUENTA = m.COD_CUENTA
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
AND c.COD_SUCURSAL != 4 
GROUP BY c.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING SUM(m.IMPORTE) > (c.SALDO * 0.1);

--21. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al
--menos el 20% del capital del a�o anterior de su sucursal.
SELECT c.*
FROM CLIENTE c, CUENTA c2, SUCURSAL s
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
AND c2.COD_SUCURSAL = s.COD_SUCURSAL
AND c2.SALDO > (s.CAPITAL_ANIO_ANTERIOR * 0.2);







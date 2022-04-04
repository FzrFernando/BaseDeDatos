--1. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
	IF 10 > 5 THEN
 		DBMS_OUTPUT.PUT_LINE ('Cierto');
 	ELSE
 		DBMS_OUTPUT.PUT_LINE ('Falso');
 	END IF;
END;
--Si 10 es mayor que 5 devolverá cierto, en caso contrario falso, en este caso nos devuelve cierto


--2. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
	IF 10 > 5 AND 5 > 1 THEN
 		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
 		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;
--Si 10 es mayor que 5 y 5 es mayor que 1 devolverá cierto, en caso contrario devovlerá falso, en este caso nos devuelve cierto


--3. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
	IF 10 > 5 AND 5 > 50 THEN
 		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
 		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;
--Si 10 es mayor que 5 y 5 es mayor que 5 devolverá cierto, en caso contrario devolverá falso, en este caso devolverá falso


--4. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
	CASE
 		WHEN 10 > 5 AND 5 > 50 THEN
 			DBMS_OUTPUT.PUT_LINE ('Cierto');
 		ELSE
 			DBMS_OUTPUT.PUT_LINE ('Falso');
	END CASE;
END;
--Si 10 es mayor que 5 y 5 es mayor que 5 devolverá cierto, en caso contrario devolverá falso, en este caso devolverá falso


--5. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
	FOR i IN 1..10 LOOP
 		DBMS_OUTPUT.PUT_LINE (i);
 	END LOOP;
END;
--Ejecuta un bucle del 1 al 10 donde nos mostrará los números


--6. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
 	FOR i IN REVERSE 1..10 LOOP
 		DBMS_OUTPUT.PUT_LINE (i);
 	END LOOP;
END;
--Ejecuta un bucle del 1 al 10 de manera inversa y nos mostrará los números invertidos


--7. Ejecuta el siguiente bloque. Indica cuál es la salida.
DECLARE
	num NUMBER(3) := 0;
BEGIN
 	WHILE num<=100 LOOP
 		DBMS_OUTPUT.PUT_LINE (num);
 		num:= num+2;
 	END LOOP;
END;
--Declaramos una variable numérica con valor inicial 0, mientras que dicha variable sea menor o igual que 100 nos mostrará dicha variable y le sumaremos 2


--8. Ejecuta el siguiente bloque. Indica cuál es la salida
DECLARE
 	num NUMBER(3) := 0;
BEGIN
 	LOOP
 		DBMS_OUTPUT.PUT_LINE (num);
 	IF num > 100 THEN EXIT; END IF;
 	num:= num+2;
 	END LOOP;
END;
--Declaramos una variable numérica con valor inicial 0, dentro de un bucle mostraremos dicha variable y en el caso de que sea mayor que 100 se terminará el bucle, pero mientras tanto le seguiremos sumando 2 a nuestra variable


--9. Ejecuta el siguiente bloque. Indica cuál es la salida.
DECLARE
 	num NUMBER(3) := 0;
BEGIN
 	LOOP
 		DBMS_OUTPUT.PUT_LINE (num);
 	EXIT WHEN num > 100;
 	num:= num+2;
 	END LOOP;
END;
--Declaramos una variable numérica con valor inicial a 0, dentro del bucle mostraremos dicha variable y le indicamos que se salga cuando sea mayor que 100, pero mientras tanto le seguiremos sumando 2.




--1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
--mensaje HOLA MUNDO.
CREATE OR REPLACE
PROCEDURE escribe
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END;

BEGIN
	escribe;
END;


--2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
--parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
--La forma del procedimiento ser la siguiente
CREATE OR REPLACE
PROCEDURE escribe_mensaje(texto VARCHAR2)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE(texto);
END;

BEGIN
	escribe_mensaje('Hola');
END;


--3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
--números desde un mínimo hasta un máximo con un determinado paso. La
--forma del procedimiento ser la siguiente
CREATE OR REPLACE
PROCEDURE serie(minimo NUMBER, maximo NUMBER, paso NUMBER)
IS
BEGIN
	FOR i IN minimo..maximo LOOP
		DBMS_OUTPUT.PUT_LINE(i);
		i + paso;
	END LOOP;
END;

BEGIN
	serie(0,10,2);
END;


--4. Crea una función AZAR que reciba dos parámetros y genere un número al
--azar entre un mínimo y máximo indicado. La forma de la función será la
--siguiente
CREATE OR REPLACE
FUNCTION azar(minimo NUMBER, maximo NUMBER)
RETURN NUMBER
IS
BEGIN
	RETURN MOD(ABS(DBMS_RANDOM.RANDOM),maximo-minimo+1)+minimo;
END azar;

SELECT azar(2,6) FROM DUAL;


--5. Crea una función NOTA que reciba un parámetro que será una nota numérica
--entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
--Bien, Notable, ...). La forma de la función será la siguiente
CREATE OR REPLACE
FUNCTION nota(nota NUMBER)
RETURN VARCHAR2
IS
cadena VARCAHR2(80)
BEGIN
	CASE
    	WHEN nota=10 OR nota=9  THEN cadena := 'Sobresaliente';
    	WHEN nota=8  OR nota=7  THEN cadena := 'Notable';
    	WHEN nota=6             THEN cadena := 'Bien';
    	WHEN nota=5             THEN cadena := 'Suficiente';
    	WHEN nota<5 AND nota>=0 THEN cadena := 'Insuficiente';
    	ELSE cadena := 'Nota no válida';
  END CASE;
END;

SELECT nota(9) FROM DUAL;










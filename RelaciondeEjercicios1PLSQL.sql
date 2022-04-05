--1. Sabiendo que una persona ha trabajado 38 horas en una semana dada y gana a 
--razón de 60 euros la hora. La tasa de impuestos del estado es del 15,5% de su paga 
--bruta. Se desea saber cuál es la paga bruta, el descuento por impuesto y la paga neta del trabajador.
DECLARE
	pagabruta NUMBER(15,2);
	descuentoimpuesto NUMBER(5,2);
	paganeta NUMBER(15,2);
BEGIN
	pagabruta := 38 * 60;
	DBMS_OUTPUT.PUT_LINE(pagabruta);
	descuentoimpuesto := pagabruta * 0.155;
	DBMS_OUTPUT.PUT_LINE(descuentoimpuesto);
	paganeta := pagabruta - descuentoimpuesto;
	DBMS_OUTPUT.PUT_LINE(paganeta);
END;


--2. Realizar un procedure que calcule el salario neto de un trabajador recibiendo como parámetro 
--las horas trabajadas, el precio de la hora y el tanto por ciento de impuestos que se aplicará 
--sobre el salario bruto.
CREATE OR REPLACE
PROCEDURE calcularsalario(horastrabajadas NUMBER, preciohora NUMBER, impuestos NUMBER)
IS
salarioneto NUMBER;
BEGIN
	salarioneto := (horastrabajadas * preciohora) - ((horastrabajadas * preciohora) * impuestos);
	DBMS_OUTPUT.PUT_LINE(salarioneto);
END calcularsalario;

BEGIN
	calcularsalario(38,60,0.155);
END;


--3. Realizar un procedure para halla la media ponderada de tres puntuaciones de exámenes que se 
--pasarán como parámetros. Los pesos asociados a cada uno de los exámenes serán fijos y son 50%, 20% 
--y 30% para cada puntuación







alter session set "_oracle_script"=true;  
create user Empleados identified by Empleados;
GRANT CONNECT, RESOURCE, DBA TO Empleados;

CREATE TABLE DEPARTAMENTO(
	codigo NUMBER(10),
	nombre VARCHAR2(100),
	presupuesto NUMBER(10,2),
	gastos NUMBER(10,2),
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO(
	codigo NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	codigo_departamento NUMBER(10),
	CONSTRAINT PK_EMPLEADO PRIMARY KEY(codigo),
	CONSTRAINT FK_EMPLEADO FOREIGN KEY(codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
);


INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (1,'Desarrollo',120000,6000);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (2,'Sistemas',150000,21000);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (3,'Recursos Humanos',280000,25000);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (4,'Contabilidad',110000,3000);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (5,'I+D',375000,38000);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (6,'Proyectos',0,0);
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (7,'Publicidad',0,1000);



INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES (1, '32481596F', 'AarÃ³n', 'Rivero', 'GÃ³mez', 1);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'DÃ­az', 2);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(4, '77705545E', 'AdriÃ¡n', 'SuÃ¡rez', NULL, 4);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(5, '17087203C', 'Marcos', 'Loyola', 'MÃ©ndez', 5);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(6, '38382980M', 'MarÃ­a', 'Santana', 'Moreno', 1);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(9, '56399183D', 'Juan', 'GÃ³mez', 'LÃ³pez', 2);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES(13, '82635162B', 'Juan Antonio','SÃ¡ez', 'Guerrero', NULL);

--Inserta un nuevo departamento indicando su cÃ³digo, nombre y presupuesto.
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto)
VALUES (8,'ProgramaciÃ³n',170000);

--Inserta un nuevo departamento indicando su nombre y presupuesto.
--NO SE PUEDE EN ORACLE

--Inserta un nuevo departamento indicando su cÃ³digo, nombre, presupuesto y gastos.
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto,gastos)
VALUES (9,'Base de datos',19000,5000);

--Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserciÃ³n debe incluir: cÃ³digo, nif, nombre, apellido1, apellido2 y codigo_departamento.
INSERT INTO EMPLEADO(codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES (14,'82445611X','Jose Antonio','Vazquez','Fernandez',6);

--Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserciÃ³n debe incluir: nif, nombre, apellido1, apellido2 y codigo_departamento.
--NO SE PUEDE EN ORACLE

--Crea una nueva tabla con el nombre departamento_backup que tenga las mismas columnas que la tabla departamento. Una vez creada copia todos las filas de tabla departamento en departamento_backup.

--Elimina el departamento Proyectos. Â¿Es posible eliminarlo? Si no fuese posible, Â¿quÃ© cambios deberÃ­a realizar para que fuese posible borrarlo?
DELETE FROM DEPARTAMENTO
WHERE nombre = 'Proyectos';
ALTER TABLE EMPLEADO DROP CONSTRAINT FK_EMPLEADO;
ALTER TABLE EMPLEADO ADD CONSTRAINT FK_EMPLEADO FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE;
DELETE FROM DEPARTAMENTO
WHERE nombre='Proyectos';
--Elimina el departamento Desarrollo. Â¿Es posible eliminarlo? Si no fuese posible, Â¿quÃ© cambios deberÃ­a realizar para que fuese posible borrarlo?
DELETE FROM DEPARTAMENTO
WHERE nombre = 'Desarrollo';

--Actualiza el código del departamento Recursos Humanos y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE DEPARTAMENTO
SET presupuesto=30
WHERE nombre='Recursos Humanos';

--Actualiza el código del departamento Publicidad y asígnale el valor 40. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE DEPARTAMENTO
SET presupuesto=40
WHERE nombre='Publicicidad';
--Actualiza el presupuesto de los departamentos sumándole 50000 € al valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €.
UPDATE DEPARTAMENTO
SET presupuesto=presupuesto+50000
WHERE presupuesto<20000;
--Realiza una transacción que elimine todas los empleados que no tienen un departamento asociado.
SELECT * FROM EMPLEADO WHERE UPPER (codigo_departamento) LIKE upper('%NULL%');
DELETE FROM EMPLEADO WHERE upper (codigo_departamento) LIKE upper('%NULL%');


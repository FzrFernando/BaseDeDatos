--creamos las tablas
CREATE TABLE DEPARTAMENTO(
codigo 		NUMBER(10),
nombre 		VARCHAR2(100),
presupuesto NUMBER(11,2),
gasto 		NUMBER(11,2),
CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO(
codigo 				NUMBER(10),
nif 				VARCHAR2(9),
nombre 				VARCHAR2(100),
apellido 			VARCHAR2(100),
apellido2 			VARCHAR2(100),
codigo_departamento NUMBER(10),
CONSTRAINT pk_empleado PRIMARY KEY (codigo),
CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO (codigo)
);

--insertamos los datos
INSERT INTO departamento VALUES (1,'Desarrollo',120000,6000);
INSERT INTO departamento VALUES (2,'Sistemas',150000,21000);
INSERT INTO departamento VALUES (3,'Recursos Humanos',280000,25000);
INSERT INTO departamento VALUES (4,'Contabilidad',110000,3000);
INSERT INTO departamento VALUES (5,'I+D',375000,38000);
INSERT INTO departamento VALUES (6,'Proyectos',0,0);
INSERT INTO departamento VALUES (7,'Publicidad',0,1000);

INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (1,'32481596F','Aar�n','Rivero','G�mez',1);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (2,'Y5575632D','Adela','Salas','D�az',2);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (3,'R6970642B','Adolfo','Rubio','Flores',3);
INSERT INTO empleado (codigo,nif,nombre,apellido,codigo_departamento) VALUES (4,'77705545E','Adri�n','Su�rez',4);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (5,'17087203C','Marcos','Loyola','M�ndez',5);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (6,'38382980M','Mar�a','Santana','Moreno',1);
INSERT INTO empleado (codigo,nif,nombre,apellido,codigo_departamento) VALUES (7,'80576669X','Pilar','Ruiz',2);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (8,'71651431Z','Pepe','Ruiz','Santana',3);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (9,'56399183D','Juan','G�mez','L�pez',2);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (10,'46384486H','Diego','Flores','Salas',5);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (11,'67389283A','Marta','Herrera','Gil',1);
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2) VALUES (12,'41234836R','Irene','Salas','Flores');
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2) VALUES (13,'82635162B','Juan Antonio','S�ez','Guerrero');

--Ejercicios adicionales
--1. Inserta un nuevo departamento indicando su c�digo, nombre y presupuesto.
INSERT INTO departamento(codigo,nombre,presupuesto) VALUES (8,'Productividad',170000);

--2. Inserta un nuevo departamento indicando su nombre y presupuesto.
INSERT INTO departamento(nombre,presupuesto) VALUES ('Calidad',10000,1000);
--No nos deja porque se viola la clave primaria

--3. Inserta un nuevo departamento indicando su c�digo, nombre, presupuesto y gastos.
INSERT INTO departamento VALUES (9,'Calidad',10000,1000);

--4. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserci�n debe
--incluir: c�digo, nif, nombre, apellido1, apellido2 y codigo_departamento
INSERT INTO empleado (codigo,nif,nombre,apellido,apellido2,codigo_departamento) VALUES (14,'2345689P','Juanma','Jimenez','Garcia',8);

--5. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserci�n debe
--incluir: nif, nombre, apellido1, apellido2 y codigo_departamento
INSERT INTO empleado (nif,nombre,apellido,apellido2,codigo_departamento) VALUES ('2345689P','Juanma','Jimenez','Garcia',4);
--No nos deja por el mismo motivo de antes

--6. Crea una nueva tabla con el nombre departamento_backup que tenga las
--mismas columnas que la tabla departamento. Una vez creada copia todos
--las filas de tabla departamento en departamento_backup
CREATE TABLE DEPARTAMENTO_BACKUP(
codigo 		NUMBER(10),
nombre 		VARCHAR2(100),
presupuesto NUMBER(11,2),
gasto 		NUMBER(11,2),
CONSTRAINT pk_departamento_Backup PRIMARY KEY (codigo)
);

--insertamos los datos con un insert de select
INSERT INTO DEPARTAMENTO_BACKUP
SELECT * FROM DEPARTAMENTO;

--7. Elimina el departamento Proyectos. �Es posible eliminarlo? Si no fuese
--posible, �qu� cambios deber�a realizar para que fuese posible borrarlo?
DELETE FROM DEPARTAMENTO
WHERE nombre='Proyectos';
--Se borra sin modificar la constraint porque no tiene hijos

--8. Elimina el departamento Desarrollo. �Es posible eliminarlo? Si no fuese
--posible, �qu� cambios deber�a realizar para que fuese posible borrarlo?
DELETE FROM DEPARTAMENTO
WHERE nombre='Desarrollo';
--No nos deja asi que procedemos a modificar la constraint
ALTER TABLE empleado DROP CONSTRAINT fk_empleado;
ALTER TABLE empleado ADD CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO (codigo) ON DELETE CASCADE;
--Procedemos a ejecutar de nuevo
DELETE FROM DEPARTAMENTO
WHERE nombre='Desarrollo';
--Ahora si funciona

--9. Actualiza el c�digo del departamento Recursos Humanos y as�gnale el valor
--30. �Es posible actualizarlo? Si no fuese posible, �qu� cambios deber�a
--realizar para que fuese actualizarlo?
--No sirve y a la hora de modificar la constraint no nos deja usar el on update cascade as� que lo hacemos manual
ALTER TABLE empleado disable CONSTRAINT fk_empleado;
UPDATE DEPARTAMENTO
SET codigo=30
WHERE nombre LIKE 'Recursos Humanos';

UPDATE EMPLEADO
SET codigo_departamento=30
WHERE codigo_departamento=3;
ALTER TABLE empleado enable CONSTRAINT fk_empleado;

--10.Actualiza el c�digo del departamento Publicidad y as�gnale el valor 40.
--�Es posible actualizarlo? Si no fuese posible, �qu� cambios deber�a
--realizar para que fuese actualizarlo?
ALTER TABLE empleado disable CONSTRAINT fk_empleado;
UPDATE DEPARTAMENTO
SET codigo=40
WHERE nombre LIKE 'Publicidad';

UPDATE EMPLEADO
SET codigo_departamento=40
WHERE codigo_departamento=7;
ALTER TABLE empleado enable CONSTRAINT fk_empleado;

--11.Actualiza el presupuesto de los departamentos sum�ndole 50000 � al
--valor del presupuesto actual, solamente a aquellos departamentos que
--tienen un presupuesto menor que 20000 �.
UPDATE departamento 
SET presupuesto=presupuesto +50000
WHERE presupuesto<20000;

--12.Realiza una transacci�n que elimine todas los empleados que no tienen
--un departamento asociado.
DELETE FROM EMPLEADO
WHERE codigo_departamento IS NULL;
--Usamos el operador IS NULL PARA DECIR QUE ES NULO


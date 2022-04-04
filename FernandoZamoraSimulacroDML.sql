alter session set "_oracle_script"=true;  
create user DMLFERNANDO identified by DMLFERNANDO;
GRANT CONNECT, RESOURCE, DBA TO DMLFERNANDO;

--Apartado	1.	(1 puntos) Crea	las	tablas	correspondientes	respetando	tanto	los	nombres	
--como	 los	 tipos	 de	 datos	 que	 aparecen	 en	 el	 diagrama. Así	 como	 todas	 las	 PK	 y	 FK	
--correspondientes.	Las	FK	deberán	crearse	con	la	 restricción	por	defecto,	es	decir,	sin	
--indicarle	nada	adicional.
CREATE TABLE ALUMNO(
nummatricula	NUMBER(6),
nombre			VARCHAR2(50),
fechanacimiento	DATE,
telefono		VARCHAR2(9),
CONSTRAINT pk_alumno PRIMARY KEY (nummatricula)
);

CREATE TABLE PROFESOR(
idprofesor		NUMBER(6),
nif_p			VARCHAR2(9),
nombre			VARCHAR2(50),
especialidad	VARCHAR2(100),
telefono		VARCHAR2(9),
CONSTRAINT pk_profesor PRIMARY KEY (idprofesor)
);

CREATE TABLE ASIGNATURA (
codasignatura	VARCHAR2(6),
nombre			VARCHAR2(50),
idprofesor		NUMBER(6),
CONSTRAINT pk_asignatura PRIMARY KEY (codasignatura),
CONSTRAINT fk_asignatura FOREIGN KEY (idprofesor) REFERENCES PROFESOR(idprofesor)
);

CREATE TABLE RECIBE(
nummatricula	NUMBER(6),
codasignatura	VARCHAR2(6),
cursoescolar	VARCHAR2(10),
CONSTRAINT pk_recibe PRIMARY KEY (nummatricula,codasignatura,cursoescolar),
CONSTRAINT fk1_recibe FOREIGN KEY (nummatricula) REFERENCES ALUMNO(nummatricula),
CONSTRAINT fk2_recibe FOREIGN KEY (codasignatura) REFERENCES ASIGNATURA(codasignatura)
);

--Apartado	2. (1,5 punto)	Realiza	las	siguientes	inserciones con	datos	inventados:
--• Inserta	2	profesores.
INSERT INTO PROFESOR
VALUES (159795,'28746425L','Antonio','Lenguaje','617552483');
INSERT INTO PROFESOR
VALUES (174203,'29461782P','Laura','Historia','638581204');

--• Inserta	4	asignaturas.
INSERT INTO ASIGNATURA
VALUES (632104,'Lengua Castellana',159795);
INSERT INTO ASIGNATURA
VALUES (674185,'Sintaxis',159795);
INSERT INTO ASIGNATURA
VALUES (602791,'Historia de España',174203);
INSERT INTO ASIGNATURA
VALUES (605249,'Historia del Arte',174203);

--• Inserta	10	alumnos.
INSERT INTO ALUMNO
VALUES (159764,'Alfonso',NULL,'638291744');
INSERT INTO ALUMNO
VALUES (158201,'María',NULL,'638623910');
INSERT INTO ALUMNO
VALUES (156381,'Nuria',NULL,'638891523');
INSERT INTO ALUMNO
VALUES (155903,'Cristóbal',NULL,'638643028');
INSERT INTO ALUMNO
VALUES (159613,'Fernando',NULL,'638374169');
INSERT INTO ALUMNO
VALUES (158437,'Carmen',NULL,'638921630');
INSERT INTO ALUMNO
VALUES (158620,'Isabel',NULL,'638691520');
INSERT INTO ALUMNO
VALUES (157298,'Carlos',NULL,'638159874');
INSERT INTO ALUMNO
VALUES (155364,'Paula',NULL,'638602415');
INSERT INTO ALUMNO
VALUES (157408,'Gonzalo',NULL,'638201695');

--• Cada	alumno	debe	realizar	al	menos	2	asignaturas.
INSERT INTO RECIBE
VALUES (159764,632104,'1ESO');
INSERT INTO RECIBE
VALUES (159764,674185,'1ESO');

INSERT INTO RECIBE
VALUES (158201,602791,'1BACHART');
INSERT INTO RECIBE
VALUES (158201,605249,'1BACHART');

INSERT INTO RECIBE
VALUES (156381,632104,'2ESO');
INSERT INTO RECIBE
VALUES (156381,674185,'2ESO');

INSERT INTO RECIBE
VALUES (155903,632104,'3ESO');
INSERT INTO RECIBE
VALUES (155903,602791,'3ESO');

INSERT INTO RECIBE
VALUES (159613,602791,'3ESO');
INSERT INTO RECIBE
VALUES (159613,674185,'3ESO');

INSERT INTO RECIBE
VALUES (158437,674185,'1ESO');
INSERT INTO RECIBE
VALUES (158437,632104,'1ESO');

INSERT INTO RECIBE
VALUES (158620,605249,'4ESO');
INSERT INTO RECIBE
VALUES (158620,602791,'4ESO');

INSERT INTO RECIBE
VALUES (157298,605249,'2ESO');
INSERT INTO RECIBE
VALUES (157298,632104,'2ESO');

INSERT INTO RECIBE
VALUES (155364,602791,'1ESO');
INSERT INTO RECIBE
VALUES (155364,674185,'1ESO');

INSERT INTO RECIBE
VALUES (157408,632104,'3ESO');
INSERT INTO RECIBE
VALUES (157408,674185,'3ESO');

--Apartado 3. (0,5 puntos) Introduce 2	 alumnos	 con	 el	 mismo	 NumMatricula.	 ¿Qué	
--sucede?	 ¿Por	 qué?.	 Deberás	 escribir	 las	 sentencias	 concretas	 además de	 explicar	
--detalladamente	lo	que	sucede.
INSERT INTO ALUMNO
VALUES (157241,'Juanma',NULL,'638489140');
INSERT INTO ALUMNO
VALUES (157241,'Javier',NULL,'638635971');
--El primero si es introducido, pero el segundo nos da error porque se está repitiendo la clave primaria cuando debe ser única, el ejercicio correcto sería cambiarle el nummatricula por otro

--Apartado	4. (0,5 puntos) Introduce	3	alumnos para	los	cuales	no	conocemos	el	número	
--de	teléfono
INSERT INTO ALUMNO
VALUES (157291,'Javier',NULL,NULL);
INSERT INTO ALUMNO
VALUES (158649,'Juan Antonio',NULL,NULL);
INSERT INTO ALUMNO
VALUES (159882,'Alejandra',NULL,NULL);

--Apartado	5.	(0,5 puntos) Modifica	los	datos	de	los 3	alumnos anteriores	para	establecer	
--un	número	de	teléfono
UPDATE ALUMNO
SET telefono = '637203516'
WHERE nummatricula = 157291;

UPDATE ALUMNO
SET telefono = '637602054'
WHERE nummatricula = 158649;

UPDATE ALUMNO
SET telefono = '638906879'
WHERE nummatricula = 159882;

--Apartado	6.	(1 puntos) Para	aquellos	alumnos nacidos	después del	año	2000	se	deberá	
--actualizar	su	fecha	de	nacimiento	con	el	valor	22/07/1981.	Deberá	realizarse	con	una	
--única	instrucción.
UPDATE ALUMNO
SET fechanacimiento = TO_DATE('DD/MM/YYYY','22/07/1981')
WHERE fechanacimiento > TO_DATE('DD/MM/YYYY','31/12/2000');

--Apartado	7.	(1 puntos) Para	los	profesores que	tienen	número	de	teléfono	y cuyo NIF	
--no	comience	por	9,	se	deberá actualizar	a “Informática”	su especialidad.
UPDATE PROFESOR
SET especialidad = 'Informática'
WHERE telefono NOT LIKE '9%';

--Apartado	8. (0,5 puntos) En	la	tabla	Recibe borra	todos	los	registros	que	pertenecen	a	
--una	de	las	asignaturas
DELETE FROM RECIBE
WHERE codasignatura LIKE '632104';

--Apartado	9. (0,5 puntos) En	la	tabla	Asignatura borra	dicha	asignatura
DELETE FROM ASIGNATURA
WHERE codasignatura LIKE '632104';

--Apartado	10. (0,5 puntos) Borra	el	resto	de	asignaturas. Indica	la	instrucción	a	ejecutar.
--¿Qué	sucede?	¿Por	qué?	¿Como	lo	solucionarías?	¿Podría	haberse	evitado	el	problema	
--con	 otro	 diseño	 físico?¿Cómo?. Explícalo	 detalladamente	 e	 indica	 las	 instrucciones	
--necesarias	para	solucionarlo.
DELETE FROM ASIGNATURA;
--Da error porque recibe esos datos en otro tabla y no hay borrado en cascada
--Lo mejor sería haber puesto un borrado en cascada o borrar la constraint

--Apartado	11.	(0,5 puntos) Borra	todos	los	profesores. Indica	la	instrucción	a	ejecutar.
--¿Qué	sucede?	¿Por	qué?	¿Como	lo	solucionarías?	¿Podría	haberse	evitado	el	problema	
--con	 otro	 diseño	 físico?¿Cómo?. Explícalo	 detalladamente	 e	 indica	 las	 instrucciones	
--necesarias	para	solucionarlo
DELETE FROM PROFESOR;
--Practicamente lo mismo que el ejercicio anterior

--Apartado	12. (1 puntos) Se	ha	detectado	que	en	la	tabla	alumnos	los	nombres	de	los	
--alumnos	están	en	minúsculas.	 Se	 desea	 actualizar	el	 nombre	 de	 cada	 alumno	 por	el	
--correspondiente	convertido	en	MAYÚSCULA.
UPDATE ALUMNO
SET nombre = UPPER(nombre);

--Apartado	13. (1 puntos) Crea una	nueva	tabla	llamada	ALUMNO_BACKUP que	tenga	
--las	mismas	columnas	que	la	tabla	ALUMNO.	Una	vez	creada	copia, todos	las	filas	de	la	
--tabla	ALUMNO a	la	tabla	ALUMNO_BACKUP.	La	copia	deberá	realizarse	con	una	única	
--instrucción.
CREATE TABLE ALUMNO_BACKUP(
nummatricula	NUMBER(6),
nombre			VARCHAR2(50),
fechanacimiento	DATE,
telefono		VARCHAR2(9),
CONSTRAINT pk_alumno_backup PRIMARY KEY (nummatricula)
);

INSERT INTO ALUMNO_BACKUP 
SELECT * FROM ALUMNO;








--Apartado	1.	(1 punto)
--Deberás	registrarte	en	la	base	de	datos	de	la	Universidad	como	un nuevo alumno/a	con	
--tus	datos	personales	y	matricularte	de	la asignatura	“Contabilidad”.
SELECT * FROM ALUMNO a2;
SELECT * FROM PERSONA;

INSERT INTO PERSONA
VALUES ('47547373W','Fernando','Zamora','Sevilla','Flores',7,'638374169',NULL,1);
INSERT INTO ALUMNO
VALUES ('123456','47547373W');
SELECT * FROM ASIGNATURA a;
SELECT * FROM ALUMNO_ASIGNATURA aa;
INSERT INTO ALUMNO_ASIGNATURA 
VALUES ('123456','160002',1);

/*Apartado	2.	(1 punto)
El	profesor	de	la asignatura	“Contabilidad” se	ha	cambiado	de	Universidad	por	lo	que
es	necesario darlo	de	baja de	la	base	de	datos y asignar	 la	asignatura de	“Contabilidad”
a	la	nueva	profesora	que	no	se	encuentra	en	el	sistema	cuyos	datos	son:
DNI:	 77222122K, NOMBRE Y	 APELLIDOS:	 MARTA LÓPEZ	 MARTOS,	 CIUDAD:	 SEVILLA,	
DIRECCIÓN: CALLE	 TARFIA,	 NÚMERO: 9,	 TELÉFONO:	 615891432,	 FECHA	 DE	
NACIMIENTO:	22	de	Julio	de	1981,	SEXO:	MUJER*/
SELECT * FROM ASIGNATURA;
SELECT * FROM PROFESOR;

ALTER TABLE PROFESOR DROP CONSTRAINT SYS_C0011167;

DELETE FROM PERSONA
WHERE DNI = '25252525A';

ALTER TABLE ASIGNATURA DISABLE CONSTRAINT SYS_C0011169;

DELETE FROM PROFESOR
WHERE DNI = '25252525A';

ALTER TABLE ALUMNO_ASIGNATURA  DISABLE CONSTRAINT SYS_C0011173;

UPDATE ASIGNATURA 
SET IDPROFESOR = NULL
WHERE IDASIGNATURA = '160002';

INSERT INTO PERSONA
VALUES ('77222122K','Marta','López Martos','Sevilla','Tarfia',9,'615891432',NULL,0);

INSERT INTO PROFESOR
VALUES ('1234','77222122K');

UPDATE ASIGNATURA 
SET IDPROFESOR = '1234'
WHERE IDASIGNATURA = '160002';


/*Apartado	3.	 (1,5 puntos)	La	universidad	nos	ha	pedido	que	guardemos	en	una	nueva	
tabla	 llamada	 ALUMNOS_MUYREPETIDORES que	 tendrá	 las	 siguientes	 columnas	
IDASIGNATURA,	DNI,	NOMBRE,	APELLIDO	Y	TELÉFONO aquellos	alumnos	que	se	han	
matriculado	tres o	más	veces de	una	asignatura. Deberás	crear	en	primer	lugar	la	tabla	
y	luego	utilizando	una	única	sentencia	guardar	todos	los	datos	solicitados.*/
CREATE TABLE ALUMNOS_MUYREPETIDORES(
IDASIGNATURA	VARCHAR2(7),
IDALUMNO		VARCHAR2(7),
CONSTRAINT pk_alumnos_muy PRIMARY KEY (IDALUMNO,IDASIGNATURA),
CONSTRAINT fk1_alumnos_muy FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA (IDASIGNATURA),
CONSTRAINT fk2_alumnos_muy FOREIGN KEY (IDALUMNO) REFERENCES ALUMNO(IDALUMNO)
);

/*Apartado 4. (1 puntos) Sobre	 la	 tabla	 creada	 anteriormente	
ALUMNOS_MUYREPETIDORES nos	han	pedido que	añadamos	una	nueva	columna	que	
se	llamará	“OBSERVACIONES”.	Para	los	alumnos/as existentes	en	la	tabla	que	residen
en	SEVILLA	y	cuyo	número	de	teléfono	contiene	el	20	se rellenara la	nueva	columna	con	
el	texto	“Se	encuentra	en	seguimiento”;*/
ALTER TABLE ALUMNOS_MUYREPETIDORES ADD OBSERVACIONES VARCHAR2(150);

/*UPDATE ALUMNOS_MUYREPETIDORES
SET OBSERVACIONES = "Se encuentra en seguimiento"
WHERE CIUDAD LIKE 'Sevilla' AND TELEFONO LIKE '%20%';*/


/*Apartado 5. (1 punto) De	 la tabla	 ALUMNOS_MUYREPETIDORES se	 desea	 borrar	
aquellos	nacidos	en	Noviembre	de	1971.*/
/*DELETE FROM ALUMNOS_MUYREPETIDORES
WHERE FECHA_NACIMIENTO = TO_DATE('MM/YYYY','11/1971');*/


/*Apartado	 6.	 (1punto). Crear	 una	 nueva	 tabla	 cuyo	 nombre	 sea	
RESUMEN_TITULACIONES que	 tendrá	la	columna	NOMBRE_TITULACIÓN y	la	columna	
NUMEROASIGNATURAS.	 Deberá	 guardarse	 en	 esa	 nueva	 tabla	 mediante	 una	 única	
sentencia los nombres	de	la	titulaciones	y	cuantas	asignaturas	tiene	cada	titulación.*/
CREATE TABLE RESUMEN_TITULACIONES(
NOMBRE_TITULACION		VARCHAR2(100),
IDTITULACION			VARCHAR2(8),
CONSTRAINT pk_RESUMEN_TITULACIONES PRIMARY KEY (IDTITULACION)
);


--Apartado	7. Suponiendo	que	tenemos	el	AUTOCOMMIT desactivado,	¿Qué	pasaría	en	
--las	siguientes	situaciones?

/*7.1 (0,5	puntos) Si	creo	una	nueva	tabla llamada	FACTURA en	la	base	de	datos	y	
posteriormente	 inserto	 datos sobre	 ella.	 ¿Podrá ver	 esos	 datos	 otro	
programador/a que	trabaje	en	tu	equipo	de	desarrollo y	que	tenga	acceso	a	
la	misma	base	de	datos?. Justifica	la	respuesta.*/
--Tendría que hacer un commit, porque si salgo de la base d edagtos se perdería todo


/*7.2 (0,5	puntos) Si	posteriormente	creo	una	nueva	tabla CLIENTE en	la	base	de	
datos.	¿Quedarán	persistidos	los	datos	en	la	base	de	datos?	Indica	qué ocurre	
y	justifica	la	respuesta.*/
--Solo queda persistido si se hace un commit, al instante está pero si se cierra la base de datos se pierde


/*7.3 (0,5	puntos) Posteriormente	nos	damos	cuenta	que	alguno	de	los datos	que	
inserté en	la	tabla	FACTURA no	son	correctos. ¿Puedo	volver	a	la	situación	
inicial con	alguna	operación?	Indica	cuál	en	caso	de	ser	posible	y	justifica	la	
respuesta.*/
--Si hubo algún SAVEPOINT se puede volver atrás gracias al ROLLBACK TO SAVEPOINT


/*7.4 . (0,5	 puntos) Inserto	 datos	 en	 la	 tabla	 CLIENTE	 y	 quiero	 que	 los	 datos	
queden	persistidos	en	la	base	de	datos.	¿Qué operación	necesito	realizar?	
Justifica	la	respuesta.*/
--Se hace un commit para que dichos datos se queden en la base de datos


/*7.5 (0,5	 puntos) Posteriormente	 quiero	 borrar	solo	 algunos	 datos	 de	 la	 tabla	
CLIENTE pero	 por	 error	 he	 borrado	 todos	 los	 datos	 de	 la	 tabla.	 ¿Puedo	
realizar	algo	para	recuperar	los	datos	que	borre?.	Justifícalo	y	en	caso	de ser	
posible	indica	cómo	actuarias.*/
--Se puede hacer un ROLLBACK para ir al momento anterior de ejecutar dicha operacion


/*7.6 (1 puntos) ¿En	qué	consiste	el	SAVEPOINT?	Explícalo detalladamente e	indica	
a	 modo	 de	 ejemplo	 las	 instrucciones	 necesarias	 donde	 se	 vea	 que	 has	
utilizado	varios	INSERT y	SAVEPOINT	de	forma	que	quede	bien	explicado	su	
funcionamiento.*/
--Para tener un punto de guardado, es decir si yo hago un insert y por error hago un delete puede ejecutar el rollabck to savepoint para ir a ese punto de guardado










--1. Generar las siguientes tablas para guardar esta información
CREATE TABLE ALUMNOS(
nombre				VARCHAR2(50),
apellido1			VARCHAR2(50),
apellido2			VARCHAR2(50),
dni					VARCHAR2(9),
direccion			VARCHAR2(150),
sexo				VARCHAR2(1),
fecha_nacimiento	DATE,
curso				NUMBER(2),
CONSTRAINT pk_alumnos PRIMARY KEY (dni),
CONSTRAINT ch_sexo CHECK (sexo IN ('H','M'))
);

CREATE TABLE CURSOS(
nombre_curso		VARCHAR2(100),
cod_curso			NUMBER(2),
dni_profesor		VARCHAR2(9),
max_alumnos			NUMBER(4),
fecha_inicio		DATE,
fecha_fin			DATE,
num_horas			NUMBER(4),
CONSTRAINT pk_cursos PRIMARY KEY (cod_curso)
);

ALTER TABLE ALUMNOS ADD CONSTRAINT fk1_alumnos FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso);

CREATE TABLE PROFESORES(
nombre		VARCHAR2(50),
apellido1	VARCHAR2(50),
apelldio2	VARCHAR2(50),
dni			VARCHAR2(9),
direccion	VARCHAR2(150),
titulo		VARCHAR2(80),
gana		NUMBER(6,2),
CONSTRAINT pk_profesores PRIMARY KEY (dni)
);

ALTER TABLE CURSOS ADD CONSTRAINT fk1_cursos FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni);

--2. Insertar las siguientes tuplas

--Insertar valores en tabla profesores
INSERT INTO PROFESORES
VALUES ('Juan','Arch','López','32432455','Puerta Negra, 4','Ing. Informática',7500);

INSERT INTO PROFESORES
VALUES ('María','Oliva','Rubio','43215643','Juan Alfonso 32','Lda. Fil. Inglesa',5400);

--Insertar valores en tabla cursos
INSERT INTO CURSOS
VALUES ('Inglés Básico',1,'43215643',15,TO_DATE('01/11/2000','DD/MM/YYYY'),TO_DATE('22/12/2000','DD/MM/YYYY'),120);

INSERT INTO CURSOS
VALUES ('Administración Linux',2,'32432455',NULL,TO_DATE('01/09/2000','DD/MM/YYYY'),NULL,80);

--Insertar valores en tabla alumnos
INSERT INTO ALUMNOS
VALUES ('Lucas','Manilva','López','123523','Alhamar,3','H',TO_DATE('01/11/1979','DD/MM/YYYY'),1);
--El anterior insert fallaba porque el sexo que queriamos introducir era un V, cuando solo puede introducirse una H o una M

INSERT INTO ALUMNOS
VALUES ('Antonia','López','Alcantara','2567567','Maniquí,21','M',NULL,2);

INSERT INTO ALUMNOS
VALUES ('Manuel','Alcantara','Pedrós','3123689','Julian,2','H',NULL,1);
--El anterior insert fallaba porque el sexo que queriamos introducir era un 2, cuando solo puede introducirse una H o una M

INSERT INTO ALUMNOS
VALUES ('José','Pérez','Caballar','4896765','Jarcha,5','H',TO_DATE('03/02/1977','DD/MM/YYYY'),2);
--El anterior insert fallaba porque el sexo que queriamos introducir era un V, cuando solo puede introducirse una H o una M
--También falla porque el curso que queriamos introducir es el 3, cuadno solo tenemos el curso 1 y el curso 2


--3. Insertar la siguiente tupla en alumnos
INSERT INTO ALUMNOS
VALUES ('Sergio','Navas','Retal','123524',NULL,'H',NULL,1);
--El anterior insert falla porque el dni es el mismo que el de un alumno que ya está introducido


--4. Insertar la siguiente tupla en la tabla profesor
INSERT INTO PROFESORES
VALUES ('Manuel','Estrada','Fernández','32432467','Madrid, 1','Ing. Informática',NULL);
--El anterior insert falla porque es el mismo profesor que hemos introducido solo que ha cambiado el campo de gana


--5. Insertar la siguiente tupla en la tabla estudiante
INSERT INTO ALUMNOS
VALUES ('María','Jaén','Sevilla','789678','Martos,5','M',NULL,NULL);


--6. La fecha de nacimiento de Antonia López está equivocada. 
--La verdadera es 23 de diciembre de 1976.
UPDATE ALUMNOS
SET fecha_nacimiento = TO_DATE('23/12/1976','DD/MM/YYYY')
WHERE dni LIKE '2567567';


--7. Cambiar a Antonia López al curso de código 5.
/*UPDATE ALUMNOS
SET CURSO = 5
WHERE dni = '2567567';*/
--El anterior update falla porque no existe un curso con ese código.


--8. Eliminar la profesora Laura Jiménez
DELETE FROM PROFESORES
WHERE nombre LIKE 'Laura' AND apellido1 LIKE 'Jiménez';
--Este delete funciona pero no había ninguna profesora que se llamase Laura Jiménez


--9. Borrar el curso con código 1.
DELETE FROM CURSOS
WHERE cod_curso = 1;
--El anterior delete falla porque no hay borrado en cascada y ya hay alumnos inscritos en ese curso


--10. Añadir un campo llamado numero_alumnos en la tabla curso
ALTER TABLE CURSOS ADD numero_alumnos NUMBER(4);


--11. Modificar la fecha de nacimiento a 01/01/2012 en aquellos alumnos 
--que no tengan fecha de nacimiento.
UPDATE ALUMNOS
SET fecha_nacimiento = TO_DATE('01/01/2012','DD/MM/YYYY')
WHERE fecha_nacimiento IS NULL;


--12. Borra el campo sexo en la tabla de alumnos.
ALTER TABLE ALUMNOS DROP COLUMN sexo;


--13. Modificar la tabla profesores para que los  profesores de Informática cobren un 20 pro ciento más de lo que cobran actualmente.
UPDATE PROFESORES
SET gana = gana + (gana*0.2)
WHERE titulo LIKE '%Informática%';

SELECT gana FROM PROFESORES;


--14. Modifica el dni de Juan Arch a 1234567
UPDATE PROFESORES
SET dni = '1234567'
WHERE nombre LIKE '%Juan%' AND apellido1 LIKE '%Arch%';
--No se puede cambiar la clave primaria porque también está en otra tabla


--15. Modifica el dni de todos los profesores de informática para que tengan el dni 7654321
UPDATE PROFESORES
SET dni = '7654321'
WHERE titulo LIKE '%Informática%';
--No se puede cambiar la clave primaria porque también está en otra tabla


--16. Cambia el sexo de la alumna María Jaén a F.
UPDATE ALUMNOS
SET sexo = 'F'
WHERE UPPER(nombre) LIKE UPPER('María') AND UPPER(apellido1) LIKE UPPER('Jaén');
--El campo sexo se eliminó antes








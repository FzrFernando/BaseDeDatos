--1. Crear las siguientes tablas con las restricciones que se especifican e inserta registros
CREATE TABLE CABALLOS(
codcaballo			VARCHAR2(4),
nombre				VARCHAR2(20) NOT NULL,
peso				NUMBER(3),
fecha_nacimiento		DATE,
propietario			VARCHAR2(25),
nacionalidad			VARCHAR2(20),
CONSTRAINT pk_caballos PRIMARY KEY (codcaballo),
CONSTRAINT ch_peso CHECK (peso BETWEEN 240 AND 300),
CONSTRAINT ch_fecha CHECK (fecha_nacimiento > TO_DATE('31/12/2000','DD/MM/YYYY')),
CONSTRAINT ch_nacionalidad CHECK (nacionalidad = UPPER(nacionalidad))
);

CREATE TABLE PARTICIPACIONES(
codcaballo		VARCHAR2(4),
codcarrera		VARCHAR2(4),
dorsal			NUMBER(2) NOT NULL,
jockey			VARCHAR2(10) NOT NULL,
posicionfinal		NUMBER(2),
CONSTRAINT pk_participaciones PRIMARY KEY (codcaballo,codcarrera),
CONSTRAINT fk1_participaciones FOREIGN KEY (codcaballo) REFERENCES CABALLOS(codcaballo),
CONSTRAINT ch_posicion CHECK (posicionfinal > 0)
);

CREATE TABLE CARRERAS(
codcarrera		VARCHAR2(4),
fechayhora		DATE,
importepremio		NUMBER(6),
apuestalimite		NUMBER(5,2),
CONSTRAINT pk_carreras PRIMARY KEY (codcarrera),
CONSTRAINT ch_fechayhora CHECK (TO_CHAR(fechayhora,'hh24:mi')BETWEEN '09:00' AND '14:30'),
CONSTRAINT ch_apuestalimite CHECK (apuestalimite < 20000)
);

ALTER TABLE PARTICIPACIONES ADD CONSTRAINT fk2_participaciones FOREIGN KEY (codcarrera) REFERENCES CARRERAS(codcarrera);

CREATE TABLE APUESTAS(
dnicliente	VARCHAR2(10),
codcaballo	VARCHAR2(4),
codcarrera	VARCHAR2(4),
importe		NUMBER(6) DEFAULT 300 NOT NULL,
tantoporuno	NUMBER(4,2),
CONSTRAINT pk_apuestas PRIMARY KEY (dnicliente,codcaballo,codcarrera),
CONSTRAINT fk1_apuestas FOREIGN KEY (codcaballo) REFERENCES CABALLOS(codcaballo) ON DELETE CASCADE,
CONSTRAINT fk2_apuestas FOREIGN KEY (codcarrera) REFERENCES CARRERAS(codcarrera) ON DELETE CASCADE,
CONSTRAINT ch_tantoporuno CHECK (tantoporuno > 1)
);

CREATE TABLE CLIENTES(
dni 		VARCHAR2(10),
nombre 		VARCHAR2(20),
nacionalidad 	VARCHAR2(20),
CONSTRAINT PK_CLIENTES PRIMARY KEY(dni),
CONSTRAINT CK_CLIENTES CHECK(regexp_like(dni,'[0-9]{8}[A-Z]{1}')),
CONSTRAINT CK2_CLIENTES CHECK (nacionalidad = UPPER (nacionalidad))
);

ALTER TABLE APUESTAS ADD CONSTRAINT fk3_apuestas FOREIGN KEY(dnicliente) REFERENCES CLIENTES(dni) ON DELETE CASCADE;

--Inserta el registro o registros necesarios para guardar la siguiente información:
--El cliente escocés realiza una apuesta al caballo más pesado de la primera carrera que se corra en el verano de 2009 por un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1.
INSERT INTO CLIENTES(dni,nacionalidad)
VALUES ('47545324X','ESCOCES');

INSERT INTO CABALLOS(codcaballo,nombre,peso)
VALUES ('1','RAYO',299);

INSERT INTO CARRERAS(codcarrera,fechayhora)
VALUES ('1',TO_DATE('09/06/2009 10:00','DD/MM/YYYY HH:MI'));

INSERT INTO APUESTAS
VALUES ('47545324X','1','1',2000,30.1);

--Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos.
INSERT INTO CARRERAS(codcarrera)
VALUES ('C6');
INSERT INTO CABALLOS(codcaballo,nombre)
VALUES ('2','Trueno');
INSERT INTO PARTICIPACIONES (codcaballo,codcarrera,dorsal,jockey)
VALUES ('2','C6',16,'2');
INSERT INTO CABALLOS(codcaballo,nombre)
VALUES ('3','Bestia');
INSERT INTO PARTICIPACIONES (codcaballo,codcarrera,dorsal,jockey)
VALUES ('3','C6',13,'3');

--Inserta dos carreras con los datos que creas necesario.
INSERT INTO CARRERAS(codcarrera)
VALUES ('C1');
INSERT INTO CARRERAS(codcarrera)
VALUES ('C2');

--Quita el campo propietario de la tabla caballos
ALTER TABLE CABALLOS DROP COLUMN propietario;

--Añadir las siguientes restricciones a las tablas:

--En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT ch_jockeys CHECK (jockey = INITCAP (jockey));

--La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
ALTER TABLE CARRERAS ADD CONSTRAINT ch_temporada CHECK fechahora (TO_CHAR(fechayhora,'DD')>='10' AND TO_CHAR(fechayhora , 'MM')='3' OR TO_CHAR(fechayhora,'MM')>3 AND TO_CHAR(fechayhora,'DD')<=10 AND TO_CHAR(fechayhora,'MM')=11 OR TO_CHAR(fechayhora,'MM'<11));

--La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.
ALTER TABLE CABALLOS ADD CONSTRAINT ch_conjuntonaciones CHECK (nacionalidad IN ('Española','Británica','Árabe')); 
     
--Borra las carreras en las que no hay caballos inscritos.
DELETE FROM PARTICIPACIONES
WHERE codcaballo IS NULL;

--AÃ±ade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos
ALTER TABLE CLIENTES ADD codigo VARCHAR2(4) NOT NULL;

--Nos hemos equivocado y el código C6 de la carrera en realidad es C66.
UPDATE CARRERAS
SET codcarrera ='C66'
WHERE codcarrera = 'C6';

--Añade un campo llamado premio a la tabla apuestas.
ALTER TABLE APUESTAS ADD premio NUMBER(20);


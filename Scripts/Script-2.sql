--1. Crear las siguientes tablas con las restricciones que se especifican e inserta registros
CREATE TABLE CABALLOS(
codcaballo			VARCHAR2(4),
nombre				VARCHAR2(20) NOT NULL,
peso				NUMBER(3),
fecha_nacimiento	DATE,
propietario			VARCHAR2(25),
nacionalidad		VARCHAR2(20),
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
posicionfinal	NUMBER(2),
CONSTRAINT pk_participaciones PRIMARY KEY (codcaballo,codcarrera),
CONSTRAINT fk1_participaciones FOREIGN KEY (codcaballo) REFERENCES CABALLOS(codcaballo),
CONSTRAINT ch_posicion CHECK (posicionfinal > 0)
);










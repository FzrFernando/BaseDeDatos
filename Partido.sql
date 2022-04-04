CREATE TABLE EQUIPOS(
cod_equipo	VARCHAR2(4),
nombre		VARCHAR2(30) NOT NULL,
localidad	VARCHAR2(15),
CONSTRAINT pk_equipos PRIMARY KEY (cod_equipo)
);

CREATE TABLE JUGADORES(
cod_jugador			VARCHAR2(4),
nombre				VARCHAR2(30) NOT NULL,
fecha_nacimiento	DATE,
demarcacion			VARCHAR2(10),
cod_equipo			VARCHAR2(4),
CONSTRAINT pk_jugadores PRIMARY KEY (cod_jugador),
CONSTRAINT fk_jugadores FOREIGN KEY (cod_equipo) REFERENCES EQUIPOS(cod_equipo)
);

CREATE TABLE PARTIDOS(
cod_partido				VARCHAR2(4),
cod_equipo_local		VARCHAR2(4),
cod_equipo_visitante	VARCHAR2(4),
fecha					DATE,
competicion				VARCHAR2(4),
jornada					VARCHAR2(20),
CONSTRAINT pk_partidos PRIMARY KEY (cod_partido),
CONSTRAINT fk_partidos FOREIGN KEY (cod_equipo_local) REFERENCES EQUIPOS(cod_equipo),
CONSTRAINT fk_partidos2 FOREIGN KEY (cod_equipo_visitante) REFERENCES EQUIPOS(cod_equipo),
CONSTRAINT ch_competicion CHECK (competicion IN ('Copa','Liga')),
CONSTRAINT ch_fecha CHECK (EXTRACT(MONTH FROM fecha) NOT IN (7,8))
);

CREATE TABLE INCIDENCIAS(
num_incidencia	VARCHAR2(6),
cod_partido		VARCHAR2(4),
cod_jugador		VARCHAR2(4),
minuto			NUMBER(2),
tipo			VARCHAR2(20),
CONSTRAINT pk_incidencias PRIMARY KEY (num_incidencia),
CONSTRAINT fk_incidencias FOREIGN KEY (cod_partido) REFERENCES PARTIDOS(cod_partido),
CONSTRAINT fk_incidencias2 FOREIGN KEY (cod_jugador) REFERENCES JUGADORES(cod_jugador),
CONSTRAINT ch_minuto CHECK (minuto BETWEEN 1 AND 99)
);

ALTER TABLE JUGADORES ADD CONSTRAINT ch_demarcacion CHECK (demarcacion IN ('PORTERO','DEFENSA','MEDIO','DELANTERO'));
ALTER TABLE INCIDENCIAS MODIFY tipo NOT NULL;
ALTER TABLE EQUIPOS ADD golesmarcados NUMBER(3);

--SELECT * FROM user_tables;




CREATE TABLE VEHICULOS(
matricula		VARCHAR2(7),
marca			VARCHAR2(10) NOT NULL,
modelo			VARCHAR2(10) NOT NULL,
fecha_compra	DATE,
precio_por_dia	NUMBER(5,2),
CONSTRAINT pk_vehiculos PRIMARY KEY (matricula),
CONSTRAINT ch_precio CHECK (precio_por_dia > 0),
CONSTRAINT ch_fecha CHECK (EXTRACT(YEAR FROM fecha_compra) >= 2001)
);

CREATE TABLE CLIENTES(
dni					VARCHAR2(9),
nombre				VARCHAR2(30) NOT NULL,
nacionalidad		VARCHAR2(30),
fecha_nacimiento	DATE,
direccion			VARCHAR2(50),
CONSTRAINT pk_clientes PRIMARY KEY (dni)
);

CREATE TABLE ALQUILERES(
matricula	VARCHAR2(7) NOT NULL,
dni			VARCHAR2(10) NOT NULL,
fecha_hora	DATE,
num_dias	NUMBER(2) NOT NULL,
kilometros	NUMBER(4) DEFAULT 0,
CONSTRAINT pk_alquileres PRIMARY KEY (matricula,dni,fecha_hora),
CONSTRAINT fk1_alquileres FOREIGN KEY (matricula) REFERENCES VEHICULOS(matricula),
CONSTRAINT fk2_alquileres FOREIGN KEY (dni) REFERENCES CLIENTES(dni)
);

ALTER TABLE VEHICULOS ADD kilometros_recorridos NUMBER(6);
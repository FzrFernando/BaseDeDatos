CREATE TABLE COMERCIAL(
id			INTEGER(10),
nombre		VARCHAR(100),
apellido1	VARCHAR(100),
apellido2	VARCHAR(100),
ciudad		VARCHAR(100),
comision	FLOAT,
CONSTRAINT pk_comercial PRIMARY KEY (id)
);

CREATE TABLE PEDIDO(
id				INTEGER(10),
cantidad		DOUBLE,
fecha			DATE,
id_cliente		INTEGER(10),
id_comercial	INTEGER(10),
CONSTRAINT pk_pedido PRIMARY KEY (id),
CONSTRAINT fk1_pedido FOREIGN KEY (id_comercial) REFERENCES COMERCIAL(id)
);

CREATE TABLE CLIENTE(
id			INTEGER(10),
nombre		VARCHAR(100),
apellido1	VARCHAR(100),
apellido2	VARCHAR(100),
ciudad		VARCHAR(100),
categoria	INTEGER(10),
CONSTRAINT pk_cliente PRIMARY KEY (id)
);

ALTER TABLE PEDIDO ADD CONSTRAINT fk2_pedido FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id);
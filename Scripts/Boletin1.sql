CREATE TABLE EMPLEADO(
codigo				INTEGER(10),
nif 				VARCHAR(9),
nombre 				VARCHAR(100),
apellido1			VARCHAR(100),
apellido2			VARCHAR(100),
codigo_departamento	INTEGER(10),
CONSTRAINT pk_empleado PRIMARY KEY (codigo)
);

CREATE TABLE DEPARTAMENTO(
codigo		INT(10),
nombre		VARCHAR(100),
presupuesto	DOUBLE,
CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

ALTER TABLE EMPLEADO ADD CONSTRAINT fk1_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo);
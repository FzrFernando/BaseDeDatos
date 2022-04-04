CREATE TABLE EMPLEADO(
codigo				NUMBER(10),
nif					VARCHAR2(9),
nombre				VARCHAR2(100),
apellido1			VARCHAR2(100),
apellido2			VARCHAR2(100),
codigo_departamento	NUMBER(10),
CONSTRAINT pk_empleado PRIMARY KEY (codigo)
);

CREATE TABLE DEPARTAMENTO(
codigo	NUMBER(10),
nombre	VARCHAR2(100),
presupuesto	NUMBER(5,2),
CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo);
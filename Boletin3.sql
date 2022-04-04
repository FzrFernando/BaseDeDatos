CREATE TABLE DEPARTAMENTO(
id		NUMBER(10),
nombre	VARCHAR2(50),
CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE PROFESOR(
id_profesor		NUMBER(10),
id_departamento	NUMBER(10),
CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
CONSTRAINT fk1_profesor FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento),
CONSTRAINT fk2_profesor FOREIGN KEY (id_profesor) REFERENCES PERSONA(id)
);


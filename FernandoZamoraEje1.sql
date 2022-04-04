/*alter session set "_oracle_script"=true;  
create user ZamoraFernandoEje1 identified by ZamoraFernandoEje1;
GRANT CONNECT, RESOURCE, DBA TO ZamoraFernandoEje1;*/

CREATE TABLE T_MAESTRO(
suscripcion		NUMBER(5),
alta			DATE,
nombre			VARCHAR2(20) NOT NULL,
direccion		VARCHAR2(30),
barrio			VARCHAR2(16),
saldoactual		NUMBER(10,2),
estrato			NUMBER(5),
mail			VARCHAR2(80) UNIQUE,
fechaalta		DATE DEFAULT SYSDATE,
CONSTRAINT pk_maestro PRIMARY KEY (suscripcion),
CONSTRAINT ch_suscripcion CHECK (suscripcion > 0),
CONSTRAINT ch_fechaalta CHECK (fechaalta>TO_DATE('01/01/1990','DD/MM/YYYY'))
);

CREATE TABLE T_ESTRATO(
estrato			NUMBER(5),
descripcion		VARCHAR2(50),
totalusuarios	NUMBER(4) DEFAULT 0,
CONSTRAINT pk_estrato PRIMARY KEY (estrato),
CONSTRAINT ch_estrato CHECK (estrato > 39),
CONSTRAINT ch_totalusuarios CHECK (totalusuarios >= 0)
);

ALTER TABLE T_MAESTRO ADD CONSTRAINT fk1_maestro FOREIGN KEY (estrato) REFERENCES T_ESTRATO(estrato);

CREATE TABLE T_CARGOS(
idcargo				VARCHAR2(2),
descripcioncargo	VARCHAR2(50),
CONSTRAINT pk_cargos PRIMARY KEY (idcargo),
CONSTRAINT ch_idcargo CHECK (idcargo IN ('FC','RC','RF','CO'))
);

CREATE TABLE T_SERVICIOS(
servicio			VARCHAR2(3),
nservicio			NUMBER(4),
descripcionservicio	VARCHAR2(200) NOT NULL,
cupousuarios		NUMBER(6),
nusuarios			NUMBER(10) DEFAULT 0,
testrato			NUMBER(5),
importefijo			NUMBER(8,2),
valorconsumo		NUMBER(10,2),
CONSTRAINT pk_servicios PRIMARY KEY (servicio,nservicio),
CONSTRAINT ch_nusuarios CHECK (nusuarios >= 0),
CONSTRAINT fk1_servicios FOREIGN KEY (testrato) REFERENCES T_ESTRATO(estrato)
);

CREATE TABLE T_MOVIMIENTOS(
id_cliente		NUMBER(5) NOT NULL,
fechaimporte	DATE DEFAULT SYSDATE,
fechamovimineto	DATE,
cargo_aplicado	VARCHAR2(2) NOT NULL,
servicio		VARCHAR2(3) NOT NULL,
nservicio		NUMBER(4) NOT NULL,		
consumo			NUMBER(10,2) NOT NULL,
importefac		NUMBER(10,2) NOT NULL,
importerec		NUMBER(10,2) NOT NULL,
impmorterefa	NUMBER(10,2) NOT NULL,
importeconv		NUMBER(10,2) NOT NULL,
CONSTRAINT pk_movimientos PRIMARY KEY (id_cliente,cargo_aplicado,servicio,nservicio),
CONSTRAINT fk1_movimientos FOREIGN KEY (cargo_aplicado) REFERENCES T_CARGOS(idcargo),
CONSTRAINT fk2_movimientos FOREIGN KEY (servicio, nservicio) REFERENCES T_SERVICIOS(servicio,nservicio)
);

--ALTER TABLE T_MAESTRO ADD CONSTRAINT fk2_maestro FOREIGN KEY (suscripcion) REFERENCES T_MOVIMIENTOS(id_cliente);
--Al intentar añadir la foreign key da error porque la primary key está compuesta Error --> SQL Error [2270] [42000]: ORA-02270: no matching unique or primary key for this column-list


-- Añade el campo dni a la tabla t_maestro, teniendo que ser un campo único.
ALTER TABLE T_MAESTRO ADD dni VARCHAR2(9) UNIQUE;

--Elimina el campo bario de la tabla t_maestro.
ALTER TABLE T_MAESTRO DROP COLUMN barrio;

--Amplía el campo descripción de la tabla t_estratos en 10 caracteres.
ALTER TABLE T_ESTRATO MODIFY descripcion VARCHAR2(60);

--Elimina todas las tablas creadas.
DROP TABLE T_MAESTRO CASCADE CONSTRAINT;
DROP TABLE T_ESTRATO CASCADE CONSTRAINT;
DROP TABLE T_CARGOS CASCADE CONSTRAINT;
DROP TABLE T_SERVICIOS CASCADE CONSTRAINT;
DROP TABLE T_MOVIMIENTOS CASCADE CONSTRAINT;





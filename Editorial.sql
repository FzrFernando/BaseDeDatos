CREATE TABLE EDITORIAL(
cod_editorial	NUMBER(10),
denominacion	VARCHAR2(60),
CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE TEMA(
cod_tema		NUMBER(10),
denominacion	VARCHAR2(60),
cod_tema_padre	NUMBER(10),
CONSTRAINT pk_tema PRIMARY KEY (cod_tema),
CONSTRAINT fk_tema FOREIGN KEY (cod_tema_padre) REFERENCES TEMA(cod_tema) ON DELETE CASCADE,
CONSTRAINT ch_cod_tema CHECK (cod_tema_padre >= cod_tema)
);

CREATE TABLE AUTOR(
cod_autor		NUMBER(10),
nombre			VARCHAR2(25),
f_nacimiento	DATE,
libro_principal	NUMBER(10),
CONSTRAINT pk_autor PRIMARY KEY (cod_autor)
);

CREATE TABLE LIBRO(
cod_libro		NUMBER(10),
titulo			VARCHAR2(30),
f_creacion		DATE,
cod_tema		NUMBER(10),
autor_principal	NUMBER(10),
CONSTRAINT pk_libro PRIMARY KEY (cod_libro),
CONSTRAINT fk_libro FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema),
CONSTRAINT fk_libro2 FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
);

ALTER TABLE AUTOR ADD CONSTRAINT fk_autor FOREIGN KEY (libro_principal) REFERENCES LIBRO(cod_libro) ON DELETE SET NULL;

CREATE TABLE LIBRO_AUTOR(
cod_libro	NUMBER(10),
cod_autor	NUMBER(10),
orden		NUMBER(1),
CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro,cod_autor),
CONSTRAINT fk_libro_autor FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro) ON DELETE CASCADE,
CONSTRAINT fk_libro_autor2 FOREIGN KEY (cod_autor) REFERENCES AUTOR(cod_autor) ON DELETE CASCADE,
CONSTRAINT ch_orden CHECK (orden BETWEEN 1 AND 5)
);

CREATE TABLE PUBLICACIONES(
cod_editorial	NUMBER(10),
cod_libro		NUMBER(10),
precio			NUMBER(4,2) NOT NULL,
f_publicacion	DATE,
CONSTRAINT pk_publicaciones PRIMARY KEY (cod_editorial,cod_libro),
CONSTRAINT fk_publicaciones FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial) ON DELETE CASCADE,
CONSTRAINT fk_publicaciones2 FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro) ON DELETE CASCADE,
CONSTRAINT ch_precio CHECK (precio > 0)
);


DROP TABLE TEMA CASCADE CONSTRAINTS;
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE EDITORIAL CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;
DROP TABLE LIBRO_AUTOR CASCADE CONSTRAINTS;
DROP TABLE PUBLICACIONES CASCADE CONSTRAINTS;

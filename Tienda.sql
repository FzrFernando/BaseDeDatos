CREATE TABLE ARTICULOS(
articulo		VARCHAR2(20),
cod_fabricante	NUMBER(3),
peso			NUMBER(3),
categoria		VARCHAR2(10),
precio_venta	NUMBER(4,2),
precio_costo	NUMBER(4,2),
existencias		NUMBER(5),
CONSTRAINT pk_articulos PRIMARY KEY (articulo,cod_fabricante,peso,categoria),
CONSTRAINT ch_mayor0 CHECK (precio_venta > 0 AND precio_costo > 0 AND peso > 0),
CONSTRAINT ch_categoria CHECK (categoria IN('PRIMERA','SEGUNDA','TERCERA'))
);

CREATE TABLE TIENDAS(
nif			VARCHAR2(10),
nombre		VARCHAR2(20),
direccion	VARCHAR2(20),
poblacion	VARCHAR2(20),
provincia	VARCHAR2(20),
codpostal	NUMBER(5),
CONSTRAINT pk_tiendas PRIMARY KEY (nif),
CONSTRAINT ch_provincia CHECK (UPPER(provincia)=provincia)
);

CREATE TABLE FABRICANTES(
cod_fabricante	NUMBER(3),
nombre			VARCHAR2(15),
pais			VARCHAR2(15),
CONSTRAINT pk_fabricantes PRIMARY KEY (cod_fabricante),
CONSTRAINT ch_mayusculas CHECK (UPPER(nombre)=nombre AND UPPER(pais)=pais) 
);

ALTER TABLE ARTICULOS ADD CONSTRAINT fk_articulos FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante);

CREATE TABLE PEDIDOS (
nif					VARCHAR2(10),
articulo			VARCHAR2(20),
cod_fabricante		NUMBER(3),
peso 				NUMBER(3),
categoria 			VARCHAR2(10),
fecha_pedido 		DATE,
unidades_pedidas	NUMBER(4),
CONSTRAINT pk_pedidos PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT ch_pedidos CHECK(unidades_pedidas>0),
CONSTRAINT fk2_pedidos FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
CONSTRAINT fk3_pedidos FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
);

CREATE TABLE VENTAS(
nif					VARCHAR2(10),
articulo			VARCHAR2(20),
cod_fabricante		NUMBER(3),
peso				NUMBER(3),
categoria			VARCHAR2(10),
fecha_venta			DATE DEFAULT SYSDATE,
unidades_vendidas	NUMBER(4),
CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
CONSTRAINT fk1_ventas FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT ch_ventas CHECK(unidades_vendidas>0),
CONSTRAINT fk2_ventas FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
CONSTRAINT fk3_ventas FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
);

--Modificar las columnas de las tablas pedidos y ventas para que las
--unidades_vendidas y las unidades_pedidas puedan almacenar cantidades num�ricas
--de 6 digitos.
ALTER TABLE PEDIDOS MODIFY unidades_pedidas NUMBER(6);
ALTER TABLE VENTAS MODIFY unidades_vendidas NUMBER(6);

--A�adir a las tablas pedidos y ventas una nueva columna para que almacenen el PVP
--del articulo
ALTER TABLE PEDIDOS ADD pvp NUMBER(5,2);
ALTER TABLE VENTAS ADD pvp NUMBER(5,2);

--Borra la columna pais de la tabla fabricante
ALTER TABLE FABRICANTES DROP CONSTRAINT ch_mayusculas;
ALTER TABLE FABRICANTES DROP COLUMN pais;

--A�ade una restriccion que indique que las unidades vendidas son como minimo 100
ALTER TABLE VENTAS ADD CONSTRAINT ch_unidades CHECK (unidades_vendidas>=100)

--Borra todas las tablas
DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE FABRICANTE CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
DROP TABLE TIENDA CASCADE CONSTRAINT;
DROP TABLE VENTAS CASCADE CONSTRAINT;












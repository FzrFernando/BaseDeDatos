CREATE TABLE BARCOS(
matricula		VARCHAR2(7),
nombre			VARCHAR2(20),
armador			VARCHAR2(20),
capacidad		NUMBER(10),
nacionalidad	VARCHAR2(25),
CONSTRAINT pk_barcos PRIMARY KEY (matricula)
);

CREATE TABLE LOTES(
codigo					VARCHAR2(10),
matricula				VARCHAR2(7),
numkilos				NUMBER(10),
precioporkilosalida		NUMBER(5,2),
precioporkiloadjudicado	NUMBER(6,2),
fechaventa				DATE,
cod_especie				VARCHAR2(10),
CONSTRAINT pk_lotes	PRIMARY KEY (codigo),
CONSTRAINT fk1_lotes FOREIGN KEY (matricula) REFERENCES BARCOS(matricula) ON DELETE CASCADE
);

CREATE TABLE ESPECIE(
codigo				VARCHAR2(10),
nombre				VARCHAR2(20),
tipo				VARCHAR2(15),
cupoporbarco		NUMBER(10),
caladero_principal	VARCHAR2(10),
CONSTRAINT pk_especie PRIMARY KEY (codigo)
);

ALTER TABLE LOTES ADD CONSTRAINT fk2_lotes FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo) ON DELETE CASCADE;

CREATE TABLE CALADERO(
codigo				VARCHAR2(10),
nombre				VARCHAR2(20),
ubicacion			VARCHAR2(50),
especie_principal	VARCHAR2(10),
CONSTRAINT pk_caladero PRIMARY KEY (codigo),
CONSTRAINT fk_caladero FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo) ON DELETE SET NULL
);

ALTER TABLE ESPECIE ADD CONSTRAINT fk1_especie FOREIGN KEY (caladero_principal) REFERENCES CALADERO(codigo);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS(
cod_especie		VARCHAR2(10),
cod_caladero	VARCHAR2(10),
fecha_inicial	DATE,
fecha_final		DATE,
CONSTRAINT pk_fechas_capturas_permitidas PRIMARY KEY (cod_especie,cod_caladero),
CONSTRAINT fk1_fechas_capturas_permitidas FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
CONSTRAINT fk2_fechas_capturas_permitidas FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
);

--La matricula de los barcos empieza por dos letras mayusculas, luego tiene un guion y luego cuatro numeros
ALTER TABLE BARCOS ADD CONSTRAINT ch_matricula CHECK (regexp_like(matricula,'^[A-Z]{2}[-]{1}[0-9]{4}'));

--La fechaventa de la tabla lotes no admite valores nulos
ALTER TABLE LOTES MODIFY fechaventa DATE NOT NULL;

--El campo precioporkiloadjudicado debe ser mayor que el campo precioporkilosalida.
ALTER TABLE LOTES ADD CONSTRAINT ch_preciomayor CHECK (precioporkiloadjudicado > precioporkilosalida);

--El campo numkilos y los campos precio de la tabla lotes deben ser mayor que cero
ALTER TABLE LOTES ADD CONSTRAINT ch_precio CHECK (numkilos > 0 AND precioporkiloadjudicado > 0 AND precioporkilosalida > 0);

--El campo nombre y ubicacion de la tabla caladero deben estar siempre en may�sculas.
ALTER TABLE CALADERO ADD CONSTRAINT ch_mayusculas CHECK (UPPER(nombre)=nombre AND UPPER(ubicacion)=ubicacion);

--Hay que tener en cuenta que en ningun caladero se permite ninguna captura de especie desde el 2 de febrero al 28 de marzo
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT ch_captura_permitida CHECK (fecha_inicial<to_date('02/02/2020','DD/MM/YYYY') AND fecha_final>to_date('28/03/2020','DD/MM/YYYY'));

--Añade un nuevo campo a la tabla caladero que almacene el nombre cientifico.
ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(70);

--Descactivar la constraint de que el precioporkiloadjudicado sea mayor que precioporkilosalida
ALTER TABLE LOTES DISABLE CONSTRAINT ch_preciomayor;

--Activar la constraint de que el precioporkiloadjudicado sea mayor que precioporkilosalida
--ALTER TABLE LOTES ENABLE CONSTRAINT ch_preciomayor;




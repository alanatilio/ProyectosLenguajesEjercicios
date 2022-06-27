Create database HOTEL_SORIAN

use HOTEL_SORIAN

CREATE TABLE RECEPCIONISTA(
COD_REC VARCHAR(4)	NOT NULL,
APE_PAT	VARCHAR(18)	NOT NULL,
APE_MAT	VARCHAR(18)	NOT NULL,
NOMBRES	VARCHAR(20)	NOT NULL,
DIRECTI	VARCHAR(25)	NOT NULL,
TELEFON	VARCHAR(9)	NOT NULL,
FECHANA DATE		NOT NULL,

PRIMARY KEY (COD_REC),

CHECK (COD_REC LIKE 'R[0-9][0-9][0-9]')
);

CREATE TABLE HUESPED(
COD_HUE		CHAR(4)		NOT NULL,
APE_PAT		VARCHAR(18)	NOT NULL,
APE_MAT		VARCHAR(18)	NOT NULL,
NOMBRES		VARCHAR(20)	NOT NULL,
NACION		VARCHAR(25)	NOT NULL,
TIPO_DOC	VARCHAR(20)	NOT NULL,
NUM_DOC		VARCHAR(9)	NOT NULL,
SEXO		VARCHAR(1),

PRIMARY KEY (COD_HUE),

CHECK (COD_HUE LIKE 'H[0-9][0-9][0-9]'),
CHECK (SEXO = 'F' OR SEXO ='M')
);

CREATE TABLE CLASIFICACION(
TIPO_CLA CHAR(3) NOT NULL,
DETALLE VARCHAR(55),
DESCRIP VARCHAR(55),

PRIMARY KEY (TIPO_CLA),

CHECK (TIPO_CLA LIKE 'C[0-9][0-9]')
);

CREATE TABLE HABITACION(
NRO_HAB INT IDENTITY NOT NULL,
TIPO	CHAR(25) NOT NULL,
PISO	SMALLINT	NOT NULL,
BA�O	SMALLINT	NOT NULL,
AGUA_CAL BIT,
VISTA_MAR	BIT  DEFAULT 1,
NUM_CAMAS SMALLINT	DEFAULT 1 NOT NULL,
PRECIO MONEY NOT NULL,
TIPO_CLA CHAR(3) NOT NULL,

PRIMARY KEY (NRO_HAB),
FOREIGN KEY (TIPO_CLA) References CLASIFICACION(TIPO_CLA),
CHECK (AGUA_CAL = '1' OR AGUA_CAL ='0')
);


CREATE TABLE FICHA_ESTADO(
NRO_FICHA INT IDENTITY,
NRO_HAB INT NOT NULL,
FECHA_HORA DATETIME NOT NULL,
ACTIVO CHAR(50),
DETALLE VARCHAR(100),

PRIMARY KEY (NRO_FICHA),
FOREIGN KEY (NRO_HAB) References HABITACION(NRO_HAB)
);


CREATE TABLE PRODUCTOS(
COD_PRO VARCHAR(3) NOT NULL,
NOMBRE VARCHAR(50) NOT NULL,
PRECIO MONEY NOT NULL,

PRIMARY KEY (COD_PRO),

CHECK (COD_PRO LIKE 'P[0-9][0-9]')
);

CREATE TABLE RESERVA_HABITACION(
ORDEN INT IDENTITY,
NRO_HAB INT NOT NULL,
FECHA_HORA_INGRESO DATETIME NOT NULL,
FECHA_HORA_SALIDA DATETIME NOT NULL,
COD_REC VARCHAR(4) NOT NULL,

PRIMARY KEY (ORDEN),

Foreign key (NRO_HAB) References HABITACION(NRO_HAB),
Foreign key (COD_REC) References RECEPCIONISTA(COD_REC)
);


CREATE TABLE BOLETA(
NRO_BOLE INT IDENTITY,
ORDEN INT,
FECHA DATETIME NOT NULL,

PRIMARY KEY (NRO_BOLE),
FOREIGN KEY (ORDEN) References RESERVA_HABITACION(ORDEN)
);

CREATE TABLE DETALLE_BOLETA(
NRO_BOLE INT ,
COD_PROD VARCHAR(3) NOT NULL,
PRECIO MONEY NOT NULL,
CANTIDAD INT default 0 NOT NULL,
IMPORTE AS PRECIO * CANTIDAD,

Foreign key (NRO_BOLE) References BOLETA(NRO_BOLE),
Foreign key (COD_PROD) References PRODUCTOS(COD_PRO)
);

CREATE TABLE HUESPED_LIBRO(
CODI_HUES CHAR(4) NOT NULL,
ORDEN INT NOT NULL,

Foreign key (CODI_HUES) References HUESPED(COD_HUE),
Foreign key (ORDEN) References RESERVA_HABITACION(ORDEN)
);

INSERT INTO RECEPCIONISTA VALUES
('R001','MAYTA','CHAMBILLA','ALFREDO','AV JORJE CHAVES','986352147','1995-05-25'),
('R002','GARMENDIA','FLORES','FRANCISCO','AV BOLOGNESI','985896314','1999-09-30'),
('R003','VALDIVIA','CHOQUE','ANAVEL','AV MARIATEGUI','978635218','1996-12-25'),
('R004','VALDERRAMA','AUINO','SAMUEL','AV VERMEJO','983657412','2000-11-28'),
('R005','BENTURA','VERMEJO','FIORELA','AV AREQUIPA','97896327','2001-05-01')

INSERT INTO HUESPED VALUES
('H001','FERSADUA','VENRACRUS','CAMILA','CHILE','CE','74589316','F'),
('H002','ESLOBEJO','CANASA','FORTUNATO','ARGENTINA','CE','15798956','M'),
('H003','CASTILLO','ALBALUNA','AROM','ESPA�A','CE','23968745','M'),
('H004','CONDEBITA','MARTINES','MIRIAM','COLOMBIA','CE','58963147','F'),
('H005','WALQUIERT','CABRERA','LOAURA','ESTADOS UNIDOS','PASAPORTE','00125879','F')

INSERT INTO CLASIFICACION VALUES
('C01','PRESIDENCIAL','MUEBLES LUJOSOS INCLUIDOS CON SERVICIO A CUARTO PROPIO'),
('C02','FAMILIAR','MUCHAS HABITACIONES Y CON BA�OS GRANDES'),
('C03','VIP','ULTIMOS PISOS, LAS MEJORES VISTAS'),
('C04','NORMAL','HABITACIONES NORMALES, ACOJEDORES Y AMPLIOS')

INSERT INTO HABITACION VALUES
('DIARIO',5,2,1,1,3,299,'C02'),
('DIARIO',6,5,1,1,5,999,'C01'),
('DIARIO',7,1,1,1,2,359,'C03'),
('DIARIO',2,2,1,0,2,159,'C02'),
('DIARIO',3,2,1,1,3,99,'C04')

INSERT INTO PRODUCTOS VALUES
('P01','CHAMPA�A',599),
('P02','BUFET',259),
('P03','JUEGOS',150),
('P04','ENTRETENIMIETO',789),
('P05','DESAYUNOS',29)

INSERT INTO RESERVA_HABITACION VALUES
(6,'2022-05-18','2022-05-20','R001'),
(8,'2022-05-13','2022-05-16','R002'),
(9,'2022-05-12','2022-05-15','R003'),
(7,'2022-04-12','2022-04-15','R004'),
(10,'2022-03-12','2022-03-15','R002')


INSERT INTO BOLETA VALUES
(2,'2022-05-12'),
(3,'2022-05-13'),
(4,'2022-05-14'),
(5,'2022-05-15'),
(6,'2022-05-16')

INSERT INTO FICHA_ESTADO VALUES
(7,'2022-05-12 12:58','SI','TODO BIEN'),
(6,'2022-05-13 02:58','SI','TODO BIEN'),
(8,'2022-05-14 00:58','SI','TODO BIEN'),
(10,'2022-05-15 23:58','SI','TODO BIEN')

INSERT INTO DETALLE_BOLETA VALUES
(5,'P05',29,5),
(2,'P01',599,1),
(3,'P02',259,2),
(4,'P03',150,3),
(5,'P04',789,1)

INSERT INTO HUESPED_LIBRO VALUES
('H001',2),
('H002',3),
('H003',4),
('H004',5),
('H005',6)

SELECT * FROM BOLETA
SELECT * FROM CLASIFICACION
SELECT * FROM FICHA_ESTADO
SELECT * FROM HUESPED
SELECT * FROM HUESPED_LIBRO
SELECT * FROM RECEPCIONISTA
SELECT * FROM DETALLE_BOLETA
SELECT * FROM RESERVA_HABITACION
SELECT * FROM PRODUCTOS
SELECT * FROM HABITACION

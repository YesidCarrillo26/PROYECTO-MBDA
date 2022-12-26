--Tablas
CREATE TABLE Usuarios (
id NUMBER NOT NULL,
nombre VARCHAR(40) NOT NULL,
genero VARCHAR(10),
correo VARCHAR(40),
fechaNacimiento DATE NOT NULL);

CREATE TABLE Artistas (
idArtista NUMBER NOT NULL,
nombre VARCHAR(30) NOT NULL,
nacionalidad VARCHAR(30) NOT NULL,
fechaNacimiento DATE NOT NULL,
genero VARCHAR(10) NOT NULL,
banda VARCHAR(30));

CREATE TABLE BusquedaArtXGeneros (
artista NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaArtistas (
artista NUMBER NOT NULL,
usuario NUMBER NOT NULL);

CREATE TABLE Generos (
nombre VARCHAR(30) NOT NULL,
origenCultural VARCHAR(10),
descripcionGenero VARCHAR(50));

CREATE TABLE BusquedaGeneros (
usuario NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE Bandas (
nombre VARCHAR(30) NOT NULL,
descripcionBanda VARCHAR(50));

CREATE TABLE BusquedaBandas (
usuario NUMBER NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaBandaXGeneros (
genero VARCHAR(30) NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE Canciones (
nombre VARCHAR(50) NOT NULL,
version NUMBER NOT NULL,
artista NUMBER,
banda VARCHAR(30),
genero VARCHAR(30) NOT NULL);

CREATE TABLE Epocas (
fecha NUMBER NOT NULL,
cancion VARCHAR(50) NOT NULL,
version INT NOT NULL,
descripcionEpoca VARCHAR(50));


--Pks

ALTER TABLE Usuarios ADD CONSTRAINT Pk_Usuarios_id
    PRIMARY KEY (id);

ALTER TABLE Artistas ADD CONSTRAINT Pk_Artistas_idArtista
    PRIMARY KEY (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT Pk_BusArtXGen_artista_genero
    PRIMARY KEY (artista, genero);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT Pk_BusquedaArtistas_artista
    PRIMARY KEY (artista);

ALTER TABLE Generos ADD CONSTRAINT Pk_Generos_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT Pk_BusquedaGeneros_genero
    PRIMARY KEY (genero);

ALTER TABLE Bandas ADD CONSTRAINT Pk_Bandas_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT Pk_BusquedaBandas_banda
    PRIMARY KEY (banda);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT Pk_BusBanXGen_genero_banda
    PRIMARY KEY (genero, banda);

ALTER TABLE Canciones ADD CONSTRAINT Pk_Canciones_nombre_version
    PRIMARY KEY (nombre, version);

ALTER TABLE Epocas ADD CONSTRAINT Pk_Epocas_nombre_cancion
    PRIMARY KEY (fecha, cancion);

--Fks


ALTER TABLE Artistas ADD CONSTRAINT fk_Artistas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);
    
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);
    
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Artista
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
    
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
 
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones
    FOREIGN KEY (cancion,version)
    REFERENCES Canciones (nombre,version);


--Atributos
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_genero
    CHECK (genero IN ('hombre','mujer','otro'));
ALTER TABLE Artistas ADD CONSTRAINT CK_Artistas_genero
    CHECK (genero IN ('hombre','mujer','otro'));
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_correo
    CHECK (correo LIKE '%@%.%');
ALTER TABLE Epocas ADD CONSTRAINT CK_Epocas_fecha
    CHECK (1899 < fecha AND fecha < 2022);
ALTER TABLE Canciones ADD CONSTRAINT CK_Canciones_version
    CHECK (version>-1 AND version<16);


--Poblar

INSERT INTO Usuarios VALUES(1000181894, 'Sergio Otero', 'hombre', 'sergiootero@mail.com', to_date('26-02-2002', 'DD-MM-YYYY'));
INSERT INTO Usuarios VALUES(1000181895, 'Insertar Nombre Creible', 'otro', 'nosequieneseste@mail.com', to_date('27-02-2002', 'DD-MM-YYYY'));
INSERT INTO Usuarios VALUES(1000181896, 'una mujer', 'mujer', 'mujerreal@mail.com', to_date('27-02-2002', 'DD-MM-YYYY'));

INSERT INTO Generos VALUES('HIP HOP', NULL, 'EMINEM');
INSERT INTO Generos VALUES('Rock', 'Ska-P', NULL);
INSERT INTO Generos VALUES('Aleteo', NULL, 'Fumarato');

INSERT INTO BusquedaGeneros VALUES(1000181894,'HIP HOP');
INSERT INTO BusquedaGeneros VALUES(1000181895,'Rock');
INSERT INTO BusquedaGeneros VALUES(1000181896,'Aleteo');

INSERT INTO Bandas VALUES('Ska-p', 'Game Over');
INSERT INTO Bandas VALUES('Queen', 'Innuendo');
INSERT INTO Bandas VALUES('Foo Fighters', 'The colour and the shape');

INSERT INTO Artistas VALUES(123456789,'EMINEM','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombre', NULL);
INSERT INTO Artistas VALUES(123456787,'MERCURY','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombre', 'Queen');
INSERT INTO Artistas VALUES(123456788,'Witney','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'mujer', NULL);

INSERT INTO BusquedaArtistas VALUES(123456789,1000181894);
INSERT INTO BusquedaArtistas VALUES(123456787,1000181895);
INSERT INTO BusquedaArtistas VALUES(123456788,1000181896);

INSERT INTO BusquedaArtXGeneros VALUES(123456789,'HIP HOP');
INSERT INTO BusquedaArtXGeneros VALUES(123456787,'Rock');
INSERT INTO BusquedaArtXGeneros VALUES(123456788,'Aleteo');

INSERT INTO BusquedaBandas VALUES(1000181894,'Ska-p');
INSERT INTO BusquedaBandas VALUES(1000181895,'Queen');
INSERT INTO BusquedaBandas VALUES(1000181896,'Foo Fighters');

INSERT INTO Canciones VALUES('Fall', 1,123456789 , NULL, 'HIP HOP');
INSERT INTO Canciones VALUES('Pretender', 1,NULL , 'Foo Fighters', 'Rock');
INSERT INTO Canciones VALUES('Sax To Me', 2,123456788 , NULL, 'Aleteo');

INSERT INTO Epocas VALUES(1976, 'Fall',1, '1DSADAS');

INSERT INTO BusquedaBandaXGeneros VALUES('Rock','Ska-p');
INSERT INTO BusquedaBandaXGeneros VALUES('Rock','Queen');


--PoblarNooK
INSERT INTO Usuarios VALUES(1000181894, 'Sergio Otero', 'hombre', 'sergiootero@mail.com', to_date('26-02-2002', 'DD-MM-YYYY'));
INSERT INTO Usuarios VALUES(1000181895, 'Insertar Nombre Creible', 'otros', 'nosequieneseste@mail.com', to_date('27-02-2002', 'DD-MM-YYYY'));

INSERT INTO Generos VALUES('HIP HOP', 43, 'EMINEM');
INSERT INTO Generos VALUES('Rock', Ska-P, NULL);

INSERT INTO BusquedaGeneros VALUES(100018143s4,'HIP HOP' );
INSERT INTO BusquedaGeneros VALUES(1000181895,'Rock',45 );

INSERT INTO Bandas VALUES('Ska-pd', 5, 'Game Over');
INSERT INTO Bandas VALUES('Queen', 4, 76);

INSERT INTO Artistas VALUES(12345678649,'EMINEM','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombrde', NULL);
INSERT INTO Artistas VALUES(12345678749,'MERCURY','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombres', 'Queen');

INSERT INTO BusquedaArtistas VALUES(12345678943,1000181894);
INSERT INTO BusquedaArtistas VALUES(123456787,100018189532);

INSERT INTO BusquedaArtXGeneros VALUES(1234567289,'HIP HOP');
INSERT INTO BusquedaArtXGeneros VALUES(1234567847,'Rock');

INSERT INTO BusquedaBandas VALUES(1000181894,37);
INSERT INTO BusquedaBandas VALUES(10001818595,'Queen');

INSERT INTO Canciones VALUES('Fall', 1,123456789 , NULL, 53);

INSERT INTO Epocas VALUES(1976, 'Fall',1, '1DSADAS',324);

INSERT INTO BusquedaBandaXGeneros VALUES(67,'Ska-p');
INSERT INTO BusquedaBandaXGeneros VALUES('Rock',32);


--tuplas
ALTER TABLE Canciones ADD CONSTRAINT CK_Canciones_nullables
	CHECK ((artista LIKE NULL AND banda NOT LIKE NULL) OR (artista NOT LIKE NULL AND banda LIKE NULL));

--tuplasOK
INSERT INTO Canciones VALUES('We Will Rock you', 1, NULL, 'Queen', 'Rock');

--tuplasNoOK
INSERT INTO Canciones VALUES('We Will Rock you', 1, 'MERCURY', 'Queen', 'Rock');

--Acciones
ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Artistas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Bandas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE Epocas DROP CONSTRAINT fk_Epocas_Canciones;
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones FOREIGN KEY (cancion, version)
REFERENCES Canciones (nombre, version)
ON DELETE CASCADE;

--AccionesOK
DELETE FROM Canciones WHERE artista LIKE NULL ;
DELETE FROM Canciones WHERE banda LIKE NULL ;
DELETE FROM Epocas WHERE cancion LIKE NULL and version LIKE NULL ;

--Disparadores
/
CREATE OR REPLACE TRIGGER Usuarios_id
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    SELECT COUNT(id) + 1 INTO :NEW.id FROM Usuarios;
END Usuarios_id;
/
CREATE OR REPLACE TRIGGER Artistas_id
BEFORE INSERT ON Artistas
FOR EACH ROW
BEGIN
    SELECT COUNT(idArtista) + 1 INTO :NEW.idArtista FROM Artistas;
END Artistas_id;
/
CREATE OR REPLACE TRIGGER TR_UP_usuariosId
BEFORE UPDATE OF id ON Usuarios
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20020, 'No se puede cambiar la id');
END TR_UP_usuariosId;
/
CREATE OR REPLACE TRIGGER TR_UP_artistasId
BEFORE UPDATE OF idArtista ON Artistas
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20020, 'No se puede cambiar la id');
END TR_UP_artistasId;
/
--DisparadoresOK
INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento) VALUES('Julia', 'mujer', 'julia@mail.com', to_date('26-02-2000', 'DD-MM-YYYY'));
UPDATE Usuarios SET id = 1000181888 WHERE id = 1000181894;

INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda) VALUES('EMINEM','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombre', NULL);
UPDATE Artistas SET idArtista = 12345678999 WHERE idArtista = 123456789;

--DisparadoresNoOK
INSERT INTO Usuarios(1000545496, nombre, genero, correo, fechaNacimiento) VALUES('Julia', 'mujer', 'julia@mail.com', to_date('26-02-2000', 'DD-MM-YYYY'));
INSERT INTO Artistas VALUES(12345678999, 'EMINEM','Estadounidense', to_date('17-10-1972', 'DD-MM-YYYY'),'hombrde', NULL);

----Indices y Vistas

CREATE OR REPLACE VIEW Inf_Can_Ver
	AS (SELECT nombre, version
		FROM Canciones);

	
CREATE INDEX Inf_Id_Cor
	ON Usuarios(id, correo);

CREATE OR REPLACE VIEW Inf_Id_Cor
	AS (SELECT id, correo
		FROM Usuarios);


CREATE INDEX Inf_Can_Epo
	ON Epocas(cancion, fecha);

CREATE OR REPLACE VIEW Inf_Can_Epo
	AS (SELECT cancion, fecha
		FROM Epocas);
		

CREATE INDEX Inf_Ban_Des
	ON Bandas(nombre, descripcionBanda);

CREATE OR REPLACE VIEW Inf_Ban_Des
	AS (SELECT nombre, descripcionBanda
		FROM Bandas);
		

CREATE OR REPLACE VIEW Inf_Can_Epo
	AS (SELECT cancion, fecha
		FROM Epocas);
		
		
CREATE INDEX Inf_Nom_Ori
	ON Generos(nombre, origenCultural);

CREATE OR REPLACE VIEW Inf_Nom_Epo
	AS (SELECT nombre, origenCultural
		FROM Generos);

--IndicesVistasOK
SELECT * FROM Inf_Can_Ver;

----PAQUETES COMPONENTES
CREATE OR REPLACE PACKAGE PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        INSERT INTO Canciones(nombre, version, artista, banda, genero)
        VALUES(xnombre, xversion, xartista, xbanda, xgenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_CANCION_INF FOR
            SELECT * FROM Canciones;
            RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
        INSERT INTO Generos(nombre, origenCultural, descripcionGenero)
            VALUES(xnombre, xorigenCultural, xdescripcionGenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_GENERO_INF FOR
            SELECT * FROM Generos;
            RETURN CO_GENERO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Epocas AS
    PROCEDURE AD_Epocas(
        xfecha NUMBER,
        xcancion VARCHAR,
        xversion INT,
        xdescripcionEpoca VARCHAR);
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Epocas AS
    PROCEDURE AD_Epocas(
        xfecha NUMBER,
        xcancion VARCHAR,
        xversion INT,
        xdescripcionEpoca VARCHAR) IS
    BEGIN
        INSERT INTO Epocas(fecha, cancion, version, descripcionEpoca)
            VALUES(xfecha, xcancion, xversion, xdescripcionEpoca);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_EPOCA_INF FOR
            SELECT * FROM Epocas;
            RETURN CO_EPOCA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
	PROCEDURE UP_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
	PROCEDURE DEL_Artistas(
		xidArtista NUMBER);
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda)
            VALUES(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
	PROCEDURE UP_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
	BEGIN
		UPDATE Artistas SET nombre = xnombre, nacionalidad = xnacionalidad, fechaNacimiento = xfechaNacimiento, genero = xgenero, banda = xbanda;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
	END;
	PROCEDURE DEL_Artistas(
		xidArtista NUMBER) IS
	BEGIN 
		DELETE FROM Artistas WHERE idArtista = xidArtista;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
	END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_ARTISTA_INF FOR
            SELECT * FROM Artistas;
            RETURN CO_ARTISTA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento)
        VALUES(xnombre, xgenero, xcorreo, xfechaNacimiento);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, SQLERRM);
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        UPDATE Usuarios SET nombre = xnombre, genero = xgenero, correo = xcorreo, fechaNacimiento = xfechaNacimiento;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        DELETE FROM Usuarios WHERE id = xid;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_USUARIO_INF FOR
            SELECT * FROM Usuarios;
            RETURN CO_USUARIO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR);
	PROCEDURE UP_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR);
	PROCEDURE DEL_Bandas(
        xnombre VARCHAR);
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        INSERT INTO Bandas(nombre, descripcionBanda)
            VALUES(xnombre, xdescripcionBanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
    END;
	PROCEDURE UP_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR) IS
	BEGIN
		UPDATE Bandas SET nombre = xnombre, descripcionBanda = xdescripcionBanda;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
	END;
	PROCEDURE DEL_Bandas(
        xnombre VARCHAR) IS
	BEGIN 
		DELETE FROM Bandas WHERE nombre = xnombre;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,SQLERRM);
	END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_BANDA_INF FOR
            SELECT * FROM Bandas;
            RETURN CO_BANDA_INF;
        END;
END;
/

-------PAQUETES ACTORES
CREATE OR REPLACE PACKAGE PA_Cantante AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_Cantante AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        PC_Canciones.AD_Canciones(xnombre, xversion, xartista, xbanda, xgenero);
    END;
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
			CO_CANCION_INF := PC_Canciones.CO_Canciones();
			RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR);
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    PROCEDURE AD_Epocas(
        xfecha NUMBER,
        xcancion VARCHAR,
        xversion INT,
        xdescripcionEpoca VARCHAR);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        PC_Usuarios.AD_Usuarios(xnombre, xgenero, xcorreo, xfechaNacimiento);
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        PC_Usuarios.UP_Usuarios(xnombre, xgenero, xcorreo, xfechaNacimiento);
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        PC_Usuarios.DEL_Usuarios(xid);
    END;
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        PC_Bandas.AD_Bandas(xnombre, xdescripcionBanda);
    END;
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        PC_Artistas.AD_Artistas(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
    END;
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
		PC_Generos.AD_Generos(xnombre, xorigenCultural, xdescripcionGenero);
    END;
    PROCEDURE AD_Epocas(
        xfecha NUMBER,
        xcancion VARCHAR,
        xversion INT,
        xdescripcionEpoca VARCHAR) IS
    BEGIN
        PC_Epocas.AD_Epocas(xfecha, xcancion, xversion, xdescripcionEpoca);
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
			CO_USUARIO_INF := PC_Usuarios.CO_Usuario();
			RETURN CO_USUARIO_INF;
        END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
			CO_BANDA_INF := PC_Bandas.CO_Banda();
			RETURN CO_BANDA_INF;
        END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
            CO_ARTISTA_INF := PC_Artistas.CO_artista();
			RETURN CO_ARTISTA_INF;
        END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
			CO_GENERO_INF := PC_Generos.CO_Genero();
			RETURN CO_GENERO_INF;
        END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
			CO_EPOCA_INF := PC_Epocas.CO_Epoca();
			RETURN CO_EPOCA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PA_Gerente AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR);
	PROCEDURE UP_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR);
	PROCEDURE DEL_Bandas(
        xnombre NUMBER);
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
	PROCEDURE UP_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
	PROCEDURE DEL_Artistas(
        xidArtista NUMBER);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_Gerente AS
	PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        PC_Usuarios.AD_Usuarios(xnombre, xgenero, xcorreo, xfechaNacimiento);
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        PC_Usuarios.UP_Usuarios(xnombre, xgenero, xcorreo, xfechaNacimiento);
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        PC_Usuarios.DEL_Usuarios(xid);
    END;
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        PC_Bandas.AD_Bandas(xnombre, xdescripcionBanda);
    END;
	PROCEDURE UP_Bandas(
        xnombre VARCHAR,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        PC_Bandas.UP_Bandas(xnombre, xdescripcionBanda);
    END;
	PROCEDURE DEL_Bandas(
        xnombre NUMBER) IS
    BEGIN
        PC_Bandas.DEL_Bandas(xnombre);
    END;
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        PC_Artistas.AD_Artistas(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
    END;
	PROCEDURE UP_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        PC_Artistas.UP_Artistas(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
    END;
	PROCEDURE DEL_Artistas(
        xidArtista NUMBER) IS
    BEGIN
        PC_Artistas.DEL_Artistas(xidArtista);
    END;
	FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
			CO_USUARIO_INF := PC_Usuarios.CO_Usuario();
			RETURN CO_USUARIO_INF;
        END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
			CO_BANDA_INF := PC_Bandas.CO_Banda();
			RETURN CO_BANDA_INF;
        END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
            CO_ARTISTA_INF := PC_Artistas.CO_artista();
			RETURN CO_ARTISTA_INF;
        END;
	
END;
/


--------------------------------------CRUDok
EXEC PC_solicitudes.AD_solicitudes(to_date('20/09/21', 'DD/MM/YY'), 'P', 200, 'A', 'descri');
EXEC PC_vehiculos.AD_vehiculos('abc123', 12, 2012, 'V', '123456789');
EXEC PC_vehiculos.EL_vehiculos('abc123');
EXEC PC_vehiculos.UP_vehiculos('O');
EXEC PC_vehiculos.UP_vehiculos('P');
---------------------------------------CRUDNoOk
EXEC PC_solicitudes.AD_solicitudes('abc123'); --Faltan datos
EXEC PC_vehiculos.UP_vehiculos(123);--Es un entero, el esetado debe ser VARCHAR(1)
EXEC PC_vehiculos.UP_vehiculos(to_date('20/09/21', 'DD/MM/YY'), 'desc'); --Mas datos de los necesarios

------------------------------------SeguridadOk

--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.AD_Usuarios('andres','hombre','andres27@hotmail.com',to_date('20/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago','mujer','santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.DEL_Usuarios(312323);
EXEC PA_EmpleadoSpotify.AD_Bandas('andrest', 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro','frances',to_date('22/09/21', 'DD/MM/YY'),'hombre',NULL);
EXEC PA_EmpleadoSpotify.AD_Generos('rock','alemania','descripcion');
SELECT PA_EmpleadoSpotify.CO_Usuario() FROM Usuarios;
SELECT PA_EmpleadoSpotify.CO_Banda() FROM Bandas;
SELECT PA_EmpleadoSpotify.CO_artista() FROM Artistas;
SELECT PA_EmpleadoSpotify.CO_Genero() FROM Generos;
SELECT PA_EmpleadoSpotify.CO_Epoca() FROM Epocas;
--PA_Cantante
EXEC PA_Cantante.AD_Canciones('Show must go on',1,NULL,'Queen','rock');
SELECT PA_Cantante.CO_Canciones() FROM Canciones;



-------------------------------------SeguridadNoOk
--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago',7,'santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.AD_Bandas(2342, 2, 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro',frances,to_date('22/09/21', 'DD/MM/YY'),'hombre','zapato');
EXEC PA_EmpleadoSpotify.AD_Epocas(1876,hombre,3,'muy tranquila');
--PA_Cantante
EXEC PA_Cantante.AD_Cancion(65,2,'yesid','the beatles','rock');



--Seguridad
CREATE ROLE ES;
CREATE ROLE CA;
CREATE ROLE GE;

GRANT EXECUTE
ON PA_EmpleadoSpotify
TO ES;

GRANT EXECUTE
ON PA_Cantante
TO CA;

GRANT EXECUTE
ON PA_Gerente
TO GE;

--XSeguridad
REVOKE EXECUTE ON PA_EmpleadoSpotify FROM ES;
REVOKE EXECUTE ON PA_Cantante FROM CA;
REVOKE EXECUTE ON PA_Gerente FROM GE;

DROP ROLE ES;
DROP ROLE CA;
DROP ROLE GE;

--XPoblar
DELETE FROM BusquedaBandaXGeneros;
DELETE FROM Epocas;
DELETE FROM Canciones;
DELETE FROM BusquedaBandas;
DELETE FROM BusquedaArtXGeneros;
DELETE FROM BusquedaArtistas;
DELETE FROM Artistas;
DELETE FROM Bandas;
DELETE FROM BusquedaGeneros;
DELETE FROM Generos;
DELETE FROM Usuarios;

--XDisparadores
DROP TRIGGER Usuarios_id;
DROP TRIGGER Artistas_id;
DROP TRIGGER TR_UP_artistasId;
DROP TRIGGER TR_UP_usuariosId;


---XPaquetes
DROP PACKAGE PA_Cantante;
DROP PACKAGE PA_EmpleadoSpotify;

DROP PACKAGE PC_Canciones;
DROP PACKAGE PC_Generos;
DROP PACKAGE PC_Epocas;
DROP PACKAGE PC_Artistas;
DROP PACKAGE PC_Usuarios;
DROP PACKAGE PC_Bandas;

--XTablas
DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Artistas CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtXGeneros CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtistas CASCADE CONSTRAINTS;
DROP TABLE Generos CASCADE CONSTRAINTS;
DROP TABLE BusquedaGeneros CASCADE CONSTRAINTS;
DROP TABLE Bandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandaXGeneros CASCADE CONSTRAINTS;
DROP TABLE Canciones CASCADE CONSTRAINTS;
DROP TABLE Epocas CASCADE CONSTRAINTS;

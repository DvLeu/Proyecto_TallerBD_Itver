DELIMITER $$

-- Función para verificar la existencia de un registro en Catalogo_COL
CREATE FUNCTION Existe_Catalogo_COL(CA_CLAVE CHAR(3)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM Catalogo_COL
    WHERE CA_CLAVE = Catalogo_COL.CA_CLAVE;
    RETURN existe;
END $$

-- Trigger antes de insertar en Catalogo_COL
CREATE TRIGGER Antes_Insert_Catalogo_COL
BEFORE INSERT ON Catalogo_COL
FOR EACH ROW
BEGIN
    IF Existe_Catalogo_COL(NEW.CA_CLAVE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro ya existe en Catalogo_COL';
    END IF;
END $$

-- Trigger antes de actualizar en Catalogo_COL
CREATE TRIGGER Antes_Update_Catalogo_COL
BEFORE UPDATE ON Catalogo_COL
FOR EACH ROW
BEGIN
    IF NOT Existe_Catalogo_COL(OLD.CA_CLAVE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Catalogo_COL';
    END IF;
END $$

-- Trigger antes de eliminar en Catalogo_COL
CREATE TRIGGER Antes_Delete_Catalogo_COL
BEFORE DELETE ON Catalogo_COL
FOR EACH ROW
BEGIN
    IF NOT Existe_Catalogo_COL(OLD.CA_CLAVE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Catalogo_COL';
    END IF;
END $$

-- Función para verificar referencias en tablas hijas para Catalogo_COL
CREATE FUNCTION TieneReferencias_Catalogo_COL(CA_CLAVE CHAR(3)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM Lote
    WHERE CA_CLAVE = Lote.CA_CLAVE0 OR CA_CLAVE = Lote.CA_CLAVE1 OR CA_CLAVE = Lote.CA_CLAVE2;
    RETURN existe;
END $$

-- Trigger antes de eliminar en Catalogo_COL que verifica referencias en tablas hijas
CREATE TRIGGER Antes_Delete_Catalogo_COL_references
BEFORE DELETE ON Catalogo_COL
FOR EACH ROW
BEGIN
    IF TieneReferencias_Catalogo_COL(OLD.CA_CLAVE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existen referencias a este registro en otras tablas';
    END IF;
END $$

-- Procedimiento almacenado para insertar en Catalogo_COL
CREATE PROCEDURE Insertar_Catalogo_COL(
    IN p_CA_CLAVE CHAR(3),
    IN p_CA_DESCRIPCION CHAR(30),
    IN p_CA_TIPO SMALLINT,
    IN p_CA_IMPORTE DOUBLE,
    IN p_CON_CLAVE SMALLINT
)
BEGIN
    -- Intentar la inserción
    INSERT INTO Catalogo_COL (
        CA_CLAVE, CA_DESCRIPCION, CA_TIPO, CA_IMPORTE, CON_CLAVE
    ) VALUES (
        p_CA_CLAVE, p_CA_DESCRIPCION, p_CA_TIPO, p_CA_IMPORTE, p_CON_CLAVE
    );
END $$

-- Procedimiento almacenado para eliminar en Catalogo_COL
CREATE PROCEDURE Eliminar_Catalogo_COL(
    IN p_CA_CLAVE CHAR(3)
)
BEGIN
    -- Validar tipo de dato de la llave primaria
    DELETE FROM Catalogo_COL WHERE CA_CLAVE = p_CA_CLAVE;
END $$

-- Procedimiento almacenado para buscar en Catalogo_COL
CREATE PROCEDURE Buscar_Catalogo_COL(
    IN p_CA_CLAVE CHAR(3)
)
BEGIN
    -- Validar tipos de datos
    IF p_CA_CLAVE IS NULL THEN
        SELECT * FROM Catalogo_COL;
    ELSE
        IF Existe_Catalogo_COL(p_CA_CLAVE) THEN
            SELECT * FROM Catalogo_COL WHERE CA_CLAVE = p_CA_CLAVE;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Catalogo_COL';
        END IF;
    END IF;
END $$

-- Procedimiento almacenado para actualizar en Catalogo_COL
CREATE PROCEDURE Actualizar_Catalogo_COL(
    IN p_CA_CLAVE CHAR(3),
    IN p_CA_DESCRIPCION CHAR(30),
    IN p_CA_TIPO SMALLINT,
    IN p_CA_IMPORTE DOUBLE,
    IN p_CON_CLAVE SMALLINT
)
BEGIN
    -- Intentar la actualización
    UPDATE Catalogo_COL
    SET
        CA_DESCRIPCION = p_CA_DESCRIPCION,
        CA_TIPO = p_CA_TIPO,
        CA_IMPORTE = p_CA_IMPORTE,
        CON_CLAVE = p_CON_CLAVE
    WHERE CA_CLAVE = p_CA_CLAVE;
END $$

DELIMITER ;

DELIMITER $$

-- Función para verificar la existencia de un registro en CARGOS
CREATE FUNCTION Existe_CARGOS(CAR_FOLIO CHAR(10), ANT_DOCTO_CC_ID DOUBLE) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM CARGOS
    WHERE CAR_FOLIO = CAR_FOLIO AND ANT_DOCTO_CC_ID = ANT_DOCTO_CC_ID;
    RETURN existe;
END $$

-- Trigger antes de insertar en CARGOS
CREATE TRIGGER before_insert_CARGOS
BEFORE INSERT ON CARGOS
FOR EACH ROW
BEGIN
    IF Existe_CARGOS(NEW.CAR_FOLIO, NEW.ANT_DOCTO_CC_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro ya existe en CARGOS';
    END IF;
END $$

-- Trigger antes de actualizar en CARGOS
CREATE TRIGGER before_update_CARGOS
BEFORE UPDATE ON CARGOS
FOR EACH ROW
BEGIN
    IF NOT Existe_CARGOS(OLD.CAR_FOLIO, OLD.ANT_DOCTO_CC_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en CARGOS';
    END IF;
END $$

-- Trigger antes de eliminar en CARGOS
CREATE TRIGGER before_delete_CARGOS
BEFORE DELETE ON CARGOS
FOR EACH ROW
BEGIN
    IF NOT Existe_CARGOS(OLD.CAR_FOLIO, OLD.ANT_DOCTO_CC_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en CARGOS';
    END IF;
END $$

-- Procedimiento almacenado para insertar en CARGOS
CREATE PROCEDURE Insertar_CARGOS(
    IN p_CAR_FOLIO CHAR(10),
    IN p_ANT_DOCTO_CC_ID DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CON_CLAVE SMALLINT,
    IN p_CAR_FECHA DATETIME,
    IN p_CAR_IMPORTE DOUBLE,
    IN p_CAR_IVA DOUBLE,
    IN p_CAR_DESCRIPCION CHAR(100),
    IN p_CL_NUMERO DOUBLE,
    IN p_CAR_POLIZA_PRO CHAR(8),
    IN p_ANT_CLIENTE_ID INT,
    IN p_ANT_CONC_CC_ID INT,
    IN p_CAR_FECHA_VENCE DATETIME,
    IN p_CAR_DESCUENTO DOUBLE,
    IN p_CAR_INICIO SMALLINT
)
BEGIN
    -- Intentar la inserción
    INSERT INTO CARGOS (
        CAR_FOLIO, ANT_DOCTO_CC_ID, L_MANZANA, L_NUMERO, CON_CLAVE, CAR_FECHA,
        CAR_IMPORTE, CAR_IVA, CAR_DESCRIPCION, CL_NUMERO, CAR_POLIZA_PRO,
        ANT_CLIENTE_ID, ANT_CONC_CC_ID, CAR_FECHA_VENCE, CAR_DESCUENTO, CAR_INICIO
    ) VALUES (
        p_CAR_FOLIO, p_ANT_DOCTO_CC_ID, p_L_MANZANA, p_L_NUMERO, p_CON_CLAVE, p_CAR_FECHA,
        p_CAR_IMPORTE, p_CAR_IVA, p_CAR_DESCRIPCION, p_CL_NUMERO, p_CAR_POLIZA_PRO,
        p_ANT_CLIENTE_ID, p_ANT_CONC_CC_ID, p_CAR_FECHA_VENCE, p_CAR_DESCUENTO, p_CAR_INICIO
    );
END $$

-- Procedimiento almacenado para eliminar en CARGOS
CREATE PROCEDURE Eliminar_CARGOS(
    IN p_CAR_FOLIO CHAR(10),
    IN p_ANT_DOCTO_CC_ID DOUBLE
)
BEGIN
    -- Validar tipo de dato de la llave primaria
    DELETE FROM CARGOS WHERE CAR_FOLIO = p_CAR_FOLIO AND ANT_DOCTO_CC_ID = p_ANT_DOCTO_CC_ID;
END $$

-- Procedimiento almacenado para buscar en CARGOS
CREATE PROCEDURE Buscar_CARGOS(
    IN p_CAR_FOLIO CHAR(10),
    IN p_ANT_DOCTO_CC_ID DOUBLE
)
BEGIN
    -- Validar tipos de datos
    IF p_CAR_FOLIO IS NULL OR p_ANT_DOCTO_CC_ID IS NULL THEN
        SELECT * FROM CARGOS;
    ELSE
        IF Existe_CARGOS(p_CAR_FOLIO, p_ANT_DOCTO_CC_ID) THEN
            SELECT * FROM CARGOS WHERE CAR_FOLIO = p_CAR_FOLIO AND ANT_DOCTO_CC_ID = p_ANT_DOCTO_CC_ID;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en CARGOS';
        END IF;
    END IF;
END $$

-- Procedimiento almacenado para actualizar en CARGOS
CREATE PROCEDURE Actualizar_CARGOS(
    IN p_CAR_FOLIO CHAR(10),
    IN p_ANT_DOCTO_CC_ID DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CON_CLAVE SMALLINT,
    IN p_CAR_FECHA DATETIME,
    IN p_CAR_IMPORTE DOUBLE,
    IN p_CAR_IVA DOUBLE,
    IN p_CAR_DESCRIPCION CHAR(100),
    IN p_CL_NUMERO DOUBLE,
    IN p_CAR_POLIZA_PRO CHAR(8),
    IN p_ANT_CLIENTE_ID INT,
    IN p_ANT_CONC_CC_ID INT,
    IN p_CAR_FECHA_VENCE DATETIME,
    IN p_CAR_DESCUENTO DOUBLE,
    IN p_CAR_INICIO SMALLINT
)
BEGIN
    -- Intentar la actualización
    UPDATE CARGOS
    SET
        L_MANZANA = p_L_MANZANA,
        L_NUMERO = p_L_NUMERO,
        CON_CLAVE = p_CON_CLAVE,
        CAR_FECHA = p_CAR_FECHA,
        CAR_IMPORTE = p_CAR_IMPORTE,
        CAR_IVA = p_CAR_IVA,
        CAR_DESCRIPCION = p_CAR_DESCRIPCION,
        CL_NUMERO = p_CL_NUMERO,
        CAR_POLIZA_PRO = p_CAR_POLIZA_PRO,
        ANT_CLIENTE_ID = p_ANT_CLIENTE_ID,
        ANT_CONC_CC_ID = p_ANT_CONC_CC_ID,
        CAR_FECHA_VENCE = p_CAR_FECHA_VENCE,
        CAR_DESCUENTO = p_CAR_DESCUENTO,
        CAR_INICIO = p_CAR_INICIO
    WHERE CAR_FOLIO = p_CAR_FOLIO AND ANT_DOCTO_CC_ID = p_ANT_DOCTO_CC_ID;
END $$

DELIMITER ;

DELIMITER $$

-- Función para verificar si un registro existe en la tabla Clientes
CREATE FUNCTION Existe_Cliente(p_CL_NUMERO DOUBLE) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM CLIENTES
    WHERE CL_NUMERO = p_CL_NUMERO;
    RETURN existe;
END $$

-- Trigger antes de insertar en Clientes para evitar duplicados
CREATE TRIGGER Trigger_Antes_Insertar_Clientes
BEFORE INSERT ON CLIENTES
FOR EACH ROW
BEGIN
    IF Existe_Cliente(NEW.CL_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro ya existe en la tabla Clientes';
    END IF;
END $$

-- Trigger antes de actualizar en Clientes para verificar la existencia
CREATE TRIGGER Trigger_Antes_Actualizar_Clientes
BEFORE UPDATE ON CLIENTES
FOR EACH ROW
BEGIN
    IF NOT Existe_Cliente(OLD.CL_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en la tabla Clientes';
    END IF;
END $$

-- Trigger antes de eliminar en Clientes para verificar la existencia
CREATE TRIGGER Trigger_Antes_Eliminar_Clientes
BEFORE DELETE ON CLIENTES
FOR EACH ROW
BEGIN
    IF NOT Existe_Cliente(OLD.CL_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en la tabla Clientes';
    END IF;
END $$

-- Función para verificar referencias en tablas relacionadas
CREATE FUNCTION Tiene_Referencias_Clientes(p_CL_NUMERO DOUBLE) RETURNS BOOLEAN
BEGIN
    DECLARE referenciado BOOLEAN;
    SELECT COUNT(*) > 0 INTO referenciado
    FROM COLONO_LOTE
    WHERE CL_NUMERO = p_CL_NUMERO;
    RETURN referenciado;
END $$

-- Trigger antes de eliminar en Clientes para evitar eliminar registros referenciados
CREATE TRIGGER Trigger_Eliminar_Referencias_Clientes
BEFORE DELETE ON CLIENTES
FOR EACH ROW
BEGIN
    IF Tiene_Referencias_Clientes(OLD.CL_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro está referenciado en otras tablas';
    END IF;
END $$

-- Procedimiento almacenado para insertar en Clientes
CREATE PROCEDURE Agregar_Cliente(
    IN num DOUBLE,
    IN terr SMALLINT,
    IN nombre CHAR(200),
    IN contacto CHAR(200),
    IN direccion CHAR(100),
    IN ciudad CHAR(50),
    IN colonia CHAR(100),
    IN cp FLOAT,
    IN lada FLOAT,
    IN telefono CHAR(50),
    IN descuento FLOAT,
    IN dpago SMALLINT,
    IN dcred SMALLINT,
    IN fpago DATETIME,
    IN fultr DATETIME,
    IN credito FLOAT,
    IN saldo FLOAT,
    IN rfc CHAR(13),
    IN curp CHAR(18),
    IN giro CHAR(100),
    IN cuota FLOAT,
    IN localidad SMALLINT,
    IN fism SMALLINT,
    IN fafm SMALLINT,
    IN municipio CHAR(100),
    IN estado CHAR(100),
    IN localidad_fact CHAR(100),
    IN num_int CHAR(15),
    IN num_ext CHAR(15),
    IN email CHAR(100),
    IN cta SMALLINT,
    IN scta1 INT,
    IN scta2 INT,
    IN scta3 DOUBLE,
    IN scta4 INT,
    IN contacto_nombre CHAR(50),
    IN banco CHAR(50),
    IN cta_banco CHAR(20),
    IN clabe_banco CHAR(20),
    IN fecha_baja DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error al insertar en la tabla Clientes' AS mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validación de campos obligatorios
    IF num IS NULL OR nombre IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los campos CL_NUMERO y CL_NOM son obligatorios';
    END IF;

    -- Intentar la inserción
    INSERT INTO CLIENTES (
        CL_NUMERO, CL_TERR, CL_NOM, CL_CONT, CL_DIREC, CL_CIUD, CL_COLONIA, CL_CP, CL_LADA, CL_TELEF, CL_DSCTO, CL_DPAGO,
        CL_DCRED, CL_FPAGO, CL_FULTR, CL_CRED, CL_SALDO, CL_RFC, CL_CURP, CL_GIRO, CL_CUOTA, CL_LOCALIDAD, CL_FISM, CL_FAFM,
        CL_MUNICIPIO, CL_ESTADO, CL_LOCALIDAD_FACT, CL_NUM_INT, CL_NUM_EXT, CL_MAIL, C_CTA, C_SCTA1, C_SCTA2, C_SCTA3,
        C_SCTA4, CL_CONTACTO, CL_BANCO, CL_CTA_BANCO, CL_CLABE_BANCO, CL_FECHA_BAJA
    ) VALUES (
        num, terr, nombre, contacto, direccion, ciudad, colonia, cp, lada, telefono,
        descuento, dpago, dcred, fpago, fultr, credito, saldo, rfc, curp, giro,
        cuota, localidad, fism, fafm, municipio, estado, localidad_fact, num_int,
        num_ext, email, cta, scta1, scta2, scta3, scta4, contacto_nombre, banco,
        cta_banco, clabe_banco, fecha_baja
    );

    COMMIT;
END $$

-- Procedimiento almacenado para eliminar en Clientes
CREATE PROCEDURE Borrar_Cliente(IN num DOUBLE)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error al eliminar en la tabla Clientes' AS mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    IF num IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo CL_NUMERO es obligatorio';
    END IF;

    DELETE FROM CLIENTES WHERE CL_NUMERO = num;

    COMMIT;
END $$

-- Procedimiento almacenado para buscar en Clientes
CREATE PROCEDURE Buscar_Cliente(IN num DOUBLE)
BEGIN
    IF num IS NULL THEN
        SELECT * FROM CLIENTES;
    ELSE
        SELECT * FROM CLIENTES WHERE CL_NUMERO = num;
    END IF;
END $$

-- Procedimiento almacenado para actualizar en Clientes
CREATE PROCEDURE Actualizar_Cliente(
    IN num DOUBLE,
    IN terr SMALLINT,
    IN nombre CHAR(200),
    IN contacto CHAR(200),
    IN direccion CHAR(100),
    IN ciudad CHAR(50),
    IN colonia CHAR(100),
    IN cp FLOAT,
    IN lada FLOAT,
    IN telefono CHAR(50),
    IN descuento FLOAT,
    IN dpago SMALLINT,
    IN dcred SMALLINT,
    IN fpago DATETIME,
    IN fultr DATETIME,
    IN credito FLOAT,
    IN saldo FLOAT,
    IN rfc CHAR(13),
    IN curp CHAR(18),
    IN giro CHAR(100),
    IN cuota FLOAT,
    IN localidad SMALLINT,
    IN fism SMALLINT,
    IN fafm SMALLINT,
    IN municipio CHAR(100),
    IN estado CHAR(100),
    IN localidad_fact CHAR(100),
    IN num_int CHAR(15),
    IN num_ext CHAR(15),
    IN email CHAR(100),
    IN cta SMALLINT,
    IN scta1 INT,
    IN scta2 INT,
    IN scta3 DOUBLE,
    IN scta4 INT,
    IN contacto_nombre CHAR(50),
    IN banco CHAR(50),
    IN cta_banco CHAR(20),
    IN clabe_banco CHAR(20),
    IN fecha_baja DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error al actualizar en la tabla Clientes' AS mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validación de campos obligatorios
    IF num IS NULL OR nombre IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los campos CL_NUMERO y CL_NOM son obligatorios';
    END IF;

    -- Intentar la actualización
    UPDATE CLIENTES
    SET
        CL_TERR = terr,
        CL_NOM = nombre,
        CL_CONT = contacto,
        CL_DIREC = direccion,
        CL_CIUD = ciudad,
        CL_COLONIA = colonia,
        CL_CP = cp,
        CL_LADA = lada,
        CL_TELEF = telefono,
        CL_DSCTO = descuento,
        CL_DPAGO = dpago,
        CL_DCRED = dcred,
        CL_FPAGO = fpago,
        CL_FULTR = fultr,
        CL_CRED = credito,
        CL_SALDO = saldo,
        CL_RFC = rfc,
        CL_CURP = curp,
        CL_GIRO = giro,
        CL_CUOTA = cuota,
        CL_LOCALIDAD = localidad,
        CL_FISM = fism,
        CL_FAFM = fafm,
        CL_MUNICIPIO = municipio,
        CL_ESTADO = estado,
        CL_LOCALIDAD_FACT = localidad_fact,
        CL_NUM_INT = num_int,
        CL_NUM_EXT = num_ext,
        CL_MAIL = email,
        C_CTA = cta,
        C_SCTA1 = scta1,
        C_SCTA2 = scta2,
        C_SCTA3 = scta3,
        C_SCTA4 = scta4,
        CL_CONTACTO = contacto_nombre,
        CL_BANCO = banco,
        CL_CTA_BANCO = cta_banco,
        CL_CLABE_BANCO = clabe_banco,
        CL_FECHA_BAJA = fecha_baja
    WHERE CL_NUMERO = num;

    COMMIT;
END $$

DELIMITER ;

DELIMITER $$

-- --------------------------------------------------------------------------------------------------------
-- Funciones, Triggers y Procedimientos para la tabla Colono_Lote

-- Función para verificar la existencia de un registro en Colono_Lote
CREATE FUNCTION Existe_Colono_Lote(CL_NUMERO DOUBLE, L_MANZANA CHAR(3), L_NUMERO CHAR(6)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM Colono_Lote
    WHERE CL_NUMERO = CL_NUMERO AND L_MANZANA = L_MANZANA AND L_NUMERO = L_NUMERO;
    RETURN existe;
END $$

-- Trigger antes de insertar en Colono_Lote
CREATE TRIGGER Antes_Insert_Colono_Lote
BEFORE INSERT ON Colono_Lote
FOR EACH ROW
BEGIN
    IF Existe_Colono_Lote(NEW.CL_NUMERO, NEW.L_MANZANA, NEW.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro ya existe en Colono_Lote';
    END IF;
END $$

-- Trigger antes de actualizar en Colono_Lote
CREATE TRIGGER Antes_Update_Colono_Lote
BEFORE UPDATE ON Colono_Lote
FOR EACH ROW
BEGIN
    IF NOT Existe_Colono_Lote(OLD.CL_NUMERO, OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Colono_Lote';
    END IF;
END $$

-- Trigger antes de eliminar en Colono_Lote
CREATE TRIGGER Antes_Delete_Colono_Lote
BEFORE DELETE ON Colono_Lote
FOR EACH ROW
BEGIN
    IF NOT Existe_Colono_Lote(OLD.CL_NUMERO, OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Colono_Lote';
    END IF;
END $$

-- Función para verificar referencias en tablas hijas para Colono_Lote
CREATE FUNCTION TieneReferencias_Colono_Lote(CL_NUMERO DOUBLE, L_MANZANA CHAR(3), L_NUMERO CHAR(6)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM CARGOS
    WHERE CL_NUMERO = CL_NUMERO AND L_MANZANA = L_MANZANA AND L_NUMERO = L_NUMERO;
    RETURN existe;
END $$

-- Trigger antes de eliminar en Colono_Lote que verifica referencias en tablas hijas
CREATE TRIGGER Antes_Delete_Colono_Lote_References
BEFORE DELETE ON Colono_Lote
FOR EACH ROW
BEGIN
    IF TieneReferencias_Colono_Lote(OLD.CL_NUMERO, OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existen referencias a este registro en otras tablas';
    END IF;
END $$

-- Procedimiento almacenado para insertar en Colono_Lote
CREATE PROCEDURE Insertar_Colono_Lote(
    IN p_CL_NUMERO DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CL_TELEFONO CHAR(35),
    IN p_CL_MAIL CHAR(100),
    IN p_CL_IMPORTE DOUBLE,
    IN p_CL_FECHA_ALTA DATETIME,
    IN p_CL_FECHA_BAJA DATETIME,
    IN p_CL_COMENTARIO VARCHAR(45)
)
BEGIN
    -- Validación de tipos y restricciones aquí
    IF p_CL_NUMERO IS NULL OR p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El numero de cliente, el numero de manzana y numero de lote no puede ser NULL';
    ELSE
        -- Intentar la inserción
        INSERT INTO Colono_Lote (
            CL_NUMERO, L_MANZANA, L_NUMERO,
            CL_TELEFONO, CL_MAIL, CL_IMPORTE,
            CL_FECHA_ALTA, CL_FECHA_BAJA, CL_COMENTARIO
        ) VALUES (
            p_CL_NUMERO, p_L_MANZANA, p_L_NUMERO,
            p_CL_TELEFONO, p_CL_MAIL, p_CL_IMPORTE,
            p_CL_FECHA_ALTA, p_CL_FECHA_BAJA, p_CL_COMENTARIO
        );
    END IF;
END $$

-- Procedimiento almacenado para eliminar en Colono_Lote
CREATE PROCEDURE Eliminar_Colono_Lote(
    IN p_CL_NUMERO DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6)
)
BEGIN
    IF p_CL_NUMERO IS NULL OR p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El numero de cliente, el numero de manzana y numero de lote no puede ser NULL';
    ELSE
        -- Intentar la eliminación
        DELETE FROM Colono_Lote WHERE CL_NUMERO = p_CL_NUMERO AND L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
    END IF;
END $$

-- Procedimiento almacenado para buscar en Colono_Lote
CREATE PROCEDURE Buscar_Colono_Lote(
    IN p_CL_NUMERO DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6)
)
BEGIN
    -- Validar tipos de datos
    IF p_CL_NUMERO IS NULL OR p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SELECT * FROM Colono_Lote;
    ELSE
        IF Existe_Colono_Lote(p_CL_NUMERO, p_L_MANZANA, p_L_NUMERO) THEN
            SELECT * FROM Colono_Lote WHERE CL_NUMERO = p_CL_NUMERO AND L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en Colono_Lote';
        END IF;
    END IF;
END $$

-- Procedimiento almacenado para actualizar en Colono_Lote
CREATE PROCEDURE Actualizar_Colono_Lote(
    IN p_CL_NUMERO DOUBLE,
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CL_TELEFONO CHAR(35),
    IN p_CL_MAIL CHAR(100),
    IN p_CL_IMPORTE DOUBLE,
    IN p_CL_FECHA_ALTA DATETIME,
    IN p_CL_FECHA_BAJA DATETIME,
    IN p_CL_COMENTARIO VARCHAR(45)
)
BEGIN
    -- Validación de tipos y restricciones aquí
    IF p_CL_NUMERO IS NULL OR p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El numero de cliente, el numero de manzana y numero de lote no puede ser NULL';
    ELSE
        -- Intentar la actualización
        UPDATE Colono_Lote
        SET
            CL_TELEFONO = p_CL_TELEFONO,
            CL_MAIL = p_CL_MAIL,
            CL_IMPORTE = p_CL_IMPORTE,
            CL_FECHA_ALTA = p_CL_FECHA_ALTA,
            CL_FECHA_BAJA = p_CL_FECHA_BAJA,
            CL_COMENTARIO = p_CL_COMENTARIO
        WHERE CL_NUMERO = p_CL_NUMERO AND L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
    END IF;
END $$

DELIMITER ;

CREATE VIEW vista_status AS
    SELECT CA_CLAVE AS clave_catalogo, CA_DESCRIPCION AS descripcion, CA_IMPORTE AS importe, CON_CLAVE AS clave_contab
    FROM catalogo_col
    WHERE CA_TIPO = 0;

CREATE VIEW vista_direccion AS
    SELECT CA_CLAVE AS clave_catalogo, CA_DESCRIPCION AS descripcion, CA_IMPORTE AS importe, CON_CLAVE AS clave_contab
    FROM catalogo_col
    WHERE CA_TIPO = 1;

CREATE VIEW vista_tipo_lote AS
    SELECT CA_CLAVE AS clave_catalogo, CA_DESCRIPCION AS descripcion, CA_IMPORTE AS importe, CON_CLAVE AS clave_contab
    FROM catalogo_col
    WHERE CA_TIPO = 2;

CREATE VIEW vista_reporte_cargos AS
    SELECT clientes.CL_NUMERO AS Cliente, clientes.CL_NOM AS Nombre, clientes.CL_DIREC AS Direccion, cargos.CAR_FECHA AS Fecha, SUM(cargos.CAR_IMPORTE) AS Cargo_total
    FROM clientes
    JOIN cargos ON clientes.CL_NUMERO = cargos.CL_NUMERO
    GROUP BY clientes.CL_NUMERO;

CREATE VIEW vista_reporte_lotes AS
    SELECT colono_lote.CL_NUMERO AS Cliente, clientes.CL_NOM AS Nombre, colono_lote.L_MANZANA AS Manzana, colono_lote.L_NUMERO AS Lote
    FROM colono_lote
    JOIN clientes ON clientes.CL_NUMERO = colono_lote.CL_NUMERO
    ORDER BY Nombre;

CREATE VIEW vista_reporte_importe_status AS
    SELECT catalogo_col.CA_DESCRIPCION AS Status, SUM(cargos.CAR_IMPORTE) AS Importe_Total
    FROM catalogo_col
    JOIN lote ON catalogo_col.CA_CLAVE = lote.CA_CLAVE0
    JOIN cargos ON lote.L_MANZANA = cargos.L_MANZANA AND lote.L_NUMERO = cargos.L_NUMERO
    GROUP BY catalogo_col.CA_TIPO, catalogo_col.CA_DESCRIPCION;

CREATE VIEW vista_reporte_cargos_fecha AS
    SELECT CAR_FECHA AS Fecha, clientes.CL_NUMERO AS Cliente, CAR_IMPORTE AS Importe
    FROM cargos
    JOIN clientes ON clientes.CL_NUMERO = cargos.CL_NUMERO
    ORDER BY Fecha;

DELIMITER $$

CREATE PROCEDURE obtener_reporte_cargos_por_fecha(IN p_fecha DATE)
BEGIN
    IF ISNULL(p_fecha) THEN
        SELECT * FROM vista_reporte_cargos;
    ELSE
        SELECT * FROM vista_reporte_cargos WHERE Fecha = p_fecha;
    END IF;
END$$

CREATE PROCEDURE obtener_reporte_lotes_por_cliente(IN p_cliente DOUBLE)
BEGIN
    IF ISNULL(p_cliente) THEN
        SELECT * FROM vista_reporte_lotes;
    ELSE
        SELECT * FROM vista_reporte_lotes WHERE Cliente = p_cliente;
    END IF;
END$$

CREATE PROCEDURE obtener_reporte_importe_status()
BEGIN
    SELECT * FROM vista_reporte_importe_status;
END$$

CREATE PROCEDURE obtener_reporte_cargos_por_periodo(IN p_fecha_inicio DATE, IN p_fecha_fin DATE)
BEGIN
    IF ISNULL(p_fecha_inicio) OR ISNULL(p_fecha_fin) THEN
        SELECT * FROM vista_reporte_lotes;
    ELSE
        SELECT * FROM vista_reporte_cargos_fecha WHERE Fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

-- Funciones, Triggers y Procedimientos para la tabla LOTE

-- Función para verificar la existencia de un registro en LOTE
CREATE FUNCTION Existe_LOTE(L_MANZANA CHAR(3), L_NUMERO CHAR(6)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM LOTE
    WHERE L_MANZANA = L_MANZANA AND L_NUMERO = L_NUMERO;
    RETURN existe;
END $$

-- Trigger antes de insertar en LOTE
CREATE TRIGGER Antes_Insertar_LOTE
BEFORE INSERT ON LOTE
FOR EACH ROW
BEGIN
    IF Existe_LOTE(NEW.L_MANZANA, NEW.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro ya existe en LOTE';
    END IF;
END $$

-- Trigger antes de actualizar en LOTE
CREATE TRIGGER Antes_Actualizar_LOTE
BEFORE UPDATE ON LOTE
FOR EACH ROW
BEGIN
    IF NOT Existe_LOTE(OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en LOTE';
    END IF;
END $$

-- Trigger antes de eliminar en LOTE
CREATE TRIGGER Antes_Eliminar_LOTE
BEFORE DELETE ON LOTE
FOR EACH ROW
BEGIN
    IF NOT Existe_LOTE(OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en LOTE';
    END IF;
END $$

-- Función para verificar referencias en tablas hijas para LOTE
CREATE FUNCTION TieneReferencias_LOTE(L_MANZANA CHAR(3), L_NUMERO CHAR(6)) RETURNS BOOLEAN
BEGIN
    DECLARE existe BOOLEAN;
    SELECT COUNT(*) > 0 INTO existe
    FROM Colono_Lote
    WHERE L_MANZANA = L_MANZANA AND L_NUMERO = L_NUMERO;
    RETURN existe;
END $$

-- Trigger antes de eliminar en LOTE que verifica referencias en tablas hijas
CREATE TRIGGER Antes_Eliminar_LOTE_Ref
BEFORE DELETE ON LOTE
FOR EACH ROW
BEGIN
    IF TieneReferencias_LOTE(OLD.L_MANZANA, OLD.L_NUMERO) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existen referencias a este registro en otras tablas';
    END IF;
END $$

-- Procedimiento almacenado para insertar en LOTE
CREATE PROCEDURE Insertar_LOTE(
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CA_CLAVE1 CHAR(3),
    IN p_CA_CLAVE2 CHAR(3),
    IN p_CA_CLAVE0 CHAR(3),
    IN p_L_TOTAL_M2 DOUBLE,
    IN p_L_IMPORTE DOUBLE,
    IN p_L_NUM_EXT CHAR(6),
    IN p_L_PAHT_MAP CHAR(150),
    IN p_L_FECHA_MANT DATETIME,
    IN p_L_FECHA_POSIBLE DATETIME
)
BEGIN
    -- Validación de tipos y restricciones aquí
    IF p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L_MANZANA y L_NUMERO no pueden ser nulos';
    ELSE
        -- Intentar la inserción
        INSERT INTO LOTE (
            L_MANZANA, L_NUMERO, CA_CLAVE1, CA_CLAVE2, CA_CLAVE0, L_TOTAL_M2,
            L_IMPORTE, L_NUM_EXT, L_PAHT_MAP, L_FECHA_MANT, L_FECHA_POSIBLE
        ) VALUES (
            p_L_MANZANA, p_L_NUMERO, p_CA_CLAVE1, p_CA_CLAVE2, p_CA_CLAVE0, p_L_TOTAL_M2,
            p_L_IMPORTE, p_L_NUM_EXT, p_L_PAHT_MAP, p_L_FECHA_MANT, p_L_FECHA_POSIBLE
        );
    END IF;
END $$

-- Procedimiento almacenado para eliminar en LOTE
CREATE PROCEDURE Eliminar_LOTE(
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6)
)
BEGIN
    -- Validar tipo de dato de la llave primaria
    IF p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L_MANZANA y L_NUMERO no pueden ser nulos';
    ELSE
        -- Intentar la eliminación
        DELETE FROM LOTE WHERE L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
    END IF;
END $$

-- Procedimiento almacenado para buscar en LOTE
CREATE PROCEDURE Buscar_LOTE(
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6)
)
BEGIN
    -- Validar tipos de datos
    IF p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SELECT * FROM LOTE;
    ELSE
        IF Existe_LOTE(p_L_MANZANA, p_L_NUMERO) THEN
            SELECT * FROM LOTE WHERE L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro no existe en LOTE';
        END IF;
    END IF;
END $$

-- Procedimiento almacenado para actualizar en LOTE
CREATE PROCEDURE Actualizar_LOTE(
    IN p_L_MANZANA CHAR(3),
    IN p_L_NUMERO CHAR(6),
    IN p_CA_CLAVE1 CHAR(3),
    IN p_CA_CLAVE2 CHAR(3),
    IN p_CA_CLAVE0 CHAR(3),
    IN p_L_TOTAL_M2 DOUBLE,
    IN p_L_IMPORTE DOUBLE,
    IN p_L_NUM_EXT CHAR(6),
    IN p_L_PAHT_MAP CHAR(150),
    IN p_L_FECHA_MANT DATETIME,
    IN p_L_FECHA_POSIBLE DATETIME
)
BEGIN
    -- Validación de tipos y restricciones aquí
    IF p_L_MANZANA IS NULL OR p_L_NUMERO IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L_MANZANA y L_NUMERO no pueden ser nulos';
    ELSE
        -- Intentar la actualización
        UPDATE LOTE
        SET
            CA_CLAVE1 = p_CA_CLAVE1,
            CA_CLAVE2 = p_CA_CLAVE2,
            CA_CLAVE0 = p_CA_CLAVE0,
            L_TOTAL_M2 = p_L_TOTAL_M2,
            L_IMPORTE = p_L_IMPORTE,
            L_NUM_EXT = p_L_NUM_EXT,
            L_PAHT_MAP = p_L_PAHT_MAP,
            L_FECHA_MANT = p_L_FECHA_MANT,
            L_FECHA_POSIBLE = p_L_FECHA_POSIBLE
        WHERE L_MANZANA = p_L_MANZANA AND L_NUMERO = p_L_NUMERO;
    END IF;
END $$

DELIMITER ;

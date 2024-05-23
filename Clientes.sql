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

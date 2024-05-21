-- Procedimiento: Insertar en catalogo_col
DELIMITER //

CREATE PROCEDURE InsertCatalogoCol(
    IN CA_CLAVE CHAR(3),
    IN CA_TIPO SMALLINT,
    IN CA_DESCRIPCION CHAR(30),
    IN CA_IMPORTE DOUBLE,
    IN CON_CLAVE SMALLINT)
BEGIN
    -- Validación de la clave primaria: no debe ser vacía ni nula
    IF CA_CLAVE IS NULL OR CA_CLAVE = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La clave CA_CLAVE no puede estar vacía.';
    END IF;

    -- Inserción de los datos
    INSERT INTO catalogo_col (CA_CLAVE, CA_TIPO, CA_DESCRIPCION, CA_IMPORTE, CON_CLAVE)
    VALUES (CA_CLAVE, CA_TIPO, CA_DESCRIPCION, CA_IMPORTE, CON_CLAVE);
END //

DELIMITER ;

-- Procedimiento: Actualizar en catalogo_col
DELIMITER //

CREATE PROCEDURE UpdateCatalogoCol(
    IN CA_CLAVE CHAR(3),
    IN CA_TIPO SMALLINT,
    IN CA_DESCRIPCION CHAR(30),
    IN CA_IMPORTE DOUBLE,
    IN CON_CLAVE SMALLINT)
BEGIN
    -- Validación de la clave primaria: no debe ser vacía ni nula
    IF CA_CLAVE IS NULL OR CA_CLAVE = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La clave CA_CLAVE no puede estar vacía.';
    END IF;

    -- Actualización de los datos
    UPDATE catalogo_col
    SET CA_TIPO = CA_TIPO, CA_DESCRIPCION = CA_DESCRIPCION, CA_IMPORTE = CA_IMPORTE, CON_CLAVE = CON_CLAVE
    WHERE CA_CLAVE = CA_CLAVE;
END //

DELIMITER ;

-- Eliminar en la tabla
DELIMITER //

CREATE PROCEDURE DeleteCatalogoCol(
    IN CA_CLAVE CHAR(3)
)
BEGIN
    -- Intentar eliminar el registro
    DELETE FROM catalogo_col WHERE CA_CLAVE = CA_CLAVE;
END //

DELIMITER ;



-- Trigger: Validar antes de eliminar en catalogo_col
DELIMITER //

CREATE TRIGGER BeforeDeleteCatalogoCol
BEFORE DELETE ON catalogo_col
FOR EACH ROW
BEGIN
    -- Validación de relaciones (ejemplo: si está referenciado en otra tabla)
    IF EXISTS (SELECT 1 FROM lote WHERE CA_CLAVE1 = OLD.CA_CLAVE OR CA_CLAVE2 = OLD.CA_CLAVE OR CA_CLAVE0 = OLD.CA_CLAVE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede eliminar porque está referenciado en la tabla lote.';
    END IF;
END //

DELIMITER ;

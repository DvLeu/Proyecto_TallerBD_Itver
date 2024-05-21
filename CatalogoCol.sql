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



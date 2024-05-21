use fraccionamiento;
show tables;
describe colono_lote;
describe clientes;
describe catalogo_col;
describe cargos;
describe lote;

-- El proyecto a realizar es un CRUD el cual haremos los comandos aqui para tener un control.\

drop procedure IF EXISTS InsertCatalogoCol;


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

CALL InsertCatalogoCol('ABC', 1, 'Descripción', 100.50, 123);

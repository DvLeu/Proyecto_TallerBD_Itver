-- Procedimientos almacenados en CatalogoCOl
-- Insertar en Catalogo
use fraccionamiento;
DELIMITER //
CREATE PROCEDURE InsertCatalogoCol(IN _CA_CLAVE char(3), IN _CA_TIPO smallint, IN _CA_DESCRIPCION char(30), IN _CA_IMPORTE double, IN _CON_CLAVE smallint)
BEGIN
  INSERT INTO catalogo_col (CA_CLAVE, CA_TIPO, CA_DESCRIPCION, CA_IMPORTE, CON_CLAVE)
  VALUES (_CA_CLAVE, _CA_TIPO, _CA_DESCRIPCION, _CA_IMPORTE, _CON_CLAVE);
END //
DELIMITER ;
-- Actualizar en Catalogo
DELIMITER //
CREATE PROCEDURE UpdateCatalogoCol(IN _CA_CLAVE char(3), IN _CA_TIPO smallint, IN _CA_DESCRIPCION char(30), IN _CA_IMPORTE double, IN _CON_CLAVE smallint)
BEGIN
  UPDATE catalogo_col
  SET CA_TIPO = _CA_TIPO, CA_DESCRIPCION = _CA_DESCRIPCION, CA_IMPORTE = _CA_IMPORTE, CON_CLAVE = _CON_CLAVE
  WHERE CA_CLAVE = _CA_CLAVE;
END //
DELIMITER ;
-- Borrar en Catalogo
DELIMITER //
CREATE PROCEDURE DeleteCatalogoCol(IN _CA_CLAVE char(3))
BEGIN
  DELETE FROM catalogo_col
  WHERE CA_CLAVE = _CA_CLAVE;
END //
DELIMITER ;
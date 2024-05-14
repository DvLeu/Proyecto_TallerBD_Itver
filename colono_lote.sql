use fraccionamiento;
-- Procedimientos de la tabla colono_lote
-- Insertar ColonoLote
DELIMITER //
CREATE PROCEDURE InsertColonoLote(IN _CL_NUMERO double, IN _L_MANZANA char(3), IN _L_NUMERO char(6), IN _CL_TELEFONO char(35), IN _CL_MAIL char(100), IN _CL_IMPORTE double, IN _CL_FECHA_ALTA datetime, IN _CL_FECHA_BAJA datetime, IN _CL_COMENTARIO varchar(45))
BEGIN
  INSERT INTO colono_lote (CL_NUMERO, L_MANZANA, L_NUMERO, CL_TELEFONO, CL_MAIL, CL_IMPORTE, CL_FECHA_ALTA, CL_FECHA_BAJA, CL_COMENTARIO)
  VALUES (_CL_NUMERO, _L_MANZANA, _L_NUMERO, _CL_TELEFONO, _CL_MAIL, _CL_IMPORTE, _CL_FECHA_ALTA, _CL_FECHA_BAJA, _CL_COMENTARIO);
END //
DELIMITER ;
-- Actualizar ColonoLote
DELIMITER //
CREATE PROCEDURE UpdateColonoLote(IN _CL_NUMERO double, IN _L_MANZANA char(3), IN _L_NUMERO char(6), IN _CL_TELEFONO char(35), IN _CL_MAIL char(100), IN _CL_IMPORTE double, IN _CL_FECHA_ALTA datetime, IN _CL_FECHA_BAJA datetime, IN _CL_COMENTARIO varchar(45))
BEGIN
  UPDATE colono_lote
  SET CL_TELEFONO = _CL_TELEFONO, CL_MAIL = _CL_MAIL, CL_IMPORTE = _CL_IMPORTE, CL_FECHA_ALTA = _CL_FECHA_ALTA, CL_FECHA_BAJA = _CL_FECHA_BAJA, CL_COMENTARIO = _CL_COMENTARIO
  WHERE CL_NUMERO = _CL_NUMERO AND L_MANZANA = _L_MANZANA AND L_NUMERO = _L_NUMERO;
END //
DELIMITER ;
-- Insertar ColonoLote
DELIMITER //
CREATE PROCEDURE DeleteColonoLote(IN _CL_NUMERO double, IN _L_MANZANA char(3), IN _L_NUMERO char(6))
BEGIN
  DELETE FROM colono_lote
  WHERE CL_NUMERO = _CL_NUMERO AND L_MANZANA = _L_MANZANA AND L_NUMERO = _L_NUMERO;
END //
DELIMITER ;

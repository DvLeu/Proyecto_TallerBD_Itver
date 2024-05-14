use fraccionamiento;
-- Insertar clientes.
DELIMITER //
CREATE PROCEDURE InsertCliente(IN _CL_NUMERO double, IN _CL_NOM char(200), IN _CL_DIREC char(100), IN _CL_RFC char(13))
BEGIN
  INSERT INTO clientes (CL_NUMERO, CL_NOM, CL_DIREC, CL_RFC)
  VALUES (_CL_NUMERO, _CL_NOM, _CL_DIREC, _CL_RFC);
END //
DELIMITER ;
-- Actualizar Clientes.
DELIMITER //
CREATE PROCEDURE UpdateCliente(IN _CL_NUMERO double, IN _CL_NOM char(200), IN _CL_DIREC char(100), IN _CL_RFC char(13))
BEGIN
  UPDATE clientes
  SET CL_NOM = _CL_NOM, CL_DIREC = _CL_DIREC, CL_RFC = _CL_RFC
  WHERE CL_NUMERO = _CL_NUMERO;
END //
DELIMITER ;
-- Borrar Clientes
DELIMITER //
CREATE PROCEDURE DeleteCliente(IN _CL_NUMERO double)
BEGIN
  DELETE FROM clientes
  WHERE CL_NUMERO = _CL_NUMERO;
END //
DELIMITER ;

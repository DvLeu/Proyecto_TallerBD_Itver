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

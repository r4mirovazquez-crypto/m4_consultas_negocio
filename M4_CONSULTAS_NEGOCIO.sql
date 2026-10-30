-- usamos comando use para asignar la base con la cual vamos a trabajar--

USE ventas_tech_db

-- Consulta 1, resumen ejecutivo--
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(id_producto) AS cantidad_pedidos,
(SUM(cantidad * precio_unitario) / COUNT(id_producto)) AS ticket_promedio
 FROM ventas
 GROUP BY MONTH(fecha_venta)
 
 -- Consulta 2: Ranking de productos
 SELECT id_producto,
	SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY id_producto DESC
LIMIT 5;
 
 -- Consulta 3: Clientes recurrentes
 
SELECT id_cliente,
	SUM(cantidad * precio_unitario) AS total_gastado,
    SUM(cantidad) AS cantidad_pedidos
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY id_cliente

-- Consulta 4: Productos por encima y por debajo del promedio--->

WITH ventas_por_producto AS (
SELECT id_producto,
    SUM(cantidad * precio_unitario) AS total_facturado
	FROM ventas
    GROUP BY id_producto)
SELECT id_producto,
total_facturado,
CASE WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_por_producto)THEN "Por Encima"
ELSE "Por Debajo"
END AS comparacion_promedio
FROM ventas_por_producto;
  
 
 
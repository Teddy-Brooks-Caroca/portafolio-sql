## 7. Optimización y Buenas Prácticas

-- Crear un índice en la tabla comunidades_indigenas_chile basado en id_comunidad para mejorar el rendimiento de búsqueda.

SELECT * FROM comunidades_indigenas_de_chile;

CREATE INDEX id_comunidades ON comunidades_indigenas_de_chile(id_comunidad);

-- Generar una vista que muestre solo las comunidades con reconocimiento internacional completo.

CREATE VIEW comunidades_reconocimiento_completo AS
SELECT 
	CI.id_comunidad,
    CI.nombre_comunidad,
    RI.reconocimiento_onu
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN reconocimiento_internacional_comunidades_indigenas RI ON CI.id_comunidad = RI.id_comunidad 
WHERE RI.reconocimiento_onu = 'Completo'; 

-- Implementar una consulta optimizada para contar comunidades por región sin usar DISTINCT.

CREATE VIEW comunidades_por_region AS
SELECT región_comunidad,COUNT(*) AS 'cantidad_de_comunidades' FROM comunidades_indigenas_de_chile GROUP BY región_comunidad;

-- Aplicar una consulta con HAVING para filtrar regiones con más de 5 comunidades.

SELECT región_comunidad,COUNT(*) AS 'cantidad_de_comunidades' FROM comunidades_indigenas_de_chile GROUP BY región_comunidad HAVING COUNT(*) > 5;

-- Verificar si existen comunidades duplicadas en la base de datos.

SELECT *
FROM comunidades_indigenas_de_chile
WHERE nombre_comunidad IN (
    SELECT nombre_comunidad
    FROM comunidades_indigenas_de_chile
    GROUP BY nombre_comunidad
    HAVING COUNT(*) > 1
    ORDER BY nombre_comunidad
);

-- Realizar un EXPLAIN sobre una consulta compleja para analizar su eficiencia.

EXPLAIN SELECT * 
FROM comunidades_indigenas_de_chile
WHERE región_comunidad = 'Región de Coquimbo';

 EXPLAIN SELECT nombre_comunidad, cantidad_habitantes_2024 FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 IN (
SELECT AVG(cantidad_habitantes_2024) FROM comunidades_indigenas_de_chile WHERE región_comunidad = 'Región de Coquimbo');

ANALYZE TABLE comunidades_indigenas_de_chile;
EXPLAIN FORMAT=JSON SELECT * FROM comunidades_indigenas_de_chile WHERE región_comunidad = 'Región de Coquimbo';

-- Optimizar una consulta para recuperar comunidades con más de 5000 habitantes utilizando INDEX.

CREATE INDEX idx_cantidad_habitantes 
ON comunidades_indigenas_de_chile(cantidad_habitantes_2024);

SELECT * FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 > 5000;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
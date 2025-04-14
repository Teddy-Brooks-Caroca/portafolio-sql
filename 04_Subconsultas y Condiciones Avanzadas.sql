## 4. Subconsultas y Condiciones Avanzadas

-- Listar las comunidades que tienen una población mayor que el promedio de todas las comunidades.

SELECT nombre_comunidad, cantidad_habitantes_2024 FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 >
(SELECT AVG(cantidad_habitantes_2024) FROM comunidades_indigenas_de_chile);

-- Obtener las comunidades cuyo territorio es mayor al promedio de todas las superficies registradas.

SELECT 
	CI.nombre_comunidad,
    CI.región_comunidad,
    TC.superficie_territorio_km2 
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN territorios_comunidades_indigenas TC ON CI.id_comunidad = TC.id_comunidad 
WHERE TC.superficie_territorio_km2 >
			(SELECT AVG(superficie_territorio_km2) 
            FROM territorios_comunidades_indigenas) 
ORDER BY 
	TC.superficie_territorio_km2;

-- Encontrar las comunidades que han recibido su primer reconocimiento después del año 2010 y tienen más de 2000 habitantes.

SELECT 
	CI.nombre_comunidad,
    RI.año_primer_reconocimiento, 
    CI.cantidad_habitantes_2024 
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN reconocimiento_internacional_comunidades_indigenas RI ON CI.id_comunidad = RI.id_comunidad 
WHERE CI.id_comunidad IN
				(SELECT id_comunidad 
                FROM reconocimiento_internacional_comunidades_indigenas 
				WHERE año_primer_reconocimiento > 2010) 
	 AND CI.cantidad_habitantes_2024 > 2000;
     
-- Mostrar las comunidades que poseen territorio_tradicional y han sido reconocidas completamente por la ONU.
SELECT 
    nombre_comunidad,
    (SELECT territorio_tradicional 
     FROM territorios_comunidades_indigenas 
     WHERE territorios_comunidades_indigenas.id_comunidad = comunidades_indigenas_de_chile.id_comunidad
    ) AS territorio_tradicional,
    (SELECT reconocimiento_onu 
     FROM reconocimiento_internacional_comunidades_indigenas 
     WHERE reconocimiento_internacional_comunidades_indigenas.id_comunidad = comunidades_indigenas_de_chile.id_comunidad
    ) AS reconocimiento_onu 
FROM 
    comunidades_indigenas_de_chile 
WHERE 
    id_comunidad IN (
        SELECT id_comunidad 
        FROM territorios_comunidades_indigenas 
        WHERE territorio_tradicional IS NOT NULL
    ) 
    AND id_comunidad IN (
        SELECT id_comunidad 
        FROM reconocimiento_internacional_comunidades_indigenas 
        WHERE reconocimiento_onu = 'Completo'
    );

-- Identificar la comunidad con la menor cantidad de habitantes en cada región.

SELECT 
	nombre_comunidad, 
    región_comunidad, 
    cantidad_habitantes_2024
FROM (
    SELECT nombre_comunidad, región_comunidad, cantidad_habitantes_2024,
	RANK() OVER (PARTITION BY región_comunidad 
				ORDER BY cantidad_habitantes_2024 ASC) AS ranking
    FROM 
		comunidades_indigenas_de_chile
) AS ranked
WHERE 
	ranking = 1;

-- Determinar qué comunidades tienen una población mayor que la de "Mapuche de Araucanía".

SELECT * FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 >
(SELECT cantidad_habitantes_2024 FROM comunidades_indigenas_de_chile WHERE nombre_comunidad = "Mapuche de Araucanía");

-- Mostrar las comunidades cuya lengua materna no coincide con la de la mayoría de su región.

SELECT 
    nombre_comunidad, 
    región_comunidad, 
    lengua_materna 
FROM 
    comunidades_indigenas_de_chile 
WHERE 
    lengua_materna <> (
        SELECT lengua_materna 
        FROM comunidades_indigenas_de_chile 
        WHERE región_comunidad = comunidades_indigenas_de_chile.región_comunidad 
        GROUP BY lengua_materna 
        ORDER BY COUNT(*) DESC 
        LIMIT 1
    );

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
## 3. Uso de Cláusulas JOIN y Relaciones Entre Tablas

-- Listar el nombre de las comunidades junto con su territorio_tradicional.

SELECT 
	CI.nombre_comunidad,
    TC.territorio_tradicional 
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN territorios_comunidades_indigenas TC ON CI.id_comunidad = TC.id_comunidad; 

-- Mostrar las comunidades junto con su status_tierra y superficie_territorio_km2.
SELECT 
	CI.nombre_comunidad,
    TC.status_tierra,
    TC.superficie_territorio_km2 
FROM 
	territorios_comunidades_indigenas TC 
    JOIN comunidades_indigenas_de_chile CI ON TC.id_comunidad=CI.id_comunidad
ORDER BY
	TC.status_tierra,
    TC.superficie_territorio_km2 DESC;
    
-- Obtener el nombre de las comunidades que han sido reconocidas legalmente antes del 2010.

SELECT 
	CI.nombre_comunidad, 
    RI.año_primer_reconocimiento 
FROM 
	reconocimiento_internacional_comunidades_indigenas RI 
    JOIN comunidades_indigenas_de_chile CI ON RI.id_comunidad = CI.id_comunidad 
WHERE 
	RI.año_primer_reconocimiento < 2010
ORDER BY
	RI.año_primer_reconocimiento;

-- Listar las comunidades que tienen reconocimiento internacional (reconocimiento_onu = "Completo").

SELECT 
	CI.nombre_comunidad,
    RI.reconocimiento_onu,
    RI.año_primer_reconocimiento
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN reconocimiento_internacional_comunidades_indigenas RI ON CI.id_comunidad = RI.id_comunidad 
WHERE 
	RI.reconocimiento_onu = 'Completo'; 

-- Mostrar las comunidades junto con sus principales actividades económicas.

SELECT 
	CI.nombre_comunidad,
    TC.principales_actividades_economicas 
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN territorios_comunidades_indigenas TC ON CI.id_comunidad = TC.id_comunidad;

-- Identificar las comunidades cuyo territorio_tradicional es mayor a 500 km².

SELECT 
	CI.nombre_comunidad,
    TC.superficie_territorio_km2 
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN territorios_comunidades_indigenas TC ON CI.id_comunidad = TC.id_comunidad 
WHERE
	TC.superficie_territorio_km2 > 500
ORDER BY
	TC.superficie_territorio_km2;

-- Obtener las comunidades junto con su primer año de reconocimiento y la organización internacional que las apoya.

SELECT 
	CI.nombre_comunidad,
    RI.organizaciones_internacionales_apoyo,
    RI.año_primer_reconocimiento
FROM 
	comunidades_indigenas_de_chile CI 
    JOIN reconocimiento_internacional_comunidades_indigenas RI ON CI.id_comunidad = RI.id_comunidad
ORDER BY
	RI.año_primer_reconocimiento;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
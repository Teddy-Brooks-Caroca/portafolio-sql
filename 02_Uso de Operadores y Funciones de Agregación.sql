## 2. Uso de Operadores y Funciones de Agregación

-- Obtener el número total de comunidades registradas.

SELECT COUNT(*) AS "Total de comunidades registradas" FROM comunidades_indigenas_de_chile;

-- Calcular el promedio de habitantes entre todas las comunidades.

SELECT AVG(cantidad_habitantes_2024) AS 'Promedio de habitantes de comunidades' FROM comunidades_indigenas_de_chile;

-- Identificar la comunidad con mayor número de habitantes.

SELECT * FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 =
(SELECT MAX(cantidad_habitantes_2024) FROM comunidades_indigenas_de_chile);

-- Determinar cuántas comunidades hay por región.

SELECT 
	región_comunidad, 
    COUNT(*) AS 'Cantidad de comunidades' 
FROM 
	comunidades_indigenas_de_chile 
GROUP BY 
	región_comunidad 
ORDER BY 
	COUNT(*) DESC;

-- Calcular la suma total de habitantes en todas las comunidades.

SELECT SUM(cantidad_habitantes_2024) AS 'Total de habitantes registrados' FROM comunidades_indigenas_de_chile;

-- Mostrar las lenguas maternas y la cantidad total de hablantes por cada una.

SELECT 
	lengua_materna, 
    SUM(cantidad_habitantes_2024) AS 'Cantidad de hablantes' 
FROM 
	comunidades_indigenas_de_chile 
GROUP BY 
	lengua_materna 
ORDER BY 
	SUM(cantidad_habitantes_2024) DESC;

-- Determinar la región con la mayor cantidad de comunidades registradas.

SELECT 
	región_comunidad,
    COUNT(*) AS 'Cantidad de comunidades' 
FROM 
	comunidades_indigenas_de_chile 
GROUP BY 
	región_comunidad 
ORDER BY 
	COUNT(*)DESC LIMIT 3;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
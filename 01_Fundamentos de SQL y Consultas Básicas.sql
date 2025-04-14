### PORTAFOLIO SQL BASE DE DATOS INDIGENA ###

## 1. Fundamentos de SQL y Consultas Básicas

-- Obtener todos los datos de la tabla comunidades_indigenas_chile.

SELECT * FROM comunidades_indigenas_de_chile;

-- Seleccionar solo el nombre_comunidad y lengua_materna de todas las comunidades.

SELECT nombre_comunidad,lengua_materna FROM comunidades_indigenas_de_chile;

-- Filtrar las comunidades que tengan más de 5000 habitantes.

SELECT nombre_comunidad,cantidad_habitantes_2024 FROM comunidades_indigenas_de_chile WHERE cantidad_habitantes_2024 > 5000;

-- Mostrar las comunidades ubicadas en la Región de la Araucanía.

SELECT * FROM comunidades_indigenas_de_chile WHERE región_comunidad = 'Región de la Araucanía';

-- Contar cuántas comunidades tienen el Mapudungun como lengua materna.

SELECT COUNT(*) AS 'Total comunidades con Mapudungun' FROM comunidades_indigenas_de_chile WHERE lengua_materna = 'Mapudungun';

-- Ordenar las comunidades en función de su cantidad_habitantes_2024, de mayor a menor.

SELECT * FROM comunidades_indigenas_de_chile ORDER BY cantidad_habitantes_2024 DESC;

-- Obtener las primeras 5 comunidades con menor población.

SELECT * FROM comunidades_indigenas_de_chile ORDER BY cantidad_habitantes_2024 LIMIT 5;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
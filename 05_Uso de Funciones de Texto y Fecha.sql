## 5. Uso de Funciones de Texto y Fecha

-- Convertir todos los nombres de las comunidades a mayúsculas.

SELECT UPPER(nombre_comunidad) AS 'Comunidades_mayus' FROM comunidades_indigenas_de_chile;

-- Extraer solo el año de reconocimiento legal de las comunidades.

DESC reconocimiento_internacional_comunidades_indigenas;
DESC territorios_comunidades_indigenas;

ALTER TABLE territorios_comunidades_indigenas
ADD COLUMN fecha_reconocimiento_legal DATE;

UPDATE territorios_comunidades_indigenas 
SET fecha_reconocimiento_legal = STR_TO_DATE(CONCAT(año_reconocimiento_legal, '-01-01'), '%Y-%m-%d');

SELECT * FROM territorios_comunidades_indigenas WHERE fecha_reconocimiento_legal IS NULL;

SELECT YEAR(fecha_reconocimiento_legal) FROM territorios_comunidades_indigenas;

-- Mostrar los nombres de las comunidades sin los espacios en blanco al inicio y final.

SELECT TRIM(nombre_comunidad) FROM comunidades_indigenas_de_chile;

-- Reemplazar la palabra "de" por "-" en los nombres de las comunidades.

SELECT REPLACE(nombre_comunidad,"de", "-") AS 'Comunidad modificada' FROM comunidades_indigenas_de_chile;

-- Concatenar el nombre_comunidad con su región_comunidad en una sola columna.

SELECT CONCAT(nombre_comunidad, ' / ',región_comunidad) AS 'comunidad_región' FROM comunidades_indigenas_de_chile;

-- Mostrar solo los tres primeros caracteres del id_comunidad.

SELECT LEFT(id_comunidad,3) AS id_corto_comunidad FROM comunidades_indigenas_de_chile;

-- Convertir todas las lenguas maternas a minúsculas y sin espacios extra.

SELECT LOWER(TRIM(lengua_materna)) AS 'lengua_minus_y_recortada' FROM comunidades_indigenas_de_chile;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
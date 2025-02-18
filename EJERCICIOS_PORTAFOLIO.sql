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

## 6. Creación y Manipulación de Datos

-- Insertar una nueva comunidad con datos ficticios.

INSERT INTO comunidades_indigenas_de_chile(id_comunidad,nombre_comunidad,región_comunidad,lengua_materna,cantidad_habitantes_2024)
VALUES
('DI?-CO-051','Diaguita de Coquimbo','Región de Comquimbo','Diaguita',2700);

INSERT INTO reconocimiento_internacional_comunidades_indigenas(id_comunidad,convenio_oit_169,reconocimiento_onu,declaracion_derechos_indigenas,organizaciones_internacionales_apoyo,año_primer_reconocimiento)
VALUES
('DI?-CO-051','Sí','Parcial','Sí','Amnistía Internacional/ONU',1998);

INSERT INTO territorios_comunidades_indigenas(id_comunidad,territorio_tradicional,superficie_territorio_km2,año_reconocimiento_legal,principales_actividades_economicas,status_tierra,fecha_reconocimiento_legal)
VALUES
('DI?-CO-051','Litoral de Coquimbo',1250.3,1998,'Artesanía y turismo cultural','En proceso','1998-01-01');

-- Actualizar el número de habitantes de una comunidad específica.

UPDATE comunidades_indigenas_de_chile SET cantidad_habitantes_2024 = 9200 WHERE id_comunidad = 'RAP-VA-003';

-- Eliminar una comunidad que haya desaparecido (simulación).

SELECT * FROM comunidades_indigenas_de_chile WHERE id_comunidad = 'QUE-MA-006';

DELETE FROM comunidades_indigenas_de_chile WHERE id_comunidad ='QUE-MA-006';

-- Duplicar los datos de una comunidad en una tabla temporal.

CREATE TEMPORARY TABLE comunidad_colla  
SELECT * FROM comunidades_indigenas_de_chile WHERE nombre_comunidad LIKE 'Colla%';

-- Crear una nueva tabla para almacenar registros históricos de habitantes.

CREATE TABLE registros_historicos_habitantes(
id_comunidad VARCHAR(20) PRIMARY KEY,
cantidad_habitantes_1995 INT(11) NOT NULL,
cantidad_habitantes_2004 INT(11) NOT NULL,
cantidad_habitantes_2012 INT(11) NOT NULL,
cantidad_habitantes_2018 INT(11) NOT NULL,
cantidad_habitantes_2024 INT(11) NOT NULL);

-- Insertar registros en la nueva tabla con datos extraídos de comunidades_indigenas_chile.

INSERT INTO registros_historicos_habitantes(id_comunidad,cantidad_habitantes_2024)
SELECT id_comunidad,cantidad_habitantes_2024
FROM comunidades_indigenas_de_chile;

INSERT IGNORE INTO registros_historicos_habitantes(id_comunidad, cantidad_habitantes_2024) # MANERA COMPLETA DE HACERLO
SELECT id_comunidad, cantidad_habitantes_2024 FROM comunidades_indigenas_chile;

-- Modificar la estructura de la tabla territorios_comunidades_indigenas para agregar una columna de "tipo de ecosistema".

ALTER TABLE territorios_comunidades_indigenas 
ADD COLUMN tipo_de_ecosistema VARCHAR(255) AFTER territorio_tradicional;

SELECT * FROM territorios_comunidades_indigenas;

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
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
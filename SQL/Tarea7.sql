-- 1. Obtener ordenados ascendentemente los códigos de los países de donde son los actores.
SELECT distinct cod_pais
FROM actor
ORDER BY cod_pais asc;
-- 2. Obtener el código y el título de las películas de año anterior a 1970 que no estén basadas en ningún libro ordenadas por título.
SELECT cod_peli, titulo
FROM pelicula
WHERE anyo < 1970 AND cod_lib IS NULL
ORDER BY titulo asc;
-- 3. Obtener el código y el nombre de los actores cuyo nombre incluye “John”.
SELECT cod_act, nombre
FROM actor
WHERE nombre LIKE '%John%';
-- 4. Obtener el código y el título de las películas de más de 120 minutos de la década de los 80.
SELECT cod_peli, titulo
FROM pelicula
WHERE duracion > 120 AND anyo BETWEEN 1980 AND 1989;
-- 5. Obtener el código y el título de las películas que estén basadas en algún libro y cuyo director se apellide ‘Pakula’.
SELECT cod_peli, titulo 
FROM pelicula 
WHERE cod_lib IS NOT NULL AND director LIKE '%Pakula%';
-- 6. ¿Cuántas películas hay de más de 120 minutos de la década de los 80?
SELECT COUNT(cod_peli)
FROM pelicula
WHERE duracion > 120 AND anyo BETWEEN 1980 AND 1989;
-- 7. ¿Cuántas películas se han clasificado de los géneros de código 'BB5' o 'GG4' o'JH6'?
SELECT COUNT(distinct cod_peli)
FROM clasificacion
WHERE cod_gen IN ('BB5','GG4','JH6');
-- 8. ¿De qué año es el libro más antiguo?
SELECT MIN(anyo)
FROM libro_peli
-- 9. ¿Cuál es la duración media de las películas del año 1987?
SELECT AVG(duracion)
FROM pelicula
WHERE anyo = 1987
-- 10. ¿Cuántos minutos ocupan todas las películas dirigidas por ‘Steven Spielberg’?
SELECT SUM(duracion)
FROM pelicula
WHERE director = 'Steven Spielberg'
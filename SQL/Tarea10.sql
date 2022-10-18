-- 21. ¿Cuántas películas hay clasificadas del género de nombre ‘Comedia’ y en las que sólo aparece un
-- actor con el papel ‘Secundario’?
SELECT count(*)
FROM pelicula p 
WHERE p.cod_peli IN (SELECT cod_peli 
                    FROM clasificacion
                    WHERE cod_gen IN (SELECT cod_gen  
                                        FROM genero
                                        WHERE nombre='Comedia')) AND 1 = (SELECT COUNT(*)
                                                                            FROM actua a 
                                                                            WHERE papel='Secundario' AND a.cod_peli=p.cod_peli)
-- 23. Obtener el código y el nombre de actor o actores más viejos.
SELECT cod_act, nombre 
FROM actor 
WHERE EXTRACT (YEAR FROM fecha_nac) = (SELECT MIN(EXTRACT (YEAR FROM fecha_nac))
                                       FROM actor);
-- 24. Obtener el código, el nombre y la fecha de nacimiento del actor más viejo que haya nacido en el
-- año 1940
SELECT a.cod_act, a.nombre,a.fecha_nac
FROM actor a 
WHERE a.fecha_nac = (SELECT MIN(fecha_nac)
                    FROM actor a1 
                    WHERE EXTRACT (YEAR FROM fecha_nac) = 1940)

-- 25. Obtener el nombre del género (o de los géneros) en los que se ha clasificado la película más larga.
SELECT g.nombre 
FROM genero g 
WHERE g.cod_gen IN (SELECT cod_gen 
                    FROM clasificacion
                    WHERE cod_peli IN (SELECT cod_peli
                                        FROM pelicula
                                        WHERE duracion = SELECT MAX(duracion)
                                                            FROM pelicula p )
                    );
        
-- 27. Obtener el título de las películas anteriores a 1950 clasificadas en más de un género (ordenadas por
-- título).
SELECT titulo
FROM pelicula p 
WHERE anyo < 1950 AND 1 < (SELECT COUNT(*)
                            FROM clasificacion c
                            WHERE p.cod_peli=c.cod_peli)
ORDER BY titulo;
-- 28. Obtener la cantidad de películas en las que han participado menos de 4 actores.
SELECT COUNT(*)
FROM pelicula p
WHERE 4 > (SELECT COUNT(*)
            FROM actua a
            WHERE a.cod_peli=p.cod_peli)
-- 29. Obtener los directores que han dirigido más de 250 minutos entre todas sus películas.
SELECT distinct director 
FROM pelicula p1 
WHERE 250 < (SELECT SUM(duracion)
            FROM pelicula p2 
            WHERE p1.director=p2.director)

-- 30. Obtener el año o años en el que nacieron más de 3 actores ordenados ascendentemente.
SELECT distinct EXTRACT(YEAR from fecha_nac)
FROM actor a1 
WHERE 3 < (SELECT COUNT(*)
            FROM actor a2
            WHERE EXTRACT(YEAR from a1.fecha_nac)=EXTRACT(YEAR from a2.fecha_nac))
ORDER BY asc;

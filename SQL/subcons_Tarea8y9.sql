-- 11. Obtener el código y el título de las películas en las que actúa un actor con el mismo nombre que el
-- director de la película (ordenadas por título).
SELECT p.cod_peli, p.titulo
FROM peliculas p 
WHERE p.director IN (SELECT ac.nombre 
                    FROM actor ac, actua a 
                    WHERE ac.cod_act=a.cod_act AND p.cod_peli=a.cod_peli)
ORDER BY p.titulo;

SELECT p.cod_peli, p.titulo
FROM pelicula p 
WHERE EXISTS (SELECT * 
                FROM actor ac, actua a 
                WHERE ac.cod_act=a.cod_act AND p.cod_peli=a.cod_peli AND p.director=ac.nombre)
ORDER BY p.titulo;
-- 12. Obtener el código y el título de las películas clasificadas del género de nombre ‘Comedia’
-- (ordenadas por título).
SELECT p.cod_peli, p.titulo 
FROM pelicula p
WHERE p.cod_peli IN (SELECT c.cod_peli
                    FROM clasificacion c, genero g 
                    WHERE c.cod_gen=g.cod_gen AND g.nombre='Comedia')
ORDER BY p.titulo 
SELECT p.cod_peli, p.titulo 
FROM pelicula p
WHERE p.cod_peli IN (SELECT cod_peli 
                    FROM clasificacion
                    WHERE cod_gen IN (SELECT cod_gen 
                                        FROM genero
                                        WHERE nombre='Comedia'))
ORDER BY p.titulo
-- 13. Obtener el código y el título de las películas basadas en algún libro anterior a 1950.
SELECT p.cod_peli, p.titulo
FROM pelicula p 
WHERE p.cod_lib IN (SELECT l.cod_lib 
                    FROM libro_peli l 
                    WHERE l.anyo <1950)
SELECT p.cod_peli, p.titulo
FROM pelicula p 
WHERE EXISTS (SELECT * 
                FROM libro_peli l 
                WHERE l.anyo <1950 AND p.cod_lib=l.cod_lib)
-- 14. Obtener el código y el nombre de los países de los actores que actúan en películas clasificadas del
-- género de nombre ‘Comedia’ (ordenados por nombre).
SELECT pa.cod_pais, pa.nombre 
FROM pais pa 
WHERE pa.cod_pais IN (SELECT ac.cod_pais
                        FROM actor ac 
                        WHERE ac.cod_act IN (SELECT a.cod_act 
                                            FROM actua a 
                                            WHERE a.cod_peli IN (SELECT c.cod_peli 
                                                                FROM clasificacion c
                                                                WHERE c.cod_gen IN (SELECT cod_gen 
                                                                                    FROM genero
                                                                                    WHERE nombre='Comedia'))));
-- 16. Obtener el código y el nombre de los actores nacidos antes de 1950 que actúan con un papel
-- ‘Principal’ en alguna película (ordenados por nombre).
SELECT ac.cod_act, ac.nombre 
FROM actor ac 
WHERE ac.fecha_nac < 1950 AND ac.cod_act IN (SELECT cod_act 
                                            FROM actua 
                                            WHERE papel='Principal')
ORDER BY ac.nombre;
-- 17. Obtener el código, el título y el autor de los libros en los que se ha basado alguna película de la
-- década de los 90 (ordenadas por título).
SELECT cod_lib, titulo, autor 
FROM libro_peli 
WHERE cod_lib IN (SELECT cod_lib 
                    FROM pelicula 
                    WHERE anyo BETWEEN 1990 AND 1999)
ORDER BY titulo;
-- 18. Obtener el código, el título y el autor de los libros en los que no se haya basado ninguna película.
SELECT cod_lib, titulo, autor 
FROM libro_peli 
WHERE cod_lib NOT IN (SELECT cod_lib 
                        FROM pelicula 
                        WHERE cod_lib IS NOT NULL)
SELECT l.cod_lib, l.titulo, l.autor 
FROM libro_peli l
WHERE NOT EXISTS (SELECT * 
                    FROM pelicula p 
                    WHERE l.cod_lib=p.cod_lib)                    
-- 19. Obtener el nombre del género o géneros a los que pertenecen películas en las que no actúa ningún
-- actor (ordenados por nombre).
SELECT nombre 
FROM genero 
WHERE cod_gen IN (SELECT cod_gen 
                    FROM clasificacion
                    WHERE cod_peli NOT IN (SELECT cod_peli 
                                            FROM actua))
ORDER BY nombre;
SELECT nombre 
FROM genero 
WHERE cod_gen IN (SELECT c.cod_gen 
                    FROM clasificacion c
                    WHERE NOT EXISTS (SELECT * 
                                        FROM actua a
                                        WHERE a.cod_peli=c.cod_peli))
ORDER BY nombre;
-- 20. Obtener el título de los libros en los que se haya basado alguna película en la que no hayan actuado
-- actores del país de nombre ‘USA’ (ordenados por título).
SELECT l.titulo 
FROM libro_peli l
WHERE EXISTS (SELECT *  
                FROM pelicula p
                WHERE l.cod_lib=p.cod_lib AND NOT EXISTS (SELECT * 
                                                            FROM actua a
                                                            WHERE a.cod_peli=p.cod_peli AND EXISTS (SELECT * 
                                                                                                    FROM actor ac 
                                                                                                     WHERE a.cod_act=ac.cod_act AND EXISTS (SELECT cod_pais 
                                                                                                                                            FROM pais pa 
                                                                                                                                             WHERE pa.cod_pais=ac.cod_pais AND pa.nombre='USA')))) 
ORDER BY titulo;
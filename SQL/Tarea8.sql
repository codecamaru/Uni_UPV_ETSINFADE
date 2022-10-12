-- Consultas sobre varias tablas
-- 11. Obtener el código y el título de las películas en las que actúa un actor con el mismo nombre que el director de la película (ordenadas por título).
SELECT p.cod_peli, p.titulo 
FROM pelicula p, actua a, actor ac 
WHERE p.director=ac.nombre AND a.cod_act=ac.cod_act AND p.cod_peli=a.cod_peli 
ORDER BY p.titulo;
-- 12. Obtener el código y el título de las películas clasificadas del género de nombre ‘Comedia’ (ordenadas por título).
SELECT p.titulo, p.cod_peli 
FROM pelicula p, clasificacion c, genero g 
WHERE p.cod_peli=c.cod_peli AND c.cod_gen=g.cod_gen AND g.nombre='Comedia'
ORDER BY p.titulo;
-- 13. Obtener el código y el título de las películas basadas en algún libro anterior a 1950.
SELECT p.cod_peli, p.titulo 
FROM pelicula p, libro_peli l 
WHERE p.cod_lib=l.cod_lib AND l.anyo<1950;
-- 14. Obtener el código y el nombre de los países de los actores que actúan en películas clasificadas del género de nombre ‘Comedia’ (ordenados por nombre).
SELECT pa.cod_pais, pa.nombre 
FROM pais pa, actor a, actua ac, genero g, clasificacion c
WHERE pa.cod_pais=a.cod_pais AND a.cod_act=ac.cod_act AND ac_cod_peli=c.cod_peli AND c.cod_gen=g.cod_gen AND g.nombre='Comedia'
ORDER BY pa.nombre;
-- 32. Obtener el código y el nombre de los países con actores y tales que todos los actores de ese país
-- han nacido en el siglo XX (ordenados por nombre).
SELECT pa.cod_pais, pa.nombre 
FROM pais pa 
WHERE EXISTS (SELECT *
                FROM actor ac 
                WHERE ac.cod_pais=pa.cod_pais) AND NOT EXISTS (SELECT *
                                                                FROM actor a 
                                                                WHERE a.cod_pais=pa.cod_pais AND NOT EXTRACT(YEAR from a.fecha_nac) BETWEEN 1900 AND 1999)
ORDER BY pa.nombre;
                                                                                          -- (AND EXTRACT YEAR from a.fecha_nach) < 1900 OR EXTRACT YEAR from a.fecha_nach) > 1999)  
-- (tambien puedes contar que todos los actores que pertenecen a ese pais es igual a todos los que pertenecen y están entre ese siglo)

-- 33. Obtener el código y el nombre de los actores tales que todos los papeles que han tenido son de
-- ‘Secundario’. Sólo interesan aquellos actores que hayan actuado en alguna película.
SELECT a.cod_act, a.nombre 
FROM actor a 
WHERE EXISTS(SELECT * 
            FROM actua ac 
            WHERE ac.cod_act=a.cod_act) AND NOT EXISTS (SELECT * 
                                                        FROM actua a1
                                                        WHERE a.cod_act=a1.cod_act AND a1.papel<>'Secundario')

-- 34. Obtener el código y el nombre de los actores que han aparecido en todas las películas del director
-- ‘Guy Ritchie’ (sólo si ha dirigido al menos una).                                                                           
SELECT a.cod_act, a.nombre 
FROM actor a 
WHERE EXISTS(SELECT *
                 FROM pelicula p 
                WHERE director='Guy Ritchie')
        AND NOT EXISTS (SELECT *
                        FROM pelicula p 
                        WHERE p.director='Guy Ritchie' AND NOT EXISTS (SELECT *
                                                                        FROM actua ac 
                                                                        WHERE ac.cod_peli=p.cod_peli AND ac.cod_act=a.cod_act));             

-- 35. Obtener el código y el nombre de los actores que han aparecido en todas las películas del director
-- ‘John Steel’ (sólo si ha dirigido al menos una).
SELECT a.cod_act, a.nombre 
FROM actor a 
WHERE EXISTS(SELECT *
                 FROM pelicula p 
                WHERE director='John Steel')
        AND NOT EXISTS (SELECT *
                        FROM pelicula p 
                        WHERE p.director='John Steel' AND NOT EXISTS (SELECT *
                                                                        FROM actua ac 
                                                                        WHERE ac.cod_peli=p.cod_peli AND ac.cod_act=a.cod_act));   

-- 36. Obtener el código y el título de las películas de menos de 100 minutos en las que todos los actores
-- que han actuado son de un mismo país (ordenadas por título).

SELECT p.cod_peli,p.titulo
FROM pelicula p 
WHERE p.duracion<100 AND EXISTS(SELECT *
                                FROM pais pa
                                WHERE NOT EXISTS(SELECT *
                                                FROM actor a 
                                                WHERE EXISTS(SELECT *
                                                                FROM actua ac 
                                                                WHERE ac.cod_act=a.cod_act AND ac.cod_peli=p.cod_peli) AND a.cod_pais<>pa.cod_pais)) AND EXISTS(SELECT *
                                                                                                                                                                FROM actua a
                                                                                                                                                                WHERE a.cod_peli=p.cod_peli);

-- 37. Obtener el código, el título y el año de las películas en las que haya actuado algún actor si se cumple
-- que todos los actores que han actuado en ella han nacido antes del año 1943 (hasta el 31/12/1942).

SELECT p.cod_peli, p.titulo, p.anyo 
FROM pelicula p 
WHERE EXISTS(SELECT * FROM actua a WHERE a.cod_peli=p.cod_peli) AND 
        NOT EXISTS(SELECT *
                  FROM actua ac 
                  WHERE ac.cod_peli=p.cod_peli AND NOT EXISTS(SELECT *
                                                        FROM actor a 
                                                        WHERE a.cod_act=ac.cod_act AND a.fecha_nac < '1/1/1943'));

-- 38. Obtener el código y el nombre de cada país si se cumple que todos sus actores han actuado en al
-- menos una película de más de 120 minutos. (Ordenados por nombre).
SELECT pa.cod_pais, pa.nombre
FROM pais pa 
WHERE EXISTS (SELECT *
                FROM actor a 
                WHERE a.cod_pais=pa.cod_pais) AND 
        NOT EXISTS (SELECT * 
                    FROM actor a 
                    WHERE a.cod_pais=pa.cod_pais AND NOT EXISTS(SELECT *
                                                                FROM actua ac 
                                                                WHERE ac.cod_act=a.cod_act AND EXISTS (SELECT *
                                                                                                        FROM pelicula p 
                                                                                                        WHERE p.cod_peli=ac,cod_peli AND p.duracion > 120)))
ORDER BY pa.nombre;
-- 3.2 Consultas sobre varias tablas
-- 11. Obtener el código y el título de las películas en las que actúa un actor con el mismo nombre que el director
-- de la película (ordenadas por título).
select p.cod_peli, p.titulo
from PELICULA p 
WHERE EXISTS (SELECT *
             FROM ACTUA a
             WHERE a.cod_peli = p.cod_peli AND EXISTS (SELECT *
                                                      FROM ACTOR ac
                                                      WHERE ac.cod_act = a.cod_act AND ac.nombre = p.director))
                                     ORDER BY p.cod_peli desc;
-- otra forma 
select p.cod_peli, p.titulo
from PELICULA p, ACTUA a, ACTOR ac 
WHERE a.cod_peli = p.cod_peli AND ac.cod_act = a.cod_act AND ac.nombre = p.director ORDER BY p.cod_peli desc;
-- 12. Obtener el código y el título de las películas clasificadas del género de nombre ‘Comedia’ (ordenadas por
-- título).
SELECT p.cod_peli, p.titulo 
FROM PELICULA p
WHERE EXISTS (SELECT *
             FROM CLASIFICACION c
             WHERE c.cod_peli = p.cod_peli AND EXISTS (SELECT *
                                                        FROM GENERO g
                                                        WHERE g.nombre = 'Comedia' AND g.cod_gen = c.cod_gen))
                                                        ORDER BY p.titulo asc;
-- otra forma
SELECT p.cod_peli, p.titulo
FROM PELICULA p, CLASIFICACION c, GENERO g
WHERE c.cod_peli = p.cod_peli AND g.nombre = 'Comedia' AND g.cod_gen = c.cod_gen
ORDER BY p.titulo asc;
-- 13. Obtener el código y el título de las películas basadas en algún libro anterior a 1950.
SELECT p.cod_peli, p.titulo
FROM PELICULA p, LIBRO_PELI l 
WHERE p.cod_lib = l.cod_lib AND l.anyo < 1950;
-- otra forma
SELECT p.cod_peli, p.titulo
FROM PELICULA p 
WHERE EXISTS (SELECT *
             FROM LIBRO_PELI l 
             WHERE p.cod_lib = l.cod_lib AND l.anyo < 1950);
-- 14. Obtener el código y el nombre de los países de los actores que actúan en películas clasificadas del género
-- de nombre ‘Comedia’ (ordenados por nombre).
SELECT distinct p.cod_pais, p.nombre 
FROM PAIS p, ACTOR a, ACTUA ac, CLASIFICACION c, GENERO g 
WHERE p.cod_pais = a.cod_pais AND a.cod_act = ac.cod_act AND ac.cod_peli = c.cod_peli AND g.cod_gen = c.cod_gen 
AND g.nombre = 'Comedia' ORDER BY p.nombre ASC;
-- 3.3 Consultas con subconsultas
-- 16. Obtener el código y el nombre de los actores nacidos antes de 1950 que actúan con un papel ‘Principal’
-- en alguna película (ordenados por nombre).
SELECT DISTINCT  A.COD_ACT, A.NOMBRE
FROM ACTOR A, ACTUA AC  
WHERE A.COD_ACT = AC.COD_ACT AND AC.PAPEL = 'Principal' AND A.FECHA_NAC < 1950;
-- otra forma
SELECT A.COD_ACT, A.NOMBRE
FROM ACTOR A 
WHERE EXISTS (SELECT *
             FROM ACTUA AC
             WHERE A.COD_ACT = AC.COD_ACT AND AC.PAPEL = 'Principal') AND YEAR(A.FECHA_NAC) < 1950
ORDER BY A.NOMBRE;
-- 17. Obtener el código, el título y el autor de los libros en los que se ha basado alguna película de la década
-- de los 90 (ordenados por título).
SELECT L.COD_LIB, L.TITULO, L.AUTOR
FROM LIBRO_PELI L 
WHERE EXISTS (SELECT *
             FROM PELICULA P 
             WHERE L.COD_LIB = P.COD_LIB AND P.ANYO BETWEEN 1990 AND 1999) 
ORDER BY L.TITULO;
-- otra forma
SELECT DISTINCT L.COD_LIB, L.TITULO, L.AUTOR -- da el mismo resultado sin el distinc, pero únicamente por el caso particular
FROM LIBRO_PELI L, PELICULA P -- en otro caso podría ser evidente que el distinct es necesario
WHERE L.COD_LIB = P.COD_LIB AND P.ANYO BETWEEN 1990 AND 1999
ORDER BY L.TITULO;
-- 18. Obtener el código, el título y el autor de los libros en los que no se haya basado ninguna película.
SELECT L.COD_LIB, L.TITULO, L.AUTOR
FROM LIBRO_PELI L
WHERE NOT EXISTS (SELECT *
                 FROM PELICULA P
                 WHERE L.COD_LIB = P.COD_LIB)
ORDER BY L.TITULO;
-- 19. Obtener el nombre del género o géneros a los que pertenecen películas en las que no actúa ningún actor
-- (ordenados por nombre).
SELECT G.NOMBRE
FROM GENERO G 
WHERE EXISTS (SELECT *
             FROM CLASIFICACION C 
             WHERE C.COD_GEN = G.COD_GEN AND EXISTS (SELECT *
                                                    FROM PELICULA P 
                                                    WHERE P.COD_PELI = C.COD_PELI AND NOT EXISTS (SELECT *
                                                                                                 FROM ACTUA A 
                                                                                                 WHERE A.COD_PELI = P.COD_PELI)))
ORDER BY G.NOMBRE;
-- 20. Obtener el título de los libros en los que se haya basado alguna película en la que no hayan actuado
-- actores del país de nombre ‘USA’ (ordenados por título).
SELECT L.TITULO
FROM LIBRO_PELI L 
WHERE EXISTS (SELECT *
             FROM PELICULA P
             WHERE L.COD_LIB = P.COD_LIB AND NOT EXISTS (SELECT *
                                                        FROM ACTUA A 
                                                        WHERE A.COD_PELI = P.COD_PELI AND EXISTS (SELECT * 
                                                                                                 FROM ACTOR AC 
                                                                                                 WHERE AC.COD_ACT = A.COD_ACT AND EXISTS (SELECT *
                                                                                                                                          FROM PAIS PA 
                                                                                                                                          WHERE PA.COD_PAIS = AC.COD_PAIS AND PA.NOMBRE = 'USA'))))
ORDER BY L.TITULO;
-- 21. ¿Cuántas películas hay clasificadas del género de nombre ‘Comedia’ y en las que sólo aparece un actor
-- con el papel ‘Secundario’?
SELECT COUNT(*)
FROM PELICULA P
WHERE (EXISTS (SELECT *
                FROM CLASIFICACION C
                WHERE C.COD_PELI = P.COD_PELI AND EXISTS (SELECT *
                                                            FROM GENERO G
                                                            WHERE G.NOMBRE = 'Comedia' AND G.COD_GEN = C.COD_GEN))) 
AND 1 =  (SELECT COUNT(A.COD_ACT) 
            FROM ACTUA A
            WHERE A.COD_PELI = P.COD_PELI);
-- 22. Obtener el a�o de la primera pel�cula en la que el actor de nombre �Jude Law� tuvo un papel como �Principal�        
SELECT MIN(P.ANYO)
FROM PELICULA P
WHERE EXISTS (SELECT *
                FROM ACTUA A
                WHERE A.COD_PELI = P.COD_PELI AND A.PAPEL = 'Principal' AND EXISTS (SELECT *
                                                                                    FROM ACTOR AC
                                                                                    WHERE AC.COD_ACT = A.COD_ACT AND AC.NOMBRE = 'Jude Law'));
-- 23. Obtener el c�digo y el nombre de actor o actores m�s viejos.
SELECT AC.COD_ACT, AC.NOMBRE
FROM ACTOR AC
WHERE AC.FECHA_NAC = (SELECT MIN(AC1.FECHA_NAC)
                        FROM ACTOR AC1);
-- 24. Obtener el c�digo, el nombre y la fecha de nacimiento del actor m�s viejo nacido en el a�o 1940.
SELECT A.COD_ACT, A.NOMBRE, A.FECHA_NAC
FROM ACTOR A
WHERE A.FECHA_NAC = (SELECT MIN(AC.FECHA_NAC)
                    FROM ACTOR AC
                    WHERE EXTRACT(YEAR FROM AC.FECHA_NAC) = 1940);
-- 25. Obtener el nombre del g�nero (o de los g�neros) en los que se ha clasificado la pel�cula m�s larga.
SELECT G.NOMBRE
FROM GENERO G
WHERE EXISTS (SELECT *
                FROM CLASIFICACION C
                WHERE C.COD_GEN = G.COD_GEN AND EXISTS (SELECT *
                                                        FROM PELICULA P1
                                                        WHERE P1.DURACION = (SELECT MAX(P.DURACION)
                                                                             FROM PELICULA P) AND P1.COD_PELI = C.COD_PELI));
-- 26. Obtener el código y el título de los libros en los que se han basado películas en las 
-- que actúan actores del país de nombre España (ordenados por título). 
SELECT L.COD_LIB, L.TITULO
FROM LIBRO_PELI L 
WHERE EXISTS (SELECT *
             FROM PELICULA P 
             WHERE P.COD_LIB = L.COD_LIB AND EXISTS (SELECT *
                                                    FROM ACTUA A 
                                                    WHERE A.COD_PELI = P.COD_PELI AND EXISTS (SELECT *
                                                                                             FROM ACTOR AC 
                                                                                             WHERE AC.COD_ACT = A.COD_ACT AND EXISTS (SELECT *
                                                                                                                                     FROM PAIS PA 
                                                                                                                                     WHERE PA.COD_PAIS = AC.COD_PAIS AND PA.NOMBRE = 'España'))))
ORDER BY L.TITULO;
-- otra forma
SELECT DISTINCT L.COD_LIB, L.TITULO -- esta consulta en particular da el mismo resultado si no se usa distinct. Sin embargo, si se hace la misma con UK, es evidente que el distinct es necesario
FROM LIBRO_PELI L , PELICULA P, ACTUA A, ACTOR AC, PAIS PA
WHERE P.COD_LIB = L.COD_LIB AND A.COD_PELI = P.COD_PELI AND AC.COD_ACT = A.COD_ACT AND PA.COD_PAIS = AC.COD_PAIS AND PA.NOMBRE = 'España'
ORDER BY L.TITULO;
-- 27. Obtener el título de las películas anteriores a 1950 clasificadas en más de un 
-- género (ordenadas por título).
SELECT P.TITULO
FROM PELICULA P 
WHERE 1 < (SELECT COUNT(C.COD_PELI)
          FROM CLASIFICACION C 
          WHERE C.COD_PELI = P.COD_PELI) AND P.ANYO < 1950
ORDER BY P.TITULO;
-- 28. Obtener la cantidad de películas en las que han participado menos de 4 actores.
SELECT COUNT(*)
FROM PELICULA P 
WHERE 4 > (SELECT COUNT(A.COD_ACT)
          FROM ACTUA A 
          WHERE A.COD_PELI = P.COD_PELI);
-- 29. Obtener los directores que han dirigido más de 250 minutos entre todas sus películas
SELECT DISTINCT P.DIRECTOR
FROM PELICULA P 
WHERE 250 < (SELECT SUM(P1.DURACION)
              FROM PELICULA P1
              WHERE P1.DIRECTOR = P.DIRECTOR);
-- 30. Obtener el año o años en el que nacieron más de 3 actores.
SELECT DISTINCT YEAR(A.FECHA_NAC)
FROM ACTOR A
WHERE 3 < (SELECT COUNT(*)
           FROM ACTOR A1
           WHERE YEAR(A1.FECHA_NAC) = YEAR(A.FECHA_NAC));
-- 31. Obtener el código y nombre del actor más joven que ha participado en una 
-- película clasificada del género de código ‘DD8’.                         
SELECT A.COD_ACT, A.NOMBRE
FROM ACTOR A 
WHERE EXISTS (SELECT *
             FROM ACTUA AC 
             WHERE AC.COD_ACT = A.COD_ACT AND EXISTS (SELECT *
                                                     FROM CLASIFICACION C 
                                                     WHERE C.COD_PELI = AC.COD_PELI AND EXISTS (SELECT *
                                                                                               FROM GENERO G 
                                                                                               WHERE G.COD_GEN = C.COD_GEN AND G.COD_GEN = 'DD8'))) and A.FECHA_NAC = (SELECT MAX(A1.FECHA_NAC)
                                                                                                                                                                        FROM ACTOR A1 
                                                                                                                                                                        WHERE EXISTS (SELECT *
                                                                                                                                                                                     FROM ACTUA AC2 
                                                                                                                                                                                     WHERE AC2.COD_ACT = A1.COD_ACT AND EXISTS (SELECT *
                                                                                                                                                                                                                             FROM CLASIFICACION C2
                                                                                                                                                                                                                             WHERE C2.COD_PELI = AC2.COD_PELI AND EXISTS (SELECT *
                                                                                                                                                                                                                                                                       FROM GENERO G2 
                                                                                                                                                                                                                                                                       WHERE G2.COD_GEN = C2.COD_GEN AND G2.COD_GEN = 'DD8'))));
-- 3.4 Consultas universalmente cuantificadas
-- 32. Obtener el código y el nombre de los países con actores y tales que todos los actores 
-- de ese país han nacido en el siglo XX (ordenados por nombre).
SELECT PA.COD_PAIS, PA.NOMBRE
FROM PAIS PA 
WHERE EXISTS (SELECT *
             FROM ACTOR AC 
             WHERE AC.COD_PAIS = PA.COD_PAIS) AND
     NOT EXISTS (SELECT * 
                FROM ACTOR AC1
                WHERE AC1.COD_PAIS = PA.COD_PAIS AND NOT YEAR(AC1.FECHA_NAC) BETWEEN 1900 AND 2000 )
     ORDER BY PA.NOMBRE;
-- 33. Obtener el código y el nombre de los actores tales que todos los papeles que han tenido 
-- son de ‘Secundario’. Sólo interesan aquellos actores que hayan actuado en alguna película.
SELECT AC.COD_ACT, AC.NOMBRE
FROM ACTOR AC 
WHERE EXISTS (SELECT *
             FROM ACTUA A 
             WHERE A.COD_ACT = AC.COD_ACT)
     AND NOT EXISTS (SELECT *
                    FROM ACTUA A1 
                    WHERE A1.COD_ACT = AC.COD_ACT AND NOT A1.PAPEL = 'Secundario')
                    ORDER BY AC.NOMBRE;
-- 34. Obtener el código y el nombre de los actores que han aparecido en todas las 
-- películas del director ‘Guy Ritchie’ (sólo si ha dirigido al menos una).                    
SELECT AC.COD_ACT, AC.NOMBRE
FROM ACTOR AC 
WHERE EXISTS (SELECT *
             FROM PELICULA P 
             WHERE P.DIRECTOR = 'Guy Ritchie') 
             AND NOT EXISTS (SELECT *
                            FROM PELICULA PE 
                            WHERE PE.DIRECTOR = 'Guy Ritchie' AND NOT EXISTS (SELECT *
                                                                               FROM ACTUA A 
                                                                               WHERE A.COD_PELI = PE.COD_PELI AND A.COD_ACT = AC.COD_ACT))
-- 35. Resolver la consulta anterior pero para el director de nombre ‘John Steel’.
SELECT AC.COD_ACT, AC.NOMBRE
FROM ACTOR AC 
WHERE EXISTS (SELECT *
             FROM PELICULA P 
             WHERE P.DIRECTOR = 'John Steel') 
             AND NOT EXISTS (SELECT *
                            FROM PELICULA PE 
                            WHERE PE.DIRECTOR = 'John Steel' AND NOT EXISTS (SELECT *
                                                                               FROM ACTUA A 
                                                                               WHERE A.COD_PELI = PE.COD_PELI AND A.COD_ACT = AC.COD_ACT)) 
-- 36. Obtener el código y el título de las películas de menos de 100 minutos en las que 
-- todos los actores que han actuado son de un mismo país.  
SELECT p.cod_peli,p.titulo
FROM PELICULA p 
WHERE p.duracion<100 AND EXISTS(SELECT *
                                FROM PAIS pa
                                WHERE NOT EXISTS(SELECT *
                                                FROM ACTOR a -- no existe actor que actue en esa peli y que no sea de ese pais
                                                WHERE EXISTS(SELECT *
                                                                FROM ACTUA ac 
                                                                WHERE ac.cod_act=a.cod_act AND ac.cod_peli=p.cod_peli) AND a.cod_pais<>pa.cod_pais)) AND EXISTS(SELECT * -- que esa peli tenga actores
                                                                                                                                                                FROM ACTUA a
                                                                                                                                                                WHERE a.cod_peli=p.cod_peli);
-- tambien funciona, lo mismo pero mas largo                                                                                                                                                           
SELECT PE.COD_PELI, PE.TITULO
FROM PELICULA PE 
WHERE PE.DURACION < 100 AND EXISTS (SELECT * -- no existe un actor de esa peli que no sea de ese pais (y que existan actores de ese pais)
                                    FROM PAIS PA 
                                    WHERE NOT EXISTS (SELECT *
                                                     FROM ACTOR AC 
                                                     WHERE NOT AC.COD_PAIS = PA.COD_PAIS AND EXISTS (SELECT *
                                                                                                FROM ACTUA A 
                                                                                                WHERE A.COD_ACT = AC.COD_ACT AND A.COD_PELI = PE.COD_PELI))
                                   AND EXISTS (SELECT *
                                              FROM ACTOR A1
                                              WHERE A1.COD_PAIS = PA.COD_PAIS AND EXISTS (SELECT *
                                                                                                FROM ACTUA A2 
                                                                                                WHERE A2.COD_ACT = A1.COD_ACT AND A2.COD_PELI = PE.COD_PELI)))
-- 37. Obtener el código, el título y el año de las películas en las que haya actuado algún 
-- actor si se cumple que todos los actores que han actuado en ella han nacido antes del año 
-- 1943 (hasta el 31/12/1942).     
SELECT PE.COD_PELI, PE.TITULO, PE.ANYO 
FROM PELICULA PE
WHERE EXISTS (SELECT * 
             FROM ACTUA A 
             WHERE A.COD_PELI = PE.COD_PELI)
     AND NOT EXISTS (SELECT * 
                    FROM ACTUA A2
                    WHERE A2.COD_PELI = PE.COD_PELI 
                    		AND EXISTS (SELECT *
                                       FROM ACTOR AC 
                                       WHERE AC.COD_ACT = A2.COD_ACT AND NOT YEAR(AC.FECHA_NAC) < 1943))
ORDER BY PE.TITULO  ;
-- 38. Obtener el código y el nombre de cada país si se cumple que todos sus actores han actuado 
-- en al menos una película de más de 120 minutos. (Ordenados por nombre).  
SELECT PA.COD_PAIS, PA.NOMBRE
FROM PAIS PA 
WHERE EXISTS (SELECT * -- el país tiene actores que actúan en películas
             FROM ACTOR AC 
             WHERE AC.COD_PAIS = PA.COD_PAIS
             AND EXISTS (SELECT * 
                        FROM ACTUA A1
                        WHERE A1.COD_ACT = AC.COD_ACT))
      AND NOT EXISTS (SELECT * -- no existe un actor de ese país tal que no actúe en una peli de más de 120 mins
                     FROM ACTOR AC2
                     WHERE AC2.COD_PAIS = PA.COD_PAIS
                     		AND NOT EXISTS (SELECT *
                                       FROM ACTUA A 
                                       WHERE A.COD_ACT = AC2.COD_ACT
                                       			AND EXISTS (SELECT *
                                                           FROM PELICULA PE 
                                                           WHERE PE.COD_PELI = A.COD_PELI
                                                           			AND PE.DURACION > 120)))
ORDER BY PA.NOMBRE; 
-- 3.6 Consultas con concatenación
-- 50. Obtener para todos los países que hay en la base de datos, el código, el nombre y 
-- la cantidad de actores que hay de ese país. 
SELECT PA.COD_PAIS, PA.NOMBRE, (SELECT COUNT(*)
                               FROM ACTOR A 
                               WHERE A.COD_PAIS = PA.COD_PAIS
                               GROUP BY A.COD_PAIS)
FROM PAIS PA
GROUP BY PA.COD_PAIS, PA.NOMBRE 
ORDER BY PA.NOMBRE;
-- otra forma  
SELECT PA.COD_PAIS, PA.NOMBRE, COUNT(COD_ACT)
FROM PAIS PA LEFT JOIN ACTOR A ON PA.COD_PAIS = A.COD_PAIS
GROUP BY COD_PAIS, PA.NOMBRE
ORDER BY PA.NOMBRE;   
-- 51. Obtener el código y el título de todos los libros de la base de datos de año 
-- posterior a 1980 junto con la cantidad de películas a que han dado lugar.   
SELECT L.COD_LIB, L.TITULO, COUNT(P.COD_PELI)
FROM LIBRO_PELI L LEFT JOIN PELICULA P ON P.COD_LIB = L.COD_LIB 
WHERE L.ANYO > 1980
GROUP BY L.COD_LIB, L.TITULO;
-- 52. Obtener para todos los países que hay en la base de datos, el código, 
-- el nombre y la cantidad de actores que hay de ese país que hayan tenido un papel 
-- como “Secundario” en alguna película
SELECT PA.COD_PAIS, PA.NOMBRE, COUNT(DISTINCT A.COD_ACT)
FROM PAIS PA LEFT JOIN (ACTOR A JOIN ACTUA AC ON AC.PAPEL = 'Secundario' AND AC.COD_ACT = A.COD_ACT) USING (COD_PAIS)
GROUP BY PA.COD_PAIS, PA.NOMBRE
ORDER BY PA.NOMBRE; 
-- 53. Obtener para cada película que hay en la base de datos que dure más de 140 minutos, 
-- el código, el título, la cantidad de géneros en los que está clasificado y la cantidad 
-- de actores que han actuado en ella.
SELECT PE.COD_PELI, PE.TITULO, COUNT(DISTINCT C.COD_GEN), COUNT(DISTINCT A.COD_ACT)
FROM ACTUA A RIGHT JOIN (PELICULA PE LEFT JOIN CLASIFICACION C USING (COD_PELI)) USING (COD_PELI)
WHERE PE.DURACION > 140 
GROUP BY PE.COD_PELI, PE.TITULO
ORDER BY PE.TITULO;
-- 3.7 Consultas conjuntistas
-- 54. Obtener los años, ordenados ascendentemente, que aparecen en la base de datos como año en 
-- el que se editó un libro o se filmó una película. Sólo interesan años en los que no aparezca 
-- el dígito 9. 
SELECT ANYO 
FROM LIBRO_PELI
WHERE ANYO NOT LIKE '%9%'
UNION
SELECT ANYO
FROM PELICULA
WHERE ANYO NOT LIKE '%9%'
ORDER BY ANYO ASC;
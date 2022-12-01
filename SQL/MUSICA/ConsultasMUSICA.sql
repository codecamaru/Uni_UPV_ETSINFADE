-- 5.1 Consultas sobre una sola relación
-- 1. ¿Cuántos discos hay?
select COUNT(*)
from DISCO;
-- 2. Selecciona el nombre de los grupos que no sean de España.
select nombre
from GRUPO
WHERE pais <> 'España';
-- 3. Obtener el título de las canciones con más de 5 minutos de duración.
select titulo 
from CANCION 
WHERE duracion > 5;
-- 4. Obtener la lista de las distintas funciones que se pueden realizar en un grupo.
select DISTINCT funcion 
from PERTENECE
ORDER BY funcion asc;
-- 5. Obtener la lista de clubs de fans junto con su tamaño (número de personas). La lista debe estar ordenada
-- de menor a mayor según el tamaño del club.
SELECT nombre, num AS numero_personas
FROM CLUB
ORDER BY num asc;
-- 6. Selecciona el nombre y la sede de los clubes de fans con más de 500 socios.  
SELECT nombre, sede
FROM CLUB
where num > 500;
-- 5.2 Consultas sobre varias relaciones
-- 7. Obtener el nombre y la sede de cada club de fans de grupos de España así como el nombre del grupo al
-- que admiran.
SELECT c.nombre, c.sede, g.nombre 
FROM CLUB c, GRUPO g 
WHERE c.cod_gru = g.cod AND g.pais = 'España';
-- 8. Obtener el nombre de los artistas que pertenezcan a un grupo de España.  
SELECT a.nombre
FROM ARTISTA a, PERTENECE p, GRUPO g 
WHERE a.dni = p.dni AND p.cod = g.cod AND g.pais = 'España' ORDER BY a.nombre asc;
-- otra forma
SELECT a.nombre
FROM ARTISTA a 
WHERE EXISTS (SELECT *
             FROM PERTENECE p
             WHERE EXISTS (SELECT *
                          FROM GRUPO g
                          WHERE p.cod = g.cod AND g.pais = 'España') AND a.dni = p.dni)
ORDER BY a.nombre asc;
-- 9. Obtener el nombre de los discos que contienen alguna canción que dure más de 5 minutos. 
SELECT d.nombre
FROM DISCO d  
WHERE EXISTS (SELECT *
             FROM ESTA e
             WHERE EXISTS (SELECT *
                          FROM CANCION c
                          WHERE e.can = c.cod AND c.duracion > 5) AND e.cod = d.cod)

-- otra forma 
SELECT distinct d.nombre
FROM DISCO d, ESTA e, CANCION c 
WHERE d.cod = e.cod AND e.can = c.cod AND c.duracion > 5 
ORDER BY d.nombre asc;
-- 10. Obtener los nombres de las canciones que dan nombre al disco en el que aparecen. 
SELECT c.titulo
from CANCION c
WHERE EXISTS (SELECT *
             FROM ESTA e
             WHERE c.cod = e.can AND EXISTS (SELECT *
                                            FROM DISCO d 
                                            WHERE d.cod = e.cod AND d.nombre = c.titulo));
-- otra forma
SELECT c.titulo
from CANCION c, ESTA e, DISCO d
WHERE c.cod = e.can AND d.cod = e.cod AND d.nombre = c.titulo;
-- 11. Obtener los nombres de compañías y direcciones postales de aquellas compañías que han 
-- grabado algún disco que empiece por ‘A’.
SELECT c.nombre, c.dir
FROM COMPANYIA c, DISCO d 
WHERE c.cod = d.cod_comp AND d.nombre LIKE 'A%';
-- otra forma
SELECT c.nombre, c.dir
FROM COMPANYIA c 
where EXISTS(SELECT *
            FROM DISCO d
            WHERE c.cod = d.cod_comp AND d.nombre LIKE 'A%');
-- 12. DNI de los artistas que pertenecen a más de un grupo.
SELECT distinct p1.dni 
FROM PERTENECE p1, PERTENECE p2
WHERE p1.dni = p2.dni AND p1.cod <> p2.cod;
-- otra forma
SELECT distinct p1.dni AS artistaqueperteneceamasdeungrupo
FROM PERTENECE p1 
WHERE EXISTS (SELECT *
             FROM PERTENECE p2
             WHERE p1.dni = p2.dni AND p1.cod <> p2.cod);
-- 5.3 Consultas con subconsultas
-- 13. Obtener el nombre de los discos del grupo más viejo.
SELECT D.NOMBRE
FROM DISCO D 
WHERE EXISTS (SELECT *
             FROM GRUPO G
             WHERE G.COD = D.COD_GRU AND G.FECHA = (SELECT MIN(G2.FECHA)
                                                   FROM GRUPO G2));
-- 14. Obtener el nombre de los discos grabados por grupos con club de fans con más de 5000 personas.
SELECT D.NOMBRE
FROM DISCO D 
WHERE EXISTS (SELECT *
             FROM GRUPO G
             WHERE G.COD = D.COD_GRU AND EXISTS (SELECT *
                                                FROM CLUB C
                                                WHERE C.COD_GRU = G.COD AND C.NUM > 5000));
-- otra forma 
SELECT distinct D.NOMBRE
FROM DISCO D , GRUPO G, CLUB C
WHERE G.COD = D.COD_GRU AND C.COD_GRU = G.COD AND C.NUM > 5000;                                                                                                   
-- 15. Obtener el nombre de los clubes con mayor número de fans indicando ese número. 
SELECT C.NOMBRE, C.NUM
FROM CLUB C
WHERE C.NUM = (SELECT MAX(C1.NUM)
              FROM CLUB C1);
-- 16. Obtener el título de las canciones de mayor duración indicando la duración.
SELECT C.TITULO, C.DURACION
FROM CANCION C
WHERE C.DURACION = (SELECT MAX(C1.DURACION)
                   FROM CANCION C1);
-- 5.4 Consultas con cuantificación universal
-- 17. Obtener el nombre de las compañías discográficas que no han trabajado con grupos españoles.                                 
SELECT C.NOMBRE
FROM COMPANYIA C 
WHERE NOT EXISTS (SELECT *
                 FROM COMPANYIA C1
                 where C1.COD = C.COD AND EXISTS (SELECT *
                                                 FROM DISCO D 
                                                 WHERE D.COD_COMP = C1.COD AND EXISTS (SELECT *
                                                                                      FROM GRUPO G 
                                                                                      WHERE G.COD = D.COD_GRU AND G.PAIS = 'España')));
-- 18. Obtener el nombre de las compañías discográficas que sólo han trabajado con 
-- grupos españoles.        
SELECT C.NOMBRE
FROM COMPANYIA C 
WHERE NOT EXISTS (SELECT *
                 FROM COMPANYIA C1
                 where C1.COD = C.COD AND EXISTS (SELECT *
                                                 FROM DISCO D 
                                                 WHERE D.COD_COMP = C1.COD AND EXISTS (SELECT *
                                                                                      FROM GRUPO G 
                                                                                      WHERE G.COD = D.COD_GRU AND G.PAIS <> 'España'))) AND EXISTS (SELECT *
                                                                                                                                                   FROM DISCO D2 
                                                                                                                                                   WHERE D2.COD_COMP = C.COD);
-- 19. Obtener el nombre y la dirección de aquellas compañías discográficas que han grabado 
-- todos los discos de algún grupo.    
SELECT C.NOMBRE, C.DIR
FROM COMPANYIA C 
WHERE EXISTS (SELECT *
             FROM GRUPO G 
             WHERE NOT EXISTS (SELECT *
                              FROM DISCO D 
                              WHERE D.COD_GRU = G.COD AND NOT D.COD_COMP = C.COD) AND EXISTS (SELECT *
                                                                                             FROM DISCO D1
                                                                                             WHERE D1.COD_GRU = C.COD))
 ORDER BY C.NOMBRE;                                                                                                                                                                                                                             
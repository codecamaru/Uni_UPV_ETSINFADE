-- 9.1 Consultas sobre una sola relación
-- 1. Obtener el código, el tipo, el color y el premio de todos los maillots que hay.
select *
from MAILLOT;
-- 2. Obtener el dorsal y el nombre de los ciclistas cuya edad sea menor o igual que 25 años. 
select dorsal, nombre 
from CICLISTA
where edad <= 25;
-- 3. Obtener el nombre y la altura de todos los puertos de categoría ‘E’ (Especial).
select nompuerto, altura  
from PUERTO
where categoria = 'E';
-- 4. Obtener el valor del atributo netapa de aquellas etapas con salida y llegada en la misma ciudad.
select netapa
from ETAPA
where salida = llegada;
-- 5. ¿Cuántos ciclistas hay?
select COUNT(*)
from CICLISTA 
-- 6. ¿Cuántos ciclistas hay con edad superior a 25 años?
select COUNT(*)
from CICLISTA
WHERE edad > 25;
-- 7. ¿Cuántos equipos hay?
select COUNT(*)
from EQUIPO;
-- 8. Obtener la media de edad de los ciclistas.
select AVG(edad)
from CICLISTA;
-- 9. Obtener la altura mínima y máxima de los puertos de montaña. 
select MIN(altura), MAX(altura)
from PUERTO;
-- 9.2 Consultas sobre varias relaciones
-- 10. Obtener el nombre y la categoría de los puertos ganados por ciclistas del equipo ‘Banesto’. 
select nompuerto, categoria  
from PUERTO p 
where EXISTS(SELECT *
            FROM CICLISTA c 
            WHERE c.dorsal = p.dorsal AND nomeq = 'Banesto');
-- 11. Obtener el nombre de cada puerto, indicando el número (netapa) y los kilómetros de la etapa en la que
-- se encuentra el puerto.
select nompuerto, e.netapa, km  
from PUERTO p, ETAPA e
where p.netapa = e.netapa
order by nompuerto;
-- 12. Obtener el nombre y el director de los equipos a los que pertenezca algún ciclista mayor de 33 años. 
select distinct e.nomeq, director 
from CICLISTA c, EQUIPO e
where edad > 33 AND c.nomeq = e.nomeq;
-- otra forma
SELECT e.nomeq, e.director
from EQUIPO e
WHERE EXISTS(SELECT *
            FROM CICLISTA c
            WHERE c.nomeq = e.nomeq AND c.edad > 33);
-- 13. Obtener el nombre de los ciclistas con el color de cada maillot que hayan llevado.
select distinct nombre, color
from CICLISTA c, LLEVAR l, MAILLOT m 
WHERE c.dorsal = l.dorsal AND l.codigo = m.codigo
order by nombre;
-- 14. Obtener pares de nombre de ciclista y número de etapa tal que ese ciclista haya ganado 
-- esa etapa y haya llevado el maillot de color ‘Amarillo’ en alguna etapa. 
select distinct c.nombre, e.netapa
from CICLISTA c, ETAPA e, LLEVAR l, MAILLOT m 
WHERE e.dorsal = c.dorsal AND c.dorsal = l.dorsal AND l.codigo = m.codigo AND m.color = 'Amarillo';
-- 15. Obtener el valor del atributo netapa de las etapas que no comienzan en la 
-- misma ciudad en que acabó la anterior etapa.
select e2.netapa
from ETAPA e1, ETAPA e2
where e1.netapa = e2.netapa - 1 AND e2.salida <> e1.LLEGADA;
-- 9.3 Consultas con subconsultas
-- 16. Obtener el valor del atributo netapa y la ciudad de salida de aquellas etapas 
-- que no tengan puertos de montaña
SELECT e.netapa, e.salida
FROM ETAPA e 
WHERE NOT EXISTS (SELECT *
                 FROM PUERTO p 
                 WHERE p.netapa = e.netapa);
-- 17. Obtener la edad media de los ciclistas que han ganado alguna etapa.
SELECT AVG(c.edad)
FROM CICLISTA c 
WHERE EXISTS (SELECT *
               FROM ETAPA e 
               WHERE c.dorsal = e.dorsal);
-- 18. Selecciona el nombre de los puertos con una altura superior a la altura media de todos los puertos. 
SELECT p1.nompuerto
FROM PUERTO p1
WHERE p1.altura > (SELECT AVG(p.altura)
					FROM PUERTO p);
-- 19. Obtener el nombre de la ciudad de salida y de llegada de las etapas donde estén los puertos con mayor
-- pendiente.
SELECT e.salida, e.llegada 
FROM ETAPA e 
WHERE EXISTS (SELECT *
             FROM PUERTO p 
             WHERE p.netapa = e.netapa AND p.pendiente = (SELECT MAX(p2.pendiente)
                                                         FROM PUERTO p2));
-- 20. Obtener el dorsal y el nombre de los ciclistas que han ganado los puertos de mayor altura. 
SELECT c.dorsal, c.nombre  
FROM CICLISTA c 
WHERE EXISTS (SELECT *
             FROM PUERTO p 
             WHERE p.dorsal = c.dorsal AND p.altura = (SELECT MAX(p2.altura)
                                                         FROM PUERTO p2));
-- 21. Obtener el nombre del ciclista más joven.
SELECT c.nombre  
FROM CICLISTA c 
WHERE c.edad = (SELECT MIN(C1.EDAD)
               FROM CICLISTA C1);
-- 22. Obtener el nombre del ciclista más joven que ha ganado al menos una etapa. 
SELECT C.NOMBRE
FROM CICLISTA C
WHERE EXISTS (SELECT *
             FROM ETAPA E
             WHERE E.DORSAL = C.DORSAL) AND C.EDAD = (SELECT MIN(C1.EDAD)
                                                     FROM CICLISTA C1
                                                     WHERE EXISTS (SELECT *
                                                                   FROM ETAPA E1
                                                                   WHERE E1.DORSAL = C1.DORSAL));
-- 23. Obtener el nombre de los ciclistas que han ganado más de un puerto
SELECT DISTINCT C.NOMBRE
FROM CICLISTA C, PUERTO P1, PUERTO P2
WHERE C.DORSAL=P1.DORSAL AND C.DORSAL=P2.DORSAL AND P1.DORSAL = P2.DORSAL AND P1.NOMPUERTO <> P2.NOMPUERTO;
-- otra forma
SELECT C.NOMBRE
FROM CICLISTA C 
WHERE EXISTS (SELECT *
             FROM PUERTO P1
             WHERE C.DORSAL=P1.DORSAL AND EXISTS (SELECT *
                                                 FROM PUERTO P2
                                                 WHERE C.DORSAL=P2.DORSAL AND P1.DORSAL = P2.DORSAL AND P1.NOMPUERTO <> P2.NOMPUERTO))
-- 9.4 Consultas con cuantificación universal 
-- 24. Obtener el valor del atributo netapa de aquellas etapas tales que todos los puertos que 
-- están en ellas tienen más de 700 metros de altura.
SELECT E.NETAPA 
FROM ETAPA E 
WHERE NOT EXISTS (SELECT *
                 FROM PUERTO P 
                 WHERE P.NETAPA = E.NETAPA AND NOT P.ALTURA > 700) AND EXISTS (SELECT *
                                                                              FROM PUERTO P1
                                                                              WHERE P1.NETAPA = E.NETAPA)
ORDER BY E.NETAPA;
-- 25. Obtener el nombre y el director de los equipos tales que todos sus ciclistas son mayores 
-- de 25 años. 
SELECT E.NOMEQ, E.DIRECTOR
FROM EQUIPO E 
WHERE NOT EXISTS (SELECT *
                 FROM CICLISTA C 
                 WHERE C.NOMEQ = E.NOMEQ AND NOT C.EDAD > 25) AND EXISTS (SELECT *
                                                                         FROM CICLISTA C1 
                                                                         WHERE C1.NOMEQ = E.NOMEQ)
order by E.NOMEQ;
-- 26. Obtener el dorsal y el nombre de los ciclistas tales que todas las etapas que han 
-- ganado tienen más de 170 km (es decir que sólo han ganado etapas de más de 170 km).
select C.DORSAL, C.NOMBRE
FROM CICLISTA C 
WHERE NOT EXISTS (SELECT *
                 FROM ETAPA E 
                 WHERE E.DORSAL = C.DORSAL AND NOT E.KM > 170) AND EXISTS (SELECT *
                                                                          FROM ETAPA E1
                                                                          WHERE E1.DORSAL = C.DORSAL)
ORDER BY C.DORSAL;
-- 27. Obtener el nombre de los ciclistas que han ganado todos los puertos de una etapa 
-- y además han ganado esa misma etapa. 
SELECT C.NOMBRE
FROM CICLISTA C 
WHERE EXISTS (SELECT * 
             FROM ETAPA E 
             WHERE E.DORSAL = C.DORSAL AND NOT EXISTS (SELECT *
                                                      FROM PUERTO P 
                                                      WHERE P.NETAPA = E.NETAPA AND NOT P.DORSAL = C.DORSAL) AND EXISTS (SELECT *
                                                                                                                          FROM PUERTO P1 
                                                                                                                          WHERE P1.NETAPA = E.NETAPA));
-- 28. Obtener el nombre de los equipos tales que todos sus corredores han llevado algún maillot 
-- o han ganado algún puerto.       
SELECT E.NOMEQ
FROM EQUIPO E 
WHERE NOT EXISTS (SELECT *
                 FROM CICLISTA C 
                 WHERE C.NOMEQ = E.NOMEQ AND NOT EXISTS (SELECT *
                                                        FROM LLEVAR L 
                                                        WHERE L.DORSAL = C.DORSAL) AND NOT EXISTS (SELECT *
                                                                                                  FROM PUERTO P 
                                                                                                  WHERE P.DORSAL = C.DORSAL)) AND EXISTS (SELECT *
                                                                                                                                         FROM CICLISTA C1 
                                                                                                                                         WHERE C1.NOMEQ = E.NOMEQ);
-- 29. Obtener el código y el color de aquellos maillots que sólo han sido llevados por ciclistas 
-- de un mismo equipo.     
SELECT m.codigo, m.color
FROM maillot m
WHERE EXISTS (SELECT *
              FROM equipo eq
              WHERE NOT EXISTS (SELECT *
                                FROM ciclista c
                                WHERE c.nomeq = eq.nomeq AND NOT EXISTS (SELECT *
                                                                         FROM llevar l
                                                                         WHERE c.dorsal = l.dorsal AND l.codigo = m.codigo))
                     AND EXISTS (SELECT *
                                 FROM ciclista c
                                 WHERE eq.nomeq = c.nomeq)); 

-- otra forma 
SELECT DISTINCT M.CODIGO, M.COLOR
FROM MAILLOT M, LLEVAR L, CICLISTA C
WHERE L.CODIGO = M.CODIGO AND L.DORSAL = C.DORSAL AND NOT EXISTS (SELECT *
                                                                FROM CICLISTA C1, LLEVAR L1 
                                                                WHERE C1.DORSAL = L1.DORSAL AND L1.CODIGO = M.CODIGO AND C1.NOMEQ <> C.NOMEQ);                                
-- 30. Obtener el nombre de aquellos equipos tales que sus ciclistas sólo hayan ganado puertos 
-- de 1ª categoría.            
SELECT E.NOMEQ
FROM EQUIPO E 
WHERE NOT EXISTS (SELECT *
                   FROM CICLISTA C
                    WHERE C.NOMEQ = E.NOMEQ AND EXISTS (SELECT *
                                                       FROM PUERTO P 
                                                       WHERE P.DORSAL = C.DORSAL AND NOT P.CATEGORIA = '1')) AND EXISTS (SELECT *
                                                                                                                       FROM CICLISTA C2
                                                                                                                       WHERE C2.NOMEQ = E.NOMEQ AND EXISTS (SELECT *
                                                                                                                                                            FROM PUERTO P2 
                                                                                                                                                            WHERE P2.DORSAL = C2.DORSAL))  
-- 9.5 Consultas agrupadas
-- 31. Obtener el valor del atributo netapa de aquellas etapas que tienen puertos de montaña 
-- indicando cuántos tiene.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
SELECT P.NETAPA, COUNT(*)
FROM PUERTO P 
GROUP BY P.NETAPA;
-- 32. Obtener el nombre de los equipos que tengan ciclistas indicando cuántos tiene cada uno.
SELECT C.NOMEQ, COUNT(*)
FROM CICLISTA C  
GROUP BY C.NOMEQ;
-- 33. Obtener el nombre de todos los equipos indicando cuántos ciclistas tiene cada uno.
SELECT E.NOMEQ, (SELECT COUNT(*)
                         FROM CICLISTA C 
                         WHERE E.NOMEQ = C.NOMEQ)
FROM EQUIPO E
GROUP BY E.NOMEQ
ORDER BY E.NOMEQ;
-- 34. Obtener el director y el nombre de los equipos que tengan más de 3 ciclistas y 
-- cuya edad media sea inferior o igual a 30 años.
SELECT E.NOMEQ, E.DIRECTOR
FROM EQUIPO E, CICLISTA C 
WHERE E.NOMEQ = C.NOMEQ
GROUP BY E.NOMEQ, E.DIRECTOR
HAVING COUNT(*) > 3 AND AVG(C.EDAD) <= 30
ORDER BY E.DIRECTOR;
-- 35. Obtener el nombre de los ciclistas que pertenezcan a un equipo que tenga más de 
-- cinco corredores y que hayan ganado alguna etapa indicando cuántas etapas ha ganado. 
SELECT C.NOMBRE, COUNT(*)
FROM CICLISTA C, EQUIPO EQ, ETAPA E 
WHERE EQ.NOMEQ = C.NOMEQ AND C.NOMEQ IN (SELECT C2.NOMEQ
                                       	FROM CICLISTA C2
                                       GROUP BY C2.NOMEQ
                                       HAVING COUNT(*) > 5) AND E.DORSAL = C.DORSAL
 GROUP BY E.DORSAL, C.NOMBRE  
 ORDER BY C.NOMBRE;
-- 36. Obtener el nombre de los equipos y la edad media de sus ciclistas de aquellos 
-- equipos que tengan la media de edad máxima de todos los equipos. 
SELECT C.NOMEQ, AVG(C.EDAD)
FROM EQUIPO EQ, CICLISTA C 
WHERE EQ.NOMEQ = C.NOMEQ AND EQ.NOMEQ IN (SELECT C1.NOMEQ
                                         FROM CICLISTA C1
                                         GROUP BY C1.NOMEQ
                                         HAVING AVG(C1.EDAD) = (SELECT MAX(AVG(C2.EDAD))
                                                                FROM CICLISTA C2
                                                                GROUP BY C2.NOMEQ))
GROUP BY C.NOMEQ;
-- 37. Obtener el director de los equipos cuyos ciclistas han llevado, entre todos, más días 
-- maillots de cualquier tipo. Nota: cada tupla de la relación Llevar indica que un ciclista 
-- ha llevado un maillot un día 
SELECT EQ.DIRECTOR
FROM EQUIPO EQ, CICLISTA C, LLEVAR L
WHERE EQ.NOMEQ = C.NOMEQ AND C.DORSAL = L.DORSAL 
GROUP BY EQ.NOMEQ, EQ.DIRECTOR
HAVING COUNT(L.CODIGO) >= ALL(SELECT COUNT(L1.CODIGO)
                        FROM EQUIPO EQ1, CICLISTA C1, LLEVAR L1
                        WHERE EQ1.NOMEQ = C1.NOMEQ AND C1.DORSAL = L1.DORSAL 
                        GROUP BY EQ1.NOMEQ, EQ1.DIRECTOR);
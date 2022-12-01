-- 1. Obtener el nombre de los autores de nacionalidad ‘Argentina’.
SELECT nombre
from AUTOR
where nacionalidad = 'Argentina';
-- 2. Obtener los títulos de las obras que contengan la palabra ‘mundo’ 
SELECT titulo 
from OBRA 
where titulo LIKE '%mundo%';
-- 3. Obtener el identificador de los libros anteriores a 1990 y que contengan más de una obra indicando el
-- número de obras que contiene.
SELECT id_lib, num_obras 
from LIBRO 
where año < 1990 AND num_obras > 1;
-- 4. ¿Cuántos libros hay de los que se conozca el año de publicación?
SELECT COUNT(*) AS LIBROS_CON_AÑO
from LIBRO 
where año IS NOT NULL;
-- 5. ¿Cuántos libros tienen más de una obra? Resolver este ejercicio utilizando el atributo num_obras.
SELECT COUNT(*) AS libros_que_tienen_masd1obra
from LIBRO 
where num_obras > 1;
-- 6. Obtener el identificador de los libros del año 1997 que no tienen título 
SELECT id_lib AS del97ysinobras
from LIBRO 
where año = 1997 AND titulo IS NULL;
-- 7. Mostrar todos los títulos de los libros que tienen título en orden alfabético descendente.
SELECT titulo AS libroscontitulo
from LIBRO 
where titulo IS NOT NULL
ORDER BY titulo desc;
-- 8. Obtener cuántas obras hay en los libros publicados entre 1990 y 1999.
SELECT SUM(num_obras) 
from LIBRO 
where año BETWEEN 1990 AND 1999;
-- 7.2 Consultas sobre varias relaciones
-- 9. Obtener cuántos autores han escrito alguna obra con la palabra “ciudad” en su título.
SELECT COUNT(a.autor_id)
FROM AUTOR a 
WHERE EXISTS (SELECT *
              FROM ESCRIBIR e 
              WHERE EXISTS (SELECT *
                           FROM OBRA o 
                           WHERE o.cod_ob = e.cod_ob AND o.titulo LIKE '%ciudad%') AND e.autor_id = a.autor_id);
-- otra forma
SELECT COUNT(DISTINCT e.autor_id)
FROM ESCRIBIR e 
WHERE EXISTS (SELECT *
             FROM OBRA o 
             WHERE o.cod_ob = e.cod_ob AND o.titulo LIKE '%ciudad%');
-- otra forma
select COUNT(distinct e.autor_id)
FROM ESCRIBIR e, OBRA o
where o.cod_ob = e.cod_ob AND o.titulo LIKE '%ciudad%';
-- 10. Obtener el título de todas las obras escritas por el autor de nombre ‘Camús, Albert’.
select o.titulo 
FROM AUTOR a, ESCRIBIR e, OBRA o
where o.cod_ob = e.cod_ob AND a.autor_id = e.autor_id AND a.nombre = 'Camús, Albert';
-- 11. ¿Quién es el autor de la obra de título ‘La tata’?
select a.nombre 
FROM AUTOR a, ESCRIBIR e, OBRA o
where o.cod_ob = e.cod_ob AND a.autor_id = e.autor_id AND o.titulo = 'La tata';
-- 12. Obtener el nombre de los amigos que han leído alguna obra del autor de identificador ‘RUKI’.
select distinct am.nombre 
FROM AUTOR a, ESCRIBIR e, OBRA o, LEER l, AMIGO am 
where o.cod_ob = e.cod_ob AND a.autor_id = e.autor_id AND a.autor_id = 'RUKI' AND o.cod_ob = l.cod_ob AND
l.num = am.num;
-- otra forma
select am.nombre 
FROM AMIGO am
WHERE EXISTS (SELECT *
             FROM LEER l
             WHERE l.num = am.num and EXISTS (SELECT *
                                              FROM OBRA o
                                              WHERE o.cod_ob = l.cod_ob AND EXISTS (SELECT * 
                                                                                   FROM ESCRIBIR e
                                                                                   WHERE o.cod_ob = e.cod_ob AND EXISTS (SELECT *
                                                                                                                        FROM AUTOR a
                                                                                                                        WHERE a.autor_id = e.autor_id AND a.autor_id = 'RUKI'))));
-- 13. Obtener el título y el identificador de los libros que tengan título y más de una obra. Resolver este
-- ejercicio sin utilizar el atributo num_obras.    
SELECT distinct l.titulo, l.id_lib
FROM LIBRO l, ESTA_EN e1, ESTA_EN e2 
WHERE l.titulo IS NOT NULL AND l.id_lib = e1.id_lib AND l.id_lib = e2.id_lib 
AND e1.id_lib = e2.id_lib AND e1.COD_OB <> e2.COD_OB;
-- 7.3 Consultas con subconsultas
-- 14. Obtener el título de las obras escritas sólo por un autor si éste es de nacionalidad 
-- “Francesa” indicando también el nombre del autor.                 
SELECT O.TITULO, A.NOMBRE 
FROM OBRA O, ESCRIBIR E, AUTOR A 
WHERE A.NACIONALIDAD = 'Francesa' AND A.AUTOR_ID = E.AUTOR_ID and E.COD_OB = O.COD_OB AND 
1 = (SELECT COUNT(*)
          FROM ESCRIBIR E1 
          WHERE E1.COD_OB = O.COD_OB);
-- 15. ¿Cuántos autores hay en la base de datos de los que no se tiene ninguna obra?
SELECT COUNT(*) AS AUTORESSINOBRA
FROM AUTOR A 
WHERE NOT EXISTS(SELECT *
                FROM ESCRIBIR E 
                WHERE E.AUTOR_ID = A.AUTOR_ID);
-- 16. Obtener el nombre de esos autores.
SELECT A.NOMBRE AS AUTORESSINOBRA
FROM AUTOR A 
WHERE NOT EXISTS(SELECT *
                FROM ESCRIBIR E 
                WHERE E.AUTOR_ID = A.AUTOR_ID);
-- 17. Obtener el nombre de los autores de nacionalidad “Española” que han escrito dos o más obras
SELECT A.NOMBRE 
FROM AUTOR A 
WHERE A.NACIONALIDAD = 'Española' AND 2 <= (SELECT COUNT(*)
                                            FROM ESCRIBIR E 
                                            WHERE E.AUTOR_ID = A.AUTOR_ID);
-- 18. Obtener el nombre de los autores de nacionalidad “Española” que han escrito alguna obra
-- que está en dos o más libros.                       
SELECT A.NOMBRE 
FROM AUTOR A 
WHERE A.NACIONALIDAD = 'Española' AND EXISTS (SELECT *
                                              FROM ESCRIBIR E 
                                              WHERE E.AUTOR_ID = A.AUTOR_ID AND EXISTS (SELECT *
                                                                                       FROM OBRA O 
                                                                                       WHERE O.COD_OB = E.COD_OB AND 2 <= (SELECT COUNT(*)
                                                                                                                          FROM ESTA_EN ES 
                                                                                                                          WHERE ES.COD_OB = O.COD_OB)));
-- 19. Obtener el título y el código de las obras que tengan más de un autor.
SELECT O.TITULO, O.COD_OB
FROM OBRA O 
WHERE 1 < (SELECT COUNT(*)
          FROM ESCRIBIR E 
          WHERE E.COD_OB = O.COD_OB);
-- 7.4 Consultas con cuantificación universal

-- 7.5 Consultas agrupadas
-- 29. Resolver el ejercicio 13 usando la cláusula GROUP BY      
-- (13. Obtener el título y el identificador de los libros que tengan título y más de una obra. Resolver este
-- ejercicio sin utilizar el atributo num_obras.)            
SELECT L.ID_LIB, L.TITULO
FROM LIBRO L, ESTA_EN E  
WHERE L.TITULO IS NOT NULL AND E.ID_LIB = L.ID_LIB
GROUP BY L.ID_LIB, L.TITULO                       
HAVING COUNT(E.ID_LIB) > 1;                    
-- 30. Obtener el nombre de los amigos que han leído más de 3 obras indicando también 
-- la cantidad de obras leídas.        
SELECT A.NOMBRE, COUNT(L.COD_OB)
FROM AMIGO A LEFT JOIN LEER L USING (NUM)
GROUP BY A.NUM, A.NOMBRE 
HAVING COUNT(*) > 3;
-- 31. Obtener, de los temas con alguna obra, la temática y la cantidad de obras con ese tema.
SELECT T.TEMATICA, COUNT(O.TEMATICA)
FROM TEMA T JOIN OBRA O ON O.TEMATICA = T.TEMATICA
GROUP BY T.TEMATICA
ORDER BY T.TEMATICA;
-- 32. Obtener, de todos los temas de la base de datos, la temática y la cantidad 
-- de obras con ese tema.
SELECT T.TEMATICA, COUNT(O.TEMATICA)
FROM TEMA T LEFT JOIN OBRA O USING(TEMATICA)
GROUP BY T.TEMATICA
ORDER BY T.TEMATICA;
-- 33. Obtener el nombre del autor (o autores) que más obras han escrito.
SELECT A.NOMBRE
FROM AUTOR A 
WHERE A.AUTOR_ID IN (SELECT E.AUTOR_ID
                    FROM ESCRIBIR E
                    GROUP BY E.AUTOR_ID
                    HAVING COUNT(E.COD_OB) >= ALL (SELECT COUNT(E1.COD_OB)
                                                    FROM ESCRIBIR E1
                                                    GROUP BY E1.AUTOR_ID));
-- 34. Obtener la nacionalidad (o nacionalidades) menos frecuentes.                                                    
SELECT A1.NACIONALIDAD
FROM AUTOR A1
WHERE A1.NACIONALIDAD IS NOT NULL
GROUP BY A1.NACIONALIDAD
HAVING COUNT(A1.AUTOR_ID) = (SELECT MIN(COUNT(A2.AUTOR_ID))
                             FROM AUTOR A2
                             WHERE A2.NACIONALIDAD IS NOT NULL
                             GROUP BY A2.NACIONALIDAD)
-- 35. Obtener el nombre del amigo (o amigos) que han leído más obras.
SELECT A.NOMBRE
FROM AMIGO A 
WHERE A.NUM IN (SELECT L1.NUM
                    FROM LEER L1 
                    GROUP BY L1.NUM 
                    HAVING COUNT(L1.COD_OB) = (SELECT MAX(COUNT(L.COD_OB))
                                                FROM LEER L
                                                GROUP BY L.NUM));



                           
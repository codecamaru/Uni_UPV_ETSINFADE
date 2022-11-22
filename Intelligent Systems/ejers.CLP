(defrule ejer1
  ?f1 <- (lista $?x ?y $?z)
  (test (neq ?y (+ 1 (length$ $?x)))) ;; otra forma de hacerlo (test (neq ?y (- (length$ $?x ?y $?z) (length$ $?z))))
  =>
  (assert (lista $?x 0 $?z)) 
  (retract ?f1)
)
;; ejer6
(deffacts bh
  (linea-ganadora 12 21 34 56 77)
  (carton linea 4 4 4 4 4 linea 3 3 3 3 3 linea 2 2 2 2 2 linea 1 1 1 1 1 linea 12 21 34 56 77)
)
(defrule ejer6
  (linea-ganadora $?l)
  (carton $?ls)
  (test (member$ $?l $?ls))
  =>
  (printout t "hay una linea ganadora" crlf)
)
;; ejer5
(defglobal ?*aciertos* = 0)
(deffacts bh
  (boleto-ganador 2 5 8 13 24 35)
  (combinacion 3 5 15 24 26 37)
)
(defrule ejer5
  ?f1 <- (boleto-ganador $?x ?y $?z)
  ?f2 <- (combinacion $?w ?a $?r)
  (test (= ?a ?y))
  =>
  (retract ?f1 ?f2)
  (assert (boleto-ganador $?x $?z))
  (assert (combinacion $?w $?r))
  (bind ?*aciertos* (+ ?*aciertos* 1))
)
(defrule objetivo
  (declare (salience -10))
  =>
  (printout t "aciertos: " ?*aciertos* crlf)
)
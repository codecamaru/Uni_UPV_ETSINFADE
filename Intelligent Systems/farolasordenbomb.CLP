;; =========================================================
;; ===     A N C H U R A   Y    P R O F U N D I D A D   ====
;; =========================================================

(defglobal ?*nod-gen* = 0)

(deffacts data
  (mapa 5 5)        ;; 5 filas 5 columnas tamaño tablero  
  (almacen 2 3)     ;; posicion inicial almacen
  (capcesto 3)      ;; capacidad cesto
  (bombillas 1 2 3) ;; bombillas posibles
  (farolas 3)       ;; nº farolas a reparar
)

(defrule derecha
  (robot ?x ?y ?n $?z nivel ?nivel)
  (profundidad-maxima ?prof)
  (mapa ?mx ?)
  (test (< ?x ?mx))
  (test (not (member$ (create$ farola (+ ?x 1) ?y) $?z)))
  (test (< ?nivel ?prof))
  =>
  (assert (robot (+ ?x 1) ?y ?n $?z nivel (+ ?nivel 1)))
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
)
(defrule izquierda
  (robot ?x ?y ?n $?z nivel ?nivel)
  (profundidad-maxima ?prof)
  (test (> ?x 1))
  (test (not (member$ (create$ farola (- ?x 1) ?y) $?z)))
  (test (< ?nivel ?prof))
  =>
  (assert (robot (- ?x 1) ?y ?n $?z nivel (+ ?nivel 1)))
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
)
(defrule abajo
  (robot ?x ?y ?n $?z nivel ?nivel)
  (profundidad-maxima ?prof)
  (test (> ?y 1))
  (test (not (member$ (create$ farola ?x (- ?y 1)) $?z)))
  (test (< ?nivel ?prof))
  =>
  (assert (robot ?x (- ?y 1) ?n $?z nivel (+ ?nivel 1)))
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
)
(defrule arriba
  (robot ?x ?y ?n $?z nivel ?nivel)
  (profundidad-maxima ?prof)
  (mapa ? ?my)
  (test (< ?y ?my))
  (test (not (member$ (create$ farola ?x (+ ?y 1)) $?z)))
  (test (< ?nivel ?prof))
  =>
  (assert (robot ?x (+ ?y 1) ?n $?z nivel (+ ?nivel 1)))
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
)
(defrule repararfarola ;; reponer X bombillas de una farola 
  (robot ?x ?y ?n ?nf $?f farola ?v ?w ?z ?nf $?o nivel ?nivel)
  (profundidad-maxima ?prof)
  (farolas ?mf)
  (test (= 1 (+ (abs (- ?x ?v)) (abs (- ?y ?w))))) ;;; comprobar que el robot está situado en una casilla adyacente a la farola a reparar
  ;; otra forma (test (or (or (and (eq (+ ?x 1) ?v) (eq ?y ?w)) (and (eq (- ?y 1) ?w) (eq ?x ?v))) (or (and (eq ?y ?w) (eq (- ?x 1) ?v)) (and (eq (+ ?y 1) ?w) (eq ?x ?v))))) 
  (test (>= ?n ?z)) ;; comprobar si el numero de bombillas que lleva en el cesto es igual o mayor que el nº de bombillas fundidas de la farola  
  (test (< ?nivel ?prof))
  (test (<= ?nf ?mf))
  =>
  (assert (robot ?x ?y (- ?n ?z) (+ 1 ?nf) $?f $?o nivel (+ ?nivel 1))) ;; le quitas las bombillas de la mano y quitas la farola de la lista de farolas
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
)
(defrule recogeralmacen ;; recoger X bombillas del almacen 
  (robot ?x ?y ?n $?f nivel ?nivel)
  (profundidad-maxima ?prof)
  (almacen ?x ?y)
  (bombillas $? ?k $?)
  (capcesto ?c)
  (test (< ?n ?c))
  (test (<= (+ ?n ?k) ?c)) ;; comprueba que la suma de lo que pueda coger y lo que lleve en la mano no sea mayor que la capacidad del cesto
  (test (< ?nivel ?prof))
  =>
  (assert (robot ?x ?y (+ ?n ?k) $?f nivel (+ ?nivel 1)))
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  ;;(printout t "hola carol he pasado por el almacén, llevaba " ?n "bombillas y he pillado " ?k crlf )
)

;; ========================================================
;; =========      ESTRATEGIA DE CONTROL DE BUSQUEDA    ========
;; ========================================================
;; La regla 'objetivo' se utiliza para detectar cuando se ha alcanzado el estado objetivo

(deffunction inicio ()
        (reset)
    (printout t "========================================================" crlf )
    (printout t "============ BIENVENIDO AL JUEGO DEL ROBOT ============"  crlf)
    (printout t "========================================================" crlf)
	(printout t "Introduce la profundidad Máxima deseada:= " )
	(bind ?prof (read))
	(printout t "Tipo de Busqueda a realizar" crlf "    1.- Anchura" crlf "    2.- Profundidad" crlf )
	(bind ?a (read))
	(if (= ?a 1)
	       then    (set-strategy breadth)
	       else   (set-strategy depth))
        (printout t " Ejecuta (run) para poner en marcha el programa " crlf)
	(assert (profundidad-maxima ?prof))
  (assert (robot 1 1 0 1 farola 4 3 3 3 farola 3 5 2 1 farola 5 5 2 2 nivel 0))   ;; posicion inicial robot y numero bombillas que lleva
  ;; posicion inicial farola, numero bombillas fundidas y nivel
	
)

(defrule objetivo
    (declare (salience 100))
    ?f<-(robot ?x ?y 0 4 nivel ?n) ;; debo testear que el robot no tenga bombillas en la mano 
   =>
    (printout t "SOLUCION ENCONTRADA EN EL NIVEL " ?n crlf)
    (printout t "NUMERO DE NODOS EXPANDIDOS O REGLAS DISPARADAS " ?*nod-gen* crlf)
    (printout t "HECHO OBJETIVO " ?f crlf)
    
    (halt)
)

(defrule no_solucion
    (declare (salience -99))
    (robot $? nivel ?n $?)
    
=>
    (printout t "SOLUCION NO ENCONTRADA" crlf)
    (printout t "NUMERO DE NODOS EXPANDIDOS O REGLAS DISPARADAS " ?*nod-gen* crlf)
    
    (halt)
)

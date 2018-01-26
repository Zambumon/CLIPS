(deftemplate estado
  (slot jarra6)
  (slot jarra8)
  (slot padre)
  ; Almacena la dirección del hecho estado a partir del cual proviene.
  ;Si no tiene padre, quiere decir que es el estado inicial.
  ; Este campo es útil cuando queramos construir el camino a seguir
  ; para llegar a la solución, una vez que la hayamos alcanzado.
  (slot nodo)
  ; Número de nodo. Nos permite numerar los estados del árbol.
  (slot nivel)
  ; Indicará la profundidad a la que se encuentra el nodo dentro del árbol.
  (slot s-accion)
  ; Indica el operador aplicado en un String. Servirá para imprimir en pantalla
  ; Cuando se alcanza el objetivo.
)

; Ejercicio 2: regla inicial

(defrule regla-inicial
	(initial-fact)
	=>
	(assert
    (estado
      (jarra6 2)
      (jarra8 2)
      (padre sin-padre)
      (nodo 0)
      (nivel 0)
      (s-accion inicio))
  )
  (assert
    (ciclo 0)
  )
)

;-------------------------------------------------------------------
;-------------------------------------------------------------------
; Es necesario mover todos para arriba para hacer el ejercicio extra
; Ejercicio 2: meta alcanzada. [Colocar esta regla hasta el final]

(defrule meta-alcanzada
  ; Si existe un estado, en el cual J6 esté vacia y la J8 tenga 4 litros
	?m <- (estado
    (jarra6 0)
    (jarra8 4))
	=>
	(assert (obtener-padre ?m))
	(assert (camino))
  (printout t crlf "Meta alcanzada" crlf)
)

;-------------------------------------------------------------------
; Ejercicio 4 1.

(defrule contruye-camino
	 ?e <- (estado
     (padre ?padre)
     (s-accion ?accion))
	 ?r <- (obtener-padre ?e)
	 ?c <- (camino $?caminoactual)
	=>
	 (assert (camino ?accion ?caminoactual))
	 (assert (obtener-padre ?padre))
	 (retract ?c)
	 (retract ?r)
)

; Ejercicio 4 2.
(defrule terminado
	 ?rec <- (obtener-padre sin-padre)
	 ?lista <- (camino $?caminocompleto)
	=>
	 (printout t "Solucion:" ?caminocompleto crlf)
	 (retract ?rec ?lista)
   ; Ejercicio extra: + mover la regla terminado hasta el principio
   (halt)
)


;-------------------------------------------------------------------
;                         OPERACIONES
;-------------------------------------------------------------------


; Ejercicio 2: 1.llenado de jarra 6

(defrule llenar-jarra-6
	?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Precondición: no estamos en el estado final.
	;(not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))
  ; Precondición: la jarra 6 no puede estar ya llena.
	(not (estado
    (jarra6 6)
    (jarra8 ?j8)))

  ; Comprobamos que el contenido de la jarra sea menor a su capacidad
  ; Llenamos la J6, dejamos J8 como estaba, subimos un nivel e indicamos la acción
	(test(< ?j6 6)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 6)
      (jarra8 ?j8)
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion llenar-jarra-6)
    )
  )
)

; Ejercicio 2: 2. llenado de jarra 8

(defrule llenar-jarra-8
	?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Precondición: no estamos en el estado final.
	; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))
  ; Precondición: la jarra 8 no puede estar ya llena.
	(not (estado
    (jarra6 ?j6)
    (jarra8 8)))

  ; Comprobamos que el contenido de la jarra sea menor a su capacidad
  ; Llenamos la J8, dejamos J6 como estaba, subimos un nivel e indicamos la acción
	(test(< ?j8 8)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 ?j6)
      (jarra8 8)
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion llenar-jarra-8)
    )
  )
)

; Ejercicio 3: 1. j6 con parte de j8

(defrule llenar-j6-con-j8
	?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

  ; Evitamos que se generen estados previamente generados
	(not (estado
    (jarra6 6)
    (jarra8 =(- ?j8 (- 6 ?j6)))))

  ; precondiciones
	(test(< ?j6 6))
	(test(> ?j8 0))
	(test(> (+ ?j6 ?j8) 6)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 6)
      (jarra8 (- ?j8 (- 6 ?j6)))
      (padre ?p) (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion llenar-j6-con-j8)
    )
  )
)

; Ejercicio 3: 2. j8 con parte de j6

(defrule llenar-j8-con-j6
	?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

  ; Evitamos que se generen estados previamente generados
	(not (estado
    (jarra8 8)
    (jarra6 =(- ?j6 (- 8 ?j8)))))

  ; precondiciones
	(test(< ?j8 8))
	(test(> ?j6 0))
	(test(> (+ ?j6 ?j8) 8)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra8 8)
      (jarra6 (- ?j6 (- 8 ?j8)))
      (padre ?p) (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion llenar-j8-con-j6)
    )
  )
)

; Ejercicio 3: 3. vaciado de jarra6


(defrule vaciar-jarra-6
  ?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

  ; Jarra6 no puede estar ya vacía
	(not (estado
    (jarra6 0)
    (jarra8 ?j8)))

  ; Precondición
	(test(> ?j6 0)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 0)
      (jarra8 ?j8)
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion vaciar-jarra-6)
    )
  )
)

; Ejercicio 3: 4. vaciado de jarra8

(defrule vaciar-jarra-8
  ?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

  ; Jarra8 no puede estar ya vacía
	(not (estado
    (jarra6 ?j6)
    (jarra8 0)))

  ; Precondición
	(test(> ?j8 0)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 ?j6)
      (jarra8 0)
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion vaciar-jarra-8)
    )
  )
)

; Vaciado de jarra6 vertiendo en j8

(defrule vaciar-j6-en-j8
  ?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

	(not (estado
    (jarra6 0)
    (jarra8 =(+ ?j8 ?j6))))

	(test(> ?j6 0))
	(test(<= (+ ?j6 ?j8) 8)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 0)
      (jarra8 (+ ?j8 ?j6))
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion vaciar-j6-en-j8)
    )
  )
)

; Vaciado de jarra8 vertiendo en j6

(defrule vaciar-j8-en-j6
  ?p <- (estado
    (jarra6 ?j6)
    (jarra8 ?j8)
    (padre ?padre)
    (nodo ?nodo)
    (nivel ?nivel)
    (s-accion ?accion))

	?c<- (ciclo ?ciclo)

  ; Estado final
  ; (not (estado
  ;  (jarra6 0)
  ;  (jarra8 4)))

	(not (estado
    (jarra6 =(+ ?j8 ?j6))
    (jarra8 0)))

	(test(> ?j8 0))
	(test(<= (+ ?j6 ?j8) 6)) =>
  (retract ?c) ; Quito el ciclo viejo
  (assert(ciclo (+ ?ciclo 1))) ; Añado 1 al ciclo
	(assert
    (estado
      (jarra6 (+ ?j8 ?j6))
      (jarra8 0)
      (padre ?p)
      (nodo ?ciclo)
      (nivel (+ ?nivel 1))
      (s-accion vaciar-j8-en-j6)
    )
  )
)

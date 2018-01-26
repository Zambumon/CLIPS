# Ejercicio 5: Búsqueda en clips

_Se tienen dos jarras de agua, una de 8 litros y otra de 6 litros, sin marcas que nos permitan saber con exactitud la cantidad de agua que contiene cada una. El objetivo es conseguir que la jarra de 8 litros contenga exactamente 4 litros de agua, usando para ello la jarra de 6._

## 1

 Sí, se trata de un problema de búsqueda
 - Tendríamos dos jarras y los litros que hay en ellas:

```
  (Jarra8 x), (Jarra6 y)
```

 - El estado inicial sería con ambas jarras vacías:

```
  (Jarra8 0), (Jarra6 0)
```
  - El estado final sería:

```
  (Jarra8 4), (Jarra 6 0)
```

(El contenido de la jarra 6 nos es indiferente)
 - Operadores:
  - Operación de llenado por completo de la Jarra8
  - Operación de llenado por completo de la Jarra6
  - Operación de vaciado de Jarra8
  - Operación de vaciado de Jarra6
  - Operación de llenado de Jarra6 con parte de agua de Jarra8
  - Operación de llenado de Jarra8 con parte de agua de Jarra6
  - Operación de vaciado de Jarra6 vertiendo el contenido en Jarra8
  - Operación de vaciado de Jarra8 vertiendo el contenido en Jarra6


## 2

```
(defrule init
	(initial-fact)
	=>
	(assert
    (estado
      (jarra6 0)
      (jarra8 0)
      (padre sin-padre)
      (nodo 0)
      (nivel 0)
      (s-accion nil))
  )
  (assert
    (ciclo 0)
  )
)

```

```
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
	(not (estado
    (jarra6 0)
    (jarra8 4)))
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
```

```
; Ejercicio 2: meta alcanzada. [Colocar esta regla hasta el final]
(defrule meta-alcanzada
  ; Si existe un estado, en el cual J6 esté vacia y la J8 tenga 4 litros
	?m <- (estado
    (jarra6 0)
    (jarra8 4))
	=>
  (printout t crlf "Meta alcanzada" crlf)
)
```

### Cuestión 2

- No, debido a que en las precondiciones había incluido que no se incluyan los estados en los que las jarras estén llenas.

### Cuestión 3

- Para evitar generar nodos previamente generados.

## 3

```
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
	(not (estado
    (jarra6 0)
    (jarra8 4)))

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
```

```
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
	(not (estado
    (jarra6 0)
    (jarra8 4)))

  ; Jarra no puede estar ya vacía
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
```

```
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
	(not (estado
    (jarra6 0)
    (jarra8 4)))

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
```

### Cuestión 4

 - Sí. Dicha condición de parada ya estaba añadida a todos los operadores.

## 4

```
(defrule contruye-camino
	 ?e <- (estado (padre ?padre) (s-accion ?accion))
	 ?r <- (obtener-padre ?e)
	 ?c <- (camino $?caminoactual)
	=>
	 (assert (camino ?accion ?caminoactual))
	 (assert (obtener-padre ?padre))
	 (retract ?c)
	 (retract ?r)
)


(defrule terminado
	 ?rec <- (obtener-padre sin-padre)
	 ?lista <- (camino $?caminocompleto)
	=>
	 (printout t "Solucion:" ?caminocompleto crlf)
	 (retract ?rec ?lista)
)
```

Solución al problema:

```
Solucion:(inicio llenar-jarra-6 vaciar-j6-en-j8 llenar-jarra-6 llenar-j8-con-j6 vaciar-jarra-8 vaciar-j6-en-j8)
```

## 5

Elimina que en cada regla de operaciones se compruebe si (J6=0, J8=4) y sustitúyelo por halt.

- Será necesario mover las reglas meta-alcanzada, contruye-camino y terminado y situarlas antes de las operaciones.
- `halt` para la ejecución del run. Si llegamos a la regla `terminado`, paramos la ejecución, pues ya hemos terminado.

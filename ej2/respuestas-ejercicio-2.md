## Ejercicio 1

1. Definimos las reglas

```

(defrule R1
  (tiene-pelo ?x)
=>
  (assert (mamifero ?x))
)

(defrule R2
  (da-leche ?x)
=>
  (assert (mamifero ?x))
)

(defrule R3
  (mamifero ?x)
  (tiene-pezunas ?x)
=>
  (assert (ungulado ?x))
)

(defrule R4
  (mamifero ?x)
  (rumia ?x)
=>
  (assert (ungulado ?x))
)

(defrule R5
  (ungulado ?x)
  (cuello-largo ?x)
=>
  (assert (jirafa ?x))
)

(defrule R6
  (ungulado ?x)
  (tiene-rayas-negras ?x)
=>
  (assert (cebra ?x))
)
```

2. Base de hechos iniciales

```

(deffacts	base-hechos-inicial
	(tiene-pelo robbie)
	(tiene-pezunas robbie)
	(tiene-rayas-negras robbie)

)
```

3. Indica cómo es la red del conocimiento

4. Ejecute el sistema ciclo a ciclo y rellene la siguiente  tabla:

Realizamos un `reset` y ejecutamos paso a paso con `run 1`

Número de ciclo:
- Ciclo 0.
  - Base de hechos:

  ```
  f-0 initial-fact
  f-1 tiene-pelo (robbie)
  f-2 tiene-pezunas (robbie)
  f-3 tiene-rayas-negras (robbie)
  ```
  - Agenda:

  ```
  R1 f-1
  ```
- Ciclo 1.
  - Base de hechos:

  ```
  f-4 mamifero (robbie)
  ```
  - Agenda:

  ```
  R3 f-4,f-2
  ```
- Ciclo 2.
  - Base de hechos:

  ```
  f-5 ungulado (robbie)
  ```
  - Agenda:

  ```
  R6 f-5, f-3
  ```
- Ciclo 3.
  - Base de hechos:

  ```
  f-6 cebra (robbie)
  ```

  - Agenda:

  ```
  La agenda se encuentra vacía.
  ```

5. Cómo ha recorrido CLIPS la red?


----

# Ejercicio 2

1. Definimos las reglas:

```
(defrule R1
  (tiene-pelo ?x)
=>
  (assert (mamifero ?x))
)

(defrule R2
  (da-leche ?x)
=>
  (assert (mamifero ?x))
)

(defrule R3
  (tiene-plumas ?x)
=>
  (assert (ave ?x))
)

(defrule R4
  (vuela ?x)
  (pone-huevos ?x)
=>
  (assert (ave ?x))
)

(defrule R5
  (come-carne ?x)
=>
  (assert (carnivoro ?x))
)

(defrule R6
  (tiene-dientes-puntiagudos ?x)
  (tiene-garras ?x)
  (tiene-ojos-al-frente ?x)
=>
  (assert (carnivoro ?x))
)

(defrule R7
  (mamifero ?x)
  (tiene-pezunas ?x)
=>
  (assert (ungulado ?x))
)

(defrule R8
  (mamifero ?x)
  (rumia ?x)
=>
  (assert (ungulado ?x))
)

(defrule R9
  (mamifero ?x)
  (carnivoro ?x)
  (tiene-color-leonado ?x)
  (tiene-manchas-oscuras ?x)
=>
  (assert (especie leopardo ?x))
)


(defrule R10
  (mamifero ?x)
  (carnivoro ?x)
  (tiene-color-leonado ?x)
  (tiene-rayas-negras ?x)
=>
  (assert (especie tigre ?x))
)

(defrule R11
  (ungulado ?x)
  (tiene-cuello-largo ?x)
  (tiene-piernas-largas ?x)
  (tiene-manchas-oscuras ?x)
=>
  (assert (especie jirafa ?x))
)

(defrule R12
  (ungulado ?x)
  (tiene-rayas-negras ?x)
=>
  (assert (especie cebra ?x))
)

(defrule R13
  (ave ?x)
  (not(vuela ?x))
  (tiene-cuello-largo ?x)
  (tiene-piernas-largas ?x)
  (blanco-negro ?x)
=>
  (assert (especie avestruz ?x))
)

(defrule R14
  (ave ?x)
  (not(vuela ?x))
  (nada ?x)
  (blanco-negro ?x)
=>
  (assert (especie pinguino ?x))
)

(defrule R15
  (ave ?x)
  (vuela-bien ?x)
=>
  (assert (especie albatros ?x))
)

(defrule R16
  (especie ?tipo ?x)
  (es-padre ?x ?y)
=>
  (assert (especie ?tipo ?y))
)
```

2. Definimos los hechos:

```
(deffacts	base-hechos-inicial
	(tiene-pelo robbie)
	(tiene-manchas-oscuras robbie)
	(come-carne robbie)
  (tiene-color-leonado robbie)
  (tiene-plumas suzie)
  (vuela-bien suzie)
  (es-padre suzie pancho)
)
```

3. Indica cómo es la red del conocimiento:

(ver imagen)

4. Ejecute el sistema ciclo a ciclo y rellene la siguiente  tabla:

Realizamos un `reset` y ejecutamos paso a paso con `run 1`

Número de ciclo:
- Ciclo 0.
  - Base de hechos:

  ```
  f-0 initial-fact
  f-1 tiene-pelo (robbie)
  f-2 tiene-manchas-oscuras (robbie)
  f-3 come-carne (robbie)
  f-4 tiene-color-leonado (robbie)
  f-5 tiene-plumas (suzie)
  f-6 vuela-bien (suzie)
  f-7 es-padre (suzie pancho)
  ```
  - Agenda:

  ```
  R3 f-5
  R5 f-3
  R1 f-1
  ```

- Ciclo 1.
  - Base de hechos:

  ```
  f-8 ave (suzie)
  ```
  - Agenda:

  ```
  R15 f-8,f-6
  R5 f-3
  R1 f-1
  ```

- Ciclo 2.
  - Base de hechos:

  ```
  f-9 especie (albatros suzie)
  ```
  - Agenda:

  ```
  R16 f-9,f-7
  R5 f-3
  R1 f-1
  ```

- Ciclo 3.
  - Base de hechos:

  ```
  f-10 especie (albatros pancho)
  ```

  - Agenda:

  ```
  R5 f-3
  R1 f-1
  ```

- Ciclo 4.
  - Base de hechos:

  ```
  f-11 carnivoro (robbie)
  ```

  - Agenda:

  ```
  R1 f-1
  ```

- Ciclo 5.
  - Base de hechos:

  ```
  f-12 mamifero (robbie)
  ```

  - Agenda:

  ```
  R9 f-12, f-11, f-4, f-2
  ```

- Ciclo 6.
  - Base de hechos:

  ```
  f-13 especie (leopardo robbie)
  ```

  - Agenda:

  ```
  La agenda se encuentra vacía.
  ```

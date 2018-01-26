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

(deffacts	base-hechos-inicial
	(tiene-pelo robbie)
	(tiene-manchas-oscuras robbie)
	(come-carne robbie)
  (tiene-color-leonado robbie)
  (tiene-plumas suzie)
  (vuela-bien suzie)
  (es-padre suzie pancho)
)

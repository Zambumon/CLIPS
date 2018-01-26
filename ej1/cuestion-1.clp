(deffacts BH-Ejercicio-1
  (nombre Juanjo)
  (nombre Juan)
  (apellido-1 Cruz)
  (apellido-1 Perez)
  (apellido-2 Lopez)
  (nombre Federico)
  (apellido-1 Perez)
  (apellido-2 Jimenez)
)

(defrule R1
	(nombre Juan)
=> (printout t "Tu nombre de pila es Juan" crlf))

(defrule R2
	(nombre Juan)
	(apellido-1 Perez)
  (apellido-2 Lopez)
=> (printout t "Te llamas Juan Perez Lopez" crlf))

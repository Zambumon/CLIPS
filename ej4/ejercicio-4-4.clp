(deftemplate Paciente
  (slot fiebre
    (type SYMBOL)
    (allowed-symbols alta moderada baja no nil)
    (default nil)
  )
  (slot sarpullido
    (type SYMBOL)
    (allowed-symbols si no nil)
    (default nil)
  )
  (slot exantema
    (type SYMBOL)
    (allowed-symbols si no nil)
    (default nil)
  )
  (slot garganta-irritada
    (type SYMBOL)
    (allowed-symbols si no nil)
    (default nil)
  )
  (slot vacunado
    (type SYMBOL)
    (allowed-symbols si no nil)
    (default nil)
  )
  (slot diagnostico
  (type SYMBOL)
  (default nil)
  )
  (slot id
    (type SYMBOL)
  )
  (slot temperatura
    (default nil)
  )
)

;; Ejercicio 2: Inferencia de la fiebre a partir de la temperatura

(defrule Fiebre-No
  ?p <- (Paciente
    (temperatura ?t)
    (id ?x)
    (fiebre nil)
    )
    (test (and (numberp ?t)(<= ?t 36.7))
    ) =>
    (modify ?p (fiebre no))
    (printout t "Fiebre del paciente " ?x ": NO" crlf)
)

(defrule Fiebre-Baja
  ?p <- (Paciente
    (temperatura ?t)
    (id ?x)
    (fiebre nil)
    )
    (test (and (numberp ?t)(> ?t 36.7)(<= ?t 37.5))
    ) =>
    (modify ?p (fiebre baja))
    (printout t "Fiebre del paciente " ?x ": BAJA" crlf)
)


(defrule Fiebre-Moderada
  ?p <- (Paciente
    (temperatura ?t)
    (id ?x)
    (fiebre nil)
    )
    (test (and (numberp ?t)(> ?t 37.5)(<= ?t 39))
    ) =>
    (modify ?p (fiebre moderada))
    (printout t "Fiebre del paciente " ?x ": MODERADA" crlf)
)

(defrule Fiebre-Alta
  ?p <- (Paciente
    (temperatura ?t)
    (id ?x)
    (fiebre nil)
    )
    (test (and (numberp ?t)(> ?t 39))
    ) =>
    (modify ?p (fiebre alta))
    (printout t "Fiebre del paciente " ?x ": ALTA" crlf)
)

;; Ejercicio 1: dado un paciente p sin diagnostico y con los sintomas... diagnosticamos la dolencia

(defrule Sarampion
  ?p <- (Paciente
    (fiebre alta)
    (exantema si)
    (vacunado no)
    (id ?x)
    (diagnostico nil)
  ) =>
  (modify ?p (diagnostico sarampion))
  (printout t "Diagnostico: Sarampion " ?x crlf)
)

(defrule Alergia
  ?p <- (Paciente
    (fiebre ~alta)
    (exantema si)
    (vacunado no)
    (id ?x)
    (diagnostico nil)
  ) =>
  (modify ?p (diagnostico alergia))
  (printout t "Diagnostico: Alergia " ?x crlf)
)

(defrule Alergia2
  ?p <- (Paciente
    (exantema si)
    (vacunado si)
    (id ?x)
    (diagnostico nil)
  ) =>
	(modify ?p (diagnostico alergia))
	(printout t "Diagnostico: Alergia "  ?x crlf)
)

(defrule Alergia3
	?p <- (Paciente
    (exantema no)
    (fiebre no)
    (sarpullido si)
    (garganta-irritada no)
    (id ?x)
    (diagnostico nil)
  ) =>
	(modify ?p (diagnostico alergia))
	(printout t "Diagnostico: Alergia " ?x crlf)
)

(defrule Gripe
	?p <- (Paciente
    (exantema no)
    (fiebre moderada|alta)
    (sarpullido no)
    (garganta-irritada si)
    (id ?x)
    (diagnostico nil)
  ) =>
	(modify ?p (diagnostico gripe))
	(printout t "Diagnostico: Gripe " ?x crlf)
)






(defrule Tratamiento-Sarampion
  ?p <- (Paciente
	(diagnostico sarampion)
  )  =>
	(printout t " Tratamiento: descanso en la cama y tratamiento de ayuda " crlf)
)

(defrule Tratamiento-Alergia
  ?p <- (Paciente
	(diagnostico alergia)
  ) =>
	(printout t " Tratamiento: antihistamínicos " crlf)
)


(defrule Tratamiento-Gripe
  ?p <- (Paciente
	(diagnostico gripe)
  ) =>
	(printout t " Tratamiento: descanso en la cama " crlf)
)




;; Ejercicio 4: pregunta inicial

(defrule Rinicial
  (initial-fact)
  ?p <- (Paciente
  (temperatura nil)
  (diagnostico nil)
  (id ?x)
  ) =>
  (printout t ?x " Introduzca la temperatura del paciente: ")
  (bind ?t (read))
  (modify ?p (temperatura ?t))
)

;; Ejercicio 4: Pregunta Exantema

(defrule RSegunda
  ?p <- (Paciente
  (exantema nil)(diagnostico nil)(fiebre ~nil)(id ?x)
  ) =>
  (printout t ?x " Tiene el paciente exantema? si/no: ")
  (bind ?e (read))
  (modify ?p (exantema ?e))
)

;; Ejercicio 4: Pregunta Vacuna

(defrule RTercera
  ?p <- (Paciente
  (vacunado nil)(diagnostico nil)(id ?x)
  ) =>
  (printout t ?x " Está el paciente vacunado? si/no: ")
  (bind ?e (read))
  (modify ?p (vacunado ?e))
)

;; Ejercicio 4: Pregunta Sarpullido

(defrule RCuarta
  ?p <- (Paciente
  (sarpullido nil)(diagnostico nil)(id ?x)
  ) =>
  (printout t ?x " Tiene el paciente sarpullidos? si/no: ")
  (bind ?e (read))
  (modify ?p (sarpullido ?e))
)

;; Ejercicio 4: Pregunta Garganta

(defrule RQuinta
  ?p <- (Paciente
  (garganta-irritada nil)(diagnostico nil)(id ?x)
  ) =>
  (printout t ?x " Tiene el paciente la garganta irritada? si/no: ")
  (bind ?e (read))
  (modify ?p (garganta-irritada ?e))
)

;; Ejercicio 4: Pregunta sin diagnostico

(defrule RSexta
  ?p <- (Paciente
  (diagnostico nil)(id ?x)(fiebre ~nil)(exantema ~nil)(sarpullido ~nil)(garganta-irritada ~nil)(vacunado ~nil)
  ) =>
  (printout t ?x " No hay una dolencia documentada que coincida con los sintomas" crlf)
)


;; Algún Paciente

(deffacts BHinicial
  (Paciente (id P1))
  (Paciente (id P2))
  (Paciente (id P3))
  (Paciente (id P4))
  (Paciente (id P5))
  (Paciente (id P6))
  (Paciente (id P7)(sarpullido si)(garganta-irritada no))
  (Paciente (id P8)(exantema si)(sarpullido si)(garganta-irritada no))
  (Paciente (id P9)(exantema si)(sarpullido si)(vacunado si)(garganta-irritada si))
  (Paciente (id P10)(exantema si)(sarpullido si)(vacunado si)(garganta-irritada no))
  (Paciente (id P11)(exantema no)(sarpullido no)(vacunado no)(garganta-irritada no))
  (Paciente (id P12)(temperatura 40)(exantema si)(garganta-irritada si))
  (Paciente (id P13)(temperatura 37)(exantema si)(garganta-irritada si))
  (Paciente (id P14)(sarpullido si)(vacunado si)(garganta-irritada si))
  (Paciente (id P15)(temperatura 36)(garganta-irritada si))
)

(deftemplate Paciente
  (slot fiebre
    (type SYMBOL)
    (allowed-symbols alta moderada baja no)
    (default no)
  )
  (slot sarpullido
    (type SYMBOL)
    (allowed-symbols si no)
    (default no)
  )
  (slot exantema
    (type SYMBOL)
    (allowed-symbols si no)
    (default no)
  )
  (slot garganta-irritada
    (type SYMBOL)
    (allowed-symbols si no)
    (default no)
  )
  (slot vacunado
    (type SYMBOL)
    (allowed-symbols si no)
    (default no)
  )
  (slot id
    (type SYMBOL)
  )
)

(defrule Sarampion
  (Paciente
    (fiebre alta)
    (exantema si)
    (vacunado no)
    (id ?x)
  ) =>
  (assert (diagnostico sarampion ?x))
  (printout t "Diagnostico: Sarampion " ?x crlf)
)

(defrule Alergia
  (Paciente
    (fiebre ~alta)
    (exantema si)
    (vacunado no)
    (id ?x)
  ) =>
  (assert (diagnostico alergia ?x))
  (printout t "Diagnostico: Alergia " ?x crlf)
)

(defrule Alergia2
  (Paciente
    (exantema si)
    (vacunado si)
    (id ?x)
  ) =>
	(assert (diagnostico alergia ?x))
	(printout t "Diagnostico: Alergia "  ?x crlf)
)

(defrule Alergia3
	(Paciente
    (exantema no)
    (fiebre no)
    (sarpullido si)
    (garganta-irritada no)
    (id ?x)
  ) =>
	(assert (diagnostico alergia ?x))
	(printout t "Diagnostico: Alergia " ?x crlf)
)

(defrule Gripe
	(Paciente
    (exantema no)
    (fiebre moderada|alta)
    (sarpullido no)
    (garganta-irritada si)
    (id ?x)
  ) =>
	(assert (diagnostico gripe ?x))
	(printout t "Diagnostico: Gripe " ?x crlf)
)


(defrule Tratamiento-Sarampion
	(diagnostico sarampion ?x)  =>
	(printout t "Tratamiento: descanso en la cama y tratamiento de ayuda " ?x crlf)
)

(defrule Tratamiento-Alergia
	(diagnostico alergia ?x)  =>
	(printout t "Tratamiento: antihistamínicos "  ?x crlf)
)


(defrule Tratamiento-Gripe
	(diagnostico gripe ?x)
   =>
	(printout t "Tratamiento: descanso en la cama "  ?x crlf)
)

(deffacts BHinicial
(Paciente (fiebre alta) (exantema si) (id P2))
(Paciente (fiebre moderada) (garganta-irritada si) (id P3))
(Paciente (fiebre baja) (sarpullido si) (id P4)))

1 Definiendo y usando plantillas
Un paciente puede manifestar los siguientes síntomas: fiebre, sarpullido, exantema, garganta irritada. El paciente puede estar o no vacunado contra el sarampión. Vamos a realizar un programa para diagnosticar al paciente, teniendo en cuenta los síntomas.
Defina una plantilla, llamada paciente, para describir la información clínica del paciente.

```
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
```

(Añadimos el id para ahorrarnos tiempo)

Regla 1:

```
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
```

Regla 2:

```
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
```

Regla 3: Si el paciente está vacunado contra el sarampión, se diagnosticará una alergia cuando presente exantema.

```
(defrule Alergia2
  (Paciente
    (exantema si)
    (vacunado si)
    (id ?x)
  ) =>
	(assert (diagnostico alergia ?x))
	(printout t "Diagnostico: Alergia "  ?x crlf))
```

Regla 4:  Si el paciente sólo presenta sarpullidos (es decir, y ningún síntoma más), se diagnosticará una alergia.

```
(defrule Alergia3
	(Paciente
    (exantema si)
    (fiebre no)
    (sarpullido no)
    (garganta-irritada no)
    (id ?x)
  ) =>
	(assert (diagnostico alergia ?x))
	(printout t "Diagnostico: Alergia " ?x crlf)
)
```

Regla 5: La gripe común suele cursar con fiebre moderada o alta y garganta irritada.

```
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
```

1. ___Cuestión: ¿Qué diagnostica el sistema para un paciente con fiebre baja y exantema?___

Respuesta:

```
(deffacts BHinicial
  (Paciente
    (fiebre baja)
    (exantema si)
    (id p1)
  )
)
```

```
CLIPS> (reset)
CLIPS> (run 1)
Diagnostico: Alergia p1
CLIPS>
```
Hechos:
0. Initial-fact
1. Paciente 1 (f-1)
 - Fiebre: baja
 - Sarpullido: no
 - Exantema: sí
 - Garganta irritada: no
 - Vacunado: no
 - Id: 1

Agenda:
1. Regla: Alergia (f-1)

---

2 Usando variables en las reglas con plantillas
Añada un nuevo atributo (id) a la plantilla Paciente, para identificar al paciente con un código. Cambie las reglas para que muestren en pantalla el id del paciente que se está diagnosticando, y que añada a la BH el diagnóstico indicando el paciente al que corresponde. Para ello debe usar variables.

Esto ya se implementó desde el principio para ahorrar tiempo.

2. ___Cuestión: ¿Qué diagnostica el sistema para los siguientes pacientes?___

Respuesta:

```
(deffacts BHinicial
  (Paciente
    (fiebre baja)
    (exantema si)
    (id P1)
  )
  (Paciente
    (fiebre alta)
    (exantema si)
    (id P2)
  )
  (Paciente
    (fiebre moderada)
    (garganta-irritada si)
    (id P3)
  )
  (Paciente
    (fiebre baja)
    (sarpullido si)
    (id P4)
  )
)
```

Diagnósticos:

```
CLIPS> (reset)
CLIPS> (run)
Diagnostico: Gripe P3
Diagnostico: Sarampion P2
Diagnostico: Alergia P1
```

Los síntomas del paciente 4 no coinciden con ninguno de las dolencias.

3 Añadiendo nuevas reglas
Añada al ejemplo anterior las reglas necesarias para inferir el tratamiento a aplicar, teniendo en cuenta el diagnóstico alcanzado.

a. No hay un tratamiento específico o terapia antiviral para el sarampión sin complicaciones. La mayor parte de los pacientes con sarampión sin complicaciones se recuperarán con descanso y tratamiento de ayuda. Suponga que todos los pacientes definidos no tienen complicaciones, por lo que no hará falta definir dicho atributo para probar este ejercicio.

b. Las alergias comunes se tratan con antihistamínicos.

c. Las gripes comunes se tratan con descanso en la cama.

3. ___Cuestión: ¿Qué tratamiento obtiene el sistema para los siguientes pacientes?___

```

(deffacts BHinicial
(Paciente (fiebre alta) (exantema si) (id P2))
(Paciente (fiebre moderada) (garganta-irritada si) (id P3))
(Paciente (fiebre baja) (sarpullido si) (id P4)))
```

Respuesta:

```
Diagnostico: Gripe P3
Tratamiento: descanso en la cama P3
Diagnostico: Sarampion P2
Tratamiento: descanso en la cama y tratamiento de ayuda P2
```

Nota: hacer las redes de conocimiento para este boletín.

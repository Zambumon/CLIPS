Cuestión 1: ¿Qué infiere el sistema para los siguientes pacientes?

```
Diagnostico: Gripe P3
Diagnostico: Sarampion P2
Diagnostico: Alergia P1
```

- Para el cuatro no se diagnostica nada.

Cuestión 2: ¿Qué infiere el sistema para los siguientes pacientes?

```
Fiebre del paciente P4: BAJA
Fiebre del paciente P3: MODERADA
Diagnostico: Gripe P3
Fiebre del paciente P2: ALTA
Diagnostico: Sarampion P2
Fiebre del paciente P1: NO
Diagnostico: Alergia P1
```

Cuestión 3: ¿Qué sucede cuando ejecutamos (reset)? ¿De qué regla(s) habla CLIPS? ¿Qué valor tiene la temperatura del paciente inicialmente? ¿Qué condición puede estar fallando?
Pruebe a añadir la condición: (test (numberp ?t))

```
[ARGACCES5] Function > expected argument #1 to be of type integer or float

[DRIVE1] This error occurred in the join network
   Problem resides in associated join
      Of pattern #1 in rule Fiebre-Alta

[ARGACCES5] Function > expected argument #1 to be of type integer or float

[DRIVE1] This error occurred in the join network
   Problem resides in associated join
      Of pattern #1 in rule Fiebre-Moderada

[ARGACCES5] Function > expected argument #1 to be of type integer or float

[DRIVE1] This error occurred in the join network
   Problem resides in associated join
      Of pattern #1 in rule Fiebre-Baja

[ARGACCES5] Function <= expected argument #1 to be of type integer or float

[DRIVE1] This error occurred in the join network
   Problem resides in associated join
      Of pattern #1 in rule Fiebre-No
```

- Al ejecutar el reset nos aparecen 3 errores asociados a las reglas que comprueban la temperatura. Estos errores nos informan que se esperaba usar un float o un integer pero que no se recibe (en principio) uno de esos tipos.
- nil
- Al usar el numberp se soluciona el error.

---

Cuestión 4: ¿En qué reglas debe añadirse? ¿En qué lugar del antecedente, como primera, segunda o tercera condición? ¿Qué sucede cuando ejecutamos (reset)?

- En aquellas usadas para inferir la fiebre a partir de la temperatura (Fiebre-No, Fiebre-Baja, Fiebre-Moderada, Fiebre-Alta), donde se hace la comparación del valor introducido con unos float.
- Es necesario que sea el primer argumento, pues tal y como nos expican los errores, CLIPS necesita que sean números. Si lo ponemos de segunda condición, nos daría un error con la primera comparación y no habríamos solucionado el problema.

```
(test (and (numberp ?t)(> ?t 36.7)(<= ?t 37.5)))

```

- Primera condición
- Se soluciona el error.


-----


Cuestión 5: ¿Cuál es la traza que se debe seguir para hacer las preguntas? Indíquela
- Ver traza:
- Primero pregunto por la temperatura
- A continuación por el exantema
- Seguido de esto se pregunta por la vacunación del paciente
- Finalmente se pregunta si tiene la garganta irritada o sarpullido. Da igual en qué orden se hagan estas dos preguntas.
- Si tras cinco preguntas no hay diagnóstico, se indica.

(Se adjunta una tabla)

----

Cuestión 6: ¿Qué reglas debe añadir? Indíquelas. Pruébelas para la siguiente base de hechos inicial y diferentes valores de entrada de datos. En caso de que no se llegue a un diagnóstico, el sistema debe indicarlo en pantalla.

- RSegunda, RTercera, RCuarta, RQuinta, RSexta

----

Cuestión 7: Diseñe un juego de pruebas (BH inicial + datos a introducir) suficientemente exhaustivo para que cubra todas las posibilidades. Anótelo en una tabla, junto a las respuestas de su programa Clips.


```

Fiebre del paciente P15: NO
P15 Tiene el paciente exantema? si/no: no
P15 Está el paciente vacunado? si/no: no
P15 Tiene el paciente sarpullidos? si/no: no
P15 No hay una dolencia documentada que coincida con los sintomas
P14 Introduzca la temperatura del paciente: 38
Fiebre del paciente P14: MODERADA
P14 Tiene el paciente exantema? si/no: no
P14 No hay una dolencia documentada que coincida con los sintomas
Fiebre del paciente P13: BAJA
P13 Está el paciente vacunado? si/no: no
Diagnostico: Alergia P13
 Tratamiento: antihistamínicos
Fiebre del paciente P12: ALTA
P12 Está el paciente vacunado? si/no: no
Diagnostico: Sarampion P12
 Tratamiento: descanso en la cama y tratamiento de ayuda
P11 Introduzca la temperatura del paciente: 37
Fiebre del paciente P11: BAJA
P11 No hay una dolencia documentada que coincida con los sintomas
Diagnostico: Alergia P10
 Tratamiento: antihistamínicos
Diagnostico: Alergia P9
 Tratamiento: antihistamínicos
P8 Introduzca la temperatura del paciente: 40
Fiebre del paciente P8: ALTA
P8 Está el paciente vacunado? si/no: si
Diagnostico: Alergia P8
 Tratamiento: antihistamínicos
P7 Introduzca la temperatura del paciente: 37
Fiebre del paciente P7: BAJA
P7 Tiene el paciente exantema? si/no: si
P7 Está el paciente vacunado? si/no: no
Diagnostico: Alergia P7
 Tratamiento: antihistamínicos
P6 Introduzca la temperatura del paciente: 40
Fiebre del paciente P6: ALTA
P6 Tiene el paciente exantema? si/no: no
P6 Está el paciente vacunado? si/no: no
P6 Tiene el paciente sarpullidos? si/no: si
P6 Tiene el paciente la garganta irritada? si/no: si
P6 No hay una dolencia documentada que coincida con los sintomas
P5 Introduzca la temperatura del paciente: 38
Fiebre del paciente P5: MODERADA
P5 Tiene el paciente exantema? si/no: no
P5 Está el paciente vacunado? si/no: si
P5 Tiene el paciente sarpullidos? si/no: no
P5 Tiene el paciente la garganta irritada? si/no: si
Diagnostico: Gripe P5
 Tratamiento: descanso en la cama
P4 Introduzca la temperatura del paciente: 36
Fiebre del paciente P4: NO
P4 Tiene el paciente exantema? si/no: no
P4 Está el paciente vacunado? si/no: si
P4 Tiene el paciente sarpullidos? si/no: si
P4 Tiene el paciente la garganta irritada? si/no: no
Diagnostico: Alergia P4
 Tratamiento: antihistamínicos
P3 Introduzca la temperatura del paciente: 37
Fiebre del paciente P3: BAJA
P3 Tiene el paciente exantema? si/no: si
P3 Está el paciente vacunado? si/no: si
Diagnostico: Alergia P3
 Tratamiento: antihistamínicos
P2 Introduzca la temperatura del paciente: 38
Fiebre del paciente P2: MODERADA
P2 Tiene el paciente exantema? si/no: si
P2 Está el paciente vacunado? si/no: no
Diagnostico: Alergia P2
 Tratamiento: antihistamínicos
P1 Introduzca la temperatura del paciente: 39
Fiebre del paciente P1: MODERADA
P1 Tiene el paciente exantema? si/no: si
P1 Está el paciente vacunado? si/no: no
Diagnostico: Sarampion P12
 Tratamiento: descanso en la cama y tratamiento de ayuda

```

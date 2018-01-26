# Boletín 1

1. __Hechos__
```
  (assert (nombre Juanjo))
  (assert (nombre Juan))
  (assert (apellido-1 Cruz))
  (assert (apellido-1 Perez))
  (assert (apellido-2 Lopez))
  (assert (nombre Federico))
  (assert (apellido-1 Perez))
  (assert (apellido-2 Jimenez))
```
 1.1 ___¿Qué devuelve Clips al añadir un hecho a la Base de Hechos (BH)?___

 CLIPS nos devuelve su número de hecho con un mensaje <Fact-N>. Al intentar insertar el séptimo hecho de la lista nos devuelve un FALSE.

 1.2 ___¿Por qué en un caso devuelve False?___

 Esto es debido a que ya existe un hecho de tipo apellido-1 y valor Perez en nuestra base de hechos.

2. __Reglas__

```
(defrule R1
	(nombre Juan)
=> (printout t "Tu nombre de pila es Juan" crlf))

(defrule R2
	(nombre Juan)
	(apellido-1 Perez)
  (apellido-2 Lopez)
=> (printout t "Te llamas Juan Perez Lopez" crlf))
```
 2.1 ___¿Se ha activado alguna regla?¿Qué hechos activan cada regla?___

 Se activan las reglas (en este orden):
 - R2 activada por los hechos F-2, F-4, y F-5.
 - R1 activada por el hecho F-2.

3. __Ejecución de las reglas__

```
CLIPS> (run 1)
Te llamas Juan Perez Lopez
CLIPS> (run 1)
Tu nombre de pila es Juan
CLIPS>
```
 3.1 ___¿Qué regla se ejecuta primero?¿Por qué?___

 Tal y como se vio en el apartado anterior, la regla que se ejecutará primero será la R2 debido a que es activada por los hechos F-4 y F-5. Debido a que estos hechos tienen un índice mayor y más reciente que el hecho que activa la regla R1 (F-2), CLIPS considera que se debe ejecutar antes la regla R2.

 3.2 ___¿Qué pasa si reiniciamos con (clear)?___

 Al realizar con clear los hechos así como las reglas que teníamos desaparecen, a excepción del initial-fact.

 4. __Definición de hechos con deffacts__

 ```
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
 ```
 4.1 ___Si se introducen los hechos con (deffacts), y se carga el fichero ¿qué ocurre en la BH y en la Agenda?___

```
CLIPS> (load "cuestion-1.clp")
Defining deffacts: BH-Ejercicio-1
Defining defrule: R1 +j+j
Defining defrule: R2 =j+j+j+j
TRUE
```
Se define una BH cuyo nombre hemos puesto como BH-Ejercicio-1 y las reglas R1 y R2 en el caso de que dichas reglas se encuentren dentro del fichero (como fue en mi caso).


 4.2 ___Ejecute (reset). ¿Qué ocurre en la BH y en la Agenda?___

 Al realizar el reset, se generan los hechos en nuestra base de hechos y se cargan las reglas en nuestra agenda.

 4.3 ___¿Cuál es el primer hecho que se ha activado?___
 El initial-fact.

```
CLIPS> (run 1)
Te llamas Juan Perez Lopez
CLIPS> (run 1)
Tu nombre de pila es Juan
CLIPS>
```

5. __Uso de variables en la reglas__

___Primera regla:___ pregunta el tipo de robot

```
(defrule regla-tipo-robot
  (initial-fact)
=>
(printout t "Que tipo de robot es (chofer/peaton)?")
(assert(tipo-robot(read)))
)
```
___Segunda regla:___ preguntará cómo está el semáforo para los coches, y se activará sólo en el caso de que el robot sea un chófer. Almacenará el color del semáforo en un hecho (semáforo <color>), donde <color> puede ser verde, rojo, ámbar o intermitente.

```
(defrule regla-semaforo-chofer
(tipo-robot chofer)
=>
(printout t "Como esta el semaforo para los coches (verde/rojo/ambar/intermitente)?")
(assert(semaforo(read)))
)
```

___Tercera regla:___ preguntará cómo está el semáforo para los peatones, y se activará sólo en el caso de que el robot sea un peatón. Almacenará el color del semáforo en un hecho (semáforo <color>), donde <color> puede ser verde, rojo, ámbar o intermitente.

```
(defrule regla-semaforo-peaton
(tipo-robot peaton)
=>
(printout t "Como esta el semaforo para los peatones (verde/rojo/ambar/intermitente)?")
(assert(semaforo(read)))
)
```

___Cuarta regla:___ permitirá pasar al robot si el semáforo está en verde. Usará una variable (las variables comienzan siempre por ?) que permite equiparar el hecho (tipo-robot ?x) con cualquier tipo de robot (peatón o coche). Dicha variable se queda ligada al valor con el que se equipara durante la ejecución de la regla, pudiéndose usar su valor en el consecuente de la regla (p.ej., en el printout).

```
(defrule robot-puede-pasar
(tipo-robot ?tipo)
(semaforo verde)
=>
(printout t "El robot " ?tipo " puede pasar" crlf)
)
```

___Quinta regla:___ se activa si el estado del semáforo es rojo y, al igual que la anterior, muestra el mensaje correspondiente.

```
(defrule robot-debe-esperar
(tipo-robot ?tipo)
(semaforo rojo)
=>
(printout t "El robot " ?tipo " debe esperar" crlf)
)
```

___Sexta regla:___ La sexta regla se activa cuando el semáforo está en ámbar o intermitente, y muestra el mensaje oportuno. Utilice el símbolo de la disyuntiva para considerar las dos opciones en el mismo antecedente de la regla: (semaforo ambar | intermitente)

```
(defrule con-cuidado
(tipo-robot ?tipo)
(semaforo ambar|intermitente)
=>
(printout t "El robot " ?tipo " debe tener cuidado al pasar" crlf)
)
```
 5.1 ___¿Qué devuelve el programa cuando el robot es un coche y el semáforo para los coches está en rojo? Copie y pegue el resultado mostrado en la dialog window tras ejecutar (run).___


Diálogo CLIPS:

```
CLIPS> (load "cuestion-2.clp")
Defining defrule: regla-tipo-robot +j+j
Defining defrule: regla-semaforo-chofer +j+j
Defining defrule: regla-semaforo-peaton +j+j
Defining defrule: robot-puede-pasar +j+j+j
Defining defrule: robot-debe-esperar =j+j+j
Defining defrule: con-cuidado =j+j+j
TRUE
CLIPS> (reset)
CLIPS> (run)
Que tipo de robot es (chofer/peaton)?chofer
Como esta el semaforo para los coches (verde/rojo/ambar/intermitente)? rojo
El robot chofer debe esperar
```

(deftemplate notaParcial
	"Info sobre cada parte de la asignatura"
	(slot alumno)
	(slot componente (allowed-symbols EXAMEN OR PRACTICA))
	(slot nota)
)
(deftemplate notaFinal
	(slot alumno)
	(slot notafinal)
)


;------------------------------------------------------------------------------------
(deffacts alumnos

	(alumno jose)
	(alumno pepe)
	(alumno juan)
	
)

;------------------------------------------------------------------------------------

(defrule Aprovado
	(notaParcial  	(alumno ?a)
			(componente EXAMEN)
			(nota ?n1))
	(test (>= ?n1 5))
	(notaParcial  	(alumno ?a)
			(componente PRACTICA)
			(nota ?n2))
	(test (>= ?n2 5))
	(peso EXAMEN ?pesoE)
	(peso PRACTICA ?pesoP)
=>
	(bind ?nE (* ?n1 ?pesoE))
	(bind ?nT (* ?n2 ?pesoP))
	(bind ?nFinal ( + ?nE ?nT))
	(assert(notaFinal (alumno ?a) (notafinal ?nFinal) ) )
	(assert (aprovado ?a))
	(printout t "Aprovado " ?a crlf)
)
(defrule Suspenso
	(notaParcial (alumno ?a) (nota ?n))
	(test (< ?n 5))
=>
	(assert (suspenso ?a))
	(printout t " Suspenso " ?a crlf)
)
(defrule No_Presentado
	(notaParcial (alumno ?a) (nota nil))
=>
	(assert (noPresentado ?a))

)

(defrule leer-entradas
	(alumno ?a)
=>
	(printout t "Introduce nota examen del alumno:" ?a crlf)	
	(bind ?nota1 (read))
	(printout t "Introduce nota practica del alumno:" ?a crlf)
	(bind ?nota2 (read))
	(assert (notaParcial(alumno ?a) (componente EXAMEN) (nota ?nota1) ) )
	(assert (notaParcial(alumno ?a) (componente PRACTICA) (nota ?nota2) ) )
)
(defrule leer-ponderacion
	(initial-fact)
=>
	(printout t "Introduce el peso del examen:"  crlf)	
	(bind ?pesoExamen (read))
	(printout t "Introduce el peso de la practica:" crlf)
	(bind ?pesoPractica (read))
	(assert (peso EXAMEN ?pesoExamen) )
	(assert (peso PRACTICA ?pesoPractica) )
	
)


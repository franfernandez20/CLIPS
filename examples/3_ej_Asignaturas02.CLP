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
(deffacts Ponderacion
        (peso EXAMEN 0.3)
        (peso PRACTICA 0.7)
)
(deffacts Notas
        (notaParcial    (alumno jose)
                        (componente EXAMEN)
                        (nota 7)
                )
        (notaParcial    (alumno jose)
                        (componente PRACTICA)
                        (nota 5)
                )        
        (notaParcial    (alumno pepe)
                        (componente EXAMEN)
                        (nota 7)
                )
        (notaParcial    (alumno pepe)
                        (componente PRACTICA)
                        (nota 3)
                )
        (notaParcial    (alumno juan)
                        (componente EXAMEN)
                        (nota 7)
                )
)

;------------------------------------------------------------------------------------
(defrule Aprovado
        (notaParcial    (alumno ?a)
                        (componente EXAMEN)
                        (nota ?n1))
        (test (>= ?n1 5))
        (notaParcial    (alumno ?a)
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
(defrule NoPresentadoA
        (alumno ?a)
        (not (notaParcial    
                        (alumno ?a)
                        (componente EXAMEN)))
=>
        (assert (noPresentado ?a))       
)
(defrule NoPresentadoB
        (alumno ?a)
        (not (notaParcial    
                        (alumno ?a)
                        (componente PRACTICA)))
=>
        (assert (noPresentado ?a))        
)

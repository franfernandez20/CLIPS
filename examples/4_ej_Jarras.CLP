
;LLENAR JARRAS DEL GRIFO
(defrule llenar-cuatro-del-grifo
        ?nodo <- (situacion
                        (litros-en-cuatro ?cuatro)
                        (litros-en-tres ?tres) )
        (test (< ?cuatro 4))
 =>
        (assert (situacion 
                        (padre ?nodo)
                        (litros-en-cuatro 4)
                        (litros-en-tres ?tres))) 
)

(defrule llenar-tres-del-grifo
         ?nodo <- (situacion
                        (litros-en-tres ?tres) )
         (test (< ?tres 3))
=>
         (duplicate ?nodo (padre ?nodo)
                        (litros-en-tres 3)) 
) 

;-------------------------------------------------------
;VACIAR JARRAS EN LA PILA
(defrule vaciar-cuatro-en-pila
         ?nodo <- (situacion
                (litros-en-cuatro ?cuatro) )
                (test (> ?cuatro 0))
 =>
        (duplicate ?nodo (padre ?nodo)
        (litros-en-cuatro 0)) 
)

(defrule vaciar-tres-en-pila
        ?nodo <- (situacion
                (litros-en-tres ?tres) )
                (test (> ?tres 0))
 =>
        (duplicate ?nodo (padre ?nodo)
                        (litros-en-tres 0)) 
)
;--------------------------------------------------------
;LLENAR UNA JARRA DE OTRA
(defrule llenar-cuatro-desde-tres
        ?nodo <- (situacion
                         (litros-en-cuatro ?cuatro)
                         (litros-en-tres ?tres) )
        (test (> (+ ?cuatro ?tres) 4))
        (test (< ?cuatro 4))
 =>
         (assert (situacion 
                        (padre ?nodo)
                        (litros-en-cuatro 4)
                        (litros-en-tres (- ?tres (- 4 ?cuatro))))) 
)
(defrule llenar-tres-desde-cuatro
        ?nodo <- (situacion
                        (litros-en-cuatro ?cuatro)
                        (litros-en-tres ?tres) )
        (test (> (+ ?cuatro ?tres) 3))
        (test (< ?tres 3))
=>
        (bind ?nuevo-cuatro (- ?cuatro (- 3 ?tres)))
        (assert (situacion 
                        (padre ?nodo)
                        (litros-en-cuatro ?nuevo-cuatro)
                        (litros-en-tres 3))) 
)
;--------------------------------------------------------
;VACIAR UNA JARRA DE OTRA
(defrule vaciar-tres-en-cuatro
        ?nodo <- (situacion
                        (litros-en-cuatro ?cuatro)
                        (litros-en-tres ?tres) )
        (test (<= (+ ?cuatro ?tres) 4))
        (test (> ?tres 0))
=> 
        (assert (situacion 
                        (padre ?nodo)
                        (litros-en-cuatro (+ ?tres ?cuatro))
                        (litros-en-tres 0)) ) )

(defrule vaciar-cuatro-en-tres
        ?nodo <- (situacion
                        (litros-en-cuatro ?cuatro)
                        (litros-en-tres ?tres) )
        (test (<= (+ ?cuatro ?tres) 3))
        (test (> ?cuatro 0))
=> 
        (assert (situacion 
                        (padre ?nodo)
                        (litros-en-cuatro 0)
                        (litros-en-tres (+ ?tres ?cuatro)) ) ) 
        
)  
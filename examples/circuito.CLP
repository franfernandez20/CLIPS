(deftemplate puerta
	"Puertas logicas binarias"
	(slot id-puerta)
	(slot tipo (allowed-symbols AND OR XOR))
	(slot id-entrada-1 (default e1))
	(slot id-entrada-2 (default e2))
	(slot id-salida-1 (default s1)) )

(deftemplate circuito
	"Circuito con multiples entradas y salidas"
	(slot id-circuito)
	(multislot id-entradas)
	(multislot id-salidas ) )

(deftemplate estado-terminal
	"Senyal en terminales de una puerta o circuito"
	(slot id-elemento)
	(slot id-terminal)
	(slot senyal (allowed-symbols TRUE FALSE)) ) 
	
	
(defrule logica-AND
	(puerta (id-puerta ?p)
			(tipo AND)
			(id-entrada-1 ?e1)
			(id-entrada-2 ?e2)
			(id-salida-1 ?s1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e1)
			(senyal ?senyal-e1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e2)
			(senyal ?senyal-e2) )
	=>
	(assert (estado-terminal
				(id-elemento ?p)
				(id-terminal ?s1)
				(senyal (and ?senyal-e1 ?senyal-e2)) ) ) )

(defrule logica-OR
	(puerta (id-puerta ?p)
			(tipo OR)
			(id-entrada-1 ?e1)
			(id-entrada-2 ?e2)
			(id-salida-1 ?s1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e1)
			(senyal ?senyal-e1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e2)
			(senyal ?senyal-e2) )
	=>
	(assert (estado-terminal
			(id-elemento ?p)
			(id-terminal ?s1)
			(senyal (or ?senyal-e1 ?senyal-e2)) ) ) ) 

(defrule logica-XOR
	(puerta (id-puerta ?p)
			(tipo XOR)
			(id-entrada-1 ?e1)
			(id-entrada-2 ?e2)
			(id-salida-1 ?s1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e1)
			(senyal ?senyal-e1) )
	(estado-terminal
			(id-elemento ?p)
			(id-terminal ?e2)
			(senyal ?senyal-e2) )
	=>
	(assert (estado-terminal
			(id-elemento ?p)
			(id-terminal ?s1)
			(senyal (not (eq ?senyal-e1 ?senyal-e2))) ) ) ) 

(defrule logica-conexion
	"Si dos terminales estan conectados, entonces
	tienen la misma senyal"
	(estado-terminal
			(id-elemento ?elemento-A)
			(id-terminal ?terminal-A)
			(senyal ?senyal))
	(conexion ?elemento-A ?terminal-A
			  ?elemento-B ?terminal-B)
	=>
	(assert (estado-terminal
			(id-elemento ?elemento-B)
			(id-terminal ?terminal-B)
			(senyal ?senyal))))
			
(defrule conexion
	"La conexion es conmutativa"
	(conexion ?p1 ?t1 ?p2 ?t2)
	=>
	(assert (conexion ?p2 ?t2 ?p1 ?t1)) )
	
	
(defrule leer-entradas
	(circuito	(id-circuito ?c)
				(id-entradas $? ?t $?))
	=>
	(printout t "Circuito: " ?c
	" Entrada: " ?t
	" Senyal: " )
	(bind ?senyal (read))
	(assert (estado-terminal
			(id-elemento ?c)
			(id-terminal ?t)
			(senyal ?senyal)) ) ) 

(defrule imprimir-salidas
	(estado-terminal
			(id-elemento ?c)
			(id-terminal ?t)
			(senyal ?senyal))
			(circuito (id-circuito ?c)
			(id-salidas $? ?t $?))
	=>
	(printout t "Circuito: " ?c
				" Salida: " ?t
				" Senyal: " ?senyal crlf) )  

	
	
	
	
	
(deffacts lista-de-elementos
	(circuito	(id-circuito C)
				(id-entradas e1 e2 e3)
				(id-salidas s1 s2) )
	(puerta (id-puerta X1)
			(tipo XOR))
	(puerta (id-puerta X2)
			(tipo XOR))
	(puerta (id-puerta A1)
			(tipo AND))
	(puerta (id-puerta A2)
			(tipo AND))
	(puerta (id-puerta O1)
			(tipo OR )) )
			
(deffacts lista-de-conexiones
 (conexion C e1 X1 e1)
 (conexion C e1 A1 e1)
 (conexion C e2 X1 e2)
 (conexion C e2 A1 e2)
 (conexion C e3 A2 e1)
 (conexion C e3 X2 e2)
 (conexion X1 s1 X2 e1)
 (conexion X1 s1 A2 e2)
 (conexion A1 s1 O1 e2)
 (conexion A2 s1 O1 e1)
 (conexion X2 s1 C s1)
 (conexion O1 s1 C s2) )
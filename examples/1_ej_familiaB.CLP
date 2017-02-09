(deftemplate persona
	"Info sobre persona"
	(slot nombre)
	(slot DNI)
	(slot sexo (allowed-symbols HOMBRE OR MUJER))
)
(deftemplate RelacionFamiliar
	(slot tipo);padre , hermanos , primos
	(slot persona1)
	(slot persona2)
)


	

(deffacts H

	(persona	(nombre Paco)
				(DNI 1)
				(sexo HOMBRE))
	(persona	(nombre Raquel)
				(DNI 2)
				(sexo MUJER))
	(persona	(nombre Isma)
				(DNI 3)
				(sexo HOMBRE))
	(persona	(nombre Fran)
				(DNI 3)
				(sexo HOMBRE))
	(persona	(nombre Miguel)
				(DNI 3)
				(sexo HOMBRE))
	(persona	(nombre Abuelo)
				(DNI 3)
				(sexo HOMBRE))

	
	(progenitor  Paco Isma)
	(progenitor  Raquel Isma)
	(progenitor  Paco Fran)
	(progenitor  Raquel Fran)
	(progenitor  Abuelo Miguel)
	(progenitor  Abuelo Paco)	
	
	
)


(defrule R_Padre 
	
	(progenitor ?x ?y)	
	(persona (nombre ?x)
			 (sexo HOMBRE))
=> 
	(assert (RelacionFamiliar 	(tipo PADRE)
								(persona1 ?x)
								(persona2 ?y)))
)

(defrule R_Madre 
	(progenitor ?x ?y)	
	(persona (nombre ?x)
			 (sexo MUJER))
=> 
	(assert (RelacionFamiliar 	(tipo MADRE)
								(persona1 ?x)
								(persona2 ?y)))
)

(defrule R_Hermanos
	(RelacionFamiliar (tipo PADRE) (persona1 ?x) (persona2 ?y))
	(RelacionFamiliar (tipo PADRE) (persona1 ?x) (persona2 ?z))
	
	(test (neq ?y ?z))
=> 
	(assert (RelacionFamiliar (tipo HERMANOS) (persona1 ?y) (persona2 ?z) ))
	(assert (RelacionFamiliar (tipo HERMANOS) (persona1 ?z) (persona2 ?y) ))
)

(defrule R_Tio
	(RelacionFamiliar (tipo HERMANOS) (persona1 ?x) (persona2 ?y) )
	(progenitor ?x ?z)
	(persona (nombre ?x)
			 (sexo HOMBRE))
=> 
	(assert (RelacionFamiliar (tipo TIO) (persona1 ?y) (persona2 ?z)))
)

(defrule R_Tia
	(hermanos ?x ?y)
	(progenitor ?x ?z)
	(mujer ?y)
=> 
	(assert (tia ?y ?z))				
)

(defrule R_Abuelo
	(progenitor ?x ?y)
	(progenitor ?y ?z)
	(hombre ?x)
=> 
	(assert (abuelo ?x ?z))
)

(defrule R_Abuela
	(progenitor ?x ?y)
	(progenitor ?y ?z)
	(mujer ?x)
=> 
	(assert (abuela ?x ?z))
)

(defrule R_Primos
	(hermanos ?x ?y)
	(progenitor ?x ?h1)
	(progenitor ?y ?h2)
	=> 
	(assert (primos ?h1 ?h2))
)

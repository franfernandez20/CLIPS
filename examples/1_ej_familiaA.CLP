(deffacts H
	(hombre Paco)
	(hombre Abuelo)
	(mujer Raquel)
	(mujer Arcahalis)
	(mujer Rosa)
	(mujer Flora)
	(mujer MariAngeles)
	(hombre Isma)
	(hombre Fran)
	(hombre Emilio)
	(hombre Miguel)
	(hombre Carlos)	
	(progenitor Raquel Isma)
	(progenitor Raquel Fran)
	(progenitor Paco Isma)
	(progenitor Paco Fran)
	(progenitor Abuelo Paco)
	(progenitor Abuelo Miguel)
	(progenitor Rosa Miguel)
	(progenitor Rosa Paco)
	(progenitor Flora Raquel)
	(progenitor Flora Arcahalis)
	(progenitor Arcahalis Carlos)
	(progenitor Emilio Carlos)
)


(defrule R_Padre 
	(progenitor ?x ?y)
	(hombre ?x)
=> 
	(assert (padre ?x ?y))
)

(defrule R_Madre 
	(progenitor ?x ?y)
	(mujer ?x)
=> 
	(assert (madre ?x ?y))
)

(defrule R_Hermanos
	(progenitor ?x ?y)
	(progenitor ?x ?z)
	(test (neq ?y ?z))
=> 
	(assert (hermanos ?y ?z))
	(assert (hermanos ?z ?y))
)

(defrule R_Tio
	(hermanos ?x ?y)
	(progenitor ?x ?z)
	(hombre ?y)
=> 
	(assert (tio ?y ?z))
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

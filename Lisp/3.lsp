; 3) Definiti o functie care testeaza apartenenta unui nod intr-un arbore n-ar 
; reprezentat sub forma (radacina lista_noduri_subarb1... lista_noduri_subarbn) 
; Ex: arborelele este (a (b (c)) (d) (e (f))) si nodul este 'b => adevarat
;
; (exercitiu-5 '(a (b (c)) (d) (e (f))) 'b))
; (exercitiu-5 '(a (b (c)) (d) (e (f))) 'z))

; apare (l e)
; l - lista in care se verifica daca apare 'nodul' e ( pe orice nivel )
; e - nodul caruia ii trebuie verificata apartenenta
;
; exercitiu-5 (l1 ... ln, e) = ( 1, daca e = max(l)
;					     	   ( 0, daca l = atom
;						       { max(exercitiu-5(l1), exercitiu-5(l2)... exercitiu-5(l3)), unde l = l1...ln si l este lista


(defun exercitiu-5(l el)
	(cond
		((equal l el) 1)
		((atom l) 0)
		(t 
            (apply #'max
                (mapcar #'
                    (lambda(v) 
                        (exercitiu-5 v el)
                    ) 
                    l
                )
            )
        )
	)
)

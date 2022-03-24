;1.

;a) Sa se elimine elementul de pe pozitia a n-a a unei liste liniare.
; (deleteN '(1 2 3 4 5) '3)

; deleteN (lista N)
; lista - lista din care se sterge al n-lea element
; N - al catalea element se sterge
;
; deleteN(l1 ... ln, N) = { NIL, daca lista e NIL
;						  {	[l1] + deleteN(l2 ... ln, N - 1), N =/= 1
;						  { [l2 ... ln], altfel

(defun deleteN (lista N)
	(cond
		((null lista) null) ; ((null lista) nil)
		((not (= N 1)) (cons (car lista) (deleteN (cdr lista) (- N 1))))
		(t (cdr lista))
	)
)


;b) Definiti o functie care determina succesorul unui numar reprezentat cifra cu cifra intr-o lista. De ex: (1 9 3 5 9 9) --> (1 9 3 6 0 0)
; (succesor '(1 2 3 1 2))
; (succesor '(1 2 3 1 9))
; (succesor '(9 9 9 9))

; succesorRecAux (lista cf col)
; lista - lista inversata la care trebuie adaugat 1
; cf - carry flag 
; col - lista colectoare
;
; succesorRecAux(l1 ... ln, cf, col) = { col, daca lista e NIL si cf = 0
;									   { [1], daca lista e NIL si cf = 1
;									   { succesorRecAux(l2 ... ln, 1, [0] + col), daca l1 = 9 si cf = 1
;									   { succesorRecAux(l2 ... ln, 0, [9] + col), daca l1 = 9 si cf = 0
;									   { succesorRecAux(l2 ... ln, 0, [l1] + col), daca cf = 0
;									   { succesorRecAux(l2 ... ln, 0, [l1+1] + col), l1 =/= 9 si cf = 1

(defun succesorRecAux (lista cf col)
	(cond		; se construieste invers lista ( primul el devine ultimul si invers )
		((and (null lista) (= cf 0)) col)		;lista null si cf 0 -> l - null, col - 2 1 4 1, cf - 0 -> s-a terminat o adaugare normala 
		((null lista) (cons 1 col))			; lista null si cf 1 -> se adauga 1 la null -> col - 1 ( in cazul 9999 -> 10000)
		((and (= (car lista) 9) (= cf 1)) (succesorRecAux (cdr lista) 1 (cons 0 col)))	; car e 9, cf e 1 -> se trece 0 in col si se pastreaza carry flag
		((= (car lista) 9) (succesorRecAux (cdr lista) 0 (cons 9 col)))  ; car e 9, cf e 0 -> se trece 9 in col si cf ramane 0
		((= cf 0) (succesorRecAux (cdr lista) 0 (cons (car lista) col))) ; se trece la urm daca cf e 0
		(t (succesorRecAux (cdr lista) 0 (cons (+ (car lista) 1) col)))) ; se aduna 1 daca primul nr nu e 9 si cf e 1
																		 ; adica, daca trebuie doar adunat cf la o cifra diferita de 9

)

; succesorRec (lista)
; lista - lista inversata la care trebuie adaugat 1 (1 2 3 4 5 -> 5 4 3 2 2 )
; 
; succesorRec(l1 ... ln) = { NIL, daca lista e NIL
; 						   { succesorRecAux(l2 ... ln, 1,[0]), daca l1 = 9
;						   { succesorRecAux(l2 ... ln, 0,[l1+1]), altfel

(defun succesorRec (lista)
	(cond
		((null lista) 'nil)
		((= (car lista) 9) (succesorRecAux (cdr lista) 1 (list 0)))
		(t (succesorRecAux (cdr lista) 0 (list (+ (car lista) 1))))
	)
)

; invertListRec (lista col)
; lista - lista ce trebuie inversata
; col - lista colectoare
;
; invertListRec(l1 ... ln, col) = { col, daca lista e NIL
; 							      {	invertListRec(l2 ... ln-1, [ln] + col), altfel

(defun invertListRec (lista col)
	(cond
		((null lista) col)
		(t (invertListRec (cdr lista) (cons (car lista) col)))
	)
)

; invertList (lista)
; lista - lista ce trebuie inversata
;
; invertList(l1 ... ln) = { invertListRec (l1 ... ln)

(defun invertList (lista)
	(invertListRec lista (list))
)

; succesor (lista)
; lista - lista la care trebuie adunat 1
; 
; succesor(l1 ... ln) = { succesorRec (invertList lista)

(defun succesor (lista)
	(succesorRec (invertList lista))	
)


;c) Sa se construiasca multimea atomilor unei liste.Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)
; (subpunct-c '(1 3 2 4 1))

; creaza-lista(l)
; l - lista ce trebuie "normalizata" (1 2 (3 (4 (5)))) - > (1 2 3 4 5)
;
; creaza-lista(l1 ... ln) = { NIL, daca lista e NIL
; 					        { creaza-lista(l1) + creaza-lista(l2... ln), daca l1 e lista
;							{ [l1] + creaza-lista(l2... ln), altfel

(defun creeaza-lista (l)
    (cond
        ((null l) nil)
        ((listp (car l)) (append (creeaza-lista (car l)) (creeaza-lista (cdr l))))
        (t (cons (car l) (creeaza-lista (cdr l))))
    )
)

; contine(l e)
; l - lista
; e - elementul care se verifica daca apartine in lista
;
; contine(l1 ... ln, e) = { fals, daca lista e NIL
;						  { adevarat, daca e = l1
;						  { contine(l2 ... ln, e), altfel	

(defun contine(l e)
    (cond
        ((null l) nil)
        ((equal e (car l)) t)
        (t (contine (cdr l) e))
    )
)

; multime(l)
; l - lista ce trebuie redusa la o multime
; 
; multime(l1 ... ln) = { fals, daca lista e NIL
;					   { multime (l2 ... ln), daca contine(l2 ... ln, l1) adevarat
;					   { l1 + multime (l2 ... ln), altfel

(defun multime(l)
    (cond
        ((null l) nil)
        ((contine (cdr l) (car l)) (multime (cdr l)))
        (t (cons (car l) (multime (cdr l))))
    )
)


; subpunct-c(l)
; l - lista ce trebuie redusa la om ultime
;
; subpunct-c(l1 ... ln) = { multime(creeaza-lista(l1 ... ln))

(defun subpunct-c(l)
    (multime (creeaza-lista l))
)


;d) Sa se scrie o functie care testeaza daca o lista liniara este o multime.
;  (testSet '(2 4 1))
;  (testSet '(2 4 1 2))

; testSet (l)
; l - lista ce trebuie verififcata daca e multime
;
; testSet(l1 ... ln) = { adevarat, daca lista e NIL
;                      { fals , daca contine(l2 ... ln, l1) = adevarat
;					   { testSet(l2 ... ln, l1), altfel

(defun testSet (l)
	(cond
		((null l) 't)
		((contine (cdr l) (car l)) nil)
		(t (testSet (cdr l)))
	)
)

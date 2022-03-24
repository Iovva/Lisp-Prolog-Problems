;2) Se da un arbore de tipul (1). Sa se precizeze nivelul pe care apare un nod din arbore.
;   Nivelul radacii se considera a fi 0.  
;   (exercitiu-7 '(A 2 B 1 D 2 F 0 G 0 C 1 E 1 H 0) 'G)
;   (exercitiu-7 '(A 2 B 1 D 2 F 0 G 1 Z 0 C 1 E 1 H 0) 'Z) inca o ramura din G in jos
;   (exercitiu-7 '(A 2 B 0 C 0) 'C)
;   (exercitiu-7 '(A 2 B 1 D 2 F 0 G 0 C 1 E 1 H 1 I 1 Z 0) 'Z)

; parcurgere-subarbori(l nv nm laux)
; l = lista ce trebuie impartita in 2 liste, reprezentand cei 2 arbori
; nv = numarul curent de varfuri parcurse
; nm = numarul curent de muchii parcurse
; laux = lista care contine segmentarea listei initiale in 2 liste, reprezentand cei 2 arbori
;
; Se incrementeaza nv (numarul varfurilor) pentru fiecare varf parcurs, si se aduna la nm (numarul muchiilor) fiecare
; numar (care reprezinta cati sub-arbori are un nod, deci, cate muchii merg in "jos")
; Eventual, incrementarea constanta a numarul de varfuri va face sa fie egal cu numarul de muchii curente + 1, de unde rezulta
; ca toate varfurile si muchiile strabatute pana atunci pot fi sectionate in prima lista, care reprezinta arborele de stanga.
; Arborele de dreapta este ce ramane.
; Evident, arborele de dreapta poate fi absent in totalitate.
; pentru lista : (B 1 D 2 F 0 G 0 C 1 E 1 H 0), se proceseaza astfel:
; 0. nv = 0, nm = 0
; 1. {B 1} nv = 0++ = 1, nm = 0 + 1 = 1,  
; 2. {D 2} nv = 1++ = 2, nm = 1 + 2 = 3,
; 3. {F 0} nv = 2++ = 3, nm = 3 + 0 = 3,
; 4. {G 0} nv = 3++ = 4, nm = 3 + 0 = 3,
;    STOP, s-a atins conditia nv = nm + 1 -> arborele complet -> (B 1 D 2 F 0 G 0) este arborele stang
;	 din moment ce au ramas elemente, (C 1 E 1 H 0) este arborele drept!
;
; parcurgere-subarbori(l1 ... ln, nv, nm, laux) = { laux, daca lista e NIL
;												  { laux + (l1 ... ln), daca nv = nm + 1 (daca arborele stang e gol)
;												  { parcurgere-subarbori(l3 ... ln, nv + 1, nm + l2, laux + [l1, l2]), altfel

(defun parcurgere-subarbori(l nv nm laux)
    (cond
        ((null l) (list laux))
        ((= nv (+ nm 1)) (cons laux (list l)))
        (t (parcurgere-subarbori (cddr l) (+ nv 1) (+ nm (cadr l)) (append laux (list (car l) (cadr l)))))
    )
)

; subarbore-st-dr (l)
; l - lista ce reprezinta un arbore de tip 1. Arborele va fi sectionat in : (radacina (arbore st) (arbore dr))
;																			 unde arbore dr nu poate exista fara arbore st si
;																			 arbore st si arbore dr sunt ambele optinale
;
;  ex: (A 2 B 1 D 2 F 0 G 0 C 1 E 1 H 0) -> (A (B 1 D 2 F 0 G 0) (C 1 E 1 H 0))
; (cddr (1 2 3 4) -> (3 4)) 
; (cadr (1 2 3 4) -> (2)) 
; (caddr(1 2 3 4) -> (3))
;
; subarbore-st-dr (l1 ... ln) = { parcurgere-subarbori (l3 ... ln, 0, 0, nil)

(defun subarbore-st-dr (l)
    (cons (car l) (parcurgere-subarbori (cddr l) 0 0 nil))
)

; gaseste-nivel-e(l e nr)
; l - lista in care se cautat
; e - elementul ce trebuie cautat
; nr - contor reprezentand nivelul curent
;
; gaseste-nivel-e(l1 ... ln, e, nr) = { NIL, daca lista e NIL
;									  { nr, daca e1 = e
;									  { gaseste-nivel-e(e2, e, nr + 1), daca gaseste-nivel-e(e2, e, nr + 1) =/= NIL
;									  { gaseste-nivel-e(e3, e, nr + 1), daca gaseste-nivel-e(e3, e, nr + 1) =/= NIL
;									  { NIL, altfel
;									unde el = subarbore-st-dr(l) = (e1 e2 e3)   (e1 = atom, e2 = lista, e3 = lista)

(defun gaseste-nivel-e(l e nr)
    (
        (lambda (el)
            (cond
                ((null l) nil)
                ((equal (car el) e) nr)
                ((not (null (gaseste-nivel-e (cadr el) e (+ nr 1)))) (gaseste-nivel-e (cadr el) e (+ nr 1)))
                ((not (null (gaseste-nivel-e (caddr el) e (+ nr 1)))) (gaseste-nivel-e (caddr el) e (+ nr 1)))
                (t nil)
            )
        )
        (subarbore-st-dr l)
    )
)

; exercitiu-7(l e)
; determina nivelul pe care e elementul e in lista l
; l - lista ce reprezinta un arbore de tip 1
; e - elementul ce trebuie cautat
;
; exercitiu-7 (l1 ... ln) = { gaseste-nivel-e(l, e, 0)

(defun exercitiu-7(l e)
    (gaseste-nivel-e l e 0)
)

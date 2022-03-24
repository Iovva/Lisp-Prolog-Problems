% problema 2
% a. Sa se scrie un predicat care transforma o lista intr-o multime, in
% ordinea primei aparitii. Exemplu: [1,2,3,1,2]
% b) Se da o lista eterogena, formata din numere intregi si liste de numere. Sa
% se sorteze fiecare sublista fara pastrarea dublurilor. De ex:
% [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].


% ----A----
%

% adauga un simbol in fata unei liste
% inserare(E: simbol, L: lista, LRez: lista)
%
% E - simbolul care trebuie adaugat
% L - lista in fata careia se adauga simbolul E
% LRez - lista (poate fi variabila libera) rezultata dupa
% adaugarea simboluli E
%
% model de flux (i, i, o) sau (i, i, i)
% model matematic:
% inserare(E, l1 ... ln) -
%   { (E) , lista e vida
%   { (E) + inserare(l1, l2 ... ln) , altfel

inserare(E, [], [E]).

inserare(E, [H|T], [E|Rez]):- inserare(H, T, Rez).


% adauga un element inaintea primei valori
% mai mare ca ea din lista sortata crescator (de la stanga la dreapta)
% sau pe ultima pozitie daca e cea mai mare;
% daca elementul este deja in lista, nu se inereaza
%
% adaugaElement(E: simbol, L: lista, LRez: lista)
% E - simbolul care trebuie adaugat
% L - lista in care trebuie adaugat elemetul
% LRez - lista (poate fi variabila libera) rezultata
% dupa adauga simbolului E in fata primei valori mai mari
%
% model de flux (i, i, o), (i, i, i)
% model matematic:
% adaugaElement(E, l1 ... ln) -
%  { (E), lista e vida
%  { (l1) + adaugaElement(E, l2 ... ln), daca E > l1
%  { (l1) + inserare(E, l2 ... ln), daca E < l1
%  { adaugaElement(E, l2 ... ln), altfel

adaugaElement(E, [], [E]).

adaugaElement(E, [Cap|Coada], [Cap|Rez]):- E > Cap,
	adaugaElement(E, Coada, Rez),
	!.

adaugaElement(E, [Cap|Coada], Rez):- E < Cap,
	inserare(E, [Cap|Coada], Rez),
	!.

adaugaElement(E, [_|Coada], Rez):-
	adaugaElement(E, Coada, Rez).



% sorteaza o lista crescator
%
% sorteazaLista(L: Lista, LRez: Lista)
% L - lista care trebuie sortata
% LRez - lista (poate fi variabilia libera) sortata
%
% model	de flux (i, i), (i, o)
% model matematic:
% sorteazaLista(l1 ... ln) -
% { (), lista e vida
% { adaugaElement(l1, sorteazaLista(l2 ... ln)), altfel

sorteazaLista([], []).
sorteazaLista([Cap|Coada], Rez):-sorteazaLista(Coada, Rez1),
	adaugaElement(Cap, Rez1, Rez).

% explicatii :
% pe ex : [4, 3, 1, 2] :
% prima oara adaugaElement pe 2 in lista vida
% dupa adaugaElement pe 1 in lista sortata [2]
% dupa adaugaElement pe 3 in lista sortata [1, 2]
% dupa adaugaElement pe 4 in lista sortata [1, 2, 3]
% dupa LRez devine lista sortata [1, 2, 3, 4]


%-------B-------


% sorteaza o lista eterogena, formata din numere intregi si liste de
% numere. Sa se sorteze fiecare sublista fara pastrarea dublurilor
%
% prelucrareLista(L, LRez)
% L - lista ce trebuie prelucrata
% L - lista prelucrata
%
% model de flux (i, i), (i, o)
% model matematic:
% prelucareLista(l1 ... ln) -
% { (), lista e vida
% { ( sorteazaLista(l1) ) + prelucrareLista(l2 ... ln), daca l1 e lista
% { (l1) + prelucarareLista(l2 ... ln), altfel


prelucrareLista([],[]).
prelucrareLista([Cap|Coada], [Rez|Rez1]):-is_list(Cap),
	!,
	prelucrareLista(Coada, Rez1),
	sorteazaLista(Cap, Rez).
prelucrareLista([Cap|Coada], [Cap|Rez1]):- prelucrareLista(Coada, Rez1).















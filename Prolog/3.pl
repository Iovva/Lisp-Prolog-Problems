% problema 3
% Fiind dat un numar n pozitiv, se cere sa se determine toate descompunerile
% sale ca suma de numere prime distincte.


% verifica daca un numar are vreun divizor inafara de el sau 1
% ( true daca are, false daca n-are )
% divizibil(X: numar, Y: simbol)
%
% X - numarul care trebuie verificat
% Y - contorul curent cu care se verifica
% (ia valori de la 2 pana la n - 1)
%
% model de flux (i, i) determinist
% model matematic:
% divizil(X, Y) -
%    { adevarat, daca X mod Y = 0
%    ( false, daca X = Y
%    { divizibil(X, Y+1), altfel

divizibil(X,Y) :- 0 is X mod Y, !.

divizibil(X,Y) :- X > Y+1, divizibil(X, Y+1).


% verifica daca un numar este prim
% ( true daca e prim, false daca nu )
% prim(X: numar)
%
% X - numarul ce trebuie verificat
% model de flux: (i) determinist
%
% model matematic:
% prim(X) -
%    { adevarat, daca X = 2 sau ( divizibil(X, 2) este fals )
%    { false, altfel

prim(2) :- true,!.

prim(X) :- X < 2,!,false.

prim(X) :- not(divizibil(X, 2)).


% creeaza o lista cu toate numerele prime mai mici sau egale ca un numar
% dat, in ordine descrescatoare
% compunePrime(N: numar, L: lista)
%
% N - numarul pentru care se returneaza o lista cu numere prime
% mai mici ca el
% L - lista de numere prime mai mici ca N
%
% model de flux (i, o), (i, i) deterministe
% model matematic:
% compunePrime(N, l1 ... ln) -
%    { (2), daca N < 3
%    { (l1) + compunePrime(N - 2, l2 ... ln), daca prim(N) este adevarat
%    { compunePrime(N - 2, l2 ... ln), altfel

compunePrime(1, [2]):-!.

compunePrime(N, [N|T]):-
	prim(N),
	!,
	N1 is N-2,
	compunePrime(N1, T).

compunePrime(N, L):-
	N1 is N-2,
	compunePrime(N1, L).


% determina descompuneri a unui numar in suma de numere prime
% sumaPrime(N: numar, LRez: lista)
%
% N - numarul ce trebuie descompus in suma de numere prime
% LRez - lista de numere prime care, adunate, dau numarul dat
%
% model de flux (i, o) - nedeterminist
%		(i, i) - determinist
% model matematic:
% sumaPrime(N)-
%    { E = candidat(compunePrime(N-1)),
%      solutie_aux(compunePrime(N-1), N, (E), E) ,daca N e par
%    { E = candidat(compunePrime(N)),
%      solutie_aux(compunePrime(N), N, (E), E) ,altfel


sumaPrime(N, LRez):-
	N mod 2 =:= 0,
	!,
	N1 is N-1,
	compunePrime(N1, LPrime),
	candidat(LPrime, E),
	solutie_aux(LPrime, N, LRez, [E], E).


sumaPrime(N, LRez):-
	compunePrime(N, LPrime),
	candidat(LPrime, E),
	solutie_aux(LPrime, N, LRez, [E], E).


% determina toate descompunerile unui numar in suma de numere prime
% cautaSolutii(N: numar, LRez: lista)
%
% N - numarul ce trebuie descompuse in suma de numere prime
% LRez - lista de solutii
%
% model de flux (i, o), (i, i) - deterministe
% model matematic:
% cautaSolutii(N)-
%    { U(sumaPrime(N))
cautaSolutii(N, LRez):-findall(LPrime, sumaPrime(N, LPrime), LRez).


% genereaza un element E candidat dintr-o lista
% ( de fiecare data, functia genereaza un alt element,
% pana nu mai sunt elemente disponibile )
% candidat(L: list, E: numar)
%
% L - lista de candidati
% E - candidatul returnat curent
%
% model de flux (i, o) - nedeterminist
% model matematic:
% candidat(l1 ... ln)-
%    { l1, daca n > 0
%    { candidat(l2 ... ln), altfel
candidat([E|_],E).
candidat([_|T],E):-candidat(T,E).



% folosind o lista de numere, genereaza o alta
% lista de numere, care, adunate, sunt egale cu
% un numar
% solutie_aux(L, N, Rez, Rez1, S)
%
% L - lista initiala
% N - numarul ce trebuie egalat de suma
% Rez - solutia
% Rez1 - colecteaza solutia
% S - suma elementelor din colectoarere
% (restrictie : cand se apeleaza, Rez1 = [S]
% sau Rez1 = [], S = 0)
%
% model de flux (i, i, o, i, i) - nedeterminist
%		(i, i, i, i, i) - determinist
% model matematic:
% solutie_aux(L, N, Rez, S)
%    { Rez1, daca S = N
%    { E = candidat(L), solutie_aux(L, N, (E) + (Rez1 ... Rezn),
%    , S + Rez1), daca E < Rez1 si S + E <= N
%    { fals, altfel


solutie_aux(_, N, Rez, Rez, N):-!.

solutie_aux(L, N, Rez, [H | Col], S) :-
	candidat(L, E),
	E < H,
	S1 is S+E,
	S1 =< N,
	solutie_aux(L, N, Rez, [E | [H | Col]], S1).


% deterministe - un predicat determinist are o solutie
% nedeterministe - un preddicat nedeterminst are mai multe solutii













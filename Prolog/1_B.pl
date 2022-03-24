% Sa se scrie un predicat care, primind o lista,
% intoarce multimea tuturor perechilor din lista. De ex, cu [a, b, c, d]
% va produce [[a, b], [a, c], [a, d], [b, c], [b, d], [c, d]]

%facePerechi(L: lista, Rez: lista, X: symbol)
%L - lista originala
%Rez - lista care contine perechi de forma [L,X], unde X
%este un element al listei L
%X - numarul care va face parte din perechi
%model de flux (i,i,i) sau (i,o,i)

facePerechi([],[],_).
facePerechi([Cap|Coada],[[X,Cap]|L],X):-facePerechi(Coada,L,X).

%combinaListe(L1: lista, L2: lista, L3: lista)
%L1 - lista la care concatenam L2
%L2 - lista pe care o concatenam la finalul listei L1
%L3 - lista rezultat
%model de flux (i,i,i) sau (i,i,o)

combinaListe([],L,L).
combinaListe([Cap|Coada],L,[Cap|X]):-combinaListe(Coada,L,X).

%adaugaPereche(L: lista, Rez: lista)
%L - lista pentru care creem combinarile de doua elemente
%Rez - lista rezultat
%model de flux (i,i) sau (i,o)

adaugaPereche([],[]).
adaugaPereche([Cap|Coada],Rez):-adaugaPereche(Coada,Rez1),
    facePerechi(Coada,Rez2,Cap),
    combinaListe(Rez2,Rez1,Rez).

/*testB1:-adaugaPereche([3,2,5,1],L).*/

testB2:-adaugaPereche([3,2,4],[[3,2],[3,4],[2,4]]).
testB3:-adaugaPereche([1,2,3],[[1,2],[2,3]]).


% Explicatii:
% La apelul predicatului, se intra pe al doilea adaugaPereche. Se tot
% apeleaza recursiv functia, pana cand prima lista ajunge la multimea
% vida, atribuind si la a doua lista multimea vida. Dupa, din adancime,
% se apeleaza facePerechi prima oara, facand toate perechile posibile
% din el curent al listei (practic de asta parcurgem in adancime, pentru
% a avea in coada doar elementele din dreapta el curent (cap) din lista
% initiala) si elementele de la drapta lui (coada). In facePerechi se
% formeaza o lista care contine toate perechile posibile formata din el
% din lista data si din elementul dat. Dupa, in combinaListe, se tot
% concateneaza elemente la prima lista(ca in curs).
% Se repeta asta, din adancime in exterior, pentru toate elementele

% Ex:
% pt lista [2,3,5,4], se executa facePerechi pt:
% [[],..4]     NU intra pentru ca priima e vida
% [[4],..,5]
% [[5,4],..,3]
% [[3,5,4],..2]

% Obs! : Daca o lista e [], nu se poate intra pe un preddicat care
% separa lista in head si tail.



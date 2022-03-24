%problema 1
%Sa se scrie un predicat care intoarce reuniunea a doua multimi.

% contine(L: lista, X: simbol)
% L - lista la care verificam apartenenta lui X
% X - simbolul (poate sa fie variabila libera) a carui apartenenta o
% verificam
% model de flux (i,i) sau (i,o)

contine([Cap|_],X):-X is Cap,!.
contine([_|Coada],X):-contine(Coada,X).

%reuniune(L1: lista, L2: lista, X - lista)
%L1,L2 - liste(multimi) a caror reuniune o cautam
%X - reuniune lui L1 si L2
%model de flux (i,i,i) sau (i,i,o)

reuniune([],X,X).

reuniune([Cap|Coada],L2,X):-contine(L2,Cap),
	reuniune(Coada,L2,X),!.

reuniune([Cap|Coada],L2,[Cap|X]):-reuniune(Coada,L2,X).


/*testA1:-reuniune([3,2,3],[1,2,3,4],L).*/
/*testA2:-reuniune([3,2,3],[1,2,3],L).*/

testA3:-reuniune([3,2,3],[1,2,3,4],[1,2,3,4]).
testA4:-reuniune([3,2,3],[1,2,3,4],[3,2]).

% Explicatii:
% La apelul functiei se intra pe al doilea reuniune. Daca contine el,
% realizeaza reuniune iar, fara sa concateneze elementul( din curs ).
% Daca nu, trece pe al treilea reuniune si il concateneaza. Totul pana
% se goleste lista 1 si se copiaza in lista finala lista a doua, urmand,
% dupa backtracking sa se adauge in fata listei toate elementele care nu
% se regaseau.
%
% Contine, la apel, daca el X este capul listei, returneaza true, daca
% nu, se apeleaza recursiv, fara capu0 primei liste. Daca se ajunge la o
% lista vida, nu intra pe nici unul din cazuri, returnand fals.

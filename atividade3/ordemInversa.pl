% Nome: Vinícius Eduardo de Souza Honório
% Matrícula: 2021.1.08.024

% Ordenação por Inserção:

insere(A,[B|C],[A,B|C]) :- B =< A, !.
insere(A,[B|C],[B|D]) :- insere(A,C,D), !.
insere(A,[],[A]).

ordemInversaInsercao([A|B],Ls) :- ordemInversaInsercao(B,Li),insere(A,Li,Ls), !.
ordemInversaInsercao([],[]).

% Ordenação por Seleção:

max([X],X) :- !.
max([A|B],A) :- max(B,M), M =< A, !.
max([_|B],M) :- max(B,M).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

removeMax(M,L,S) :- max(L,M), apaga(M,L,S), !.

ordemInversaSelecao(L,[M|S]) :- removeMax(M,L,Li), ordemInversaSelecao(Li,S).
ordemInversaSelecao([],[]).
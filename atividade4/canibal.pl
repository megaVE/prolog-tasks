%------------------------------------------
% Busca em largura/profundidade
% Por Luiz Eduardo
%---------------------------------------------------
% Adaptação do Problema dos Missionários e Canibais
% Por Vinícius Eduardo de Souza Honório - 2021.1.08.024
%---------------------------------------------------

ap([],X,X).
ap([A|B],C,[A|D]) :- ap(B,C,D).

in(A,[A|_]) :- !.
in(A,[_|B]) :- in(A,B).

% Implementacao do algoritmo de busca em largura ou profundidade
% 1 = largura
% 2 = profundidade
estrategia(1).

atingemeta([_-E|_]) :- meta(E).

busca([Caminho|_], Solucao) :- atingemeta(Caminho), !, Solucao = Caminho.
busca([Caminho|Lista], Solucao) :- 
   findall(UMAEXT, estende(Caminho,UMAEXT), EXT),
   estrategia(Tipo),
   estrategia(Tipo),
   (Tipo = 1 -> ap(Lista, EXT,  Lista1);
    Tipo = 2 -> ap(EXT, Lista, Lista1)),
   busca(Lista1, Solucao).

naorepete(_-E,C) :- not(in(_-E,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

margem([F,L,C,R], M) :-
   (F = M -> write('F'); write(' ')),
   (L = M -> write('L'); write(' ')),
   (C = M -> write('C'); write(' ')),
   (R = M -> write('R'); write(' ')).

desenha(Estado) :-
     write('    '), margem(Estado, a), write('|    |'), margem(Estado,b).

escreve([_-E]) :- write('Estado Inicial: '), write(E), nl, !.
escreve([O-E|R]) :- 
    escreve(R), 
    write('Executando: '), 
    traduz(O,T),
    write(T), write(' obtemos '), /*desenha(E),*/ write(E), nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

%-----------------------------------
% Especificacao do problema
%-----------------------------------

traduz(levaMMD, 'indo dois missionários da esquerda para direita').
traduz(levaMCD, 'indo um missionário e um canibal da esquerda para direita').
traduz(levaCCD, 'indo dois canibais da esquerda para direita').
traduz(levaMME, 'indo dois missionários da direita para esquerda').
traduz(levaMCE, 'indo um missinário e um canibal da direita para esquerda').
traduz(levaCCE, 'indo dois canibais da direita para esquerda').
traduz(levaMD, 'indo um missionário da esquerda para direita').
traduz(levaCD, 'indo um canibal da esquerda para direita').
traduz(levaME, 'indo um missionário da direita para esquerda').
traduz(levaCE, 'indo um canibal da direita para esquerda').
inicial([3,3,0,0,0]).
meta([0,0,_,3,3]).
% Leva 2 missionários no barco

oper(levaMMD,[2,2,0,1,1],[0,2,1,3,1]).
oper(levaMMD,[3,A,0,0,B],[1,A,1,2,B]) :- A =< 1, B =< 2.

oper(levaMME,[1,1,1,2,2],[3,1,0,0,2]).
oper(levaMME,[0,A,1,3,B],[2,A,0,1,B]) :- B =< 1, A =< 2.

% Leva 2 canibais no barco

oper(levaCCD,[3,X,0,0,Z],[3,Y,1,0,W]) :- X >= 2, Y is X-2, W is Z+2.
oper(levaCCD,[0,X,0,3,Z],[0,Y,1,3,W]) :- X >= 2, Y is X-2, W is Z+2.

oper(levaCCE,[0,X,1,3,Z],[0,Y,0,3,W]) :- Z >= 2, W is Z-2, Y is X+2.
oper(levaCCE,[3,X,1,0,Z],[3,Y,0,0,W]) :- Z >= 2, W is Z-2, Y is X+2.

% Leva 1 canibal e 1 missionário no barco

oper(levaMCD,[A,B,0,C,D],[X,Y,1,Z,W]) :- A >= 1, B >= 1, X is A-1, Y is B-1, Z is C+1, W is D+1, Z >= W.

oper(levaMCE,[A,B,1,C,D],[X,Y,0,Z,W]) :- C >= 1, D >= 1, X is A+1, Y is B+1, Z is C-1, W is D-1, X >= Y.

% Leva 1 canibal

oper(levaCD,[3,3,0,0,0],[3,2,1,0,1]).
oper(levaCD,[A,B,0,C,D],[A,X,1,C,Y]) :- B >= 1, C \= D, X is B-1, Y is D+1.

oper(levaCE,[A,B,1,C,D],[A,X,0,C,Y]) :- D >= 1, A \= B, X is B+1, Y is D-1.

% Leva 1 missionário

oper(levaMD,[1,1,0,2,2],[0,1,1,3,2]).
oper(levaMD,[A,B,0,C,D],[X,B,1,Y,D]) :- A >= 1, A \= B, X is A-1, Y is C+1, Y >= D.

oper(levaME,[2,2,1,1,1],[3,2,0,0,1]).
oper(levaME,[A,B,1,C,D],[X,B,0,Y,D]) :- C >= 1, C \= D, X is A+1, Y is C+1, X >= B.

% traduz(fa, 'fazendeiro vai sozinho   ').
% traduz(fb, 'fazendeiro volta sozinho ').
% traduz(la, 'fazendeiro leva o lobo   ').
% traduz(lb, 'fazendeiro traz o lobo   ').
% traduz(ca, 'fazendeiro leva a cabra  ').
% traduz(cb, 'fazendeiro traz a cabra  ').
% traduz(ra, 'fazendeiro leva o repolho').
% traduz(rb, 'fazendeiro traz o repolho').

% oper(fa, [a,L,C,R], [b,L,C,R]) :- L \= C, C \= R.
% oper(fb, [b,L,C,R], [a,L,C,R]) :- L \= C, C \= R.
% oper(la, [a,a,C,R], [b,b,C,R]) :- (C \= R; C = b).
% oper(lb, [b,b,C,R], [a,a,C,R]) :- (C \= R; C = a).
% oper(ca, [a,L,a,R], [b,L,b,R]).
% oper(cb, [b,L,b,R], [a,L,a,R]).
% oper(ra, [a,L,C,a], [b,L,C,b]) :- (L \= C; C = b).
% oper(rb, [b,L,C,b], [a,L,C,a]) :- (L \= C; C = a).

% % [F,L,C,R], margem em que está cada elemento
% inicial([a,a,a,a]).
% meta([b,b,b,b]).
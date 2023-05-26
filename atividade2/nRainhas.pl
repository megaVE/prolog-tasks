% Nome: Vinícius Eduardo de Souza Honório
% Matrícula: 2021.1.08.024

apaga(X,[X|Y],Y).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

solucao(N,S) :-
	crialista(N,L),
	criasup(N,DS),
	criainf(N,DI),
	resolve(S,L,L,DS,DI),
    leituraLista(N,S).

% leituraLista: chama a função imprime para cada linha de solução do tabuleiro

leituraLista(_,[]) :- !.
leituraLista(N,[A|X]) :- imprime(N,1,A), leituraLista(N,X).

% imprime: imprime cada linha de solução do tabuleiro, de acordo com o tamanho do tabuleiro e com a casa na qual está a rainha

imprime(N,X,_) :- X > N, nl, !.
imprime(N,X,A) :- X == A, write('R'), Y is X + 1, imprime(N,Y,A).
imprime(N,X,A) :- X \= A, write('.'), Y is X + 1, imprime(N,Y,A).

resolve([],[],_,_,_).
resolve([C|LC],[L|LL],C0,DS,DI):-
	apaga(C,C0,C01),
	NS is L - C,
	NI is L + C,
	apaga(NS,DS,DS1),
	apaga(NI,DI,DI1),
	resolve(LC,LL,C01,DS1,DI1).

% criasup: retorna uma lista contendo todas as diagonais superiores do cenário

criasup(N,L) :- A is 1-N, B is N-1, findall(X,(between(A,B,X)),L).

% criainf: retorna uma lista contendo todas as diagonais inferiores do cenário

criainf(N,L) :- A is 2*N, findall(X,(between(2,A,X)),L).

crialista(N,[N|L]) :- N > 0, N1 is N-1, crialista(N1,L).
crialista(0,[]).

% AUTOR
% Vinícius Eduardo de Souza Honório
% MATRÍCULA
% 2021.1.08.024

% Filho e Pais

mae(elisa,vinicius).
pai(edson,vinicius).
pai(edson,david).

% Avós

mae(maria,elisa).
pai(alberto,elisa).
mae(judite,edson).
pai(sebastiao,edson).

% Avós

mae(maria,elisangela).
pai(jose,elisangela).
mae(maria,rafael).
pai(jose,rafael).
mae(judite,edilene).
pai(sebastiao,edilene).
mae(judite,edna).
pai(sebastiao,edna).

% Primos

mae(elisangela,kauan).
mae(edilene,gabriela).
mae(edilene,beatriz).
mae(edna,cristiane).
mae(cristiane,emanuel).

% Bisavós

mae(leotildes,alberto).
mae(josevita,sebastiao).

% Relações

filho(X,Y) :- pai(Y,X).
filho(X,Y) :- mae(Y,X).

neto(X,Y) :- pai(Y,Z), pai(Z,X).
neto(X,Y) :- pai(Y,Z), mae(Z,X).
neto(X,Y) :- mae(Y,Z), pai(Z,X).
neto(X,Y) :- mae(Y,Z), mae(Z,X).

avo(X,Y) :- neto(Y,X).

bisneto(X,Y) :- pai(Z,X), neto(Z,Y).
bisneto(X,Y) :- mae(Z,X), neto(Z,Y).

bisavo(X,Y) :- bisneto(Y,X).

tio(X,Y) :- pai(Z,Y), pai(W,Z), pai(W,X), X \= Z.
tio(X,Y) :- pai(Z,Y), mae(W,Z), mae(W,X), X \= Z.
tio(X,Y) :- mae(Z,Y), pai(W,Z), pai(W,X), X \= Z.
tio(X,Y) :- mae(Z,Y), mae(W,Z), mae(W,X), X \= Z.

primo(X,Y) :- pai(Z,X), tio(Z,Y).
primo(X,Y) :- mae(Z,X), tio(Z,Y).
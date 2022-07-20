% Caracetrísticas
camiseta(amarela).
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).

nome(carlos).
nome(evandro).
nome(henrique).
nome(marcel).
nome(rodolfo).

curiosidade(animais).
curiosidade(cinema).
curiosidade(esportes).
curiosidade(musica).
curiosidade(televisao).

profissao(analista).
profissao(corretor).
profissao(editor).
profissao(frentista).
profissao(professor).

bebida(agua).
bebida(cafe).
bebida(cha).
bebida(cerveja).
bebida(vinho).

idade(25).
idade(30).
idade(35).
idade(40).
idade(45).

amigo(camiseta, nome, curiosidade, profissao, bebida, idade).

% O elemento está em algum dos extremos da Lista
naPonta(Lista, Elemento) :- last(Lista, Elemento).
naPonta([Elemento|_], Elemento).

% O elemento está na posição informada assumindo que a primeira posição é 1
naPosicao(Lista, Elemento, Posicao) :- nth0(Index, Lista, Elemento), Index =:= (Posicao - 1).

% X está em algum lugar a esquerda de Y
aEsquerda(Lista, X, Y) :- nth0(IndexX, Lista, X), nth0(IndexY, Lista, Y), IndexX < IndexY.

% X está em algum lugar a direita de Y
aDireita(Lista, X, Y)  :- aEsquerda(Lista, Y, X).

% X está em uma posição adjacente de Y
aoLado(Lista, X, Y)    :- nextto(X, Y, Lista); nextto(Y, X, Lista).

% X está imediatamente a esquerda de Y
exatamenteAEsquerda(Lista, X, Y) :- aEsquerda(Lista, X, Y), aoLado(Lista, X, Y).

% X está imediatamente a direita de Y
exatamenteADireita(Lista, X, Y)  :- aDireita(Lista, X, Y),  aoLado(Lista, X, Y).

% X está em alguma posição a direita de Y e em alguma posição a esquerda de Z
entre(Lista, X, Y, Z) :- aDireita(Lista, X, Y), aEsquerda(Lista, X, Z).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H, T)), todosDiferentes(T).

% Solução com as dicas
solucao(Mesa) :-
Mesa = [
        amigo(Camiseta1, Nome1, Curiosidade1, Profissao1, Bebida1, Idade1),
        amigo(Camiseta2, Nome2, Curiosidade2, Profissao2, Bebida2, Idade2),
        amigo(Camiseta3, Nome3, Curiosidade3, Profissao3, Bebida3, Idade3),
        amigo(Camiseta4, Nome4, Curiosidade4, Profissao4, Bebida4, Idade4),
        amigo(Camiseta5, Nome5, Curiosidade5, Profissao5, Bebida5, Idade5)
],

% Na quarta posição está o homem que está bebendo Água.
naPosicao(
    Mesa,
    amigo(_,        _,        _,           _,         agua,    _),
    4
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% Evandro está em uma das pontas.
naPonta( 
    Mesa,
    amigo(_,        evandro,  _,           _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem de camiseta Vermelha está em algum lugar entre o homem de 35 anos e o homem que está bebendo Cerveja, nessa ordem.
entre(
    Mesa,
    amigo(vermelha, _,        _,           _,         _,        _),
    amigo(_,        _,        _,           _,         _,        35),
    amigo(_,        _,        _,           _,         cerveja,  _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem que está bebendo Café está exatamente à esquerda do homem que gosta de curiosidades de Esportes.
exatamenteAEsquerda(
    Mesa,
    amigo(_,        _,        _,           _,         cafe,     _),
    amigo(_,        _,        esportes,    _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem mais novo está em algum lugar entre o homem mais velho e o homem de 30 anos, nessa ordem.
entre(
    Mesa,
    amigo(_,        _,        _,           _,         _,        25),
    amigo(_,        _,        _,           _,         _,        40),
    amigo(_,        _,        _,           _,         _,        30)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O Frentista está vestindo uma camiseta Verde.
    amigo(verde,    _,        _,           frentista, _,        _),
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)


% O Professor está exatamente à esquerda do homem de 30 anos.
exatamenteAEsquerda(
    Mesa,
    amigo(_,        _,        _,           professor, _,        _),
    amigo(_,        _,        _,           _,         _,        30)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem que está bebendo Vinho está em algum lugar à direita do homem de camiseta Branca.
aDireita(
    Mesa,
    amigo(_,        _,        _,           _,         vinho,    _),
    amigo(branca,   _,        _,           _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),


% O Frentista está ao lado do homem que gosta de curiosidades de Animais.
aoLado(
    Mesa,
    amigo(_,        _,        _,           frentista, _,        _),
    amigo(_,        _,        animais,     _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem que gosta de curiosidades de Televisão está em algum lugar à direita do homem de camiseta Vermelha.
aDireita(
    Mesa,
    amigo(_,        _,        televisao,   _,         _,        _),
    amigo(vermelha, _,        _,           _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem de 45 anos está exatamente à direita do homem que gosta de curiosidades de Música.
exatamenteADireita( 
    Mesa,
    amigo(_,        _,        _,           _,         _,        45),
    amigo(_,        _,        musica,      _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O Editor está em algum lugar entre o Henrique e o homem que está bebendo Cerveja, nessa ordem.
entre( 
    Mesa,
    amigo(_,        _,        _,           editor,    _,        _),
    amigo(_,        henrique, _,           _,         _,        _),
    amigo(_,        _,        _,           _,         cerveja,  _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% Marcel gosta de curiosidades de Animais.
    amigo(_,        marcel,   animais,     _,         _,        _),
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)

% Na quinta posição está o homem que gosta de curiosidades de Cinema.
naPosicao(
    Mesa,
    amigo(_,        _,        cinema,      _,         _,        _),
    5
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem de 30 anos está em algum lugar entre Marcel e o homem de 40 anos, nessa ordem.
entre(
    Mesa,
    amigo(_,        _,        _,           _,         _,        30),
    amigo(_,        marcel,   _,           _,         _,        _),
    amigo(_,        _,        _,           _,         _,        40)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% Rodolfo está ao lado de Carlos.
aoLado( 
    Mesa,
    amigo(_,        rodolfo,  _,           _,         _,        _),
    amigo(_,        carlos,   _,           _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O Analista está ao lado do homem que gosta de curiosidades de Esportes.
aoLado( 
    Mesa,
    amigo(_,        _,        _,           analista,  _,        _),
    amigo(_,        _,        esportes,    _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem de Azul está em algum lugar à esquerda do homem que está bebendo Água.
aEsquerda( 
    Mesa,
    amigo(azul,     _,        _,           _,         _,        _),
    amigo(_,        _,        _,           _,         agua,     _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% O homem de camiseta vermelha está em algum lugar entre o homem que gosta de curiosidades de Música e o Evandro, nessa ordem.
entre( 
    Mesa,
    amigo(vermelha, _,        _,           _,         _,        _),
    amigo(_,        _,        musica,      _,         _,        _),
    amigo(_,        evandro,  _,           _,         _,        _)
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

% Rodolfo está na terceira posição.
naPosicao( 
    Mesa,
    amigo(_,        rodolfo,  _,           _,         _,        _),
    3
%   amigo(camiseta, nome,     curiosidade, profissao, bebida,   idade)
),

camiseta(Camiseta1),
camiseta(Camiseta2),
camiseta(Camiseta3),
camiseta(Camiseta4),
camiseta(Camiseta5),
todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]),

nome(Nome1),
nome(Nome2),
nome(Nome3),
nome(Nome4),
nome(Nome5),
todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

curiosidade(Curiosidade1),
curiosidade(Curiosidade2),
curiosidade(Curiosidade3),
curiosidade(Curiosidade4),
curiosidade(Curiosidade5),
todosDiferentes([Curiosidade1, Curiosidade2, Curiosidade3, Curiosidade4, Curiosidade5]),

profissao(Profissao1),
profissao(Profissao2),
profissao(Profissao3),
profissao(Profissao4),
profissao(Profissao5),
todosDiferentes([Profissao1, Profissao2, Profissao3, Profissao4, Profissao5]),

bebida(Bebida1),
bebida(Bebida2),
bebida(Bebida3),
bebida(Bebida4),
bebida(Bebida5),
todosDiferentes([Bebida1, Bebida2, Bebida3, Bebida4, Bebida5]),

idade(Idade1),
idade(Idade2),
idade(Idade3),
idade(Idade4),
idade(Idade5),
todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]).

% (camiseta(Camiseta1); nome(Camiseta1); curiosidade(Camiseta1); profissao(Camiseta1); bebida(Camiseta1); idade(Camiseta1)),
% (camiseta(Camiseta2); nome(Camiseta2); curiosidade(Camiseta2); profissao(Camiseta2); bebida(Camiseta2); idade(Camiseta2)),
% (camiseta(Camiseta3); nome(Camiseta3); curiosidade(Camiseta3); profissao(Camiseta3); bebida(Camiseta3); idade(Camiseta3)),
% (camiseta(Camiseta4); nome(Camiseta4); curiosidade(Camiseta4); profissao(Camiseta4); bebida(Camiseta4); idade(Camiseta4)),
% (camiseta(Camiseta5); nome(Camiseta5); curiosidade(Camiseta5); profissao(Camiseta5); bebida(Camiseta5); idade(Camiseta5)),
% 
% (camiseta(Nome1); nome(Nome1); curiosidade(Nome1); profissao(Nome1); bebida(Nome1); idade(Nome1)),
% (camiseta(Nome2); nome(Nome2); curiosidade(Nome2); profissao(Nome2); bebida(Nome2); idade(Nome2)),
% (camiseta(Nome3); nome(Nome3); curiosidade(Nome3); profissao(Nome3); bebida(Nome3); idade(Nome3)),
% (camiseta(Nome4); nome(Nome4); curiosidade(Nome4); profissao(Nome4); bebida(Nome4); idade(Nome4)),
% (camiseta(Nome5); nome(Nome5); curiosidade(Nome5); profissao(Nome5); bebida(Nome5); idade(Nome5)),
% 
% (camiseta(Curiosidade1); nome(Curiosidade1); curiosidade(Curiosidade1); profissao(Curiosidade1); bebida(Curiosidade1); idade(Curiosidade1)),
% (camiseta(Curiosidade2); nome(Curiosidade2); curiosidade(Curiosidade2); profissao(Curiosidade2); bebida(Curiosidade2); idade(Curiosidade2)),
% (camiseta(Curiosidade3); nome(Curiosidade3); curiosidade(Curiosidade3); profissao(Curiosidade3); bebida(Curiosidade3); idade(Curiosidade3)),
% (camiseta(Curiosidade4); nome(Curiosidade4); curiosidade(Curiosidade4); profissao(Curiosidade4); bebida(Curiosidade4); idade(Curiosidade4)),
% (camiseta(Curiosidade5); nome(Curiosidade5); curiosidade(Curiosidade5); profissao(Curiosidade5); bebida(Curiosidade5); idade(Curiosidade5)),
% 
% (camiseta(Profissao1); nome(Profissao1); curiosidade(Profissao1); profissao(Profissao1); bebida(Profissao1); idade(Profissao1)),
% (camiseta(Profissao2); nome(Profissao2); curiosidade(Profissao2); profissao(Profissao2); bebida(Profissao2); idade(Profissao2)),
% (camiseta(Profissao3); nome(Profissao3); curiosidade(Profissao3); profissao(Profissao3); bebida(Profissao3); idade(Profissao3)),
% (camiseta(Profissao4); nome(Profissao4); curiosidade(Profissao4); profissao(Profissao4); bebida(Profissao4); idade(Profissao4)),
% (camiseta(Profissao5); nome(Profissao5); curiosidade(Profissao5); profissao(Profissao5); bebida(Profissao5); idade(Profissao5)),
% 
% (camiseta(Bebida1); nome(Bebida1); curiosidade(Bebida1); profissao(Bebida1); bebida(Bebida1); idade(Bebida1)),
% (camiseta(Bebida2); nome(Bebida2); curiosidade(Bebida2); profissao(Bebida2); bebida(Bebida2); idade(Bebida2)),
% (camiseta(Bebida3); nome(Bebida3); curiosidade(Bebida3); profissao(Bebida3); bebida(Bebida3); idade(Bebida3)),
% (camiseta(Bebida4); nome(Bebida4); curiosidade(Bebida4); profissao(Bebida4); bebida(Bebida4); idade(Bebida4)),
% (camiseta(Bebida5); nome(Bebida5); curiosidade(Bebida5); profissao(Bebida5); bebida(Bebida5); idade(Bebida5)),
% 
% (camiseta(Idade1); nome(Idade1); curiosidade(Idade1); profissao(Idade1); bebida(Idade1); idade(Idade1)),
% (camiseta(Idade2); nome(Idade2); curiosidade(Idade2); profissao(Idade2); bebida(Idade2); idade(Idade2)),
% (camiseta(Idade3); nome(Idade3); curiosidade(Idade3); profissao(Idade3); bebida(Idade3); idade(Idade3)),
% (camiseta(Idade4); nome(Idade4); curiosidade(Idade4); profissao(Idade4); bebida(Idade4); idade(Idade4)),
% (camiseta(Idade5); nome(Idade5); curiosidade(Idade5); profissao(Idade5); bebida(Idade5); idade(Idade5)).

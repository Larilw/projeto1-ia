:-initialization(main).

main():-
    writeln("Bem-vindo ao calculador de rotas!"),
    writeln("Por favor, digite 'ler_arquivo('').' com o caminho absoluto do seu arquivo texto dentro das aspas simples dentro dos parenteses!").
    /*
    writeln("Por favor, forneca o caminho absoluto do arquivo txt que especifica as suas rotas:"),
    nl,
    read(Arquivo),
    ler_arquivo(Arquivo).
    */
/*
ler_arquivo(NomeArquivo):-
    \+ open(NomeArquivo, read, Stream),
    writeln("Não foi possível abrir o arquivo, tente novamente:").
*/

% ler_arquivo(NomeArquivo): Tenta ler arquivo no caminho passado em NomeArquivo
% ler_arquivo(+NomeArquivo)
ler_arquivo(NomeArquivo):-
    writeln("\nSucesso ao abrir o arquivo! Lendo...\n"),
    open(NomeArquivo, read, Stream),
    ler_linhas(Stream, Linhas),
    close(Stream),
    processa_linhas(Linhas),
    menu.
    
% ler_linhas(Stream, Lista): Se atingiu o final do arquivo, retorna uma lista vazia
% ler_linhas(+Stream, ?Lista)
ler_linhas(Stream, []):-
    at_end_of_stream(Stream).

% ler_linhas(Stream, Lista): Se não atingiu fim do arquivo, lê as linhas do arquivo e constrói uma lista de linhas
% ler_linhas(+Stream, ?Lista)
ler_linhas(Stream, [Linha | Resto]):-
    % Se não chegou no fim do arquivo, continua.
    \+ at_end_of_stream(Stream),
    read(Stream, Linha),
    ler_linhas(Stream, Resto).

% processa_linhas(Lista): Printa cada elemento da lista
% processa_linhas(+Lista)
processa_linhas([]).
processa_linhas([Linha | Resto]):-
    % Adiciona a cabeça da lista como um predicado dinâmico.
    assertz(Linha),
    processa_linhas(Resto).

menu:-
    writeln("-----MENU-----\n"),
    writeln("-> Se quiser ver todas as rotas possiveis, escreva ''"),
    writeln("-> Se quiser saber todos os destinos possiveis a partir de uma cidade presente nas rotas, escreva ''"),
    writeln("-> Se quiser saber todas as origens possiveis para uma dada cidade destino presente nas rotas, escreva ''"),
    writeln("-> Se quiser saber o menor caminho entre duas cidades presentes nas rotas, escreva 'menor_caminho(origem,destino,MenorCaminho).'"),
    writeln("\nLEMBRETE: Ao digitar os comandos, apenas substitua o(s) parametro(s) que possuem letra inicial minuscula pelo nome da(s) cidade(s) de seu interesse.").

% Predicado para verificar se um elemento está em uma lista.
esta_na_lista(X, [X | _]).
esta_na_lista(X, [_ | T]) :-
    esta_na_lista(X, T).

% Predicado para calcular a distância entre duas cidades com lista de cidades visitadas.
pode_ir(X, X, _, 0).
pode_ir(Ini, Fim, Visitadas, Dist) :-
    rota(Ini, Adj, D1),
    \+ esta_na_lista(Adj, Visitadas), % Verifica se a cidade Adj não foi visitada
    pode_ir(Adj, Fim, [Adj | Visitadas], D2),
    Dist is D1 + D2.

% Predicado para encontrar um caminho entre duas cidades com lista de cidades visitadas.
caminho(Ini, Fim, Dist, Cam) :-
    caminho1(Ini, [Fim], 0, Dist, Cam).

caminho1(Cid, [Cid | Cids], Dist, Dist, [Cid | Cids]).
caminho1(Ini, [Adj | Cids], Dist, DistF, CamF) :-
    rota(Interm, Adj, D1),
    \+ esta_na_lista(Interm, [Adj | Cids]), % Verifica se a cidade Interm não foi visitada
    D2 is Dist + D1,
    caminho1(Ini, [Interm, Adj | Cids], D2, DistF, CamF).

% menor_caminho(Ini, Fim, MenorCam): Calcula o menor caminho entre duas cidades.
% menor_caminho(+Ini, +Fim, -MenorCam)
menor_caminho(Ini, Fim, MenorCam) :-
    findall((Dist, Cam),caminho(Ini, Fim, Dist, Cam), TodosCaminhos),
    encontrar_menor_caminho(TodosCaminhos, MenorCam).

% Predicado para encontrar o menor caminho a partir de uma lista de caminhos.
encontrar_menor_caminho([D1], D1).
encontrar_menor_caminho([D1 | Resto], (D2, C2)) :-
    encontrar_menor_caminho(Resto, (D2, C2)),
    D1 < D2, !.
encontrar_menor_caminho([(_, _) | Resto], MenorCam) :-
    encontrar_menor_caminho(Resto, MenorCam).

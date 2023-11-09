% Predicado para ler um arquivo, passando o nome dele.
ler_arquivo(NomeArquivo):-
    % Abre o arquivo e armazena o fluxo (stream) do arquivo na variável Stream.
    open(NomeArquivo, read, Stream),

    % Lê cada linha que está na variável Stream e armazena em um vetor chamado Linhas.
    ler_linhas(Stream, Linhas),

    % Fecha o fluxo do arquivo.
    close(Stream),

    % Processa a lógica do trabalho pedido, fornecendo as linhas lidas do arquivo.
    processa_linhas(Linhas).

% Se atingiu o final do arquivo, retorna uma lista vazia.
ler_linhas(Stream, []):-
    at_end_of_stream(Stream).

% Se não atingiu fim do arquivo, lê as linhas do arquivo e constrói uma lista de linhas.
ler_linhas(Stream, [Linha | Resto]):-
    % Se não chegou no fim do arquivo, continua.
    \+ at_end_of_stream(Stream),

    % Lê uma linha do arquivo e coloca na variável Linha.
    read(Stream, Linha),

    % Pede para continuar lendo o arquivo e ir armazenando no resto da lista, pois a cabeça já tá ocupada (Linha).
    ler_linhas(Stream, Resto).

% Caso base da recursividade.
processa_linhas([]).
% Caso recursivo, para adicionar cada elemento da lista Linha como um predicado dinâmico.
processa_linhas([Linha | Resto]):-
    % Adiciona a cabeça da lista como um predicado dinâmico.
    assertz(Linha),
    % Pede para processar o resto da lista.
    processa_linhas(Resto).

% Predicado para verificar se um elemento está em uma lista.
esta_na_lista(X, [X | _]).
esta_na_lista(X, [_ | T]) :- esta_na_lista(X, T).

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

% Predicado para calcular o menor caminho entre duas cidades.
menor_caminho(Ini, Fim, MenorCam) :-
    findall((Dist, Cam), caminho(Ini, Fim, Dist, Cam), TodosCaminhos),
    encontrar_menor_caminho(TodosCaminhos, MenorCam).

% Predicado para encontrar o menor caminho a partir de uma lista de caminhos.
encontrar_menor_caminho([(D1, C1)], (D1, C1)).
encontrar_menor_caminho([(D1, C1) | Resto], (D2, C2)) :-
    encontrar_menor_caminho(Resto, (D2, C2)),
    D1 < D2, !.
encontrar_menor_caminho([(_, _) | Resto], MenorCam) :-
    encontrar_menor_caminho(Resto, MenorCam).

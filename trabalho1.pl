% ler_arquivo(NomeArquivo): Tenta ler arquivo no caminho passado em NomeArquivo
% ler_arquivo(+NomeArquivo)
ler_arquivo(NomeArquivo):-
    % Abre o arquivo e armazena o fluxo (stream) do arquivo na variável Stream.
    open(NomeArquivo, read, Stream),

    % Lê cada linha que está na variável Stream e armazena em um vetor chamado Linhas.
    ler_linhas(Stream, Linhas),

    % Fecha o fluxo do arquivo.
    close(Stream),

    % Processa a lógica do trabalho pedido, fornecendo as linhas lidas do arquivo.
    processa_linhas(Linhas).

% ler_linhas(Stream, Lista): Se atingiu o final do arquivo, retorna uma lista vazia
% ler_linhas(+Stream, ?Lista)
ler_linhas(Stream, []):-
    at_end_of_stream(Stream).

% ler_linhas(Stream, Lista): Se não atingiu fim do arquivo, lê as linhas do arquivo e constrói uma lista de linhas
% ler_linhas(+Stream, ?Lista)
ler_linhas(Stream, [Linha | Resto]):-
    % Se não chegou no fim do arquivo, continua.
    \+ at_end_of_stream(Stream),

    % Lê uma linha do arquivo e coloca na variável Linha.
    read(Stream, Linha),

    % Pede para continuar lendo o arquivo e ir armazenando no resto da lista, pois a cabeça já tá ocupada (Linha).
    ler_linhas(Stream, Resto).

% processa_linhas(Lista): Printa cada elemento da lista
% processa_linhas(+Lista)
processa_linhas([]).
processa_linhas([Linha | Resto]):-
    % Printa a cabeça da lista.
    writeln(Linha),
    % Adiciona a cabeca da lista como predicado
    assertz(Linha),
    % Pede para processar o resto da lista.
    processa_linhas(Resto).

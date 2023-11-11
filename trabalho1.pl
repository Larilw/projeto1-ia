:-initialization(main).

% main: Fornece as primeiras intruções para fazer o programa funcionar.
main:-
    writeln('Bem-vindo ao calculador de rotas!'),
    writeln("Por favor, digite 'ler_arquivo('').' com o caminho absoluto do seu arquivo texto dentro das aspas simples dentro dos parenteses!").

% menu: Apresenta as quatro opções possíveis para conferir as melhores rotas referente ao grafo carregado.
menu:-
    writeln('-----MENU-----\n'),
    writeln("-> Se quiser ver todas as melhores rotas possiveis, escreva 'listar_menores_caminhos(X,Y).'"),
    writeln("-> Se quiser saber todas as melhores rotas que vao para um destino especifico, escreva 'listar_menores_caminhos(X,destino).'"),
    writeln("-> Se quiser saber todas as melhores rotas que saem de uma origem especifica, escreva 'listar_menores_caminhos(origem,Y).'"),
    writeln("-> Se quiser saber o menor caminho entre duas cidades presentes nas rotas, escreva 'listar_menores_caminhos(origem,destino).'"),
    writeln('\nLEMBRETE: Ao digitar os comandos, apenas substitua o(s) parametro(s) que possue(m) letra inicial minuscula pelo nome da(s) cidade(s) de seu interesse.').

% ler_arquivo(NomeArquivo): Tenta ler arquivo no caminho passado em NomeArquivo
% ler_arquivo(+NomeArquivo)
ler_arquivo(NomeArquivo):-
    open(NomeArquivo, read, Stream),
    writeln('\nSucesso ao abrir o arquivo! Lendo...\n'),
    ler_linhas(Stream, Linhas),
    close(Stream),
    processa_linhas(Linhas),
    menu.
    
% ler_linhas(Stream, Lista): Se atingiu o final do arquivo, retorna uma lista vazia.
% ler_linhas(+Stream, -Lista)
ler_linhas(Stream, []):-
    at_end_of_stream(Stream).

% ler_linhas(Stream, Lista): Se não atingiu fim do arquivo, lê as linhas do arquivo e constrói uma lista de linhas.
% ler_linhas(+Stream, -Lista)
ler_linhas(Stream, [Linha | Resto]):-
    % Se não chegou no fim do arquivo, continua.
    \+ at_end_of_stream(Stream),
    read(Stream, Linha),
    ler_linhas(Stream, Resto).

% processa_linhas(Lista): Adiciona cada elemento da lista como um predicado dinâmico.
% processa_linhas(+Lista)
processa_linhas([]).
processa_linhas([Linha | Resto]):-
    assertz(Linha),
    processa_linhas(Resto).

% esta_na_lista(X, Lista): Verifica se X está na lista.
% esta_na_lista(?X, +Lista)
esta_na_lista(X, [X | _]).
esta_na_lista(X, [_ | T]) :-
    esta_na_lista(X, T).

% caminho1(Ini, Lista, Custo, CustoF, CamF): Percorre o grafo montando do destino pra origem a lista de nós visitados e guardando o custo dessa rota.
% caminho1(?Ini, ?Lista, +Custo, -CustoF, -CamF)
caminho1(Cid, [Cid | Cids], Custo, Custo, [Cid | Cids]).
caminho1(Ini, [Adj | Cids], Custo, CustoF, CamF) :-
    % Escolhe no conjunto de fatos algum fato que encaixe o segundo argumento com Adj.
    rota(Interm, Adj, C1),
    % Verifica se a cidade Interm não foi visitada.
    \+ esta_na_lista(Interm, [Adj | Cids]),
    % Atualiza o custo da rota.
    C2 is Custo + C1,
    % Se chama recursivamente tendo agora Interm como a nova cabeça da lista e D2 com novo custo.
    caminho1(Ini, [Interm, Adj | Cids], C2, CustoF, CamF).

% caminho(Ini, Fim, Custo, Cam): Encontra um caminho entre duas cidades com lista de cidades visitadas.
% caminho(?Ini, ?Fim, -Custo, -Cam)
caminho(Ini, Fim, Custo, Cam) :-
    caminho1(Ini, [Fim], 0, Custo, Cam).

% menor_caminho(Ini, Fim, MenorCaminho): Calcula o menor caminho entre Ini e Fim.
% menor_caminho(?Ini, ?Fim, -MenorCaminho)
menor_caminho(Ini, Fim, MenorCaminho) :-
    % Pega todas as soluções encontradas pelo predicado caminho, que tem o custo e o caminho como saída, colocando-as em TodosCaminhos de forma ordenada.
    setof((Custo, Cam), caminho(Ini, Fim, Custo, Cam), TodosCaminhos),
    % Unifica MenorCaminho com a cabeça de TodosCaminhos.
    TodosCaminhos = [MenorCaminho | _].

% listar_menores_caminhos(Ini, Fim): Encontra e imprime todos os menores caminhos entre Ini e Fim.
% listar_menores_caminhos(+Ini, +Fim)
listar_menores_caminhos(Ini, Fim):-
    %Encontra todos os caminhos
    findall(MenorCaminho, menor_caminho(Ini,Fim,MenorCaminho), MenoresCaminhos),
    %Imprime os caminhos encontrados
    imprimir_caminhos(MenoresCaminhos).

% imprimir_caminhos(Caminhos): Imprime os caminhos no formato desejado, pulando caminhos com custo zero.
% imprimir_caminhos(+Caminhos)
imprimir_caminhos([]).
imprimir_caminhos([Caminho | Resto]) :-
    Caminho = (Custo, _),
    %Verifica se o custo do caminho e maior que 0 para imprimir
    Custo > 0,
    writeln(Caminho),
    imprimir_caminhos(Resto).
imprimir_caminhos([_|Resto]) :-
    imprimir_caminhos(Resto).
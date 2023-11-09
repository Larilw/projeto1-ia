# A proposta do projeto

Este trabalho se refere ao primeiro projeto proposto na disciplina de Inteligência Artificial do curso de Ciência da Computação, da Universidade do Oeste do Paraná (UNIOESTE), câmpus Foz do Iguaçu.

Dado um arquivo texto que siga o seguinte formato:
    % Formato do Arquivo de Dados
    % Existência de Rota Aérea entre Cidades
    % Simbologia:
    % A: cidade de partida
    % B: cidade de destino
    % Preço: custo da rota aérea, em reais, necessário para ir de A a B
    rota(A,B,Preço).

O presente projeto propõe que um programa escrito na linguagem Prolog seja capaz de receber um arquivo texto, como descrito acima, e determinar o trajeto mais econômico (menos caro) entre as cidades inicial e final do pacote. O sistema deve:
    • Indicar quais cidades o trajeto determinado irá passar por, incluindo cidade inicial e final do pacote;
    • Valor total: soma do preço (em reais) estimado para cada rota aérea que faz parte do trajeto determinado.

# Execução

O primeiro passo é rodar o arquivo fonte "trabalho1.pl", você pode faze-lo usando o atalho que sua IDE proporciona.

Após isso, é necessário chamar o predicado inicial do programa digitando `ler_arquivo('').`, lembre sempre de passar o caminho ABSOLUTO do arquivo texto que deseja que seja analisado dentro das aspas simples (ATENÇÃO: o caminho só será válido se as barras forem colocadas da seguinte forma /).
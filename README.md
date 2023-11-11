# A proposta do projeto

Este trabalho se refere ao primeiro projeto proposto na disciplina de Inteligência Artificial do curso de Ciência da Computação, da Universidade do Oeste do Paraná (UNIOESTE), câmpus Foz do Iguaçu.

Dado um arquivo texto que siga o seguinte formato:

    % Formato do Arquivo de Dados
    % Existência de Rota Aérea entre Cidades
    % Simbologia:
    %   A: cidade de partida
    %   B: cidade de destino
    %   Preço: custo da rota aérea, em reais, necessário para ir de A a B
    rota(A, B, Preço).

O presente projeto propõe que um programa escrito na linguagem Prolog seja capaz de receber um arquivo texto, como descrito acima, e determinar o trajeto mais econômico (menos caro), ou seja, a melhor rota, entre as cidades inicial e final do pacote. O sistema deve:
• Indicar quais cidades o trajeto determinado irá passar por, incluindo cidade inicial e final do pacote;
• Valor total: soma do preço (em reais) estimado para cada rota aérea que faz parte do trajeto determinado.

# Execução

O primeiro passo é rodar o arquivo fonte "trabalho1.pl", você pode fazê-lo usando o atalho que sua IDE proporciona. Como por exemplo, no SWI-Prolog você pode rodá-lo através do atalho "Consult".

É importante ressaltar que um programa escrito em Prolog te permite interagir com qualquer predicado presente no código, mas muitos deles são feitos para serem usados por outros predicados, não necessariamente para serem chamados diretamente pelo usuário, por isso, você receberá a orientação de quais predicados deve usar durante a execução, eles aparecerão entre aspas simples!

Imediatamente após rodar o programa, você receberá uma mensagem de boas vindas e a primeira instrução para conseguir executar o programa corretamente. Essa instrução indicará que é necessário chamar o predicado inicial do programa digitando `ler_arquivo('').` (ATENÇÃO: lembre sempre de passar o caminho ABSOLUTO do arquivo texto que deseja que seja analisado dentro das aspas simples e que o caminho só será válido se as barras forem colocadas da seguinte forma /).

São providos alguns arquivos de teste que estão localizados na pasta grafos, também é possível visualizar os grafos de teste nas imagens da pasta imagens-grafo.

Se você fornecer um caminho válido, conseguirá ver um menu de opções para interagir com o programa:

-> A primeira opção te indica digitar exatamente `listar_menores_caminhos(X,Y).`. Este predicado te fornecerá todas as melhores rotas possíveis entre cada uma das cidades presentes no arquivo de texto.

-> A segunda opção te indica digitar `listar_menores_caminhos(X,destino).`, substituindo somente `destino` por um nome de cidade presente no arquivo de texto. O predicado testará substituindo X por cada cidade presente no arquivo, assim, ele escolherá apenas a melhor rota em cada par de X e cidade destino. Observe que o predicado é o mesmo que o anterior, porém, agora o destino é fixo, apenas a cidade origem pode variar para que várias rotas sejam achadas.

-> A terceira opção te indica digitar `listar_menores_caminhos(origem,Y,MenorCaminho).`, substituindo somente `origem` por um nome de cidade presente no arquivo de texto. O predicado testará substituindo Y por cada cidade presente no arquivo, assim, ele escolherá apenas a melhor rota em cada par de cidade origem e Y. Observe que agora a origem é fixa e apenas as cidades destino variam para que várias rotas sejam achadas.

-> A quarta opção te indica digitar `listar_menores_caminhos(origem,destino,MenorCaminho).`, substituindo tanto `origem` quanto `destino` por nomes de cidades presente no arquivo texto. Neste caso, como tanto a cidade origem quanto a cidade destino são definidas por você, tudo que o programa fará será tentar achar a melhor rota entre essas duas cidades.

IMPORTANTE: Caso o usuário queira visualizar os caminhos serem retornados um por um pode ser utilizado o predicado `menor_caminho(X,Y,MenorCaminho).` da mesma forma que a descrita acima com o predicado `listar_menores_caminhos(X,Y,MenorCaminho).`, alterando X e Y conforme o desejo do usuário. Caso o usuário escolha utilizar o predicado `menor_caminho.` ao escrever o predicado e deve-se enter, e ir apertando a tecla `;` para que seja possível ver a melhor rota para todas as combinações possíveis! Se não fizer isso, apenas verá a primeira combinação e poderá achar que o algoritmo não funcionou, então cuidado! A única exceção a esse caso é o uso com origem e destino definidas, que retorna apenas um caminho.

# Autoras

Este projeto foi feito pelas alunas Larissa Wong e Victória Zaias.

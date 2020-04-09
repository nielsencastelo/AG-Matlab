% Função que gera uma população inicial aleatória
% Data: 05/01/2014
% Autor: Nielsen C. Damasceno
% Entrada:
%       a e b são os intervalos inteiros que representam os clusters
%       gene é a quantidade de tipos classes
%       tampop é o tamanho da população
% Saída:
%       x é a matriz da população (tam x gene)

function x = gera_populacao(a,b,tampop,gene)
    x = zeros(tampop,gene);
    for i = 1 : tampop
        for j = 1 : gene
            x(i,j) = round(a + (b-a).*rand);
        end
    end
end
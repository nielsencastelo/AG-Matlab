% Fun��o que gera uma popula��o inicial aleat�ria
% Data: 05/01/2014
% Autor: Nielsen C. Damasceno
% Entrada:
%       a e b s�o os intervalos inteiros que representam os clusters
%       gene � a quantidade de tipos classes
%       tampop � o tamanho da popula��o
% Sa�da:
%       x � a matriz da popula��o (tam x gene)

function x = gera_populacao(a,b,tampop,gene)
    x = zeros(tampop,gene);
    for i = 1 : tampop
        for j = 1 : gene
            x(i,j) = round(a + (b-a).*rand);
        end
    end
end
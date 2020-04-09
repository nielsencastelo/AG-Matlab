% A seguinte fun��o faz a sele��o de uma popula��o
%
% Entrada:  populacao � uma matriz(nxd)
%           tiposelec � o tipo de sele��o
%           fav � a fun��o de avalia��o do AG
%           melhor_cromossomo armazena o melhor individuo do AG
%           fontes � o n�mero de sinais de fontes
% Sa�da: 	Novapopulacao
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     05.01.2014
function novapopulacao = roleta(populacao,fav,melhor_cromossomo)

    npop = size(populacao,1);
    
   % verifica se tem um valor negativo na fun��o de avalia��o
         
            somafav = sum(fav);
            % Vetor das adaptabilidade relativa
            adr = zeros(npop,1);

            % Calculo das adaptabilidade relativas
            % a soma das adaptabilidade � igual a 1
            for i = 1:npop
                adr(i) = fav(i)/somafav;                    
            end

            % Processo de roleta
            roleta = zeros(npop,1);
            roleta(1) = adr(1);
            for i = 2:npop
                roleta(i) = roleta(i-1)+adr(i);
            end

            % Come�ando a selecionar os individuos da proxima populacao
            % Operador de Selecao - Metodo da Roleta
            % A probabilidade de ser "sorteado" � dos indiv�duos com maior
            % adequabilidade relativa
            selecionado = zeros(npop,1);
            for r = 1:npop
                bola    = rand(1);
                posicao = 1;
                flag    = 0;
                while(1)
                    if (bola <= roleta(posicao))
                        selecionado(r) = posicao;
                        flag = 1;
                    end
                    posicao = posicao + 1;
                    if (flag == 1) 
                        break;
                    end
                end
             end
            cjselecionado = hist(selecionado,npop);  % Em cada posicao do vetor o numero de vezes que o elemento foi selecionado
            indice = 1;
            for i = 1:npop
                if (cjselecionado(i) ~= 0)
                    nobt = cjselecionado(i);           % Numero de copias obtidas
                    for c = 1:nobt
                        novapopulacao(indice,:) = populacao(selecionado(i),:); % Elemento da nova populacao � igual ao elemento selecionado da 
                        indice = indice + 1;                                   % populacao anterior
                    end
                end
            end
    novapopulacao = populacao;
end
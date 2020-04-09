% Algoritmo Gen�tico aplicados a microagrega��o vers�o serial
% Data: 05/01/2014
% Autor: Nielsen C. Damasceno

clc; clear; close all;

% Cria as amostras
%N = 30;
%x = class9(N);
x = company();
g = 3;                   % Grupos de n� indiv�duos
gene = length(x);
tampop = 100;              % Tamanho da popula��o
n_geracao = 5;

populacao = gera_populacao(1,4,tampop,gene);
novapopulacao   = zeros(tampop,gene);
melhorpopulacao = zeros(tampop,gene);
fav  = zeros(tampop,1);                             % Vetor das funcaoes de adaptabilidade
prec = 0.8;                                         % percentual de recombina��o 80% da populacao
pmut = 0.01;                                        % percentual de muta��o de 1% da populacao
cromossomo_aux = zeros(1,gene);      % Para troca de partes do cromossomo no crossover
novosindividuo = zeros(tampop*0.2,gene);
melhor_cromossomo = zeros(1,gene);   % Para guardar o melhor individuo (elitismo)
melhoradp_ant = 0;
estagnacao  = 0;
variancia   = 1;
h           = zeros(n_geracao,1);
p           = zeros(tampop,1);
melhores    = zeros(n_geracao,1);
epoca       = 1;
tic;
sst = fSST(x);
while(1)
    % Condicao de parada para o numero de geracoes
    if (epoca == n_geracao)
        break; 
    end
    %Fun��o de avalia��o
    for i = 1 : size(populacao,1)
            solucao = populacao(i,:);
            solucao = organiza(solucao);
            [solucao] = vns(solucao,x,20,g);  % Chama VNS para resolver o subproblema
            solucao = organiza(solucao);
            sse = fSSE(x,solucao);
            loss = sse/sst; % Perda de informa��o
            fav(i) = loss;
    end
     %Seleciona-se o pior individuo da popula��o atual
     [pioradp piorindividuo] = max(fav);
     
     % Guarda o melhor individuo
     if (epoca ~= 1)
        melhoradp_ant = melhoradp;
     end
     
     %Seleciona-se o melhor indiv�duo da popula��o atual
     [melhoradp melhorindividuo] = min(fav);
     %Guarda-se a cada �poca(gera��o) qual foi o melhor indiv�duo 
     melhores(epoca)   = melhoradp;
     melhor_cromossomo = populacao(melhorindividuo,:);
     
     % Se os melhores indiv�duos come�am a aparecer (repetir) nas gera��es 
     % futuras, ent�o houve uma estagna��o da popula��o 
     if (melhoradp == melhoradp_ant)
            estagnacao = estagnacao + 1;
     end
     
     % Condicao de parada para o criterio de estagnacao da populacao
     if(estagnacao > n_geracao * 0.8)
        break;
     end
     
     % Come�ar a trabalhar aqui!
     novapopulacao = selecao(populacao,'roleta',fav, melhor_cromossomo, 1);
     novapopulacao = selecao(novapopulacao,'elitismo',fav, melhor_cromossomo, 1);
     novapopulacao = round(novapopulacao);
     novapopulacao = recombinacao(novapopulacao,prec);
     novapopulacao = mutacao(novapopulacao,pmut);
    
     populacao = novapopulacao;
    
     epoca = epoca + 1;
     
     fprintf('Iter AG: %d\n',epoca);
     fprintf('Loss %f\n',min(fav));
end
tempo = toc;
% Temos o melhor cromossomo vamos usar para achar o melhor y
[melhoradp, melhorindividuo]= min(fav);
solucao = populacao(melhorindividuo,:);
solucao = organiza(solucao);
% Apresenta resultados
clf;
maxClass = ver_classes(solucao); % Quantidade de classes
colors = rand(maxClass,3);
plota(x,solucao,colors);

centros = centroide(x,solucao);  % Encontra centroides
plotaCentroide(centros); % Visualizaa os centroides
fprintf('Tempo: %f\n',tempo);   
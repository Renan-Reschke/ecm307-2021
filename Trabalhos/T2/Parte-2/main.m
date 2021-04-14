%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Renan Scheidt Reschke
%%  RA: 19.02009-0
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  0 - Proposta 
%% 
%%  a. Cada aluno determina as frequências f0, f1 e f2 da sua própria gravação (3x) - cada vogal gera 9 valores => 45 valores no total
%%  b. Formar base de conhecimento Número de alunos x 45
%%  c. Histograma de cada vogal - média e o desvio padrão de cada frequência para cada vogal (espera-se distribuição gaussiana)
%%  d. Eliminar valores fora de contexto e verificar diferenças da base - Tratamento dos Outliers
%%  e. Gravar 5 vogais que não serão usadas na base (vogais_teste)
%%  f. 1 - Acertou e 0 - Errou -> a, e, i, o, u
%%  Ou seja, modelo de ML gera um vetor [1 1 0 0 1]: acertou /a/, /e/ e /u/ e errou /i/ e /o/
%%  g. Verificar qualidade do sistema de aprendizado para cada vogal
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Limpeza

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variaveis

fprintf('\nDesenvolvido por: Renan Scheidt Reschke\nRA: 19.02009-0\n\n');

%% Desabilita warnings
warning('off')

%% Inicializacao do programa
fprintf('Iniciando o programa...\n');
fprintf('Sinal analisado: a2.wav\n\n');
fprintf('Tipo: Discreto\n\n');
fprintf('Recuperando dados do sinal...\n');

%% Recuperacao de dados da amostra
[gk, fs] = audioread ('audio/a2.wav');          % transforma um arquivo .wav em um vetor g(k)
                                                % recupera a taxa de amostragem - fs
% Como o software usado pra gravação gravou em double channel, é preciso escolher um para analisar:                                                
gk = gk(:,1);                                   % Pega apenas um canal do audio
N       = length(gk);                           % numero de pontos do sinal em analise
Ts      = 1/fs;                                 % tempo de amostragem
ws      = 2*pi*fs;                              % frequencia anngular
duracao = N*Ts;                                 % Duracao do sinal
tempo   = linspace(0,duracao,N);                % vetor tempo computacional
fmax    = fs/2;                                 % frequencia maxima de amostragem
frequencia = linspace(-fmax,fmax,N);            % vetor de frequencias de Fourier
resolucao  = fs/N;                              % resolucao em frequencia

fprintf('Dados recuperados com sucesso!\n\n');
fprintf('Tempo de duracao do sinal: %.3fs\n', duracao);
fprintf('Frequencia do sinal: %dHz\n\n', fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 4 do T2
fprintf('Item 4: Analise temporal\n');
fprintf('\tSim, é possível observar uma periodicidade no sinal no domínio do tempo\n\tcomo pode ser observado na imagem "Figure 1".\n\n');

%% Visualizacao do sinal no dominio do tempo
fig1 = figure(1);
plot(tempo,gk,'k-')                   % configura plot(x,y, cor preta)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude
title('Sinal a2.wav amostrado')       % titulo
grid
%saveas(fig1,'plot-sons/a2.png')       % Salva o grafico como png


%% Serie discreta de Fourier
fprintf('Iniciando a Serie Discreta de Fourier (matricial)\n');

tic;
wn                = exp(-1i*2*pi/N);                  % Definindo wn
Matriz_jotas      = wn*ones(N, N);                    % Matriz NxN wn
Matriz_expoentes  = [0:1:N-1]'*[0:1:N-1];             % Expoentes de wn
Wn                = Matriz_jotas.^Matriz_expoentes;   % matriz wn^(expoentes)
Xn                = Wn*gk;                            % Calculo da matriz Xn

fprintf('Duracao da analise por produto matricial: ');toc;fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 5 do T2
fprintf('Item 5: Análise de Fourier\n');
fprintf('\tSim, é possível justificar a resposta do item 4 pois, como a Análise\n\tde Fourier demonstra na imagem "Figure 2", existem harmônicas presentes no sinal.\n\n');


%% Visualizacao do sinal no dominio da frequencia
fig2 = figure(2);
plot(frequencia,fftshift(log10(abs(Xn))),'k-');         % configura plot(x,y, cor preta)
hold;
formantes = identificar_formantes(frequencia, fftshift(log10(abs(Xn))));

xlabel('Frequencia em Hz')                              % tempo em segundos
ylabel('Amplitude')                                     % amplitude em volts
title('Espectro de amplitude de a2.wav')                % titulo
grid
%saveas(fig2,'plot-frequencias/freq_a2.png')             % Salva o grafico como png


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 6 do T2

%% Formantes da vogal /a/
[f0_a f1_a f2_a formante_sexo_a] = leitura_formantes('csv-formantes/formantes-a.csv');

%% Formantes da vogal /e/
[f0_e f1_e f2_e formante_sexo_e] = leitura_formantes('csv-formantes/formantes-e.csv');

%% Formantes da vogal /i/
[f0_i f1_i f2_i formante_sexo_i] = leitura_formantes('csv-formantes/formantes-i.csv');

%% Formantes da vogal /o/
[f0_o f1_o f2_o formante_sexo_o] = leitura_formantes('csv-formantes/formantes-o.csv');

%% Formantes da vogal /u/
[f0_u f1_u f2_u formante_sexo_u] = leitura_formantes('csv-formantes/formantes-u.csv');

%% Plot do gráfico bidimensional das formantes                                                    
fig3 = figure(3);
scatter_formantes(f1_a, f2_a, f1_e, f2_e, f1_i, f2_i, f1_o, f2_o, f1_u, f2_u);

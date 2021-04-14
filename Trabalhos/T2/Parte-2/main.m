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

%%Limpeza

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variaveis
disp('Limpando a tela...')

%%Desabilita warnings
disp('Desabilitando warnings')
warning('off')

%%Inicializacao do programa
disp('Iniciando o programa...')
fprintf('\nSinal analisado: a1.wav\n');
fprintf('\nTipo: Discreto\n');
fprintf('\nRecuperando dados do sinal\n');

%%Recuperacao de dados da amostra
[gk, fs] = audioread ('audio/a1.wav');          % transforma um arquivo .wav em um vetor g(k)
                                                % recupera a taxa de amostragem - fs
N       = length(gk);                           % numero de pontos do sinal em analise
Ts      = 1/fs;                                 % tempo de amostragem
ws      = 2*pi*fs;                              % frequencia anngular
duracao = N*Ts;                                 % Duracao do sinal
tempo   = linspace(0,duracao,N);                % vetor tempo computacional
fmax    = fs/2;                                 % frequencia maxima de amostragem
frequencia = linspace(-fmax,fmax,N);            % vetor de frequencias de Fourier
resolucao  = fs/N;                              % resolucao em frequencia
fprintf('Tempo de duracao: %.3fs\n', duracao);


%%% Utilizando produto Matricial%%%%%%%%%%%%
tic;
wn                = exp(-1i*2*pi/N);                  % Definindo wn
Matriz_jotas      = wn*ones(N, N);                    % Matriz NxN wn
Matriz_expoentes  = [0:1:N-1]'*[0:1:N-1];              
Wn                = Matriz_jotas.^Matriz_expoentes;   %
Xn                = Wn*gk;                            % Calculo da matriz Xn

fprintf('Duracao da analise por produto matricial: ');
toc;

%%%%%%%%%%%%%%%% Visualizacao do  Sinal Artificial %%%%%%%%%%%%%%%%%
fig1 = figure(1);

plot(tempo,gk,'k-')                   % configura plot(x,y, cor preta)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude
title('Sinal a1.wav amostrado')       % titulo
grid
saveas(fig1,'a1.png')                 % Salva o grafico como png

fig2 = figure(2);
plot(frequencia,fftshift(log10(abs(Xn))),'k-')          % configura plot(x,y, cor preta)
xlabel('Frequencia em Hz')                              % tempo em segundos
ylabel('Amplitude')                                     % amplitude em volts
title('Espectro de amplitude de a1.wav')                % titulo
grid
saveas(fig2,'freq_a1.png')                              % Salva o grafico como png
         
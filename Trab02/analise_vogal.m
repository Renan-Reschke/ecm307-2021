%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0 - Proposta 
%% 
%%  a. implementar a serie discreta
%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)
%%  b. visualizar graficamente
%%  c. interpretar o resultado
%%  d. comparar com tempo
%%
%%  Trabalho em Octave *.m
%%
%%  a. Analisar as cinco vogais: Xa, Xe, Xi, Xo, e Xu.
%%  b. Os tempos de execucao de cada vogal.
%%  c. O que voce observa de diferente em cada serie de Fourier.
%%  d. Voce conseguiria analisar no tempo?
%%  e. Como voce transformaria o "for" em produto matricial como foi feito na teoria?
%%  
%%  Entrega 23/03 ate 23:59 - individual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 19.02009-0 Renan Scheidt Reschke



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
fprintf('\nSinal analisado: a.wav\n');
fprintf('\nTipo: Discreto\n');
fprintf('\nRecuperando dados do sinal\n');

%%Recuperacao de dados da amostra
[gk, fs] = audioread ('a.wav');         % transforma um arquivo .wav em um vetor g(k)
                                        % recupera a taxa de amostragem - fs
N       = length(gk);                   % numero de pontos do sinal em analise
Ts      = 1/fs;                         % tempo de amostragem
ws      = 2*pi*fs;                      % frequencia anngular
duracao = N*Ts;                         % Duracao do sinal
tempo   = linspace(0,duracao,N);        % vetor tempo computacional
fmax    = fs/2;                         % frequencia maxima de amostragem
frequencia = linspace(-fmax,fmax,N);    % vetor de frequencias de Fourier
resolucao  = fs/N;                      % resolucao em frequencia
fprintf('Tempo de duracao: %.3fs\n', duracao);

%%Comparacao do uso de for e produto matricial
fprintf('Calculando tempo de execução do algoritmo ...')
tic;                                     % inicia um contador
for n = 0 : N-1                          % N pontos    
  aux_k = 0;                             % inicia com zero
  for k = 0 :  N-1                       % N pontos - somatoria_{k=0}^{N-1}            
    aux_k = aux_k + gk(k+1)*exp(-1i*n*k*2*pi/N);           
  end            
  Xn(n+1) = aux_k/N;                     % valor final para n fixo - Fourier        
end 
Xn  = fftshift(Xn);  
fprintf('\nDuracao da analise por for: ');
toc;                                    % estima o tempo de duracao do for


%%% Utilizando produto Matricial - Desenvolvido por Guilherme Samuel%%%%%%%%%%%%
tic;
wn                = exp(-1i*2*pi/N);                  % Definindo wn
Matriz_jotas      = wn*ones(N, N);                    % Matriz NxN wn

% É criado um vetor que varia de 0 até N-1, obtém-se sua 
% transposta e multiplica o resultado final pelo vetor original.
% O que resulta na Matriz_expoentes, que será do tipo:
% 0 0 0 0 ... 0
% 0 1 2 3 ... {N-1}
% 0 2 4 6 ... {2(N-1)}
% 0 3 6 9 ... {3(N-1)}
Matriz_expoentes  = [0:1:N-1]'*[0:1:N-1];              

% A Matriz_fourier é obtida elevando cada elemento da Matriz_jotas por cada
% elemento da Matriz_expoentes
% A Matriz_fourier será do tipo:
% 1   1           1            1        ...    1
% 1 wn^1         wn^2         wn^3      ...   wn^{N-1}
% 1 wn^2         wn^4         wn^6      ...   wn^{2(N-1)}
% 1 wn^3         wn^6         wn^9      ...   wn^{3(N-1)}
% ?   ?          ?            ?         ?      ?
% 1 wn^{N-1}  wn^{2(N-1}}  wn^{3(N-1}}  ...   wn^{(N-1)(N-1)}
Matriz_fourier    = Matriz_jotas.^Matriz_expoentes;   %

Xf = Matriz_fourier*gk;

fprintf('\nDuracao da analise por produto matricial: ');
toc;

%%%%%%%%%%%%%%%% Visualizacao do  Sinal Artificial %%%%%%%%%%%%%%%%%
fig1 = figure(1);

subplot(2,1,1)
plot(tempo,gk,'k-')                   % configura plot(x,y, cor preta)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude
title('Sinal a.wav amostrado')        % titulo
grid

subplot(2,1,2)
stem(frequencia,abs(Xn),'k-')         % configura plot(x,y, cor preta)
xlabel('Frequencia em Hz')            % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Espectro de amplitude')        % titulo
grid
saveas(fig1,'analise_a.png')          %Salva os graficos como png
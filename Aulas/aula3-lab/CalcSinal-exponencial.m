%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Prepara��o do c�digo 
%% 
%% Boas pr�ticas: limpeza de vari�veis; vari�veis globais
%% Constantes; carregar bibliotecas;...
%%
%%% Limpeza

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as vari�veis

%%% Carregar bibliotecas

pkg load symbolic;  % biblioteca simb�lica


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Problema
%%
%% aproximar uma onda quadrada por um sinal
%% harm�nico - g(t) = c. cos(t) + erro
%% 
%% Definir a onda quadrada

Ap = +1;    % amplitude positiva de g(t)
An = 0 ;    % amplitude negativa de g(t)
To = 2*pi ; % per�odo da onda quadrada
to = -pi/2; % instante inicial de g(t)

%%% Par�metros calculados

fo = 1/To;    % frequ�ncia da onda quadrada
wo = 2*pi*fo; % frequ�ncia angular de g(t)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3 - calcular o valor de c
%% 
%%  Ambiente de c�lculo integral e simb�lico
%%  
%%  Symbolic pkg v2.9.0: 
%%  Python communication link active, SymPy v1.5.1.
%%

syms n t  % t - tempo vari�vel simb�lica

%%% determinando o termo da s�rie exponencial

Ip    = int(Ap*exp(-j*n*wo*t),t,to,to+To/2);
In    = int(An*exp(-j*n*wo*t),t,to+To/2,to+To);
Inum  = Ip + In; 

Dn = Inum/To;       % determina o os termos da s�rie

%%% determinando o valor m�dio do sinal - D0

Ip    = int(Ap,t,to,to+To/2);
In    = int(An,t,to+To/2,to+To);
Inum  = Ip + In; 

D0    = Inum/To;       % determina o valor m�dio


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 -  Substituindo os valores de n

N  = 10;              % n�mero de harm�nicas
n  = [-N:1:N];        % �ndice de harm�nicas

%%%%%% eixo frequencia

frequencia = n*fo;    % multipla inteira da frequ�ncia fundamental

Dn      = eval(Dn);   % determinar os valores de Dn para cada n
D0      = eval(D0);   % determina D0 numericamente
Dn(N+1) = D0;         % substitui o NaN referente a indetermina��o

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  5 -  S�ntese de Fourier
%%
%%
%%  g(t) =  sum_{n=-N}^{N} Dn * exp(j n wo t)

gt    = 0;                    % valor inicial de g(t) - nulo
M     = 1000;                 % N�mero de pontos do sinal (resolu��o)
tempo = linspace(-To,To,M);   % vetor linear de tempo

for k = 1 : 2*N+1             % Tenho agora 2*N pontos mais o zero
  
  gt = gt + Dn(k) * exp(+j*n(k)*wo*tempo);
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  6 -  Visualiza��o
%%
%%

figure(1)

plot(tempo,gt,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(t) sinteizado')        % t�tulo
grid

figure(2)

stem(frequencia,Dn,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequ�ncia em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % t�tulo
grid

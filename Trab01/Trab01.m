%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Preparação do código 
%% 
%% Boas práticas: limpeza de variáveis; variáveis globais
%% Constantes; carregar bibliotecas;...
%%
%%% Limpeza
display('1 - Preparação do código ')

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variáveis

%%% Carregar bibliotecas

pkg load symbolic;  % biblioteca simbólica


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  2 - calcular o valor de Dn
%% 
%%  Ambiente de cálculo integral e simbólico
%%  
%%  Symbolic pkg v2.9.0: 
%%  Python communication link active, SymPy v1.5.1.
%%
%%  g(t) = exp(-t)
%%  Dn = 1/To int_0^To g(t) exp(-j n wo t) dt
%%

display('2 - calcular o valor de Dn')
syms n wo to To t  % t - tempo variável simbólica

%%% numerador de Dn

Inum    = int(exp(-(1+j*n*wo)*t),t,to,to+To);

%%% determinando Dn

Dn = Inum/To;     % da teoria - Denominador = To


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Problema
%%
%% Um sinal periodico g(t) e definido pela eq 2 no intervalo 0 <= t <= 1 que
%% representa exatamente a eq de um per?odo deste sinal que equivale a T0 = 1s.
%% 
%% Definir a onda quadrada
display('3 - Definindo valores numericos de g(t)')

To = 1;  % período da onda quadrada
to = 0; % instante inicial de g(t)

%%% Parâmetros calculados

fo = 1/To;    % frequência da onda quadrada
wo = 2*pi*fo; % frequência angular de g(t)

%%% Funcao teorica g(t)

gtTeo = @(t) exp(-t);    % cria g(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - Determinando numericamente os valores
M = 1000;
Ts = To/M;
tempo = [0:Ts:To];

N = 10;
n = [-N:1:N];
DnNum = eval(Dn);

%%% Sintetizando o sinal
sinal = 0;
for k = 0 : 2*N
  sinal += DnNum(k+1)*exp(j*n(k+1)*wo*tempo);
end

%%% Determinar g(t)
gt = gtTeo(tempo);

%%% Determinar erro r1 entre sinal e gt

r1 = gt - sinal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5 - Visualizar r1 (verde), sinal (azul) e gt (preto)
figure(1)

plot(tempo,gt,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
hold;
plot(tempo,sinal,'b-','linewidth',3)
plot(tempo,r1,'g-','linewidth',3)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(t) sinteizado')        % título
grid



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - Sintetizando o sinal




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0 - Problema
%
% decomposição de um sinal g(t) em sinais harmônicos
%
% g(t) = sum_{n=1}^N cn xn(t) --> cn
%
% 1. Integral simbólica - variável t:tempo e n:frequência
% 2. Substituição de valores de n
% 3. Visualização dos resultados
% 4. Sintetizar a função g(t) - somatória (?)
% 5. Validação: o resultado faz sentido?
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Boas práticas

clear all;  % limpa todas as variáveis
close all;  % limpa todas as figuras
clc;        % limpa visualmente a tela

%% Bibliotecas

pkg load symbolic; % carrega o pacote simbólico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - definit g(t)
%
% onda quadrada - segmentos

To = 2*pi;      % período da onda quadrada
to = -pi/2;     % tempo inicial de g(t)
tau = pi;       % duração do nível alto de g(t)
th = to + tau;  % tempo que termina o nível alto de g(t)
tl = to + To;   % tempo que termina o nível baixo de g(t)

Ah = +1;        % amplitude em nível alto
Al = -1;        % amplitude em nível baixo

%% determinar parâmetros

fo = 1/To;      % determinando a frequência de g(t)
wo = 2*pi*fo;   % determinando a frequência angular


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Cálculo do cn - analisador
%
% Integral simbólica - t: tempo e n:frequência
%
% Symbolic pkg v2.9.0: 
% Python communication link active, SymPy v1.4.

syms t n

%% Determinando o numerador
%
% int_to^th g(t)x(t) dt + int_th^tl g(t)x(t) dt

Ipos = int(+1*cos(n*t), t, to, th);
Ineg = int(-1*cos(n*t), t, th, tl);

Inum = Ipos + Ineg;

%% Determinando o denominador

Iden = int(cos(n*t)*cos(n*t), t, 0, To);

%% Determinando o cn

cn = Inum/Iden;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 -

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5 - Substituição dos valores de n

% n = [1,2,3,4,5,6,7,8,9,10];

N = 10;                    % número de termos da decomposição
n = [1:1:N];               % geração do vetor n

cnNumerico = eval(cn);     % determina cn numericamente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6 - Visualização do resultado

figure()
stem(n, cnNumerico, 'linewidth', 2);  % plot de valores discretos
xlabel('valores de n');               % label x
ylabel('valores de cn');              % label y
title('Decomposição de g(t)');        % título do gráfico
grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7 - Sintetizador
%
% g(t) = c1 cos(t) + 0 cos(2t) + c3 cos(3t) + 0 cos(4t) + ... 
%
% g(t) --> cn: [c1 0 c3 0 c5 0 c7 0 c9 0] - análise
% cn: [c1 0 c3 0 c5 0 c7 0 c9 0] --> g(t) - síntese

M     = 1000;                 % sample rate - pontos
tempo = linspace(-To,To,M);   % vetor linear

g = cnNumerico(1)*cos(tempo);     % primeira harmônica

figure()
plot(tempo, g, 'linewidth', 2);  % plot de valores continuos (interpolar)
xlabel('valores de n');          % label x
ylabel('valores de cn');         % label y
title('Decomposição de g(t)');   % título do gráfico
grid;

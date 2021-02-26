%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0 - Problema
%
% decomposi��o de um sinal g(t) em sinais harm�nicos
%
% g(t) = sum_{n=1}^N cn xn(t) --> cn
%
% 1. Integral simb�lica - vari�vel t:tempo e n:frequ�ncia
% 2. Substitui��o de valores de n
% 3. Visualiza��o dos resultados
% 4. Sintetizar a fun��o g(t) - somat�ria (?)
% 5. Valida��o: o resultado faz sentido?
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Boas pr�ticas

clear all;  % limpa todas as vari�veis
close all;  % limpa todas as figuras
clc;        % limpa visualmente a tela

%% Bibliotecas

pkg load symbolic; % carrega o pacote simb�lico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - definit g(t)
%
% onda quadrada - segmentos

To = 2*pi;      % per�odo da onda quadrada
to = -pi/2;     % tempo inicial de g(t)
tau = pi;       % dura��o do n�vel alto de g(t)
th = to + tau;  % tempo que termina o n�vel alto de g(t)
tl = to + To;   % tempo que termina o n�vel baixo de g(t)

Ah = +1;        % amplitude em n�vel alto
Al = -1;        % amplitude em n�vel baixo

%% determinar par�metros

fo = 1/To;      % determinando a frequ�ncia de g(t)
wo = 2*pi*fo;   % determinando a frequ�ncia angular


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - C�lculo do cn - analisador
%
% Integral simb�lica - t: tempo e n:frequ�ncia
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
%% 5 - Substitui��o dos valores de n

% n = [1,2,3,4,5,6,7,8,9,10];

N = 10;                    % n�mero de termos da decomposi��o
n = [1:1:N];               % gera��o do vetor n

cnNumerico = eval(cn);     % determina cn numericamente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6 - Visualiza��o do resultado

figure()
stem(n, cnNumerico, 'linewidth', 2);  % plot de valores discretos
xlabel('valores de n');               % label x
ylabel('valores de cn');              % label y
title('Decomposi��o de g(t)');        % t�tulo do gr�fico
grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7 - Sintetizador
%
% g(t) = c1 cos(t) + 0 cos(2t) + c3 cos(3t) + 0 cos(4t) + ... 
%
% g(t) --> cn: [c1 0 c3 0 c5 0 c7 0 c9 0] - an�lise
% cn: [c1 0 c3 0 c5 0 c7 0 c9 0] --> g(t) - s�ntese

M     = 1000;                 % sample rate - pontos
tempo = linspace(-To,To,M);   % vetor linear

g = cnNumerico(1)*cos(tempo);     % primeira harm�nica

figure()
plot(tempo, g, 'linewidth', 2);  % plot de valores continuos (interpolar)
xlabel('valores de n');          % label x
ylabel('valores de cn');         % label y
title('Decomposi��o de g(t)');   % t�tulo do gr�fico
grid;

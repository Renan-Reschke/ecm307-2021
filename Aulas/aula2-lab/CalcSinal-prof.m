%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 0 - Problema
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 1 - Boas pr�ticas

clear all;         % limpa as vari�veis(todas)
close all;         % limpo todas as figuras
clc;               % limpa visualmente a tela

%%% Bibliotecas

pkg load symbolic; % carrega o pacote simb�lico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 2 - definir g(t)
%
% onda quadrada - segmentos

To  = 2*pi;      % per�odo da onda quadrada
to  = -pi/2;     % tempo inicial de g(t)


tau = To/2;      % dura��o do n�vel alto de g(t)
th  = to + tau;  % tempo que termina o n�vel alto de g(t)
tl  = to + To;   % tempo que termina o n�vel baixo de g(t)

Ah  = +1;        % amplitude em n�vel alto
Al  = -1;        % amplitude em n�vel baixo

%%% Determinando par�metros

fo  = 1/To;      % determinando a frequ�ncia de g(t)
wo  = 2*pi*fo;   % determinando a frequ�ncia angular


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 3 - C�lculo do c
%
% Integral simb�lica - t
%
% Symbolic pkg v2.9.0 
% Python communication link active, SymPy v1.5.1.
%

syms t

%%% Determinando o numerador
%
%  int_to^th g(t)x(t) dt + int_th^tl g(t)x(t) dt

Ipos = int(+1*cos(t),t,to,th);
Ineg = int(-1*cos(t),t,th,tl);

Inum = Ipos + Ineg;

%%% Determinando o denominador

Iden = int(cos(t)*cos(t),t,0,To);

%%% Determinar o c

c   = Inum/Iden;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 3 - C�lculo do cn - analisador
%
% Integral simb�lica - t:tempo e n:frequ�ncia
%
% Symbolic pkg v2.9.0 
% Python communication link active, SymPy v1.5.1.
%

syms n t

%%% Determinando o numerador
%
%  int_to^th g(t)x(t) dt + int_th^tl g(t)x(t) dt

Ipos = int(+1*cos(n*t),t,to,th);
Ineg = int(-1*cos(n*t),t,th,tl);

Inum = Ipos + Ineg;

%%% Determinando o denominador

Iden = int(cos(n*t)*cos(n*t),t,0,To);

%%% Determinar o c

cn   = Inum/Iden;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 5 - Substitui��o dos valores de n

% n = [1,2,3,4,5,6,7,8,9,10];

N   = 100;              % n�mero de termos da decomposi��o
n   = [1:1:N];          % gera��o do vetor n

cnNumerico = eval(cn);  % determina cn numericamente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 6 - Visualizando o resultado

figure()

stem(n,cnNumerico,'linewidth',2);             % plot de valores discretos
xlabel('valores de n');         % label eixo x   
ylabel('Valores de cn');        % label eixo y
title('Decomposi��o de g(t)');  % t�tulo do gr�fico
grid;                           % gride

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 7 - Sintetizador
%
% g(t) = c1 cos(t) + 0 cos(2t) + c3 cos(3t) + 0 cos(4t) +...
% 
% g(t) --> cn: [c1 0 c3 0 c5 0 c7 0 c9 0] - an�lise
%
% cn: [c1 0 c3 0 c5 0 c7 0 c9 0] --> g(t) - s�ntese

M     = 1000;                       % sample rate - pontos
tempo = linspace(-To,To,M);         % vetor linear

g = cnNumerico(1)*cos(tempo);             % primeira harm�nica
g = g + cnNumerico(2)*cos(2*tempo);       % segunda harm�nica
g = g + cnNumerico(3)*cos(3*tempo);       % terceira harm�nica
g = g + cnNumerico(4)*cos(4*tempo);       % quarta harm�nica
g = g + cnNumerico(5)*cos(5*tempo);       % quinta harm�nica
g = g + cnNumerico(6)*cos(6*tempo);       % sexta harm�nica
g = g + cnNumerico(7)*cos(7*tempo);       % s�tima harm�nica
g = g + cnNumerico(8)*cos(8*tempo);       % oitava harm�nica
g = g + cnNumerico(9)*cos(9*tempo);       % nona harm�nica
g = g + cnNumerico(10)*cos(10*tempo);     % d�cima harm�nica

figure()

plot(tempo,g,'linewidth',2);    % plot de valores continuos (interpolar)
xlabel('tempo');                % label eixo x   
ylabel('amoplitude');           % label eixo y
title('Sintese de g(t)');       % t�tulo do gr�fico
grid;  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 8 - Sintetizador usando for

g1 = cnNumerico(1)*cos(tempo);    % primeira harm�nica
                                  % incia a vari�vel g1                         
                                  
for k = 2 : N
  
  g1 = g1 + cnNumerico(k)*cos(k*tempo);
  
end

figure()

plot(tempo,g1,'linewidth',2,'k-');   % plot de valores continuos (interpolar)
xlabel('tempo');                     % label eixo x   
ylabel('amoplitude');                % label eixo y
title('Sintese de g(t)');            % t�tulo do gr�fico
grid;
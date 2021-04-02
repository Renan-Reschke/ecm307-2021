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
%%  2 - calcular o valor de Dn
%% 
%%  Ambiente de c�lculo integral e simb�lico
%%  
%%  Symbolic pkg v2.9.0: 
%%  Python communication link active, SymPy v1.5.1.
%%
%%  g(t) = exp(-t)
%%  Dn = 1/To int_0^To g(t) exp(-j n wo t) dt
%%

  syms n wo to To t  % t - tempo vari�vel simb�lica

% Numerador de Dn
  Inum = int(exp(-(1+j*n*wo)*t),t,to,to+To); % integral de g(t)*gn(t)dt

%%% determinando Dn

  Dn = Inum/To;     % da teoria - Denominador = To


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Problema
%%
%% Um sinal periodico g(t) e definido pela eq 2 no intervalo 0 <= t <= 1 que
%% representa exatamente a eq de um per?odo deste sinal que equivale a T0 = 1s.
%% 
%%

  To = 1; % per�odo da onda
  to = 0; % instante inicial de g(t)

%%% Par�metros calculados

  fo = 1/To;    % frequ�ncia da onda quadrada
  wo = 2*pi*fo; % frequ�ncia angular de g(t)

%%% Funcao teorica g(t)
  gtTeo = @(t) exp(-t);    % cria g(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - Determinando numericamente os valores
  M = 1000;
  Ts = To/M;
  tempo = [to:Ts:To];
  %%% Determinar g(t)
  gt = gtTeo(tempo);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3 - c1, c-1, p1 e r1
  n = [-1 +1];
  DnNum = eval(Dn);
  
  %%% Sintetizando p1
  p1 = DnNum(1)*exp(j*n(1)*wo*tempo) + DnNum(2)*exp(j*n(2)*wo*tempo);
    
  %%% Determinar erro r1 entre sinal e gt
  r1 = gt - p1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 4 - c1, c-1, p1 e r1
  n = [-2 -1 1 2];
  DnNum = eval(Dn);
  
  %%% Sintetizando o sinal
  p2 = 0;
  for k = 0 : (length(n)-1)
    p2 += DnNum(k+1)*exp(j*n(k+1)*wo*tempo);
  end
    
  %%% Determinar erro r1 entre sinal e gt
  r2 = gt - p2;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 5 - c1, c-1, p1 e r1
  n = [1:1:100];
  DnNum = eval(Dn);
  
  %%% Sintetizando o sinal
  pn = 0;
  for k = 0 : (length(n)-1)
    pn += DnNum(k+1)*exp(j*n(k+1)*wo*tempo) + DnNum(k+1)*exp(j*(-n(k+1))*wo*tempo);
  end
    
  %%% Determinar erro r1 entre sinal e gt
  rn = gt - pn;
  
  
  
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualiza��o dos t�picos 3,4 e 5  
  figure(1)
  subplot(3,1,1);
  plot(tempo,gt,'k-','linewidth',3)     % g(t)
  hold;
  plot(tempo,p1,'b-','linewidth',3)     % sinal sintetizado
  plot(tempo,r1,'r-','linewidth',3)     % residuo
  xlabel('Tempo em segundos')           % tempo em segundos
  ylabel('Amplitude em volts')          % amplitude em volts
  title('T�pico 3')                     % t�tulo
  grid
  legend('g(t)','p1','r1')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  subplot(3,1,2);
  plot(tempo,gt,'k-','linewidth',3);    % g(t)
  hold;
  plot(tempo,p2,'b-','linewidth',3);    % sinal sintetizado
  plot(tempo,r2,'r-','linewidth',3);    % residuo
  xlabel('Tempo em segundos');          % tempo em segundos
  ylabel('Amplitude em volts');         % amplitude em volts
  title('T�pico 4');                    % t�tulo
  grid;
  legend('g(t)','p2','r2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  subplot(3,1,3);
  plot(tempo,gt,'k-','linewidth',3)     % g(t)
  hold;
  plot(tempo,pn,'b-','linewidth',3)     % sinal sintetizado
  plot(tempo,rn,'r-','linewidth',3)     % residuo
  xlabel('Tempo em segundos')           % tempo em segundos
  ylabel('Amplitude em volts')          % amplitude em volts
  title('T�pico 5 (n = 100)')           % t�tulo
  grid
  legend('g(t)','p100','r100')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

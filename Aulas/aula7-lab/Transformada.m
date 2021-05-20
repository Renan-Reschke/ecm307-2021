%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0 - Boas práticas
%% 
%% Dicas para a segunda parte do trabalho T2
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
close all;
warning('off');

%%% pacote simbólico

pkg load symbolic;                                    % Somente para os que usam 
                                                      % Octave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - criando os sinais
%% 
%% g(t)  -  triangular
%% g1(t) -  derivada de g(t)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
%%% criando g(t)

To    = 100;                % período de 100 segundos
gp    = @(t) 2*t+1;         % reta ascendente
gn    = @(t) -2*t+1;        % reta descendente
ti    = -0.5;               % instante inicial
tf    = +0.5;               % instante final

%%% criando g1(t)

g1p    = @(t) 2;         % constante positiva
g1n    = @(t) -2;        % constante negativa
 
%%% Valores calculados para o primeio pulso

 fo   = inv(To);            % frequência em Hz --> fo  = 0.01Hz
                            % frequência fundamental - resolução
 wo   = 2*pi*fo;            % frequência angular
 
 %%% fmax depende da aplicação
 
 fmax = 10;                 % frequência máxima de Fourier
 N    = fmax/fo;            % Número de harmônicas da análise
                            % -10Hz --> 10Hz - escolha

%%% Vetor tempo para visualização do sinal
%%% diferente da variável simbólica t
%%% para efeito de organização da solução
%%% existem outros caminhos

 M     = 1000;
 Ts    = To/M;
 tempo = [-To/10:Ts:To/10];      % Tempo de simulação de um período do sinal g(t)
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Determinando Fourier
%% 
%% Dn  -  triangular
%% Dn1 -  derivada de g(t)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


syms n t

%%% Fourier da triangular

Dn = inv(To)*int(gp*exp(-j*n*wo*t),t,ti,0) + inv(To)*int(gn*exp(-j*n*wo*t),t,0,tf);
D_o = inv(To)*int(gp,t,ti,0) + inv(To)*int(gn,t,0,tf);

%%% Fourier da derivada

Dn1 = inv(To)*int(g1p*exp(-j*n*wo*t),t,ti,0) + inv(To)*int(g1n*exp(-j*n*wo*t),t,0,tf);
D_o1 = inv(To)*int(g1p,t,ti,0) + inv(To)*int(g1n,t,0,tf);


%%% Determinando o termo Dn numericamente

 n    = [-N:1:N];           % índice de cada harmônica
 f    = n*fo;               % vetor de frequências da análise de Fourier

%%% Triangular

Dn = eval(Dn);
display('passou.................')
D_o = eval(D_o);% Corrigindo o valor médio (NaN devido a indeterminação)
Dn(N+1) = D_o;% Subistituindo no vetor de respostas

%%% Derivada
 
Dn1 = eval(Dn1);
D_o1 = eval(D_o1);     % Corrigindo o valor médio (NaN devido a indeterminação)
Dn1(N+1) = D_o1;       % Subistituindo no vetor de respostas
display('passou.................')

%% Visualizando o espectro de Amplitude
 
fig1 = figure(1) 

subplot(2,1,1);plot(f,abs(Dn),'ko'); 
title('Serie de Fourier do sinal g(t) -- To = 100s');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')

subplot(2,1,2);plot(f,abs(Dn1),'ko'); 
title('Serie de Fourier da derivada de g(t) -- To = 100s');
xlabel('Frequencia em Hz');
ylabel('Amplitude em  volts')
saveas(fig1,'Serie de Fourier da derivada de g(t).png');
display('passou.................')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Sintese de Fourier
%% 
%% gs  -  triangular
%% gs1 -  derivada de g(t)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n=[-N:1:N];

aux  = 0;    
aux1  = 0;         

for k = 0 : 2*N     
  
  aux  = aux  + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
  aux1 = aux1 + Dn1(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

%%% sinais sintetizados

gs  = aux;
gs1 = aux1;


fig2 = figure(2)

subplot(2,1,1); plot(tempo,gs); 
title('Sintese de Fourier do sinal g(t)');
xlabel('Tempo em segundos');
ylabel('Amplitude em  volts');
subplot(2,1,2); plot(tempo,gs1);
title('Sintese de Fourier da derivada de g(t)');
xlabel('tempo em segundos');
ylabel('Amplitude em  volts');
saveas(fig2,'Sintese de Fourier da derivada de g(t).png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - ganho do sistema
%% 
%%  H1 = Dn1/Dn
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig3 = figure(3) 

plot(f,abs(Dn1./Dn),'ko'); 
title('Ganho do sistema de derivada');
xlabel('Frequencia em Hz');
ylabel('Ganho do sistema de derivada');
saveas(fig3,'Ganho do sistema de derivada.png');

fig4 = figure(4) 

plot(f,abs(j*2*pi*f.*Dn1),'ko'); 
title('Ganho do sistema de derivada');
xlabel('Frequencia em Hz');
ylabel('Ganho do sistema de derivada');
saveas(fig4,'Ganho do sistema de derivada1.png');
tac;
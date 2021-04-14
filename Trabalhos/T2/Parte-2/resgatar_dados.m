function [gk N Ts ws duracao tempo fmax frequencia resolucao] = resgatar_dados (gk, fs)
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
endfunction
%
%
%
%     Função que recupera os dados de um áudio
%
%
%     Parâmetros: 
%         gk - vetor de um áudio (ESTÉREO)
%         fs - frequência do áudio
%
%     Retorno:
%         gk          = Pega apenas um canal do audio
%         N           = numero de pontos do sinal em analise
%         Ts          = tempo de amostragem
%         ws          = frequencia anngular
%         duracao     = Duracao do sinal
%         tempo       = vetor tempo computacional
%         fmax        = frequencia maxima de amostragem
%         frequencia  = vetor de frequencias de Fourier
%         resolucao   = resolucao em frequencia
%
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
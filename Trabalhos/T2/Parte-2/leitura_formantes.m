%
%
%
%     Função que recupera os dados de formantes de uma planilha csv
%
%
%
function [f0 f1 f2 formante_sexo] = formantes(arquivo)
  leitura       = csvread(arquivo);   % Faz leitura do csv com as formantes da vogal
  f0            = leitura(:,1);       % Cria um vetor com f0
  f1            = leitura(:,2);       % Cria um vetor com f1
  f2            = leitura(:,3);       % Cria um vetor com f2
  formante_sexo = leitura(:,4);       % Cria um vetor com o sexo da pessoa que realizou a gravação
                                      % 1 - Homem; 2 - Mulher
endfunction
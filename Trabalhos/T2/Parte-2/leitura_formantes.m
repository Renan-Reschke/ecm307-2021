%
%
%
%     Fun��o que recupera os dados de formantes de uma planilha csv
%
%
%     Par�metros: 
%         arquivo - arquivo .csv de dados
%
%     Retorno:
%         f0            - vetor de formantes f0
%         f1            - vetor de formantes f1
%         f2            - vetor de formantes f2
%         formante_sexo - vetor de sexo de quem realizou a grava��o
%
function [f0 f1 f2 formante_sexo] = formantes(arquivo)
  leitura       = csvread(arquivo);   % Faz leitura do csv com as formantes da vogal
  f0            = leitura(:,1);       % Cria um vetor com f0
  f1            = leitura(:,2);       % Cria um vetor com f1
  f2            = leitura(:,3);       % Cria um vetor com f2
  formante_sexo = leitura(:,4);       % Cria um vetor com o sexo da pessoa que realizou a grava��o
                                      % 1 - Homem; 2 - Mulher
endfunction
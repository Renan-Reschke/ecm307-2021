%
%
%
%   Função para exibir se o áudio da vogal testada bate com a vogal esperada
%
%
%   Parâmetros: -
%
function acertou(elemento)
  if elemento == 1
    fprintf('Acertou!\n')
  else
    fprintf('Errou.\n')
  endif
endfunction
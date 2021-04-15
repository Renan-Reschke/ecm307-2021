%
%
%
%     Função que exibe as formantes no console
%
%
%     Parâmetros: 
%         formantes - vetor de formantes
%
%     Retorno:
%         -
%
function print_formantes(formantes)
  fprintf('Formantes (aproximadas): [');
  for k=1:length(formantes)
    fprintf(' %.1f ', formantes(k));
  endfor
  fprintf(']\n');
endfunction
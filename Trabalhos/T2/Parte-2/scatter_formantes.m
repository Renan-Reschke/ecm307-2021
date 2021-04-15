%
%
%
%     Função que plota uma scatter de formantes de todas as vogais
%
%
%     Parâmetros:
%         f1_a - vetor de formantes f1 de /a/
%         f2_a - vetor de formantes f2 de /a/
%         f1_a - vetor de formantes f1 de /e/
%         f2_a - vetor de formantes f2 de /e/
%         f1_a - vetor de formantes f1 de /i/
%         f2_a - vetor de formantes f2 de /i/
%         f1_a - vetor de formantes f1 de /o/
%         f2_a - vetor de formantes f2 de /o/
%         f1_a - vetor de formantes f1 de /u/
%         f2_a - vetor de formantes f2 de /u/
%
%     Retorno: -
%
function scatter_formantes(f1_a, f2_a, f1_e, f2_e, f1_i, f2_i, f1_o, f2_o, f1_u, f2_u)
  scatter(f1_a, f2_a, 'filled');    % Scatter das formantes de /a/
  hold on;
  scatter(f1_e, f2_e, 'filled');    % Scatter das formantes de /e/
  scatter(f1_i, f2_i, 'filled');    % Scatter das formantes de /i/
  scatter(f1_o, f2_o, 'filled');    % Scatter das formantes de /o/
  scatter(f1_u, f2_u, 'filled');    % Scatter das formantes de /u/
  hold off;
  grid;
endfunction
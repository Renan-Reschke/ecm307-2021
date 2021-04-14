%
%
%
%     Função que plota uma scatter de formantes de todas as vogais
%
%
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
  title('Formantes')
  xlabel('Formante f1 [Hz]');
  ylabel('Formante f2 [Hz]');
  leg = legend({'Vogal /a/', 'Vogal /e/', 'Vogal /i/', 'Vogal /o/', 'Vogal /u/'}, 'FontSize', 12);    
endfunction
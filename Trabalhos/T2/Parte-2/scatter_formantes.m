function scatter_formantes(f1_a, f2_a, f1_e, f2_e, f1_i, f2_i, f1_o, f2_o, f1_u, f2_u)
  scatter(f1_a, f2_a, 'filled');
  hold on;
  scatter(f1_e, f2_e, 'filled');
  scatter(f1_i, f2_i, 'filled');
  scatter(f1_o, f2_o, 'filled');
  scatter(f1_u, f2_u, 'filled');
  hold off;
  grid;
  title('Formantes')
  xlabel('Formante f1');
  ylabel('Formante f2');
  leg = legend({'Vogal /a/', 'Vogal /e/', 'Vogal /i/', 'Vogal /o/', 'Vogal /u/'}, 'FontSize', 12);    
endfunction
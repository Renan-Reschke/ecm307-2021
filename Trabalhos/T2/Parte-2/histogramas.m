%%%%   Fun��o para plotagem de um histograma das formantes de 5 vogais obtidas a%   prtir de um arquivo csv (padronizado para esse uso espec�fico)%%%   Par�metros: -%function histogramas()  %% Formantes da vogal /a/  [f0_a f1_a f2_a formante_sexo_a] = leitura_formantes('csv-formantes/formantes-a.csv');  % Resgata os valores das formantes do banco de dados da vogal /a/  [media_f0_a media_f1_a media_f2_a] = media_formantes(f0_a, f1_a, f2_a);                 % Determina a m�dia das formantes da vogal /a/    %% Formantes da vogal /e/  [f0_e f1_e f2_e formante_sexo_e] = leitura_formantes('csv-formantes/formantes-e.csv');  % Resgata os valores das formantes do banco de dados da vogal /e/  [media_f0_e media_f1_e media_f2_e] = media_formantes(f0_e, f1_e, f2_e);                 % Determina a m�dia das formantes da vogal /e/    %% Formantes da vogal /i/  [f0_i f1_i f2_i formante_sexo_i] = leitura_formantes('csv-formantes/formantes-i.csv');  % Resgata os valores das formantes do banco de dados da vogal /i/  [media_f0_i media_f1_i media_f2_i] = media_formantes(f0_i, f1_i, f2_i);                 % Determina a m�dia das formantes da vogal /i/    %% Formantes da vogal /o/  [f0_o f1_o f2_o formante_sexo_o] = leitura_formantes('csv-formantes/formantes-o.csv');  % Resgata os valores das formantes do banco de dados da vogal /o/  [media_f0_o media_f1_o media_f2_o] = media_formantes(f0_o, f1_o, f2_o);                 % Determina a m�dia das formantes da vogal /o/    %% Formantes da vogal /u/  [f0_u f1_u f2_u formante_sexo_u] = leitura_formantes('csv-formantes/formantes-u.csv');  % Resgata os valores das formantes do banco de dados da vogal /u/  [media_f0_u media_f1_u media_f2_u] = media_formantes(f0_u, f1_u, f2_u);                 % Determina a m�dia das formantes da vogal /u/    fig = figure();    %% Histogramas da vogal /a/  subplot(5,3,1);  hist(f0_a, 10);  title('Formantes f0 de /a/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,2);  hist(f1_a, 10);  title('Formantes f1 de /a/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,3);  hist(f2_a, 10);  title('Formantes f2 de /a/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    %% Histogramas da vogal /e/  subplot(5,3,4);  hist(f0_e, 10);  title('Formantes f0 de /e/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,5);  hist(f1_e, 10);  title('Formantes f1 de /e/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,6);  hist(f2_e, 10);  title('Formantes f2 de /e/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    %% Histogramas da vogal /i/  subplot(5,3,7);  hist(f0_i, 10);  title('Formantes f0 de /i/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,8);  hist(f1_i, 10);  title('Formantes f1 de /i/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,9);  hist(f2_i, 10);  title('Formantes f2 de /i/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    %% Histogramas da vogal /o/  subplot(5,3,10);  hist(f0_o, 10);  title('Formantes f0 de /o/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,11);  hist(f1_o, 10);  title('Formantes f1 de /o/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,12);  hist(f2_o, 10);  title('Formantes f2 de /o/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    %% Histogramas da vogal /u/  subplot(5,3,13);  hist(f0_u, 10);  title('Formantes f0 de /u/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,14);  hist(f1_u, 10);  title('Formantes f1 de /u/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    subplot(5,3,15);  hist(f2_u, 10);  title('Formantes f2 de /u/');  xlabel('Frequ�ncia [Hz]');  ylabel('Quantidade');    %saveas(fig, 'histogramas-formantes/formantes_hist.png');  endfunction
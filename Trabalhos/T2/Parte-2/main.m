%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Renan Scheidt Reschke
%%  RA: 19.02009-0
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  0 - Proposta 
%% 
%%  a. Cada aluno determina as frequências f0, f1 e f2 da sua própria gravação (3x) - cada vogal gera 9 valores => 45 valores no total
%%  b. Formar base de conhecimento Número de alunos x 45
%%  c. Histograma de cada vogal - média e o desvio padrão de cada frequência para cada vogal (espera-se distribuição gaussiana)
%%  d. Eliminar valores fora de contexto e verificar diferenças da base - Tratamento dos Outliers
%%  e. Gravar 5 vogais que não serão usadas na base (vogais_teste)
%%  f. 1 - Acertou e 0 - Errou -> a, e, i, o, u
%%  Ou seja, modelo de ML gera um vetor [1 1 0 0 1]: acertou /a/, /e/ e /u/ e errou /i/ e /o/
%%  g. Verificar qualidade do sistema de aprendizado para cada vogal
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Limpeza

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variaveis

fprintf('\nDesenvolvido por: Renan Scheidt Reschke\nRA: 19.02009-0\n\n');

%% Desabilita warnings
warning('off')

%% Inicializacao do programa
fprintf('Iniciando o programa...\n');
fprintf('Sinal analisado: o2.wav\n\n');
fprintf('Tipo: Discreto\n\n');
fprintf('Recuperando dados do sinal...\n');

%% Recuperacao de dados da amostra
[gk, fs] = audioread ('audio/o2.wav');          % transforma um arquivo .wav em um vetor g(k)
                                                % recupera a taxa de amostragem - fs
                                                
[gk N Ts ws duracao tempo fmax frequencia resolucao] = resgatar_dados (gk, fs); % recupera dados importantes do sinal

%% Serie discreta de Fourier

fourier = fourier(gk, N);

fprintf('Dados recuperados com sucesso!\n\n');
fprintf('Tempo de duracao do sinal: %.3fs\n', duracao);
fprintf('Frequencia do sinal: %dHz\n', fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 7 do T2
formantes = identificar_formantes(frequencia, fourier);     % Reconhece automaticamente f0, f1 e f2
print_formantes(formantes);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 4 do T2
fprintf('Item 4: Analise temporal\n');
fprintf('\tSim, é possível observar uma periodicidade no sinal no domínio do tempo\n\tcomo pode ser observado na imagem "Figure 1".\n\n');


%% Visualizacao do sinal no dominio do tempo
fig1 = figure(1);
plot(tempo,gk,'k-')                   % configura plot(x,y, cor preta)
xlabel('Tempo em segundos')           % titulo eixo x
ylabel('Amplitude')                   % titulo eixo y
title('Sinal o2.wav amostrado')       % titulo do gráfico
grid
%saveas(fig1,'plot-sons/o2.png')       % Salva o grafico como png

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 5 do T2
fprintf('Item 5: Análise de Fourier\n');
fprintf('\tSim, é possível justificar a resposta do item 4 pois, como a Análise\n\tde Fourier demonstra na imagem "Figure 2", existem harmônicas presentes no sinal.\n\n');


%% Visualizacao do sinal no dominio da frequencia
fig2 = figure(2);
plot(frequencia,fourier,'k-');hold on;                       % configura plot(x,y, cor preta)
identificar_formantes(frequencia, fourier);
xlabel('Frequencia em Hz')                              % titulo eixo x
ylabel('Amplitude')                                     % titulo eixo y
title('Espectro de amplitude de o2.wav')                % titulo do gráfico
grid
%saveas(fig2,'plot-frequencias/freq_o2.png')             % Salva o grafico como png


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Item 6 do T2 : Formantes do banco de dados
fprintf('Item 6: Plot (f1, f2)\n');
fprintf('\tA plotagem dos pontos pode ser visualizada na imagem "Figure 3"\n\n');
%% Formantes da vogal /a/
[f0_a f1_a f2_a formante_sexo_a] = leitura_formantes('csv-formantes/formantes-a.csv');
[media_f0_a media_f1_a media_f2_a] = media_formantes(f0_a, f1_a, f2_a);

%% Formantes da vogal /e/
[f0_e f1_e f2_e formante_sexo_e] = leitura_formantes('csv-formantes/formantes-e.csv');
[media_f0_e media_f1_e media_f2_e] = media_formantes(f0_e, f1_e, f2_e);

%% Formantes da vogal /i/
[f0_i f1_i f2_i formante_sexo_i] = leitura_formantes('csv-formantes/formantes-i.csv');
[media_f0_i media_f1_i media_f2_i] = media_formantes(f0_i, f1_i, f2_i);

%% Formantes da vogal /o/
[f0_o f1_o f2_o formante_sexo_o] = leitura_formantes('csv-formantes/formantes-o.csv');
[media_f0_o media_f1_o media_f2_o] = media_formantes(f0_o, f1_o, f2_o);

%% Formantes da vogal /u/
[f0_u f1_u f2_u formante_sexo_u] = leitura_formantes('csv-formantes/formantes-u.csv');
[media_f0_u media_f1_u media_f2_u] = media_formantes(f0_u, f1_u, f2_u);

%% Plot do gráfico bidimensional das formantes f1 e f2                                                    
fig3 = figure(3);
scatter_formantes(f1_a, f2_a, f1_e, f2_e, f1_i, f2_i, f1_o, f2_o, f1_u, f2_u);
title('Formantes')
xlabel('Formante f1 [Hz]');
ylabel('Formante f2 [Hz]');
leg = legend({'Vogal /a/', 'Vogal /e/', 'Vogal /i/', 'Vogal /o/', 'Vogal /u/'}, 'FontSize', 12);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fprintf('Fim da análise de um dos áudios que está incluso na base de dados\n');
fprintf('Início dos testes para áudios gravados por pessoas externas ao grupo de aprendizado...\n');

%% Vogais de teste para verificar o programa
vetor_testes = [];  % Armazena o resultado dos testes para os audios [/a/ /e/ /i/ /o/ /u/]
                    % 0 - Errou; 1 - Acertou

% Teste vogal /a/
fprintf('Início do teste para a vogal /a/:\n');
vetor_testes(1) = teste_vogal('audio-teste/a-teste.wav', 'a');
acertou(vetor_testes(1));

% Teste vogal /e/
fprintf('Início do teste para a vogal /e/:\n');
vetor_testes(2) = teste_vogal('audio-teste/e-teste.wav', 'e');
acertou(vetor_testes(2));

% Teste vogal /i/
fprintf('Início do teste para a vogal /i/:\n');
vetor_testes(3) = teste_vogal('audio-teste/i-teste.wav', 'i');
acertou(vetor_testes(3));

% Teste vogal /o/
fprintf('Início do teste para a vogal /o/:\n');
vetor_testes(4) = teste_vogal('audio-teste/o-teste.wav', 'o');
acertou(vetor_testes(4));
% Teste vogal /u/
fprintf('Início do teste para a vogal /u/:\n');
vetor_testes(5) = teste_vogal('audio-teste/u-teste.wav', 'u');
acertou(vetor_testes(5));

  
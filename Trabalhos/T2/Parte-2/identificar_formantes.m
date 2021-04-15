%
%
%
%     Função que identifica as formantes de um sinal
%
%
%     Parâmetros: 
%         frequencia - vetor de frequencias (x)
%         sinal      - vetor obtido pela análise de fourier
%
%     Retorno:
%         formantes - vetor com as 3 primeiras formantes do áudio
%
function formantes = identificar_formantes (frequencia, sinal)
  
  pkg load signal;                          % Pacote para uso do findpeaks
  
  x = frequencia(idivide (int32 (length(frequencia)), int32 (2), 'fix'):end);
  y = sinal(idivide (int32 (length(sinal)), int32 (2), 'fix'):end);
  [pks,idx] = findpeaks(y, 'DoubleSided');    % Encontra os picos de um gráfico
                                              % Armazena o valor do pico em pks e 
                                              % o index em que se encontra no vetor 
                                              % x em um vetor de index (idx)
                                              
  x_idx = x(idx)';  % Armazena os pontos x onde ocorrem picos no gráfico da Série de Fourier
  y_idx = y(idx);   % Armazena os pontos y onde ocorrem picos no gráfico da Série de Fourier
  
  interpolacao = splinefit (x_idx, y_idx, length(x_idx));   % Realiza interpolação dos pontos de pico obtidos anteriormente
                                                            % Os picos dessa interpolação determinarão as formantes
  y_aprox = ppval(interpolacao, x);
  [pks2, idx2] = findpeaks(y_aprox, 'DoubleSided', 'MinPeakHeight', 1.15);  % Encontra os picos no gráfico da interpolação
  
  x_formantes = [];  y_formantes = [];  i = 1;    % possíveis formantes
  
  % Pega apenas os picos positivos, pois os negativos não importam
  for k=1:length(x(idx2))
    if y_aprox(idx2)(k)>0
      x_formantes(i) = x(idx2)(k);
      y_formantes(i) = y_aprox(idx2)(k);
      i++;
    endif
  endfor
  
  j = 1;
  
  % Análise se um pico é ou não uma formante
  % Características para ser formante:
      % Ser maior que seus vizinhos (antecessor e sucessor)
      % Ser maior que 100 (em nenhuma vogal a formante é menor que 100)
  formantes = []; y_plot = []; i = 1;
  for k=1:length(y_formantes)-1
    if j<4
      if k != 1                                                                                          % pontos a partir do index 2
        if and(and(y_formantes(k)>=y_formantes(k-1),y_formantes(k)>=y_formantes(k+1)),y_formantes(k)>=0) % Compara o ponto atual com seus vizinhos
          formantes(i) = x_formantes(k);                                                                 % Armazena o ponto atual no vetor de formantes 
                                                                                                         % se ele for maior que seus vizinhos
          y_plot(i) = y_formantes(k);                                                                    % Apenas para usado caso queira visualizar em gráfico
          i++; j++;
        endif
      elseif and(k == 1,y_formantes(k)>=y_formantes(k+1))   % Ponto de index 1
        if x_formantes(k)>100
          formantes(i) = x_formantes(k);                    % Armazena o ponto atual no vetor de formantes 
                                                            % se ele for maior que 100
          y_plot(i) = y_formantes(k);                       % Apenas para usado caso queira visualizar em gráfico
          i++; j++;
        elseif y_formantes(k+1)>=y_formantes(k+2)
          formantes(i) = x_formantes(k+1);                  % Armazena o ponto de index 2 no vetor de formantes 
                                                            % se ele for maior que seu sucessor (index = 3)
          y_plot(i) = y_formantes(k+1);                     % Apenas para usado caso queira visualizar em gráfico
          i++; j++;
        endif
      endif
    endif
  endfor
    
  % Plots usados apenas para testes
  %f1 = plot(x, y_aprox, 'm-'); 
  %hold on;
  %f2 = plot(x_formantes, y_formantes, 'xb');            % Plota os pontos de pico no gráfico
  %f3 = plot(formantes, y_plot, 'or');
  %legend([f1 f2 f3],'Interpolação dos picos de frequência', 'Possíveis formantes', 'Reais formantes');
  
endfunction
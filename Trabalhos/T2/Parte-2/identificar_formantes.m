%
%
%
%     Função que plota pontos de pico em um gráfico (x,y)
%
%
%
function formantes = identificar_formantes (frequencia, sinal)
  
  pkg load signal;                          % Pacote para uso do findpeaks
  
  x = frequencia(idivide (int32 (length(frequencia)), int32 (2), 'fix'):end);
  y = sinal(idivide (int32 (length(sinal)), int32 (2), 'fix'):end);
  [pks,idx] = findpeaks(y, 'DoubleSided');    % Encontra os picos de um gráfico
                                              % Armazena o valor do pico em pks e 
                                              % o index em que se encontra no vetor 
                                              % x em um vetor de index (idx)
  x_idx = x(idx)';
  y_idx = y(idx);
  %breaks = idivide (int32 (length(y)), int32 (length(x_idx)), 'fix');
  interpolacao = splinefit (x_idx, y_idx, length(x_idx));
  y_aprox = ppval(interpolacao, x);
  [pks2, idx2] = findpeaks(y_aprox, 'DoubleSided', 'MinPeakHeight', 1.15);
  
  x_formantes = [];  y_formantes = [];  i = 1;
  for k=1:length(x(idx2))
    if y_aprox(idx2)(k)>0
      x_formantes(i) = x(idx2)(k);
      y_formantes(i) = y_aprox(idx2)(k);
      i++;
    endif
  endfor
  
  j = 1;
  
  formantes = []; y_plot = []; i = 1;
  for k=1:length(y_formantes)-1
    if j<4
      if k != 1
        if and(and(y_formantes(k)>=y_formantes(k-1),y_formantes(k)>=y_formantes(k+1)),y_formantes(k)>=0)
          formantes(i) = x_formantes(k);
          y_plot(i) = y_formantes(k);
          i++; j++;
        endif
      elseif and(k == 1,y_formantes(k)>=y_formantes(k+1))
        if x_formantes(k)>100
          formantes(i) = x_formantes(k);
          y_plot(i) = y_formantes(k);
          i++; j++;
        elseif y_formantes(k+1)>=y_formantes(k+2)
          formantes(i) = x_formantes(k+1);
          y_plot(i) = y_formantes(k+1);
          i++; j++;
        endif
      endif
    endif
  endfor
  
  %f1 = plot(x, y_aprox, 'm-'); 
  %hold on;
  %f2 = plot(x_formantes, y_formantes, 'xb');            % Plota os pontos de pico no gráfico
  %f3 = plot(formantes, y_plot, 'or');
  %legend([f1 f2 f3],'Interpolação dos picos de frequência', 'Possíveis formantes', 'Reais formantes');
  
endfunction
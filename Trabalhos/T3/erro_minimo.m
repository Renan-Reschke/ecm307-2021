function [b_bckup c_bckup erro_min] = erro_minimo(b, c, Vp)
  erro_min  = 9999999;
  N         = 1;
  Trecho_escolhido = Vp(231:275);   % intervalo de 28ms a 36ms deltaT = 8ms
  tic;
  for i = 1: length(b)              %%%%%%%%%
    for j = 1: length(c)            %% Avalia cada dupla (b, c)
      D       = [1 b(i) c(j)];            % denominador
      Gs      = tf(N, D);           % funcao de transferencia estimada
      [serie, tempo, X] = impulse(Gs);
      erro = sum(power(Trecho_escolhido - serie(1:45), 2));  % calcula o erro para (b, c) atual
      
      if erro < erro_min            % atualiza o erro minimo encontrado e (b, c)
        erro_min = erro;
        b_bckup = b(i);
        c_bckup = c(j);
      endif        
    endfor
  endfor
  fprintf("Tempo para achar o erro minimo: ");
  toc;
endfunction
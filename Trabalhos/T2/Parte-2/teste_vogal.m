function teste_vogal (arquivo)  [gk, fs] = audioread (arquivo);                               % transforma um arquivo .wav em um vetor g(k)                                                                % recupera a taxa de amostragem - fs                                                  [gk N Ts ws duracao tempo fmax frequencia resolucao] = resgatar_dados (gk, fs); % recupera dados importantes do sinal    fourier = fourier(gk, N);  formantes = identificar_formantes(frequencia, fourier);     % Reconhece automaticamente f0, f1 e f2  print_formantes(formantes);endfunction
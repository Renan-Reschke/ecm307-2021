## Introdução ao Octave (matlab)

### Boas práticas de inicialização no matlab
- `clear all;` Limpa todas as variáveis.
- `close all;` Limpa (fecha) todas as figuras.
- `clc;` Limpa visualmente a tela.
- `%comentar` '%' insere um comentário

### Uso de bibliotecas
- `pkg load symbolic;` Carrega o pacote simbólico

### Definição de variáveis
- `variavel = <valor>` Atribui valor a uma variável
- `<tipo> variavel1 variavel2` Atribui n variáveis a um tipo

### Visualizando um gráfico (imagem)
- Exemplo 1: Valores discretos
    ```
    figure()
    stem(n,cnNumerico,'linewidth',2);     % plot de valores discretos
    xlabel('valores de n');               % label eixo x   
    ylabel('Valores de cn');              % label eixo y
    title('Decomposição de g(t)');        % título do gráfico
    grid;                                 
    ```

- Exemplo 2: Gráfico continuo
    ```
    figure()
    plot(tempo,g,'linewidth',2);    % plot de valores continuos (interpolar)
    xlabel('tempo');                % label eixo x   
    ylabel('amoplitude');           % label eixo y
    title('Sintese de g(t)');       % t�tulo do gr�fico
    grid;
    ```

### Comandos úteis usados na aula
- ```linspace(<val.inicial>,<val.final),<quant.dePontos>)``` Cria um vetor linear
- ```[<val.inicial>:<incremento>:<quant.dePontos>]``` Cria um vetor linear
- ```eval(cn)``` Determina um valor numericamente

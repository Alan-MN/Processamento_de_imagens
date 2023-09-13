function quanizado = quantizar255(imagem_original)
  N_values = 2:256;
  Erelat_values = zeros(size(N_values));
  if size(imagem_original, 3) == 3
        imagem_original = double(rgb2gray(imagem_original))/255;
    end

  % Loop através de diferentes valores de N
  for i = 1:length(N_values)
      N = N_values(i);

      % Quantize a imagem
      imagem_quantizada = quantizarImagem(imagem_original, N);

      % Calcule o erro relativo e armazene-o no vetor
      Erelat = calcularErroRelativo(imagem_original, imagem_quantizada);
      Erelat_values(i) = Erelat;
  end

  % Plote o gráfico de Erelat em função de N
  figure;
  plot(N_values, Erelat_values, '-o');
  xlabel('N (Níveis de Cinza)');
  ylabel('Erro Relativo (Erelat)');
  title('Erro Relativo vs. Níveis de Cinza');
  grid on;
  quanizado = 1;

end


function [imagem_quantizada, Erelat] = quantizarImagem(imagem_original, N)
    % Verificar se a imagem está em escala de cinza
    if size(imagem_original, 3) == 3
        imagem_original = rgb2gray(imagem_original);
    end

    % Normalizar a imagem para o intervalo [0, 1]
    imagem_original = double(imagem_original) / 255.0;

    % Quantização da imagem
    passo = 1 / (N - 1);
    imagem_quantizada = round(imagem_original / passo) * passo;

    % Calcular o erro relativo
    Erelat = norm(imagem_quantizada - imagem_original, 'fro') / norm(imagem_original, 'fro');


end



function Erelat = calcularErroRelativo(imagem_original, imagem_quantizada)
    diferenca = imagem_quantizada - imagem_original;
    norma_diferenca = norm(diferenca, 'fro');
    norma_original = norm(imagem_original, 'fro');
    Erelat = norma_diferenca / norma_original;
end

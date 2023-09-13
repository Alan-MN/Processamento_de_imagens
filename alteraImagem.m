function alterado = alteraImagem(Imagem_recebida, tipo_alteracao)
   if tipo_alteracao == 'D'
        alterado = dilatar(Imagem_recebida);
    elseif tipo_alteracao == 'C'
        alterado = comprimir(Imagem_recebida);
    end
end

function dilatado = dilatar(img)
    [L, C, dim] = size(img);

    if dim == 3
        X = double(rgb2gray(img))/255;
    else
        X = img;
    end



    L_dilatado = L * 2;
    C_dilatado = C * 2;
    dilatado = zeros(L_dilatado, C_dilatado);

    for i = 1:L
        for j = 1:C
            dilatado(i * 2 - 1, j * 2 - 1) = X(i, j);
            dilatado(i * 2, j * 2 - 1) = X(i, j);
            dilatado(i * 2 - 1, j * 2) = X(i, j);
            dilatado(i * 2, j * 2) = X(i, j);
        end
    end
end

function comprimida = comprimir(img)
    [L, C, dim] = size(img);

    if dim == 3
        X = double(rgb2gray(img)) / 255;
    end

    L_comprimida = floor(L / 2);
    C_comprimida = floor(C / 2);
    comprimida = zeros(L_comprimida, C_comprimida);

    for i = 1:L_comprimida
        for j = 1:C_comprimida
            pixel1 = X(i * 2 - 1, j * 2 - 1);
            pixel2 = X(i * 2 - 1, j * 2);
            pixel3 = X(i * 2, j * 2 - 1);
            pixel4 = X(i * 2, j * 2);
            media = (pixel1 + pixel2 + pixel3 + pixel4) / 4;

            comprimida(i, j) = media;
        end
    end

end

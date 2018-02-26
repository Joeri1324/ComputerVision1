function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        g = fspecial('gaussian', 5, 0.5);
        h = fspecial('laplacian', 0.7);
        imOut = imfilter(imfilter(image, g), h);

    case 2
        %method 2
        h = fspecial('log', 5, 0.5);
        imOut = imfilter(image, h);
    case 3
        %method 3
        g = fspecial('gaussian', 5, 0.5);
        h = fspecial('gaussian', 5, 2);
        imOut = imfilter(image, h) - imfilter(image, g);
end
end


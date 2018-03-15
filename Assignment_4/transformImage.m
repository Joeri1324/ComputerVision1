function [tranformedImage] = transformImage(image, m, t)
    [x, y] = find(image);
    
    transformedCoords = (m * [x, y]') + t;
    tranformedImage = zeros(round(max(transformedCoords(1, :))), round(max(transformedCoords(2, :))));
    for i = 1:size(transformedCoords, 2)
        newPixel = image(x(i), y(i));
        newX = ceil(transformedCoords(1, i));
        newY = ceil(transformedCoords(2, i));
        
        % why should this be?
        if newX > 1 && newY > 1
            tranformedImage(newX, newY) = newPixel;
        end
    end
end

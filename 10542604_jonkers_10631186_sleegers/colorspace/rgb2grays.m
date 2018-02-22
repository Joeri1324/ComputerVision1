function [output_image] = rgb2grays(input_image, method)
% converts an RGB into grayscale by using 4 different methods
    output_image = zeros(size(input_image, 1), size(input_image, 2));
    % converts an RGB image into normalized rgb
    if strcmp(method, 'built-in')
        output_image = rgb2gray(input_image);
    end
    for row=1:size(input_image, 1)
        for col=1:size(input_image, 2)
            R = input_image(row, col, 1);
            G = input_image(row, col, 2);
            B = input_image(row, col, 3);
            
            if strcmp(method, 'lightness')
                disp(max([R, G, B]))
                output_image(row, col) = (max([R, G, B]) + min([R, G, B])) / 2;
            end
            if strcmp(method, 'average')
                output_image(row, col) = (R + B + G) / 3;
            end
            if strcmp(method, 'luminosity')
                output_image(row, col) = 0.21 * R + 0.72 * G + 0.07 * B;
            end
        end
    end
end


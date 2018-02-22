function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space

    output_image = zeros(size(input_image));
    
    for row=1:size(input_image, 1)
        for col=1:size(input_image, 2)
            R = input_image(row, col, 1);
            G = input_image(row, col, 2);
            B = input_image(row, col, 3);
            output_image(row, col, :) = [
                (R - G) / sqrt(2);
                (R + G - 2 * B) / sqrt(6);
                (R + G + B) / sqrt(3)
            ];
        end
    end
end


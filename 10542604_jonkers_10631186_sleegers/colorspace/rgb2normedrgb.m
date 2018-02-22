function [output_image] = rgb2normedrgb(input_image)
    output_image = zeros(size(input_image));
    % converts an RGB image into normalized rgb
    for row=1:size(input_image, 1)
        for col=1:size(input_image, 2)
            R = input_image(row, col, 1);
            G = input_image(row, col, 2);
            B = input_image(row, col, 3);
            sum = (R + G + B);
            output_image(row, col, :) = [
                R / sum;
                G / sum;
                B / sum;
            ];
        end
    end
end


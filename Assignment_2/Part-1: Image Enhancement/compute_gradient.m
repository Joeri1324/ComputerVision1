function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
    sobel_x = [[1, 0, -1]; [2, 0, -2]; [1, 0, -1]];
    sobel_y = [[1, 2, 1]; [0, 0, 0]; [-1, -2, -1]];
    
    Gx = imfilter(image, sobel_x);
    Gy = imfilter(image, sobel_y);
    im_magnitude = sqrt(Gx .^ 2 + Gy .^ 2);
    im_direction = atan(Gy / Gx);
end


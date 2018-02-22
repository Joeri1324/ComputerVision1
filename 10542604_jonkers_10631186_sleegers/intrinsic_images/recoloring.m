ball = im2double(imread('./ball.png'));
ball_r = im2double(imread('./ball_reflectance.png'));
ball_s = im2double(imread('./ball_shading.png'));


original_color = ball_r(200, 200, :);
green = [0 1 0];
magenta = [1 0 1];

green_ball_r = zeros(size(ball_r));
magenta_ball_r = zeros(size(ball_r));

for row=1:size(ball_r, 1)
    for col=1:size(ball_r, 2)
        if ball_r(row, col, :) == original_color
            green_ball_r(row, col, :) = green;
            magenta_ball_r(row, col, :) = magenta;
        end
    end
end


green_reconstructed_ball = green_ball_r .* ball_s;
magenta_reconstructed_ball = magenta_ball_r .* ball_s;

subplot(2, 2, 1)
imshow(green_reconstructed_ball);

subplot(2, 2, 2)
imshow(magenta_reconstructed_ball);

subplot(2, 2, 3)
imshow(ball);
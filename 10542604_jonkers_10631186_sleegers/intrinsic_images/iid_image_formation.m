ball = im2double(imread('./ball.png'));
ball_r = im2double(imread('./ball_reflectance.png'));
ball_s = im2double(imread('./ball_shading.png'));

reconstructed_ball = ball_r .* ball_s;

subplot(2, 2, 1);
imshow(ball_r);

subplot(2, 2, 2);
imshow(ball_s);

subplot(2, 2, 3);
imshow(ball);

subplot(2, 2, 4);
imshow(reconstructed_ball);

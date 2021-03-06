I = im2double(imread('image.jpeg'));

[h, w] = size(I);
n = h * w;
avg_RGB = [sum(sum(I(:, :, 1))), sum(sum(I(:, :, 2))), sum(sum(I(:, :, 3)))] ./ n;

I(:, :, 1) = (128/avg_RGB(1)) * I(:, :, 1);
I(:, :, 2) = (128/avg_RGB(2)) * I(:, :, 2);
I(:, :, 3) = (128/avg_RGB(3)) * I(:, :, 3);

subplot(2, 1, 1)
imshow(imread('image.jpeg'))
subplot(2, 1, 2)
imshow(I / 655)
function [H, r1, c1] = harris_corner_detector(I, treshold1, treshold2)

grayI = rgb2gray(I);
% Gaussian derivative filters to x and to y
G = fspecial('gauss', [3, 3]);
Gx = fspecial('gauss', [1, 3]);
Gy = fspecial('gauss', [3, 1]);
Gdx = gradient(Gx);
Gdy = gradient(Gy);

% Images smoothed with gaussian derivatives
Ix = imfilter(grayI, Gdx);
Iy = imfilter(grayI, Gdy);

% Calculate Q(x,y) of auto-correlation
A = imfilter(Ix.^2, Gx);
C = imfilter(Iy.^2, Gy);
B = imfilter(Ix.*Iy, G);

% Cornerness of each pixel
H = (A.*C - B.^2) - 0.04*((A+C).^2);

% Check corners
[r1, c1] = find(H > treshold1);
[r2, c2] = find(H > treshold2);

subplot(2, 2, 1)
imshow(Ix)
title('gradient x direction')

subplot(2, 2, 2)
imshow(Iy)
title('gradient y direction')

subplot(2, 2, 3)
imshow(color_edge(I, r1, c1))
title(strcat('corners detected by harris with treshold ', num2str(treshold1)))

subplot(2, 2, 4)
imshow(color_edge(I, r2, c2))
title(strcat('corners detected by harris with treshold ', num2str(treshold2)))

end
function [H, r, c] = harris_corner_detector(I, treshold)

grayI = rgb2gray(I)
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
[r, c] = find(H > treshold);

% set corners to green
for i = 1:size(r)
    I(r(i), c(i), :) = [0; 1; 0];
end

subplot(2, 2, 1)
imshow(Ix)
title('gradient x direction')

subplot(2, 2, 2)
imshow(Iy)
title('gradient y direction')

subplot(2, 2, 3)
imshow(I)
title('corners detected by harris')

end

J = im2double(imread('person_toy/00000001.jpg'));
I = im2double(imread('pingpong/0000.jpeg'));

% Gaussian derivative filters to x and to y
G = fspecial('gauss', [3, 3]);
Gx = fspecial('gauss', [1, 3]);
Gy = fspecial('gauss', [3, 1]);
Gdx = gradient(Gx);
Gdy = gradient(Gy);

% Images smoothed with gaussian derivatives
Ix = imfilter(I, Gdx);
Iy = imfilter(I, Gdy);

% Caclculate Q(x,y) of auto-correlation
A = imfilter(Ix.^2, Gx);
C = imfilter(Iy.^2, Gy);
B = imfilter(Ix.*Iy, G);

% Cornerness of each pixel
H = (A.*C - B.^2) - 0.04*((A+C).^2);
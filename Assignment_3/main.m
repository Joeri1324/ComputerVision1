%%
J = im2double(imread('person_toy/00000001.jpg'));
I = im2double(imread('pingpong/0000.jpeg'));

figure
harris_corner_detector(I, 0.001);

figure
harris_corner_detector(J, 0.001);

%% Rotated image

rotatedJ = imrotate(J, randi([0, 360]));
harris_corner_detector(rotatedJ, 0.005);

%% Optical flow

I = im2double(imread('sphere1.ppm'));
J = im2double(imread('sphere2.ppm'));

R = lucas_kanade(I, J);
[~, r, c] = harris_corner_detector(I, 0.002);

disp('fish')
disp(R(r(6), c(6), :));


%%

tracking('./pingpong/', 0.005)
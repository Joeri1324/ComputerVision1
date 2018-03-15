%% Harris corner
J = im2double(imread('person_toy/00000001.jpg'));
I = im2double(imread('pingpong/0000.jpeg'));

figure
harris_corner_detector(I, 0.001, 0.005);

figure
harris_corner_detector(J, 0.001, 0.005);

%% Rotated image

rotatedJ = imrotate(J, 180);
harris_corner_detector(rotatedJ, 0.001, 0.005);


%% Optical flow

I = im2double(imread('sphere1.ppm'));
J = im2double(imread('sphere2.ppm'));

%% Tracking
tracking('./person_toy/', 0.0005)
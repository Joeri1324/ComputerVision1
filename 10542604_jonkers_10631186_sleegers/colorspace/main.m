%% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

J = ConvertColorSpace(I, 'ycbcr');

J = ConvertColorSpace(I, 'opponent');
% close all
J = ConvertColorSpace(I,'rgb');

% close all
J = ConvertColorSpace(I,'hsv');

% close all
J = ConvertColorSpace(I,'ycbcr');

% close all
J = ConvertColorSpace(I, 'gray');

%% gray

subplot(2, 2, 1)
lum = rgb2grays(I, 'luminosity');
imshow(lum / 255);

subplot(2, 2, 2)
light = rgb2grays(I, 'lightness');
imshow(light / 255);

subplot(2, 2, 3)
avg = rgb2grays(I, 'average');
imshow(avg / 255);

subplot(2, 2, 4)
imshow(rgb2gray(I))
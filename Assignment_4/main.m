%% SIFT !
boat1 = im2double(imread('./boat1.pgm'));
boat2 = im2double(imread('./boat2.pgm'));

[matches, scores, boat1_f, boat2_f] = keypoint_matching(boat1, boat2);
showMatchedFeatures(boat1, boat2, boat1_f, boat2_f, matches)

%% RANSAC!
[m, t, score] = RANSAC(1000, 50, matches, boat1_f, boat2_f, 10);

subplot(2, 2, 1)
imshow(transformImage(boat2, m, t));

subplot(2, 2, 2)
imshow(boat1);
%% STITCHING !

img1 = im2double(rgb2gray(imread('./left.jpg')));
img2 = im2double(rgb2gray(imread('./right.jpg')));

[matches, scores, img1_f, img2_f] = keypoint_matching(img1, img2);

[m, t, score] = RANSAC(10000, 5, matches, img1_f, img2_f, 10);

imshow(stitch(img1, img2, m, t));

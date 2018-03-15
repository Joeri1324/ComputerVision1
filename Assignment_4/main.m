%% SIFT!
boat1 = im2double(imread('./boat1.pgm'));
boat2 = im2double(imread('./boat2.pgm'));

[matches, scores, boat1_f, boat2_f] = keypoint_matching(boat1, boat2);

showMatchedFeatures(boat1, boat2, boat1_f, boat2_f, matches)

%% RANSAC!
[projection, score] = RANSAC(1, 30, matches, boat1_f, boat2_f);
%% STIT

reshaped_projection = [
    projection(1) projection(2) 0;
    projection(3) projection(4) 0;
    projection(5) projection(6) 1;
];

%%

[x, y] = find(boat1);
x = reshape(x, [1, size(x)]);
y = reshape(y, [1, size(y)]);
zero = zeros(size(x));
one = ones(size(x));

A = reshape([
    x, y, zero, zero, one, zero;
    zero, zero, x, y, zero, one;
], [ size(x, 2) * 2, 6]);

new_coords = reshape(A * projection, [ 2, size(x, 2)]);

new_image = zeros(ceil(max(new_coords(1, :))), ceil(max(new_coords(2, :))));

for i = 1:size(new_coords, 2)
    new_image(ceil(new_coords(1, i)), ceil(new_coords(2, i))) = boat1(x(i), y(i));
end

imshow(new_image)

%%

img1 = rgb2gray(im2double(imread('./left.jpg')));
img2 = rgb2gray(im2double(imread('./right.jpg')));

[matches, scores, img1_f, img2_f] = keypoint_matching(img1, img2);

[projection, score] = RANSAC(100000, 10, matches, img1_f, img2_f);

[x, y] = find(img1);
x = reshape(x, [1, size(x)]);
y = reshape(y, [1, size(y)]);
zero = zeros(size(x));
one = ones(size(x));


A = reshape([
    x, y, zero, zero, one, zero;
    zero, zero, x, y, zero, one;
], [ size(x, 2) * 2, 6]);

new_coords = reshape(A * projection, [ 2, size(x, 2)]);



min_x = min(new_coords(1, :));
min_y = min(new_coords(2, :));

new_image = zeros(ceil(size(img2, 2) - min_y), ceil(size(img2, 1) - min_x));

for i = 1:size(new_coords, 2)
    if (ceil(new_coords(1, i) - min_x) > 0 && ceil(new_coords(2, i) - min_y) > 0)
        new_image(ceil(new_coords(1, i) - min_x) , ceil(new_coords(2, i) - min_y)) = img1(x(i), y(i));
    end
end

[x, y] = find(img2);
x = reshape(x, [1, size(x)]);
y = reshape(y, [1, size(y)]);

for i = 1:size(x, 2)
   xx = ceil(x(i) );
   yy = ceil(y(i) + min_y);
   if xx > 0 && yy > 0
       new_image(xx, yy) = img2(x(i), y(i));
   end
end

imshow(new_image)






%% 1.1

close all
clear all
clc
warning('off','all')
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/SphereGray5';  
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
%% 1.2

figure
[image_stack, scriptV] = load_syn_images('./photometrics_images/SphereGray25');
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
imshow(albedo)
%% 1.3

[image_stack5, scriptV5] = load_syn_images('./photometrics_images/SphereGray5');
[albedo5noshadow, normals] = estimate_alb_nrm(image_stack5, scriptV5, false);
[albedo5shadow, normals] = estimate_alb_nrm(image_stack5, scriptV5, true);

disp(sum(sum((albedo5noshadow - albedo5shadow) .^ 2)));

[image_stack25, scriptV25] = load_syn_images('./photometrics_images/SphereGray25');
[albedo25noshadow, normals] = estimate_alb_nrm(image_stack25, scriptV25, false);
[albedo25shadow, normals] = estimate_alb_nrm(image_stack25, scriptV25, true);

disp(sum(sum((albedo25noshadow - albedo25shadow) .^ 2)));

figure
subplot(1, 2, 1)
imshow(albedo5noshadow)

subplot(1, 2, 2)
imshow(albedo25noshadow)

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
[image_stack, scriptV] = load_syn_images('./photometrics_images/SphereGray5');
[~, normals] = estimate_alb_nrm(image_stack, scriptV);
disp('Integrability checking')
[~, ~, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers for sphere5: %d\n\n', sum(sum(SE > threshold)));

[image_stack, scriptV] = load_syn_images('./photometrics_images/SphereGray25');
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers for sphere25: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

show_results(albedo, normals, SE);
show_model(albedo, height_map);

figure
%% 1.3

[image_stack, scriptV] = load_syn_images('./photometrics_images/SphereGray5');

[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
[p, q, SE] = check_integrability(normals);

figure
height_map = construct_surface(p, q);
surf(height_map)

figure
height_map = construct_surface(p, q, 'row');
surf(height_map)

figure
height_map = construct_surface(p, q, 'average');
surf(height_map)
%% 
[image_stack, scriptV] = load_syn_images('./photometrics_images/SphereGray25');


[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
[p, q, SE] = check_integrability(normals);

figure
height_map = construct_surface(p, q, 'average');
surf(height_map)

%% 1.4

[image_stack, scriptV] = load_syn_images('./photometrics_images/MonkeyGray');

[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

[p, q, SE] = check_integrability(normals);
height_map = construct_surface(p, q, 'average');
surf(height_map);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers all images: %d\n\n', sum(sum(SE > threshold)));

[albedo, normals] = estimate_alb_nrm(image_stack(:, :, 1:5), scriptV(1:5, :));

[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers 5 images: %d\n\n', sum(sum(SE > threshold)));

%% RGB sphere

[r_image_stack, r_scriptV] = load_syn_images('./photometrics_images/SphereColor', 1);
[b_image_stack, b_scriptV] = load_syn_images('./photometrics_images/SphereColor', 2);
[g_image_stack, g_scriptV] = load_syn_images('./photometrics_images/SphereColor', 3);

[r_albedo, r_normals] = estimate_alb_nrm(r_image_stack, r_scriptV);
[g_albedo, g_normals] = estimate_alb_nrm(g_image_stack, g_scriptV);
[b_albedo, b_normals] = estimate_alb_nrm(b_image_stack, b_scriptV);

[r_p, r_q, SE] = check_integrability(r_normals);
[g_p, g_q, SE] = check_integrability(g_normals);
[b_p, b_q, SE] = check_integrability(b_normals);

r_height_map = construct_surface(r_p, r_q, 'average');
b_height_map = construct_surface(b_p, b_q, 'average');
g_height_map = construct_surface(g_p, g_q, 'average');

combined = (r_height_map + b_height_map + g_height_map) / 3;
surf(combined)
%% Monkey Color

[r_image_stack, r_scriptV] = load_syn_images('./photometrics_images/MonkeyColor', 1);
[b_image_stack, b_scriptV] = load_syn_images('./photometrics_images/MonkeyColor', 2);
[g_image_stack, g_scriptV] = load_syn_images('./photometrics_images/MonkeyColor', 3);

[r_albedo, r_normals] = estimate_alb_nrm(r_image_stack, r_scriptV);
[g_albedo, g_normals] = estimate_alb_nrm(g_image_stack, g_scriptV);
[b_albedo, b_normals] = estimate_alb_nrm(b_image_stack, b_scriptV);

[r_p, r_q, SE] = check_integrability(r_normals);
[g_p, g_q, SE] = check_integrability(g_normals);
[b_p, b_q, SE] = check_integrability(b_normals);

r_height_map = construct_surface(r_p, r_q, 'average');
b_height_map = construct_surface(b_p, b_q, 'average');
g_height_map = construct_surface(g_p, g_q, 'average');

combined = (r_height_map + b_height_map + g_height_map) / 3;
surf(combined)

%% Yale

[image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, true);

[p, q, SE] = check_integrability(normals);
avg_height_map = construct_surface(p, q, 'average');
row_height_map = construct_surface(p, q, 'row');
col_height_map = construct_surface(p, q, 'col');

show_model(albedo, row_height_map)

%% 
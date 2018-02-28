%%
J = im2double(imread('./images/image1_saltpepper.jpg'));
I = im2double(imread('./images/image1.jpg'));

disp(myPSNR(I, J));

%% 
J = im2double(imread('./images/image1_gaussian.jpg'));
I = im2double(imread('./images/image1.jpg'));

disp(myPSNR(I, J));

%%
J = im2double(imread('./images/image1_saltpepper.jpg'));
I = im2double(imread('./images/image1_gaussian.jpg'));

denoised_box_3 = denoise(J, 'box', 3);
denoised_box_5 = denoise(J, 'box', 5);
denoised_box_7 = denoise(J, 'box', 7);

figure
subplot(2, 2, 1)
imshow(denoised_box_3);
subplot(2, 2, 2);
imshow(denoised_box_5);
subplot(2, 2, 3);
imshow(denoised_box_7);

disp('box salt pepper psnt')
disp(myPSNR(J, denoised_box_3));
disp(myPSNR(J, denoised_box_5));
disp(myPSNR(J, denoised_box_7));

denoised_box_3 = denoise(I, 'box', 3);
denoised_box_5 = denoise(I, 'box', 5);
denoised_box_7 = denoise(I, 'box', 7);

figure
subplot(2, 2, 1)
imshow(denoised_box_3);
subplot(2, 2, 2);
imshow(denoised_box_5);
subplot(2, 2, 3);
imshow(denoised_box_7);

disp('box gaussian psnr')
disp(myPSNR(J, denoised_box_3));
disp(myPSNR(J, denoised_box_5));
disp(myPSNR(J, denoised_box_7));

%%

denoised_median_3 = denoise(I, 'median', 3, 3);
denoised_median_5 = denoise(I, 'median', 5, 5);
denoised_median_7 = denoise(I, 'median', 7, 7);

figure
subplot(2, 2, 1)
imshow(denoised_box_3);
subplot(2, 2, 2);
imshow(denoised_box_5);
subplot(2, 2, 3);
imshow(denoised_box_7);

disp('median salt pepper psnt')
disp(myPSNR(J, denoised_box_3));
disp(myPSNR(J, denoised_box_5));
disp(myPSNR(J, denoised_box_7));

figure
subplot(2, 2, 1)
imshow(denoised_box_3);
subplot(2, 2, 2);
imshow(denoised_box_5);
subplot(2, 2, 3);
imshow(denoised_box_7);

disp('median gaussian psnt')

disp(myPSNR(I, denoised_box_3));
disp(myPSNR(I, denoised_box_5));
disp(myPSNR(I, denoised_box_7));

%%

sigmas = [0.5, 1, 2];

for i = 1:length(sigmas)
   kernell = gauss2D(sigmas(i), 7);
   denoised = imfilter(I, kernell);
   subplot(2, 2, i);
   imshow(denoised);
   disp(myPSNR(I, denoised));
end

%%

I = im2double(imread('./images/image1.jpg'));
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(I);

subplot(2, 2, 1)
imshow(Gx)
subplot(2, 2, 2)
imshow(Gy)
subplot(2, 2, 3)
imshow(im_magnitude)
subplot(2, 2, 4)
imshow(im_direction)

%%

I = im2double(imread('./images/image2.jpg'));

subplot(2, 2, 1)
imshow(I);
subplot(2, 2, 2)
imshow(compute_LoG(I, 1))
subplot(2, 2, 3)
imshow(compute_LoG(I, 2))
subplot(2, 2, 4)
imshow(compute_LoG(I, 3))




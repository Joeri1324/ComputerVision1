
j = 0;


for i = 1:length(gaborFilterBank)
    real_filter = gaborFilterBank(i).filterPairs(:, :, 1);
    subplot(6, 6, i)
    filter_image = imfilter(img_gray, real_filter);
    imshow(filter_image);
    title(sprintf('\\lambda = %.1f, \\theta = %.1f, \\sigma = %.1f',gaborFilterBank(i).lambda,...
                                                                                                              gaborFilterBank(i).theta,...
                                                                                                              gaborFilterBank(i).sigma));
end
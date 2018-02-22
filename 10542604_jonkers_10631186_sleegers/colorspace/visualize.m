function visualize(input_image)
    figure;
    subplot(2, 2, 1)
    imshow(input_image)
    for i=1:size(input_image, 3)
        subplot(2,2, i+1);
        imshow(input_image(:, :, i));
    end
end


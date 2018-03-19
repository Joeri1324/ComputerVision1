function [words] = descriptorsToWords(descriptors, C)
    words = zeros([size(descriptors, 2), 1]);
    for i = 1:size(descriptors, 2)
        distances = sum((descriptors(:, i) - C') .^ 2, 2);
        [~, index] = min(distances);
        words(i) = index;
    end
end
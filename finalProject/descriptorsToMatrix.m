function [matrix] = descriptorsToMatrix(descriptors)
    matrix = [];
    for i = 1:size(descriptors, 1)
        d = descriptors(i, :);
        for j = 1:size(d, 2)
            matrix = [matrix, d{:, j}];
        end
    end
end
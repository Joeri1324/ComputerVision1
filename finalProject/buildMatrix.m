function [matrix, Y] = buildMatrix(descriptors, C)
    matrix = [];
    Y = [];
    amount_of_classes = size(descriptors, 1);
    for i = 1:amount_of_classes
        d = descriptors(i, :);
        
        newY = zeros(size(d, 2), amount_of_classes);
        newY(:, i) = 1;
        Y = [Y; newY];
        
        for j = 1:size(d, 2)
            feature_vector = histcounts(descriptorsToWords(double(d{:, j}), C),  size(C, 1));
            matrix = [
                matrix;
                feature_vector
            ];   
        end
    end
end
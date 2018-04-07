function [matrix, Y, backpointers] = buildMatrix(descriptors, C)
    matrix = [];
    Y = [];
    backpointers = [];
    amount_of_classes = size(descriptors, 1);
    for i = 1:amount_of_classes
        d = descriptors(i, :);
        
        newY = zeros(size(d, 2), amount_of_classes);
        newY(:, i) = 1;
        Y = [Y; newY];
        
        for j = 1:size(d, 2)
            
            backpointers = [backpointers; [i j]];
            feature_vector = histcounts(descriptorsToWords(double(d{:, j}), C),  size(C, 1));
            matrix = [
                matrix;
                feature_vector / sum(feature_vector)
            ];
        end
    end
end
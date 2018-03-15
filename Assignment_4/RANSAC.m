function [best_projection , max_amount_of_inliers] = RANSAC(N, P, matches, fa, fb)
    % do something
    
    max_amount_of_inliers = 0;
    best_projection = zeros(6);
    
    for i = 1:N
        perm = randperm(size(matches, 2));
        subset_matches = matches(:, perm(1:P));

        b = reshape(fb(1:2, subset_matches(2, :)), [P * 2, 1]);

        X = fa(1, subset_matches(1, :));
        Y = fa(2, subset_matches(2, :));

        zero = zeros(size(X));
        one = ones(size(X));       
        
        A = reshape([
            X, Y, zero, zero, one, zero;
            zero, zero, X, Y, zero, one;
        ], [P * 2, 6]);

        zero = zeros([1, size(matches, 2)]);
        one = ones([1, size(matches, 2)]);
        X = fa(1, matches(1, :));
        Y = fa(2, matches(2, :));
        T = reshape([
            X, Y, zero, zero, one, zero;
            zero, zero, X, Y, zero, one;
        ], [size(matches, 2) * 2, 6]);
    

        projection = pinv(A) * b;

        B = reshape(fb(1:2, matches(2, :)), [size(matches, 2), 2]);
        projectedT = reshape(T * projection, [size(matches, 2), 2]) ;

        SED = sqrt(sum((projectedT - B) .^ 2, 2));
        number_of_inliers = sum(SED <= 10);
        
        if number_of_inliers > max_amount_of_inliers
            max_amount_of_inliers = number_of_inliers;
            best_projection = projection;
        end
    end
    
end
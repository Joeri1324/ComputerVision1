function [best_projection, score] = untitled(N, P, matches, fa, fb)
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
    
        
    
        projection = pinv(A) * b;
        m = reshape(projection(1:4), [2,2])';
        t = reshape(projection(5:6), [2,1]);
        
        b = reshape(fb(1:2, matches(2, :)), [size(matches, 2), 2]);
        disp(size(b));
        X = fa(1, matches(1, :));
        Y = fa(2, matches(2, :));
        projected = ((M * [Y; X]) + t);
        Xb = fb(1:2, matches(2, :));
        disp(Xb(1:2, 1:5));
        disp(projected(1:2, 1:5));
        
        % do for all points 
        b = reshape(fb(1:2, matches(2, :)), [size(matches, 2), 2]);
        X = fa(1, matches(1, :));
        Y = fa(2, matches(2, :));
        err = sqrt(sum(((M * [X; Y] + t) - b') .^ 2, 1));
        
        number_of_inliers = sum(err <= 10);
        if number_of_inliers > max_amount_of_inliers
            best_projection = projection;
            score = number_of_inliers;
        end
    end
end
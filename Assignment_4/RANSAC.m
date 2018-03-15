function [best_m, best_t, best_amount_of_inliers] = RANSAC(N, P, matches, fa, fb, treshold)
    % do something
    
    best_amount_of_inliers = 0;
    best_m = 0;
    best_t = 0;
    
    for i = 1:N
        perm = randperm(size(matches, 2));
        subset_matches = matches(:, perm(1:P));

        [m, t] = createProjectionMatrix(subset_matches, fa, fb);
        
        % transform points
        T = [
            fa(1, matches(1, :));
            fa(2, matches(1, :));
        ];
        transformedPoints = (m * T) + t;
        
        % calculate error
        b = [
            fb(1, matches(2, :));
            fb(2, matches(2, :));
        ];
    
        err = sqrt(sum((transformedPoints - b) .^ 2, 1));
        number_of_inliers = sum(err <= treshold);
        if number_of_inliers > best_amount_of_inliers
            best_amount_of_inliers = number_of_inliers;
            [best_m, best_t] = createProjectionMatrix(matches(:, err <= treshold), fa, fb);
        end
    end
end
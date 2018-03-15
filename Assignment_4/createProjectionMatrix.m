function [m, t] = createProjectionMatrix(matches, fa, fb) 
    b = fb(1:2, matches(2, :));
    b = b(:);
    
    A = buildStackedMatrix(matches, fa);

    x = pinv(A) * b;
    m = reshape(x(1:4), [2,2]);
    t = reshape(x(5:6), [2,1]);
    m = m';
end
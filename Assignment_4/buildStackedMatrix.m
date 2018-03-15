function [A] = buildStackedMatrix(matches, fa) 
    X = fa(1, matches(1, :));
    Y = fa(2, matches(1, :));

    zero = zeros(size(X));
    one = ones(size(X)); 

    A = reshape([
        X, Y, zero, zero, one, zero;
        zero, zero, X, Y, zero, one;
    ], [size(matches, 2) * 2, 6]);
end
function [ P ] = MATRIX( xy, uv )
% Calculate projection matrix based on input and output coordinates.
    
    % CODE FROM ASSIGNMENT 1
    % Construct matrix A 
    x = xy(:, 1);
    y = xy(:, 2);
    u = uv(:, 1);
    v = uv(:, 2);
    o = ones(size(x));
    z = zeros(size(x));
    Aoddrows = [x, y, o , z, z, z, -u.*x, -u.*y, -u];
    Aevenrows = [z, z, z, x, y, o, -v.*x, -v.*y, -v];
    A = [Aoddrows; Aevenrows];
    
% Q: Why is the above matrix not identical to the one in the assignment?
% because its ordered differently. First all the x' equations are put
% into the matrix and then all y' equations. This doesn't change anything 
% because the matrix multiplication yields the 0-vector.
    
    % Generate SVD
    [~, ~, V] = svd(A);
    % Last row of V can approximate 0 vector, so this is our matrix M.
    P = V(:,end);
    P = reshape(P, 3, 3);
    P = P';
    
end
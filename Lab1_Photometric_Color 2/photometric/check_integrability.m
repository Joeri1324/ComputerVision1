function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
[h, w, ~] = size(normals);
p = zeros(h, w);
q = zeros(h, w);

for row=1:size(normals, 1)
    for col=1:size(normals, 2)
        p(row, col) = normals(row, col, 1) / normals(row, col, 3);
        q(row, col) = normals(row, col, 2) / normals(row, col, 3);
    end
end


% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy


% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

[Gx, ~] = imgradient(p);
[~, Gy] = imgradient(q);

SE = (Gx - Gy) .^ 2;

% ========================================================================




end


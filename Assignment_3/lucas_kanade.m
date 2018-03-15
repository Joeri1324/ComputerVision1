function [RESULT] = lucas_kanade(I, J, vis)

grayI = rgb2gray(I);
grayJ = rgb2gray(J);

G = fspecial('gauss', [5, 5]);
Gx = fspecial('gauss', [1, 5]);
Gy = fspecial('gauss', [5, 1]);
Gdx = gradient(Gx);
Gdy = gradient(Gy);

% Images smoothed with gaussian derivatives
Ix = imfilter(grayI, Gdx);
Iy = imfilter(grayI, Gdy);
It = grayI - grayJ;

[m, n, ~] = size(I);

vectorSize = round(m / 15) * round(n / 15);
X = zeros(vectorSize);
Y = zeros(vectorSize);
U = zeros(vectorSize);
V = zeros(vectorSize);

RESULT = zeros(m, n, 2);

indexI = 0;
indexJ = 0;


for i = 1:14:m-14
    indexI = indexI + 1;
    
    for j = 1:14:n-14
        indexJ = indexJ + 1;
        blockIx = Ix(i:i+14, j:j+14);
        blockIy = Iy(i:i+14, j:j+14);
        blockIt = It(i:i+14, j:j+14);
        A = [ blockIx(:)' ; blockIy(:)' ];
        b = - blockIt(:)' ;
        v = linsolve(A * A', A * b');
        U(indexJ) = v(1);
        V(indexJ) = v(2);
        X(indexJ) = j;
        Y(indexJ) = i;
        
        for z = i:i+15
            for l = j:j+15
                RESULT(z, l, 1) = v(1);
                RESULT(z, l, 2) = v(2);
            end
        end        
    end
end

if vis
    figure

    subplot(2, 2, 1)
    imshow(I)

    subplot(2, 2, 2)

    imshow(J)
    hold on;
    quiver(X, Y, U, V, 10, 'red');
end

end
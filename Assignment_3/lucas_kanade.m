function lucas_kanade(I, J)

grayI = rgb2gray(I);
grayJ = rgb2gray(J);

G = fspecial('gauss', [3, 3]);
Gx = fspecial('gauss', [1, 3]);
Gy = fspecial('gauss', [3, 1]);
Gdx = gradient(Gx);
Gdy = gradient(Gy);

% Images smoothed with gaussian derivatives
Ix = imfilter(grayI, Gdx);
Iy = imfilter(grayI, Gdy);
It = grayI - grayJ;

[m, n, ~] = size(I);
disp(size(Ix))
disp(n)

vectorSize = round(m / 15) * round(n / 15);
X = zeros(vectorSize);
Y = zeros(vectorSize);
U = zeros(vectorSize);
V = zeros(vectorSize);

indexI = 0;
indexJ = 0;

% imshow(I);

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
        
        % vectors(i, j, :) = [i, j, v(1), v(2)];
    end
end

figure

subplot(2, 2, 1)
imshow(I)
hold on;
quiver(X, Y, U, V, 10, 'red');

subplot(2, 2, 2)

imshow(J)
hold on;
quiver(X, Y, U, V, 10, 'red');


end
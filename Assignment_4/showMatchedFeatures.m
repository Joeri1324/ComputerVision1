function showMatchedFeatures(img1, img2, fa, fb, matches)

perm = randperm(size(matches, 2));
matches = matches(:, perm(1:50));

disp(matches)

figure(1) ; clf ;
imagesc(cat(2, img1, img2)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(img1,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(img1,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;

end
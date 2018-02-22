function G = gauss2D( sigma , kernel_size )
   g = gauss1D(sigma, kernel_size);
   G = g' * g;
   G = G ./ sum(sum(G));
end

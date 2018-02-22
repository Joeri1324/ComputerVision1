function G = gauss1D( sigma , kernel_size )
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end 
    x = -floor(kernel_size/2):floor(kernel_size/2);
    G =  exp(- x.^2 ./ (2 * (sigma^2)));
    G = G ./ sum(G);
    
    % left-hand sight of the gaussian is just a scalar, since the kernel
    % needs to be normalized anyway this can be ommited.
end

function [ PSNR ] = myPSNR( orig_image, approx_image )
    [h, w] = size(orig_image);
    mse = 1/(h*w) * sum(sum((orig_image - approx_image) .^ 2));
    PSNR = 20 * log10(max(max(orig_image))/sqrt(mse));
end

%%


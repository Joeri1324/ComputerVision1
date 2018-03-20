function [result] = stitch(img1, img2, m, t)
    A = [
        m(1, 1) m(2, 1) 0;
        m(1, 2) m(2, 2) 0;
        t(1) t(2) 1;
    ];
    T = maketform('affine', A);
    [x, y] = tformfwd(T,[1 size(img2,2)], [1 size(img1, 1)]);
    donothing =  maketform('affine', [1 0 0; 0 1 0; 0 0 1]);
    
    xdata = [min(1,x(1)) max(size(img2,2),x(2))];
    ydata = [min(1,y(1)) max(size(img2,1),y(2))];
    result1 = imtransform(img1,T,'Xdata',xdata,'YData',ydata);
    result2 = imtransform(img2, donothing, 'Xdata',xdata,'YData',ydata);
    result = max(result1, result2);
end
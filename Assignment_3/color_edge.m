function [colored_img] = color_edge(img, r, c)
    colored_img = img;
    [h, w, ~] = size(colored_img);
    for i = 1:size(r)
        startX = r(i) - 2;
        if startX < 1
            startX = 1;
        end 
        endX = r(i);
        if endX > h
            endX = h;
        end
        for f = startX:endX
            startY = c(i) - 2;
            endY = c(i) + 2;
            if startY < 1
                startY = 1;
            end
            if endY > w
                endY = w;
            end
            for d = startY:endY
                colored_img(f, d, :) = [1; 0; 1];
            end
        end  
    end
end

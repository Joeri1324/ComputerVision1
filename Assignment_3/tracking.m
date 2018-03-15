

function tracking(folder_name, treshold) 
    imageNames = dir(strcat(folder_name, '*.jpg'));
    
    imageNames = {imageNames.name}';

    outputVideo = VideoWriter(fullfile(folder_name, 'movie.avi'));
    outputVideo.FrameRate = 10;
    open(outputVideo)
    
    img = im2double(imread(strcat(folder_name, imageNames{1})));
    [~, r, c] = harris_corner_detector(img, treshold, treshold);
    colored_img = color_edge(img, r, c);
    
    writeVideo(outputVideo, colored_img)

    for ii = 1:length(imageNames)-1
       img1 = im2double(imread(strcat(folder_name, imageNames{ii})));
       img2 = im2double(imread(strcat(folder_name, imageNames{ii+1})));
       result = lucas_kanade(img1, img2, false);
       

       for vv = 1:length(r)
 
           difU = result(r(vv), c(vv), 1);
           difV = result(r(vv), c(vv), 2);

           r(vv) = round(r(vv) + difV);
           c(vv) = round(c(vv) + difU);
       end

       colored_img = color_edge(img2, r, c);
       writeVideo(outputVideo, colored_img)
    end
    
    close(outputVideo)
    
    avi = VideoReader(strcat(folder_name, 'movie.avi'));
    
    ii = 1;
    while hasFrame(avi)
       mov(ii) = im2frame(readFrame(avi));
       ii = ii+1;
    end
    
    figure
    imshow(mov(1).cdata, 'Border', 'tight')

    movie(mov,1, avi.FrameRate)
end


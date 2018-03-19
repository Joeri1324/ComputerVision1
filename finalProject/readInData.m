function [images] = readInData(folderName)

    imagefiles = dir(strcat(folderName, '*.jpg')); 
    
    nfiles = length(imagefiles);    % Number of files found

    for ii=1:nfiles
       currentfilename = strcat(folderName, imagefiles(ii).name);
       image = imread(currentfilename);
       
       % right now all images are converted to grayscale
       % should do rgb sift later as well.
        if size(image, 3) == 3
           currentimage = rgb2gray(im2single(im2double(image)));
        else
           currentimage = im2single(im2double(image));
        end
       images{ii} = currentimage;
    end
end
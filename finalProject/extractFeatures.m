function [descriptors] = extractFeatures(image)

    % should double check these parameters ;)
    [~, descriptors] = vl_dsift(image, 'Step', 10);
end
function [descriptors] = extractFeatures(image, color)

    % should double check these parameters ;)
    [~, descriptors] = vl_phow(image, 'Color', color, 'Step', 10);
end
function [descriptors] = extractFeatures(image, color)

    % should double check these parameters ;)
    [~, descriptors] = vl_phow(image, 'Step', 30, 'Color', color, 'Fast', true);
end
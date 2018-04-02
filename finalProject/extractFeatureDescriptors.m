function [descriptors] = extractFeatureDescriptors(data_set, use_data,color)

    if use_data == false
        use_data = size(data_set, 2);
    end
 
    descriptors = {};
    for i = 1:use_data
        descriptors{i} = extractFeatures(data_set{i}, color);
    end
end
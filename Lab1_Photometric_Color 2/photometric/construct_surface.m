function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        previous_height_value = 0;
        for row=1:size(height_map, 1)
            height_value = previous_height_value + q(row, 1);
            height_map(row, 1) = height_value;
            previous_height_value = height_value;
        end
        
        for row=1:size(height_map, 1)
            previous_height_value = height_map(row, 1);
            for col=2:size(height_map, 2)
                height_value = previous_height_value + p(row, col);
                height_map(row, col) = height_value;
                previous_height_value = height_value;
            end
        end
      
       
        % =================================================================
               
    case 'row'
        
        previous_height_value = 0;
        for col=1:size(height_map, 2)
            height_value = previous_height_value + p(1, col);
            height_map(1, col) = height_value;
            previous_height_value = height_value;
        end
        
        for col=1:size(height_map, 2)
            previous_height_value = height_map(1, col);
            for row=2:size(height_map, 1)
                height_value = previous_height_value + q(row, col);
                height_map(row, col) = height_value;
                previous_height_value = height_value;
            end
        end
        
          
    case 'average'
        height_map_1 = zeros(h, w);
        height_map_2 = zeros(h, w);
        previous_height_value = 0;
        for row=1:size(height_map, 1)
            height_value = previous_height_value + q(row, 1);
            height_map_1(row, 1) = height_value;
            previous_height_value = height_value;
        end
        
        for row=1:size(height_map, 1)
            previous_height_value = height_map(row, 1);
            for col=2:size(height_map, 2)
                height_value = previous_height_value + p(row, col);
                height_map_1(row, col) = height_value;
                previous_height_value = height_value;
            end
        end
        
        previous_height_value = 0;
        for col=1:size(height_map, 2)
            height_value = previous_height_value + p(1, col);
            height_map_2(1, col) = height_value;
            previous_height_value = height_value;
        end
        
        for col=1:size(height_map, 2)
            previous_height_value = height_map(1, col);
            for row=2:size(height_map, 1)
                height_value = previous_height_value + q(row, col);
                height_map_2(row, col) = height_value;
                previous_height_value = height_value;
            end
        end
        
        height_map = (height_map_1 * -1 + height_map_2) / 2; 
        
end


end


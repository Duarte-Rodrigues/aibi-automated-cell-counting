function mask = createCellMask(rect_left_top_row,rect_left_top_col, rect_height, rect_width)
% This function returns a 1200x1600 mask of a rectangle represented by 4
% parameters.
% rect_left_top_row - rectangle left top corner row index
% rect_left_top_col - rectangle left top corner column index
% rect_height - rectangle height
% rect_width = rectangle width

mask = zeros(1200, 1600);

mask(rect_left_top_row:(rect_left_top_row + rect_height), rect_left_top_col:(rect_left_top_col + rect_width)) = 1;
    
size(mask)
% if (size(mask) ~= [1200 1600])
%     imresize(mask, [1200 1600]);
% end
      
end


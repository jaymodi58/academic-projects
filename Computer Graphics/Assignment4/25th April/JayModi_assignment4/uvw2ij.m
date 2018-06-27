%%
function [i j] = uvw2ij(p)
    %
    % Input: 
    %   p: 3-D vector on the plane, (u,v,w) coordinates.
    
    % Output: 
    %   i,j: matrix indices
    
    nrows = 64;
    ncols = 64;
    %display(p);
    
    % Converts 3D plane coordinates to [i j] pixel on image.
    i = -p(2) + 0.5 + nrows/2;
    j =  p(1) + 0.5 + ncols/2;
    
    
    
end  % End of the function

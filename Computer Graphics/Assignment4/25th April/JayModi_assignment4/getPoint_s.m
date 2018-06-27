%%
function s = getPoint_s(i,j,f,nrows,ncols)
    %
    % Input: 
    %   i,j: matrix indices 
    %   f: focal distance
    %   nrows, ncols: matrix dimensions 
    %
    % Output: 
    %   s: 3-D vector, (u,v,w) coordinates. 
    %
    %

    % Converts (i,j) pixel coordinates to s = ( u, v, w=focal length ).
    u =      (j - 1) - ncols/2 + .5;
    v =  - ( (i - 1) - nrows/2 + .5 );
    s = [ u v -f ]';

end  % End of the function

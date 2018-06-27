%% Homography
%
% The homography between the texture image and 
% the polar coordinates.

function Phi = homography()

    im=imread('tc-earth_daymap.jpg');
    im_size = size(im);
    % display(im_size);
    
    % Image coordinates
    x = [1 1 im_size(1) im_size(1)];   % x-coords
    y = [1 im_size(2) im_size(2) 1];   % y-coords
    one = ones(1,size(x,2));
    X  = [x;y;one];     % Matrix containing the 2-D points.

    % Theta and Phi values
    u = [0  0  180 180];   % u-coords
    v = [0 180 180  0];   % v-coords
    one = ones(1,size(u,2));
    W  = [u;v;one];     % Matrix containing the 2-D points.

    A=[];
    for i=1:size(W,2)
        W1 = [zeros(1,3) ; W(:,i).'];
        W2 = [-W(:,i).' ;zeros(1,3)];
        W3 = [X(2,i)*(W(:,i).');-X(1,i)*(W(:,i).')];
        temp=[W1 W2 W3];
        A=[A;temp];
    end

    [U, L, V] = svd(A);

    Phi_ini=V(:,9);

    % Matrix optimization
    X = [ x(1:4); y(1:4) ];
    w = [ u; v ];
    f = @(phi) costFunction(Phi_ini, X, w);
    options = optimoptions('fsolve','Display','off');
    [Phi_final,fval] = fsolve(f,Phi_ini,options);

    Phi = [ Phi_final(1)   Phi_final(2)    Phi_final(3) ; ...
               Phi_final(4)   Phi_final(5)    Phi_final(6) ; ...
               Phi_final(7)   Phi_final(8)    Phi_final(9) ];
end
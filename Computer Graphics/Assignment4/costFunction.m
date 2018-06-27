%% Optimization of the homographic matrix.
%

function L = costFunction (phi, X, w)
    % Number of measurements    x(i) <---> w(i), i = 1 .. I
    I = size(X,2);
 
    % x and y coordinates
    x = X(1,:);
    y = X(2,:);
 
    % u and v coordinates
    u = w(1,:);
    v = w(2,:);
 
    sum_squares = 0;
    for i=1:I
        n1 = (phi(1)*u(i)) + (phi(2)*v(i)) + phi(3) ;
        n2 = (phi(4)*u(i)) + (phi(5)*v(i)) + phi(6) ;
        d = (phi(7)*u(i)) + (phi(8)*v(i)) + phi(9) ;
        square= (x(i)-(n1/d)).^2 + (y(i)-(n2/d).^2);
        sum_squares = sum_squares + square;
    end
    
    L = sum_squares;
return
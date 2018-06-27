%% 
function c = trace( r, theScene, Phi , texture)
    %
    % INPUT:
    %       r: ray object 
    %       theScene: scene object 
    % OUTPUT:
    %       c: color, [r,g,b]
    %
    %

    % Light source(s)
    l = theScene.lightDirection;                                

    % Intersect ray r with each object in the scene.
    NumObjects =  length( theScene.objectList );        

    % Array to store all intersection hits
    t_all = [];                                                           
    for i = 1 : NumObjects

        % The object to be intersected
        Object = theScene.objectList{ i };

        % Perform intersection between ray and object
        t = Object.Intersect( r );

        % display(t);
        % Concatenate with all other t values
        t_all = [ t_all, t ];                                                 
    end

    % We are interested in the value t that corresponds to the closest
    % intersected surface in front of the starting point for the ray. Note that
    % this ray is not necessarily the ray formed by the eye and s. It can also
    % be a reflected or refracted ray. Also, we are not interested in
    % intersections that take place "behind" the starting point of the ray,
    % i.e., we look towards the "front" along the ray, not backwards. As a
    % result, we want the minimum out of all t values, i.e.,
    [ t, idx ] = min( t_all );                               

    % If the ray does not hit an object then t == inf (i.e,, preset return value of the
    % intersection function). In this case, the color to return is just the
    % background color.
    hit_and_object = ( t ~=inf );

    if (hit_and_object)
        % This is the intersected object
        Object = theScene.objectList{ idx };  

        % Calculate shade
        c = shade( Object, r, t, l , Phi, texture);                                 
    else
        % We didn't hit any object, just return the background color
        c = theScene.bgColor;                                       
    end
end     % End trace()
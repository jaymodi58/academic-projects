%% 
function c = shade(  Object, ray, t, l, Phi, texture)

    % Calculate the 3-D point at the intersection. Given t, calculate p(t) = e + (s - e) * t.
    p = ray.getPoint3D(t);

    % Initial color is black (no shade, no light, nothingness...)
    c = [ 0, 0, 0 ]'; 

    % Calculate the phong shade, i.e., L = La + Ld + Ls. 
    c = c + Phong( Object, p, l, ray , Phi , texture); 
end
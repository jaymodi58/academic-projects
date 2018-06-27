%% 
function L = Phong( Object, p, l, ray, Phi , texture)

% The color of the surface.
    %display(class(Object));
    if(Object.Radius == 600)
        %display('Plane is here.');
        L = Object.Color;
    else
        %display('In Sphere');        
        % if(Object.Radius==60)
        if(Object.Radius == 30)
            %display('At the earth');
            
            %display(k);
            %% ------------------------Homography-------------------------------------------------------------
%             r = sqrt ( (p(1)-Object.Center(1))^2 + (p(2)-Object.Center(2))^2 + (p(3)-Object.Center(3))^2 );
%             theta = atand( (p(2)-Object.Center(2)) / (p(1)-Object.Center(1)) );
%             phi = acosd( (p(3)-Object.Center(3))/r);
% 
%             hit_point = Phi * [phi theta+90 1]';
%             hit_point = hit_point / hit_point(3);
%             % display(hit_point);
%             k = impixel(texture, round(hit_point(2)) , round(hit_point(1)) );
%             k = k';
            %--------------------------------------------------------------------------------------------------
            
            %% ------------------------Reflaction-------------------------------------------------------------
            
            point = [ (p(1)-Object.Center(1)), (p(2)-Object.Center(2)), (p(3)-Object.Center(3)) ]';
            
            n = Object.getNormalVector( point );
            line = ray.e - ray.s;
            %angle=acosd(  (dot(line,n) / (norm(line)*norm(n))) );
            ref = (2 * dot(n,line) * n) - line ;
            %new_angle = acosd(  (dot(ref,n) / (norm(ref)*norm(n))) );
            
            plane = Plane([ 0, 1600, 1 ]', [ -1, -1, 1.5 ], [ 255, 255, 0 ]', 600);
            
            r = Ray(point,ref);
            
            t = plane.Intersect( r );
            intersect_point = r.getPoint3D(t);
            %intersect_point(:, :,:) = Object.Color;
            
            [i j] = uvw2ij(intersect_point);
            
            load('image.mat');
            if  (i <= nrows && j <= ncols && i >= 1 && j >= 1)
                display('hitted image');
                load('image.mat');
                %display(round(i));
                %display(round(j));
                im(round(i),round(j),:) = plane.Color;
                save('image.mat','im','nrows','ncols');
            end
            
            %verify = round(dot( (intersect_point-[ 0, 1600, 1 ]'),[ -1, -1, 1.5 ]));
            
            k = Object.Color;
        else
            k = Object.Color;
        end
       
        % Calculate the surface normal at p  
        n = Object.getNormalVector( p ); 

        % Lambertian component (Diffuse color)
        Ld = k * max( 0, dot(l,n) );

        % Phong component (Specular reflection).
        v = (ray.e-p)/norm(ray.e-p);      % Insident ray
        p_phong = 128;                        % Phong exponent
        h = (v + l) / norm( v + l );
        Ls = k * max( 0, dot(h,n) )^p_phong;

        L =  Ld + Ls;
        
    end

end


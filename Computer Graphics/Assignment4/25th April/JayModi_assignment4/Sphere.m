classdef Sphere
    properties
        Center         % [u, v, w] coordinates of center
        Radius         % radius 
        Color           % [r, g, b] RGB color vector  
    end
    methods
        
        %-------------------------------------------------------------%
        % Constructor 
        %-------------------------------------------------------------%
        function obj = Sphere(center, radius, color)
            obj.Center = center;
            obj.Radius = radius;
            obj.Color  = color; 
        end
        %-------------------------------------------------------------%
        % Ray-sphere intersection
        %-------------------------------------------------------------%
        function t = Intersect( obj, ray )
            
            % Use notation similar to the one on slides
            d = ray.s - ray.e;        % Direction vector 
            e = ray.e;                  % Eye location
            
            c = obj.Center;             % Sphere center 
            R = obj.Radius;             % Sphere radius 
                        
            % Ray-sphere intersection 
            delta = ( d' * ( e - c ) )^2 - ( d' * d ) * ( ( e - c )' * ( e - c ) - R^2 );
            
            if delta < 0    % There is no intersection
                t = inf;
            else            % We have an intersection
                t1 = ( - d' * ( e - c ) + sqrt( delta ) ) / ( d' * d ); 
                t2 = ( - d' * ( e - c ) - sqrt( delta ) ) / ( d' * d ); 
                
                % Take the smaller t. It corresponds to the closer
                % intersection. 
                t = min( t1, t2 );
                
            end
        end
        %-------------------------------------------------------------%
        % Calculate the surface normal at p  
        %-------------------------------------------------------------%
         function n = getNormalVector( obj, p )
                % The surface normal is just a direction, i.e., a unit vector.  
                n = (p - obj.Center) /  norm( p - obj.Center );                                    
         end
        %-------------------------------------------------------------%
        % Calculate the color at the intersection point 
        %-------------------------------------------------------------%
        function L = getColor( obj, ray, light_vector )
                        
            % Intersect this Sphere with the input Ray
            t = obj.Intersect( ray );
            
            % Calculate the color if we have an intersection
            if (t ~=inf)                 
                
                % Calculate the 3-D point at the intersection. Given t,
                % calculate p(t) = e + (s - e) * t.
                p = ray.getPoint3D(t); 
                
                % Obtain the surface normal at p. Surface normal is just a
                % direction, i.e., it is a unit vector.  
                n = (p - obj.Center) /  norm( p - obj.Center );                                    
                
                % The color of this sphere. 
                k = obj.Color;
                
                % Light vector 
                l = light_vector; 
                
                % Lambertian component (Diffuse color)
                Ld = k * max( 0, dot(l,n) );                            
                
                % Phong component (Specular reflection). 
                v = (ray.e-p)/norm(ray.e-p);      % Insident ray
                p_phong = 128;                          % Phong exponent 
                h = (v + l) / norm( v + l ); 
                Ls = k * max( 0, dot(h,n) )^p_phong;                            

                L =  Ld + Ls; 
                
            else
                L = [0,0,0];
            end
        end

   end
end

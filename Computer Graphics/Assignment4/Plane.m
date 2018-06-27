classdef Plane
    properties
        P0              % [u, v, w] coordinates of the point in plane
        Normal          % Normal Vector of Plane
        Color           % [r, g, b] RGB color vector  
        Radius          % radius = 600(always) (only to diffrentiate from sphere) 
    end
    methods
        
        %-------------------------------------------------------------%
        % Constructor 
        %-------------------------------------------------------------%
        function obj = Plane(p0, normal, color, radius)
            obj.P0 = p0;
            obj.Normal = normal;
            obj.Color  = color;
            obj.Radius = radius;
        end
        %-------------------------------------------------------------%
        % Ray-plane intersection
        %-------------------------------------------------------------%
        function t = Intersect( obj, ray )
            
            % Use notation similar to the one on slides
            d = ray.s - ray.e;        % Direction vector 
            e = ray.e;                  % Eye location
            
            p0 = obj.P0;             % Sphere center 
            normal = obj.Normal;             % Sphere radius 
                        
            % Ray-plane intersection 
            if d * normal == 0    % There is no intersection because the ray and plane are parallel.
                t = inf;
            else            % We have an intersection
                t = ( dot( (p0-e),normal )) / (dot(d,normal));
                %display(t);
            end
        end
   end
end

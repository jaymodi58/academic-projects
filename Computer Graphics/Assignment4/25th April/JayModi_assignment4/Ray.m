
%
% Ray is a representation of the parameteric ray equation p(t) = e + d*t,
% where d = s - e; 
%
classdef Ray
    properties
        e           % Start point
        s           % End point 
    end
    methods
        %-------------------------------------------------------------%
        % Constructor 
        %-------------------------------------------------------------%
        function obj = Ray(e, s)
            obj.e = e;
            obj.s = s;
        end
        %-------------------------------------------------------------%
        % Get coordinates of the 3-D point at p(t) 
        %-------------------------------------------------------------%
        function p = getPoint3D(obj, t)
            p = obj.e + (obj.s - obj.e) * t;      % p(t) = e + (s-e)*t
        end
        
   end
end

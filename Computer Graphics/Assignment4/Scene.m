classdef Scene
    properties
        eyeLocation          % Eye location (i.e., viewer)
        focalDistance        % focal distance
        bgColor                % background color [r,g,b] 
        lightDirection        % 3xN array. Each column is the (u,v,w) of a light direction    
        objectList  = {};     % Cell structure representing a list of objects
    end
    methods
        
        %-------------------------------------------------------------%
        % Constructor 
        %-------------------------------------------------------------%
        function obj = Scene( e, f, bgk, l )
            obj.eyeLocation     = e;         % Eye location (i.e., viewer)
            obj.focalDistance   = f;         % focal distance
            obj.bgColor           = bgk;     % background color [r,g,b] 
            obj.lightDirection   = l;         % 3xN array. Each column is the (u,v,w) of a light direction    
        end
        
        % Set the list of objects to the scene 
        function obj = setObjects(obj, o)
            obj.objectList = o; 
        end
        
   end
end

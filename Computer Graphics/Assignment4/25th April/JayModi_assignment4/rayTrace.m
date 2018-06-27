%function rayTrace()
    %% The basic camera model (perspective view model)
    %
    % The basic model consists of a 3-D coordinate system and a simple camera.
    % Points in this 3-D coordinate system are given by ${\bf p} = (u,v,w)^{T}$.
    % For the camera, we use a perspective model where the eye
    % is the center of projection. In this tutorial, we place the eye at the origin
    % of the $u-v-w$ coordinate system, i.e., ${\bf e} =
    % \left(0,0,0\right)^{T}$. 
    %

    %clear all;
    close all;
    clc;
    
    % Eye position
    e = [ 0 0 700 ]';                            

    %% 
    % The camera's image plane is parallel to the $u-v$ plane, and is placed at a distance
    % $f$ (i.e., focal distance) from the eye, on the negative side of w-axis.
    % The focal distance in our scene is:

    % Focal distance (i.e., distance from the eye to the image plane)
    % f = 150;                                    
    f = 80;

    %%
    % We will denote points on the image plane by ${\bf s}$. Because the image plane is
    % parallel to the $u-v$-plane and is located at $w=-f$, every point on the
    % image plane has its w-coordinate equal to $-f$, i.e.,  $\forall {\bf s}$,
    % ${\bf s} = ( u, v, -f )^{T}$. 

    %% The basic scene 
    % The basic scene consists of a set of light sources (or directions) and a background color. 
    % Here, I am will make the simplifying assumption that the light is parallel everywhere. Thus, I need
    % only the normalized light direction  (i.e., a unit vector), ${\bf l} = ( l_u, l_v, l_w )^{T}$.

    % Unit vector representing the direction of the light
    %l = [ -6.5 6.5 1 ]';
    l = [ 0.5 0.5 1 ]';
    l = l / norm( l );                  

    %%
    % The background color in this case is black. You can choose any color you
    % want. 

    % Background color (RGB)
    kb = [ 0, 0, 0 ]';               

    %% 
    % We have defined the geometry of the basic scene and camera. In this
    % tutorial, I implement geometric components as Matlab objects (object-oriented
    % programming). To create the basic scene, I declare an object Scene as
    % follows: 
    %

    % Create the basic scene. No objects are added to the scene at this point.
    % Objects will be added later in the form of a cell array.
    theScene = Scene(e, f, kb, l);


    %%  Objects that will compose our scene
    % In addition to defining the basic scene geometry, we need to add a few
    % geometric objects to the scene. These objects are usually represented by
    % equations or triangulated point sets. In this tutorial, we will use
    % equations of simple objects such as spheres and planes. We define these
    % objects as follows: 

    % Create Sphere 1--------------Earth
    center = [ 10, 10, -600 ]';
    radius = 100;
    color  = [ 100, 0, 0 ]';
    S1 = Sphere(center, radius, color);            % Create a sphere object

    % Create Sphere 2-----------Moon
    center = [ -110, 10, -400 ]';
    radius = 40;
    color  = [ 100, 100, 0 ]';
    S2 = Sphere(center, radius, color);            % Create a sphere object

    % Create Plane-----------Plane passing through 
    p0 = [ 0, 1600, 1 ]';
    normal = [ -1, -1, 1.5 ];
    color  = [ 255, 255, 0 ]';
    radius = 600;
    %plane = Plane(p0, normal, color, radius);                % Create a plane object

    %%  
    % With the objects defined, I make a simple list of objects. I implement
    % this list using a Matlab cell array, i.e.: 

    % List of objects 
    listObjects = { S1, S2 };   % Add more objects as needed.
    theScene = theScene.setObjects( listObjects );        
    % The way the method setObjects is called above looks a bit dodgy! Because
    % Matlab passes parameters by value, the method needs to return the actual
    % object and assign it to itself. We can also pass parameters/objects by
    % reference. For this, see Superclass methods in the Matlab documentation.

    %% The image-matrix representation 
    % The ultimate goal of ray-tracing is to create an image. Images are stored in matrices. Elements in the matrix are indexed using
    % $(i,j)$ coordinates. We need to define the dimensions of the image matrix:

    % Dimensions of the matrix where image will be stored.
    % nrows = 100;  ncols = 100;    
    nrows = 200;  ncols = 250;
    %% The main function 
    % The main function of the ray-tracing algorithm is a loop that scans all
    % pixels in the image matrix while creates rays that will be intersected
    % with the scene objects. 
    %
    % While the image matrix is indexed using $(i,j)$ coordinates, the geometric
    % calculations are done in $(u,v,w)$ space. To create the image
    % using ray-tracing, we need to associate each pixel $(i,j)$
    % to its coorresponding 3-D point ${\bf s} = (u,v,w)$ on the image plane. 

    texture = imread ('tc-earth_daymap.jpg');
    %map = imresize(map,[180,180]);
    % [t_row t_col] = size(texture);
    % [ l1,l2] = meshgrid( linspace(0,180,t_col), linspace(-90,90,t_row) );
    % subplot(121),imshow(texture);
    Phi = homography();
    for i = 1 : nrows
        for j = 1 : ncols
            im( i, j, : ) = kb;
        end
    end
    if exist('image.mat', 'file') == 2
            delete('image.mat');
    end
    save('image.mat','im','nrows','ncols');
    count = 0;
    % Loop over all pixels in the image
    for i = 1 : nrows
        for j = 1 : ncols
            %
            % Convert (i,j) pixel coordinates to s = ( u, v, w=focal length ).
            s = getPoint_s(i,j,f,nrows,ncols);

            % The initial viewing ray connects the eye location, e, and the
            % point s on image plane. The ray for pixel (i,j) is:
            r = Ray(e,s);

            %load('image.mat');
            % Intersect ray r with all scene objects
%             if (im( i,j, 1) == kb(1) && im( i,j, 2) == kb(2) && im( i,j, 1) == kb(3) )
%                 
%                 im( i, j, : ) = trace(r,theScene,Phi ,texture);
%                 %save('image.mat','im','nrows','ncols');
%            
%             else
%                 display('Here');
%             end
            im( i, j, : ) = trace(r,theScene,Phi ,texture);
            % display(im(i,j,:));
            count = count + 1 ;
            display(count);
        end
    end

    % Convert matrix of doubles to image data so we can display it. This step 
    % normalizes the pixel values so color components are between 0 and 255 (or
    % between 0 and 1). 
    im = mat2gray( im );

    % Display the image
    imshow( im );

%end   % End of the function
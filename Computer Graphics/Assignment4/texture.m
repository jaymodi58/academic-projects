% % Create Sphere 1
% center = [ 20, 20, -400 ]';
% radius = 200;
% [x,y,z] = sphere(radius);
% surf(x+center(1), y+center(2), z+center(3));
% hold on;
% 
% % Create Sphere 2
% center1 = [ -20, 20, -200 ]';
% radius1 = 60;
% [x,y,z] = sphere(radius1);
% surf(x+center1(1), y+center1(2), z+center1(3));
% hold off;



A=imread('tc-earth_daymap.jpg');
[mytext,map]=rgb2ind(A,256);
mytext=flipud(mytext);

% Create the surface.
[x,y,z] = sphere(100);

figure,surface(x,y,z,'CData',mytext,'FaceColor','texturemap','FaceLighting','phong','EdgeLighting','phong','EdgeColor','none');
%set the colormap. 

colormap(map);


%Create light object
light('position',[1 2 0 ],'Style','infinite','color',[0.8 0.7 0.8]);
light('position',[-2 -3 0 ],'color',[0.8 0.7 0.8]);


%Specify the viewpoint
axis square;
%view(12,0);
view(180,0);

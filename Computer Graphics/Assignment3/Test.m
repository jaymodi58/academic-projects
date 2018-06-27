x=object_point(1,:);
y=object_point(2,:);
z=object_point(3,:);
plot3(x,y,z,'.-')

%% Little triangles
% The solution is to use Delaunay triangulation. Let's look at some
% info about the "tri" variable.

tri = delaunay(x,y);
plot(x,y,'.')

%%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

%% Plot it with TRISURF

h = trisurf(tri, x, y, z);
axis vis3d

%% Clean it up

axis off
l = light('Position',[-50 -15 29])
set(gca,'CameraPosition',[208 -50 7687])
lighting phong
shading interp
colorbar EastOutside

%%
minX = min(object_point(1,:));
minY = min(object_point(2,:));
minZ = min(object_point(3,:));
maxX = max(object_point(1,:));
maxY = max(object_point(2,:));
maxZ = max(object_point(3,:));

object_point=object_point';


tri = delaunay(object_point(1,:), object_point(2,:));
trimesh(tri, object_point(1,:), object_point(2,:), object_point(3,:));

objX= object_point(1,:);        
    objY=object_point(2,:);
    objZ=object_point(3,:);
    dx=0.05;
    dy=0.05;
    x_edge=floor(min(objX)):dx:ceil(max(objX));
    y_edge=floor(min(objY)):dy:ceil(max(objY));
    [X,Y]=meshgrid(x_edge,y_edge);
    Z=griddata(objX,objY,objZ,X,Y);
    surf(X,Y,Z)
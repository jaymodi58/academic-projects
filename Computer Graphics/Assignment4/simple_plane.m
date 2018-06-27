%p0 = [ 0, 1600, 1 ]';
%normal = [ -1, -1, 1.5 ];


point = [0,-20,0];
normal = [0,-1,0];


%# a plane is a*x+b*y+c*z+d=0
%# [a,b,c] is the normal. Thus, we have to calculate
%# d and we're set
d = -point*normal'; %'# dot product for less typing

%# create x,y
[xx,yy]=ndgrid(1:10,1:10);

%# calculate corresponding z
z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);

%# plot the surface
surf(xx,yy,z);
hold on;

scatter3(0,1600,0,'o','filled'); 

xlabel('X ---->') % x-axis label
ylabel('Y ---->') % y-axis label
zlabel('Z ---->') % z-axis label

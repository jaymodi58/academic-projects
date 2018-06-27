clc;
clear all;
close all;

center1 = [ 10, 10, -200 ]';
radius1 = 30;
 
center2 = [  -10, 10, -100 ]';
radius2 = 10;

hold on;

[x y z] = sphere;
a=[ center1(1) center1(2)  center1(3)  radius1;...
    center2(1) center2(2)  center2(3)  radius2 ];
surf(x*a(1,4)+a(1,1) , y*a(1,4)+a(1,2) , z*a(1,4)+a(1,3));

hold off;

hold on;
surf(x*a(2,4)+a(2,1),y*a(2,4)+a(2,2),z*a(2,4)+a(2,3));
point = [0,-20,0];
normal = [-1,1,-1];


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


scatter3(0,0,400,'o','filled');       % Eye
%scatter3(0,0,-200,'*');             % light

grid;


xlabel('X ---->') % x-axis label
ylabel('Y ---->') % y-axis label
zlabel('Z ---->') % z-axis label

daspect([1 1 1])
view(30,10)





 
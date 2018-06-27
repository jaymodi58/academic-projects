
% 1st plane
% x=-10:.1:10;
% [X,Y] = meshgrid(x);
% a=2; b=-3; c=10; d=-1;
% Z=(d- a * X - b * Y)/c;
% surf(X,Y,Z);
% shading flat;
% xlabel('x'); ylabel('y'); zlabel('z');

% 2nd plane
% u=linspace(-5,5,81);
% v=linspace(0,10,81);
% [x,y]=meshgrid(u,v);
% xlabel('x'),ylabel('y'),zlabel('z')
% title('Horizontal Plane Example')
% 
% hold on
% z2=0*x + exp(1);    % the 0*x + exp(1) makes sure the output for z2 is the same size
%                     % as x and y, but only has the value of e in each component.
% mesh(x,y,z2)
% hold off

% xd=linspace(-2,2,40);
% yd=linspace(-2,2,40);
% [x,y]=meshgrid(xd,yd);
% 
% % first plane
% a1=0;
% b1=-2;
% c1=3;
% d1=1;
% z1=-a1/c1*x-b1/c1*y+d1/c1;
% 
% mesh(x,y,z1);





point = [0,-150,0];
normal = [0,150,0];

%# a plane is a*x+b*y+c*z+d=0
%# [a,b,c] is the normal. Thus, we have to calculate
%# d and we're set
d = -point*normal'; %'# dot product for less typing

%# create x,y
[xx,yy]=ndgrid(1:10,1:10);

%# calculate corresponding z
z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);

%# plot the surface
figure
surf(xx,yy,z)


xlabel('X ---->') % x-axis label
ylabel('Y ---->') % y-axis label
zlabel('Z ---->') % z-axis label

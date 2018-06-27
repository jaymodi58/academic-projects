function pathplanning()
%
% This program demonstrates a simple 
% path-planning approach based on 
% minimizing a cost function. 
%

% Particle's initial position
particle(1).StartPosition = [ 10 10 ]';

% Particle's current position
particle(1).CurrentPosition = particle(1).StartPosition;

% This is the goal position.  
particle(1).GoalPosition = [ 90 90 ]';

% (x,y) coordinates of the centroid of obstacles 
o(1).location=[ 30 40 ]';
o(1).R=25;
o(2).location=[ 60 50 ]';
o(2).R=25;
o(3).location=[ 30 80 ]';
o(3).R=25;
o(4).location=[ 80 20 ]';
o(4).R=25;
%display(size(o,2));

% Advancement step for gradient descent
lambda = 3;

% We will store the calculated path locations 
% in this array so we can plot them. 
X = [];

% Termination condition
GoalReached = false;

% Plot initial location of particles
s = particle(1).StartPosition;
g = particle(1).GoalPosition;
figure, 
plot( s(1), s(2),'ro', 'LineWidth', 2 )        % starting point
text( s(1)+2, s(2)-5, 'Start', 'FontSize', 12 );
hold on;


plot( g(1), g(2),'bo', 'LineWidth', 2 )    % goal point
text( g(1)+2, g(2)-5, 'Goal', 'FontSize', 12 );
axis([0 100 0 100 0 100]);
view([-20,40]);
%axis square;
set(gcf, 'Color', 'w' );


% Drawing Obstacles (filled circles).
filledCylinder(30,40,10);
filledCylinder(60,50,10);
filledCylinder(30,80,10);
filledCylinder(80,20,10);

% Initialize variables for locations
x = particle(1).StartPosition;
g = particle(1).GoalPosition;

% This loop calculates the new position of the particle.  
% It repeats until goal is reached 
n=1;
while ~GoalReached    
    
    % Calculate next step using gradient descent 
    x = x - lambda * Grad( x, g, o );

    % Store location. Concatenate the previous result with current's.
    X = [ X x ]; 
    
    % Plot particle at new location 
    hold on;
    plot( x(1), x(2), 'g*' )   % trajectory points
    axis([0 100 0 100 0 1]);
    
    frame=getframe;
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if n==1
         imwrite(imind,cm,'pathplanning.gif','gif', 'Loopcount',inf);
         n=2;
    else
         imwrite(imind,cm,'pathplanning.gif','gif','WriteMode','append');
    end
    
    
    % Pause for a moment so we can see the motion
    pause( .1 );               
    
    % Check if goal has been reached, i.e., distance 
    % between current and goal locations is less than a 
    % pre-defined threshold. 
    if ( norm( x - g ) <= 3 ) 
        GoalReached = true;
    end
    
end 
    


% Gradient vector (2-D direction) of cost function at current position
function G = Grad( p, g, o) 

% p:  2x1 vector with the current position 
% g:  2x1 vector with goal position


% Calculate the cost of moving to locations of a 4-size neighborhood
%
%            ^ 
%            |
%            y1
%            |
%  -- x2 --- p --- x1 --> 
%            |
%            y2
%            |
%
y1 = p + [  0;  1 ];
y2 = p + [  0; -1 ]; 

x1 = p + [  1;  0 ]; 
x2 = p + [ -1;  0 ];

% Calculate the components of the gradient vector
cx = Cpathplan( x1, g, o ) - Cpathplan( x2, g, o ); 
cy = Cpathplan( y1, g, o ) - Cpathplan( y2, g, o ); 

% Resultant vector formed by cost's x and y components
r = [ cx; cy ]; 

% Calculate the direction vector, i.e., direction of the gradient vector
G = r / norm( r ); 



function c = Cpathplan( p, g, o )
% Cost function for path planning calculated at position s with respect to
% goal g and obstacle o
%
% p:             2x1 vector with the current position 
% g:             2x1 vector with goal position
% o(i).location: 2x1 vector with obstacle position 
% o(i).R:        Radius of the obstacle 

% Value of log10E
logE = 2.718281828;

% Goal cost (Euclidean distance squared) 
c( 1 ) = norm(p-g);

% Collision cost 
field=0;

for i=1:size(o,2)
%     display(i);
%     display ( o(i).location(1));
%     display(o(i).location(2)); 
    dist = sqrt( (p(1)-o(i).location(1))^2 + (p(2)-o(i).location(2))^2 );
    %display(dist);
    if 0 < dist && dist <= o(i).R
        field_temp = logE ^ (log( o(i).R / dist )* logE);
    else
        field_temp=0;
    end
    field = field + field_temp;
end
%display(field);
c( 2 ) = field;             % TODO (Equation 3.2 of Breen's paper)

% Total cost 
c = c(1) + c(2); 

return 


function h = filledCylinder(x,y,r)
% Drawing filled cylinder in figure.
    hold on
    [X,Y,Z] = cylinder(r);
    Z=Z/6;
    surf(X+x,Y+y,Z)
    hold off
return
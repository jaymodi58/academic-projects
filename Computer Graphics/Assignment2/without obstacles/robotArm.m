function robotArm()
close all;
addpath( genpath( '.' ) ); 

% Target position
p = [ 10 10 ]';

% Construction of basic body part and its local coordinate frame
Part = BuildBasicPart();

%-------------------------------------------------------------------------
TransformedPart = DrawKinematicChain( Part, 0, 0 , 0, p );
% display(TransformedPart.Joints(1:2,2));

% Particle's initial position
particle(1).StartPosition = TransformedPart.Joints(1:2,2);

% Particle's current position
particle(1).CurrentPosition = particle(1).StartPosition;

% This is the goal position.  
particle(1).GoalPosition = p;

% (x,y) coordinates of the centroid of obstacles 
o = [];

% Advancement step for gradient descent
lambda = 1;

% We will store the calculated path locations 
% in this array so we can plot them. 
X = [];

% Termination condition
GoalReached = false;

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
    % plot( x(1), x(2), 'r*' )   % trajectory points
    temp = [x(1) x(2)];
    
    % Draw chain
    flag=0;
    for theta3 = 1 : 360
        for theta2 = 1 : 360
            for theta1 = 1 : 360
                answer = estimation( Part, theta1, theta2 , theta3, temp );
                if answer == true
                    % theta = [theta1, theta2 , theta3];
                    % display(theta);
                    DrawKinematicChain( Part, theta1, theta2, theta3, p );
                    flag = 1;
                end
                % pause(.05);
            end
            if flag == 1
                break;
            end
        end
        if flag == 1
                break;
        end
    end
    
    
        frame=getframe;
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if n==1
             imwrite(imind,cm,'robot.gif','gif', 'Loopcount',inf);
             n=2;
        else
             imwrite(imind,cm,'robot.gif','gif','WriteMode','append');
        end
    
    
    % Pause for a moment so we can see the motion
    pause( .1 );               
    
    % Check if goal has been reached, i.e., distance 
    % between current and goal locations is less than a 
    % pre-defined threshold. 
    if ( norm( x - g ) <= 1 ) 
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


    % Goal cost (Euclidean distance squared) 
    c( 1 ) = norm( p - g );

    % Collision cost 
    c( 2 ) = 0;             % TODO (Equation 3.2 of Breen's paper)

    % Other cost 
    c( 3 ) = 0;             % TODO (Not used in Example 1)     


    % Total cost 
    c = sum( c ); 
    
return 



%-------------------------------------------------------------------------
function DrawPart( Part, color )

% draw body part
plot( Part.Pts( 1, : ), Part.Pts( 2, : ), [color '.-'], 'LineWidth', 3 )
%axis equal;
axis( [ -5 25 -5 25 ] );
% view([-20,40]);
plot( Part.Joints( 1, : ), Part.Joints( 2, : ), ['r' '.'], 'LineWidth', 3 )

return 


function Part = BuildBasicPart()
%-------------------------------------------------------------------------
% Construction of basic body part (all parts of same size and shape)
%-------------------------------------------------------------------------
%                                                                    begin

% Basic body part of kinematic chain (rectangle)
Part.Pts    = [ 0 0; 1 0; 1 1; 0 1; 0 0]';
Part.Joints = [ 1/8 1/2; 7/8 1/2]';

% Add a row of ones to Pts to convert to homogeneous coordinates
Part.Pts    = [ Part.Pts; ...
                ones( 1, size( Part.Pts, 2 ) ) ];
Part.Joints = [ Part.Joints; ...
                ones( 1, size( Part.Joints, 2 ) ) ];
                           
% Scale part horizontally to its final size. 
S = [ 6  0  0  ; ...                      
      0  2  0  ; ...
      0  0  1 ];

Part.Pts    = S * Part.Pts;
% display(Part.Pts);
Part.Joints = S * Part.Joints;
% display(Part.Joints);


% Size of the scaled part (distance between joint points)
Part.d = norm( Part.Joints( 1:2, 2 ) - Part.Joints( 1:2, 1 ) );


% Place part's joint point at its rotation axis of the previous part. 
% This is done by translating the entire part so its "left" join point is 
% at the "right" joint point of the previous part. The base part will be
% connected to the origin of the World coordinate system. 
t = -Part.Joints( 1:2, 1 ) ;

T = [ 1  0  t(1)  ;...
      0  1  t(2)  ;...
      0  0   1   ]; 

Part.Pts    = T * Part.Pts;
Part.Joints = T * Part.Joints;

% Draw the local coordinate system for the body part
Part.x_axis = [ 0 0 1; 0 2 1]';
Part.y_axis = [ 0 0 1; 2 0 1]';

%                                                                       end
%--------------------------------------------------------------------------

return 


% Rotate as a function of the angle 
function R = Rotation( x ) 

% degree-to-radian conversion 
theta = x * pi / 180;

R = [ cos( theta )  -sin( theta )   0; ...
      sin( theta )   cos( theta )   0; ...
            0           0           1 ];

return

function T = Translation( d ) 
% Translation by a vector [ d 0 ]
T =  [ 1  0   d ; ...
       0  1   0 ; ...
       0  0   1 ];

return                 
 

function TransformedPart = DrawKinematicChain( Part, theta1, theta2, theta3, p )

clf;
hold on; 

% Plot target point 
plot( p( 1 ), p( 2 ), 'ro', 'LineWidth', 2 );
text( p( 1 )-1, p( 2 ) + 1, 'Target', 'FontSize', 13 );
% axis equal;
axis( [ -5 25 -5 25 ] );
% view([-20,40]);

% Adding rotating rod initially.
% Translate to join connection
d =  0; 
R0 = Rotation(90);
T0 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T0 * R0 * Part.Pts;
TransformedPart.Joints  = T0 * R0 * Part.Joints;
TransformedPart.x_axis  = T0 * R0 * Part.x_axis;
TransformedPart.y_axis  = T0 * R0 * Part.y_axis;
% draw body part
DrawPart( TransformedPart, 'k' );


% Translate to join connection
d = Part.d; 
R1 = Rotation(theta1);
T1 =  [ 1  0   0 ; ...
       0  1   d ; ...
       0  0   1 ];

%T1 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * Part.y_axis;
% draw body part
DrawPart( TransformedPart, 'b' );


% Translate to join connection
d = Part.d;
R2 = Rotation(theta2);
T2 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * T2 * R2 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * T2 * R2 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * T2 * R2 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * T2 * R2 * Part.y_axis;
       

% draw body part
DrawPart( TransformedPart, 'g' );


% Translate to join connection
d = Part.d;
R3 = Rotation(theta3);
T3 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * T2 * R2 * T3 * R3 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * T2 * R2 * T3 * R3 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * T2 * R2 * T3 * R3 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * T2 * R2 * T3 * R3 * Part.y_axis;
       

% draw body part
DrawPart( TransformedPart, 'c' );

hold off;

return


function answer = estimation( Part, theta1, theta2, theta3, temp)

% Adding rotating rod initially.
% Translate to join connection
d =  0; 
R0 = Rotation(90);
T0 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T0 * R0 * Part.Pts;
TransformedPart.Joints  = T0 * R0 * Part.Joints;
TransformedPart.x_axis  = T0 * R0 * Part.x_axis;
TransformedPart.y_axis  = T0 * R0 * Part.y_axis;

% Translate to join connection
d = Part.d; 
R1 = Rotation(theta1);
T1 =  [ 1  0   0 ; ...
       0  1   d ; ...
       0  0   1 ];

%T1 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * Part.y_axis;

% Translate to join connection
d = Part.d;
R2 = Rotation(theta2);
T2 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * T2 * R2 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * T2 * R2 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * T2 * R2 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * T2 * R2 * Part.y_axis;

% Translate to join connection
d = Part.d;
R3 = Rotation(theta3);
T3 = Translation(d);
TransformedPart = Part;
TransformedPart.Pts     = T1 * R1 * T2 * R2 * T3 * R3 * Part.Pts;
TransformedPart.Joints  = T1 * R1 * T2 * R2 * T3 * R3 * Part.Joints;
TransformedPart.x_axis  = T1 * R1 * T2 * R2 * T3 * R3 * Part.x_axis;
TransformedPart.y_axis  = T1 * R1 * T2 * R2 * T3 * R3 * Part.y_axis;

check=(TransformedPart.Joints(1:2,2))';

if round(check(1)) == round(temp(1)) && round(check(2)) == round(temp(2))
    answer = true;
else
    answer =false;
end

return
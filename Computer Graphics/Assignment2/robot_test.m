%-------------------------------------------------------------------------
% Construction of basic body part (all parts of same size and shape
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

% draw body part
plot( Part.Pts( 1, : ), Part.Pts( 2, : ), 'LineWidth', 3 )
axis equal;
axis( [ -5 15 -5 15 ] );
plot( Part.Joints( 1, : ), Part.Joints( 2, : ), ['k' '.'], 'LineWidth', 3 )

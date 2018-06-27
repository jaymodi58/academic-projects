% Demonstrates the projection of a set of 3-D points onto an image. The
% projection matrix was obtained from camera calibration. 
tic;
% clean up memory and close all figures
close all;
clear all;

% Pose number
imNumber = '0112';

run=0;

if (run == 1 )
    minX = -0.3;
    minY =  0.1;
    minZ = -0.3;
    maxX =  0.2;
    maxY =  1.7;
    maxZ =  0.2;
    step = 0.03;
else
    minX = -2.0;
    minY = -2.0;
    minZ = -2.0;
    maxX =  2.0;
    maxY =  2.0;
    maxZ =  2.0;
    step = 0.1;
end

% These are the first frames on Cameras 1 and 2
Cam(1).im = rgb2gray(imread(strcat('silhouettes/Silhouette1_',imNumber,'.png')));
Cam(2).im = rgb2gray(imread(strcat('silhouettes/Silhouette2_',imNumber,'.png')));
Cam(3).im = rgb2gray(imread(strcat('silhouettes/Silhouette3_',imNumber,'.png')));
Cam(4).im = rgb2gray(imread(strcat('silhouettes/Silhouette4_',imNumber,'.png')));
Cam(5).im = rgb2gray(imread(strcat('silhouettes/Silhouette5_',imNumber,'.png')));
Cam(6).im = rgb2gray(imread(strcat('silhouettes/Silhouette6_',imNumber,'.png')));
Cam(7).im = rgb2gray(imread(strcat('silhouettes/Silhouette7_',imNumber,'.png')));
Cam(8).im = rgb2gray(imread(strcat('silhouettes/Silhouette8_',imNumber,'.png')));

object_point=[];

% Number of Cameras
noc = 8;

% Sample 3-D points within a cube shape centered at the origin
    for X = minX : step : maxX
        for Y = minY : step : maxY
            for Z = minZ : step : maxZ

                hit=0;
                % Display the projection of cube points as seen from Cameras 1 to 8 
                for iCam = 1 : noc
                    % Obtain projection matrix for camera iCam
                    P = getProjMatrix( iCam );

                    % Project 3-D points to image points
                    x = P * [ X Y Z 1 ]';

                    % Transform homogeneous coords into cartesian
                    u = x(1)/x(3);
                    v = x(2)/x(3);
                   
                    if ( v <= size(Cam(iCam).im,1) && u <= size(Cam(iCam).im,2) && 1 <= u && 1 <= v)
                        if( (Cam(iCam).im(round(v),round(u))) ~= 0 )
                            hit = hit + 1;
                        end
                    end 
                end

                % Storing points if the point is hit by all the cameras.
                if(hit == noc)
                   temp = [ X Y Z ]';
                   object_point = [object_point, temp ];
                end
            end
        end
    end
%display(object_point);
minX = min(object_point(1,:));
minY = min(object_point(2,:));
minZ = min(object_point(3,:));
maxX = max(object_point(1,:));
maxY = max(object_point(2,:));
maxZ = max(object_point(3,:));

object_point=object_point';
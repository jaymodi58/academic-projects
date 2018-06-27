% %# load image
% img=imread('tc-earth_daymap.jpg');
% 
% %# convert pixel coordinates from cartesian to polar
% [r c] = size(img);
% [X Y] = meshgrid(1:c,1:r);
% [theta rho] = cart2pol(X, Y);
% 
% %# show pixel locations (subsample to get less dense points)
% XX = X(1:8:end,1:4:end);
% YY = Y(1:8:end,1:4:end);
% tt = theta(1:8:end,1:4:end);
% rr = rho(1:8:end,1:4:end);
% subplot(121), scatter(XX(:),YY(:),3,'filled'), axis ij image
% subplot(122), scatter(tt(:),rr(:),3,'filled'), axis ij square tight
% 
% %# show images
% figure
% subplot(121), imshow(img, map), axis on
% subplot(122), warp(theta, rho, zeros(size(theta)), img, map)
% view(2), axis square

I=imread('tc-earth_daymap.jpg');   %read image
I1=flipud(I);
A=imresize(I1,[1024 1024]);
A1=double(A(:,:,1));
A2=double(A(:,:,2));
A3=double(A(:,:,3));  %rgb3 channel to double
[m n]=size(A1);
[t r]=meshgrid(linspace(-pi,pi,n),1:m); %Original coordinate

M=2*m;
N=2*n;
[NN MM]=meshgrid((1:N)-n-0.5,(1:M)-m-0.5);
T=atan2(NN,MM);
R=sqrt(MM.^2+NN.^2);                  

B1=interp2(t,r,A1,T,R,'linear',0);
B2=interp2(t,r,A2,T,R,'linear',0);
B3=interp2(t,r,A3,T,R,'linear',0); %rgb3 channel Interpolation
B=uint8(cat(3,B1,B2,B3));        

subplot(211),imshow(I);  %draw the Original Picture
subplot(212),imshow(B);  %draw the result
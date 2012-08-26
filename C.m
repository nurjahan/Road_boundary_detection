function [Gradient,theta] = C(im,radius,no_of_orient,nbins)
%
% Calculate color gradient with multiple orientations

%	INPUT
%		im				RGB for color. range [0,1]
%		radius			radius of the disk size
%		no_of_orient	number of orientation
%		nbins			number of bin
%		
%	OUTPUT
%		Gradient		Size [h,w,d,no_of_orient] of color gradient image, here d is 3 as color has L, a and b value.
%
gamma = 2.5;
min_AB = -110;
max_AB = 110;
LAB = RGB2Lab(im.^gamma); 
LAB(:,:,1) = LAB(:,:,1) ./ 100;
LAB(:,:,2) = (LAB(:,:,2) - min_AB) ./ (max_AB-min_AB);
LAB(:,:,3) = (LAB(:,:,3) - min_AB) ./ (max_AB-min_AB);
LAB(:,:,2) = max(0,min(1,LAB(:,:,2)));
LAB(:,:,3) = max(0,min(1,LAB(:,:,3)));
	
if numel(radius)==1, radius = radius*ones(3,1); end
if numel(nbins)==1, nbins = nbins*ones(3,1); end
radius = radius(:);
nbins = nbins(:);
Gradient = zeros([size(im) no_of_orient]);
for i = 1:3, 
	map_C = max(1,ceil(LAB(:,:,i)*nbins(i)));
	[Gradient(:,:,i,:),theta] = grad_mul_Or(map_C,nbins(i),radius(i),no_of_orient);
end

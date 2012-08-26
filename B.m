function [brigness_G,theta] = B(im,radius,no_of_orient,nbins)
% Calculate brightness gradient with multiple orientations
%
%	INPUT
%		im				given image.range [0,1]
%		radius			radius of the disk size
%		no_of_orient	number of orientation
%		nbins			number of bin
%		
%	OUTPUT
%		Gradient		Size [h,w,no_of_orient] of brightness gradient image

im1=rgb2gray(im);
%%gaussianFilter = fspecial('gaussian', [3, 3]);
%%im1= filter2(gaussianFilter, im1);

map_B = max(1,ceil(im1*nbins));
[brigness_G,theta] = grad_mul_Or(map_B,nbins,radius,no_of_orient);

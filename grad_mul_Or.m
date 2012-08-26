function [Gradient,theta] = grad_8_Or(map_BCT,n_BCT,radius,no_of_orient)
%
% Compute the gradient for brightness, color or texture with multiple orientations 
%INPUT
%	map_BCT			color map for color or gary color map for brightness or texton map for texture. values in [1,n_BCT]
%	n_BCT			number of bin for color and brightness or number of texton for texture
%	radius			radius of the disc
%	no_of_orient	number of orientation
%
%OUTPUT
%	Gradient		Size [h w no_of_orient] containing gradient
%	theta			containging disc orientations


radius = max(1,radius);
no_of_orient = max(1,no_of_orient);
theta = (0:no_of_orient-1)/no_of_orient*pi;

[h,w] = size(map_BCT);
Gradient = zeros(h,w,no_of_orient);
fwrite(1,'[');
for i = 1:no_of_orient,
	fwrite(1,'.');
	Gradient(:,:,i) = grad_1_Or(map_BCT,n_BCT,radius,theta(i));
end
fwrite(1,sprintf(']\n'));

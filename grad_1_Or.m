function [Gradient] = grad_1_Or(map_BCT,n,radius,theta)
%
% Compute the gradient of brightness, color or texture for each single orientation
%INPUT
%	map_BCT			color map for color or gary color map for brightness or texton map for texture. values in [1,n_BCT]
%	n				number of bin for color and brightness or number of texton for texture
%	radius			radius of the disc
%	no_of_orient	number of orientation
%
%OUTPUT
%	Gradient		Size [h w] containing gradient

% process options
radius = max(1,radius);
theta = mod(theta,pi);
radius_w = floor(radius);

% count number of pixels in a disc
[u,v] = meshgrid(-radius_w:radius_w,-radius_w:radius_w);
mask = (u.^2 + v.^2 <= radius^2);
mask(radius_w+1,radius_w+1) = 0; % mask out center pixel to remove bias
count = sum(mask(:));

x1=radius*cos(theta);
y1=radius*sin(theta);
x=0;y=0;
side=1+((((x1-x)*(v-y))-((y1-y)*(u-x)))>0);	

if theta==0;
	side1=1+(v==0 & u>0);
	side=side1.*side;
end

side = side .* mask;

if sum(sum(side==1)) ~= sum(sum(side==2)), error('bug:inbalance'); end
f_half_disk = (side==1)/count*2;
s_half_disk = (side==2)/count*2;

% compute gradient using 2*n convolutions
Gradient = zeros(size(map_BCT)); 
for i = 1:n,
	im = double(map_BCT==i); 
	GradientL = conv2(im,f_half_disk,'same');
	GradientR = conv2(im,s_half_disk,'same');
	Gradient = Gradient + sum((GradientL-GradientR).^2./(GradientL+GradientR+eps),3);
end
Gradient = 0.5 * Gradient;



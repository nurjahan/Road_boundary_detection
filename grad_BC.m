function [Gradient,theta] = grad_BC(im,radius,no_of_orient,smooth,sigmaSmo)

% Calculate color or brightness gradient with multiple orientations

%	INPUT
%		im				RGB for color or gray for brightness. range [0,1]
%		radius			radius of the disk size
%		no_of_orient	number of orientation
%		
%	OUTPUT
%		Gradient		Size [h,w,d,no_of_orient] of color gradient image, here d is 3 as color has L, a and b value.

nbins = 32;
gamma = 2.5;

if ndims(im)==2, % compute gradient from gray image for brightness
	map_B = max(1,ceil(im*nbins));
	[Gradient,theta] = grad_mul_Or(map_B,nbins,radius,no_of_orient,smooth,sigmaSmo);
	
else,  % compute gradient from LAB image for color
	% min and max values for a,b channels of LAB used to scale values into the unit interval.Range of a and b are [-110,110]
	min_AB = -110;
	max_AB = 110;
	LAB = RGB2Lab(im.^gamma); %%http://en.wikipedia.org/wiki/Gamma_correction
	LAB(:,:,1) = LAB(:,:,1) ./ 100;
	LAB(:,:,2) = (LAB(:,:,2) - min_AB) ./ (max_AB-min_AB);
	LAB(:,:,3) = (LAB(:,:,3) - min_AB) ./ (max_AB-min_AB);
	LAB(:,:,2) = max(0,min(1,LAB(:,:,2)));
	LAB(:,:,3) = max(0,min(1,LAB(:,:,3)));
	
	if numel(radius)==1, radius = radius*ones(3,1); end
	if numel(nbins)==1, nbins = nbins*ones(3,1); end
	if numel(sigmaSmo)==1, sigmaSmo = sigmaSmo*ones(3,1); end
	radius = radius(:);
	nbins = nbins(:);
	sigmaSmo = sigmaSmo(:);
	
	Gradient = zeros([size(im) no_of_orient]);
	for i = 1:3, 
		map_C = max(1,ceil(LAB(:,:,i)*nbins(i)));
		[Gradient(:,:,i,:),theta] = grad_mul_Or(map_C,nbins(i),radius(i),no_of_orient,smooth,sigmaSmo(i));
	end
end










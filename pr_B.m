function [probability] = pr_B(im,radius,no_of_orient,nbins)
%
% Calculate the probability of boundary using brightness Gradient.
%
%	INPUT
%		im				image
%		radius			radius of the disk
%		no_of_orient	number of orientation
%		nbins			number of bin
%
%	OUTPUT			
%		probability		size [h,w] containg probability of pixel boundary 


 beta=[ -3.6944 2.7430];%%beta from logistic fits with the help of training image set

[bright_G,gtheta] = B(im,radius,no_of_orient,nbins);

% calculate oriented probability
[h,w,max_G] = size(im);
prob_mul_Or = zeros(h,w,no_of_orient);

for i = 1:no_of_orient,
	bright = bright_G(:,:,i); 
	bright = bright(:);
	x1 = [ones(size(bright)) bright];
	z=x1*beta';
	probability_i = 1 ./ (1 + (exp(-z))); 
	prob_mul_Or(:,:,i) = reshape(probability_i,[h w]);
end

% nonmax suppression and max over orientations
[max_G,max_Or] = max(prob_mul_Or,[],3); %% max_G= maximum value from 8 orientations, max_Or= corresponding orientation of the maximum one
probability = zeros(h,w);
max_theta=(max_Or-1)/no_of_orient*pi;
probability_i = nonmax_Subpression1(max(0,max_G),max_theta); 
%%probability_i1=probability_i >.05;
probability = max(0,min(1,probability_i));



function [probability] = pr_T(im,radius,no_of_orient,nbins)
%
% Calculate the probability of boundary using texture Gradient
%
%	INPUT
%		im				image
%		radius			radius of the disk
%		no_of_orient	number of orientation
%		nbins			number of bin
%
%	OUTPUT			
%		probability		size [h,w] containg probability of pixel boundary 


beta=[-4.7151 6.3752]; %%beta from logistic fits with the help of training image set
[texture_G,gtheta] = T(im,radius,no_of_orient,nbins);

% calculate oriented probability
[h,w,max_G] = size(im);
prob_mul_Or = zeros(h,w,no_of_orient);

for i = 1:no_of_orient,
	texture = texture_G(:,:,i); texture = texture(:);
	x1 = [ones(size(texture)) texture];
	z=x1*beta';
	probability_i = 1 ./ (1 + (exp(-z))); 
	prob_mul_Or(:,:,i) = reshape(probability_i,[h w]);
end

% nonmax suppression and max over orientations
[max_G,max_Or] = max(prob_mul_Or,[],3); %% max_G= maximum value from 8 orientations, max_Or= corresponding orientation of the maximum one
probability = zeros(h,w);
max_theta=(max_Or-1)/no_of_orient*pi;
probability_i = nonmax_Subpression1(max(0,max_G),max_theta); 
%%probability_i1=probability_i>.6;
probability = max(0,min(1,probability_i));

% mask out 1-pixel border where nonmax suppression fails
probability(1,:) = 0;
probability(end,:) = 0;
probability(:,1) = 0;
probability(:,end) = 0;


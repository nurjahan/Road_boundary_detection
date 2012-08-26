function [probability] = pr_C(im,radius,no_of_orient,nbins)
%
% Calculate the probability of boundary using color Gradient
%
%	INPUT
%		im				image
%		radius			radius of the disk
%		no_of_orient	number of orientation
%		nbins			number of bin
%
%	OUTPUT			
%		probability		size [h,w] containg probability of pixel boundary 


beta=[-2.9216  1.5439   2.7643]; %%beta from logistic fits with the help of training image set
[color_G,gtheta] = C(im,radius,no_of_orient,nbins);

% calculate oriented probability
[h,w,max_G] = size(im);
prob_mul_Or = zeros(h,w,no_of_orient);

for i = 1:no_of_orient,
	LAB_a = color_G(:,:,2,i); LAB_a = LAB_a(:);
	LAB_b = color_G(:,:,3,i); LAB_b = LAB_b(:);
	x1 = [ones(size(LAB_a)) LAB_a LAB_b];
	z=x1*beta';
	probability_i = 1 ./ (1 + (exp(-z))); %%http://en.wikipedia.org/wiki/Logistic_regression ()
	prob_mul_Or(:,:,i) = reshape(probability_i,[h w]);
end

% nonmax suppression and max over orientations
[max_G,max_Or] = max(prob_mul_Or,[],3); %% max_G= maximum value from 8 orientations, max_Or= corresponding orientation of the maximum one
probability = zeros(h,w);
max_theta=(max_Or-1)/no_of_orient*pi;
probability_i = nonmax_Subpression1(max(0,max_G),max_theta); 
probability_i1=probability_i>.06;
probability = max(0,min(1,probability_i1));



function [textiure_G,theta] = T(im,radius,no_of_orient,nbins)
%
% assign each pixel to nearst texton
% compute texture gradient
% no of odd symmetric filter=6 and no of even symmetric filter=6. 
% 2 scales [1,sqrt(2)] and 32-mean cluster
% elong is 2.start sigma 1.

im2=rgb2gray(im);
k=32;
univ_tex_name = sprintf( ...
    'Universal_texton_%d_k-mean.mat',k);
univ_texton = load(univ_tex_name); 
tmap = texton_map(filter_bank(univ_texton.fb,im2),univ_texton.tex);
[textiure_G,theta] = grad_mul_Or(tmap,k,radius,no_of_orient);
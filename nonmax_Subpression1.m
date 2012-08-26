function [im] = nonmax_Subpression(im,max_theta)


% Perform non-max suppression whic is orthogonal to theta
%
%%	INPUT
%%		im		size[h w] maximum gradient magnitude among 8 orientations
%%		max_Or  size[h w] corresponding gradient orientation of maximum gradient magnitude

%%	OUTPUT
%%		im		size[h w] nonmax subpressed image

max_theta = mod(max_theta+pi/2,pi);

% Determine which pixels belong to which cases.

mask37 = ( max_theta>=pi/2 & max_theta<pi*3/4 );
mask48 = ( max_theta>=pi*3/4 & max_theta<pi );
mask15 = ( max_theta>=0 & max_theta<pi/4 );
mask26 = ( max_theta>=pi/4 & max_theta<pi/2 );
mask = ones(size(im));
[h,w] = size(im);
[ix,iy] = meshgrid(1:w,1:h);

id = find( mask15 & ix<w & iy<h & ix>1 & iy>1);
id_n1 = id + h;
id_n2=id-h;
mask(id(find((im(id)<im(id_n1)) | (im(id)<im(id_n2))))) = 0;

id2 = find( mask26 & ix<w & iy<h & ix>1 & iy>1);
id2_n1 = id2 -h- 1;
id2_n2 = id2 +h+1;
mask(id2(find((im(id2)<im(id2_n1)) | (im(id2)<im(id2_n2))))) = 0;

id3 = find( mask37 & ix>1 & iy>1 & ix<w & iy<h);
id3_n1 = id3 + 1;
id3_n2 = id3 - 1;
mask(id3(find((im(id3)<im(id3_n1)) | (im(id3)<im(id3_n2))))) = 0;

id4 = find( mask48 & ix>1 & iy<h & ix<w & iy>1);
id4_n1 = id4 - h+1;
id4_n2= id4 + h - 1;
mask(id4(find((im(id4)<im(id4_n1)) | (im(id4)<im(id4_n2))))) = 0;

% apply mask to image
im = im .* mask;

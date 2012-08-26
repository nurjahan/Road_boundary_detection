function [probability,probability_i1,max_theta_degree,im1] = pr_BCT(im,radius,no_of_orient,nbins,Hf,Hdendro,HtopCls)

% Calculate the probability of boundary using Brightness color and texture Gradient
%
%	INPUT
%		im				image
%		radius			radius of the disk
%		no_of_orient	number of orientation
%		nbins			number of bin
%
%	OUTPUT			
%		probability		size [h,w] containg probability of pixel boundary 


%%beta=[-4.50 1.9072 1.2478 1.3107 3.6687]; %%beta from logistic fits with the help of training image set
beta=[-4.50 2.9072 1.2478 1.3107 3.6687];
[bright_G,gtheta] = B(im,radius,no_of_orient,nbins);
[color_G,gtheta] = C(im,radius,no_of_orient,nbins);
[texture_G,gtheta] = T(im,radius,no_of_orient,nbins);

% calculate oriented probability
[h,w,max_G] = size(im);
prob_mul_Or = zeros(h,w,no_of_orient);
probability_i2 = zeros(h,w,3);


for i = 1:no_of_orient,
	bright = bright_G(:,:,i); 
	bright = bright(:);
	LAB_a = color_G(:,:,2,i); LAB_a = LAB_a(:);
	LAB_b = color_G(:,:,3,i); LAB_b = LAB_b(:);
	texture = texture_G(:,:,i); texture = texture(:);
	x1 = [ones(size(bright)) bright LAB_a LAB_b texture];
	z=x1*beta';
	probability_i = 1 ./ (1 + (exp(-z))); 
	prob_mul_Or(:,:,i) = reshape(probability_i,[h w]);
end

% nonmax suppression and max over orientations
[max_G,max_Or] = max(prob_mul_Or,[],3); %% max_G= maximum value from 8 orientations, max_Or= corresponding orientation of the maximum one
probability = zeros(h,w);
probability_i3 = zeros(h,w,3);
max_theta=(max_Or-1)/no_of_orient*pi;
max_theta_degree = radtodeg(max_theta); %%normal X-Y
probability_i = nonmax_Subpression1(max(0,max_G),max_theta); 

probability_i(1:4,:)=0;
probability_i(h-4:h,:)=0;
probability_i(:,1:4)=0;
probability_i(:,w-4:w)=0;
probability_i(1:4,:)=0
probability_i(200,:)=0

%%probability_i1=(probability_i>0);
probability_i1=(probability_i>.3);



	fid1 = fopen('max_Or.txt', 'wt'); % Open for writing
	for i=1:size(max_Or,1)
		fprintf(fid1, '%d ', max_Or(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	fid1 = fopen('probability_i1.txt', 'wt'); % Open for writing
	for i=1:size(probability_i1,1)
		fprintf(fid1, '%d ', probability_i1(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	fid1 = fopen('probability_i.txt', 'wt'); % Open for writing
	for i=1:size(probability_i,1)
		fprintf(fid1, '%d ', probability_i(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	fid1 = fopen('max_theta_degree.txt', 'wt'); % Open for writing
	for i=1:size(max_theta_degree,1)
		fprintf(fid1, '%d ', max_theta_degree(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
	
	
	[probability_i4,im1,small_line,line_position1,normalize_polar,pl_coordinate]=polar_coordinate(im,no_of_orient,max_Or,max_theta_degree,probability_i1,h,w,Hf,Hdendro,HtopCls); 


%%%%%%%%%%%%%%%%%%%%%%%%% saving output as file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	fid1 = fopen('line_position1.txt', 'wt'); % Open for writing
	for i=1:size(line_position1,1)
		fprintf(fid1, '%d ', line_position1(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	fid1 = fopen('pl_coordinate.txt', 'wt'); % Open for writing
	for i=1:size(pl_coordinate,1)
		fprintf(fid1, '%d ', pl_coordinate(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	fid1 = fopen('small_line.txt', 'wt'); % Open for writing
	for i=1:size(small_line,1)
		fprintf(fid1, '%d ', small_line(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	fid1 = fopen('normalize_polar.txt', 'wt'); % Open for writing
	for i=1:size(normalize_polar,1)
		fprintf(fid1, '%d ', normalize_polar(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	
	
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
probability=probability_i4;





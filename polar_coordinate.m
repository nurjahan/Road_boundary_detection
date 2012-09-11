function [probability_i4,im1,small_line,line_position1,normalize_polar,pl_coordinate]=polar_coordinate(im,no_of_orient,max_Or,max_theta_degree,probability_i1,h,w,Hf,Hdendro,HtopCls)

max_Or_1=max_Or';
probability_i1_1=probability_i1';
%%max_theta_degree1 = radtodeg(max_theta); %%image X Y
p=1;
k=1;
im1=im;
for t=1:no_of_orient
	cont=t;
	ort=find(max_Or_1==t & probability_i1_1==1);
	[h1 w1]=size(ort);
	for i=1:h1
		i1=mod(ort(i),w); %% row
		j1=floor(ort(i)/w)+1; %%column
		if i1==0
			i1=w;
			j1=j1-1;
		end	
		
%%%%%%%%%%%%%%%% set the color wheel %%%%%%%%%%%%%%%%%
		x11=i1;
		y11=j1;
		switch cont,
		case{1}, %%180 for normal X-Y axis
			probability_i4(j1,i1,1)=1;
			probability_i4(j1,i1,2)=1;
			probability_i4(j1,i1,3)=0;	
			small_line(k,1)=x11+1;
			small_line(k,2)=y11;
		case{2}, %%157
			probability_i4(j1,i1,1)=1;
			probability_i4(j1,i1,2)=0;
			probability_i4(j1,i1,3)=1;
			small_line(k,1)=x11+2;
			small_line(k,2)=y11+1;
		case{3}, %%135
			probability_i4(j1,i1,1)=0;
			probability_i4(j1,i1,2)=1;
			probability_i4(j1,i1,3)=1;
			small_line(k,1)=x11+1;
			small_line(k,2)=y11+1;
		case{4}, %%112.5
			probability_i4(j1,i1,1)=1;
			probability_i4(j1,i1,2)=0;
			probability_i4(j1,i1,3)=0;
			small_line(k,1)=x11+1;
			small_line(k,2)=y11+2;
		case{5}, %%90
			probability_i4(j1,i1,1)=0;
			probability_i4(j1,i1,2)=1;
			probability_i4(j1,i1,3)=0;		
			small_line(k,1)=x11;
			small_line(k,2)=y11+1;
		case{6}, %%67.5
			probability_i4(j1,i1,1)=0;
			probability_i4(j1,i1,2)=0;
			probability_i4(j1,i1,3)=1;
			small_line(k,1)=x11-1;
			small_line(k,2)=y11+2;
		case{7}, %%45
			probability_i4(j1,i1,1)=1;
			probability_i4(j1,i1,2)=1;
			probability_i4(j1,i1,3)=1;	
			small_line(k,1)=x11-1;
			small_line(k,2)=y11+1;			
		case{8}, %%22.5
			probability_i4(j1,i1,1)=1;
			probability_i4(j1,i1,2)=.64;
			probability_i4(j1,i1,3)=0;	
			small_line(k,1)=x11-2;
			small_line(k,2)=y11+1;
	
		end	
		im1(j1,i1,1)=probability_i4(j1,i1,1); %% boundary RGB image with color wheel
		im1(j1,i1,2)=probability_i4(j1,i1,2);
		im1(j1,i1,3)=probability_i4(j1,i1,3);
		
%%%%%%%%%%%%%%%%%%%%%%%%%% set polar coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		x1=i1;
		y1=j1;
		
		theta1=(max_theta_degree(j1,i1)*pi/180);
		if theta1 ~=pi/2  
			m=tan(theta1);
			c=y1-m*x1;
			y2=0;
			x2=(y2-c)/m;
			y=c/(m^2+1);
			x=-(m*c/(m^2+1));
			
		else
			y2=0;
			x2=x1;
			y=0;
			x=x1;
			
		end		
		
		%% another way to calculate d
		
		d=sqrt(x^2+y^2);
		if y<0
			dis=-d;
			d=-d;
		else
			dis=d;
		end
		 
		%%dis=d;
		%%d=sqrt(d^2);
		% angle with x axis to the orthogonal distance
		theta2=acos(dis/x2);
		%%theta2=acos(d/xw0);
		theta2=max(0,theta2*180/pi);
		line_position1(k,1)=x1;
		line_position1(k,2)=y1;
		line_position1(k,3)=x2; %% when y=0=y2;
		line_position1(k,4)=y2; %%y2=0
		line_position1(k,5)=max_theta_degree(j1,i1);
		line_position1(k,6)=y; %% intersection point between line and origin for calculating polar
		%%line_position1(k,7)=max_theta_degree1(j1,i1);
		pl_coordinate(k,1)=d;
		pl_coordinate(k,2)=theta2;
		k=k+1;		
		%% for line passing through the point
			
	end
end	

%%%%%%%%%%%%%%%%%%%%%%%%% normalize polar coordinae %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% technique 1 %%%%%%%%%%%%%%%%%%
max_d=max(pl_coordinate(:,1));
max_theta=max(pl_coordinate(:,2));
min_d=min(0,min(pl_coordinate(:,1)));
min_theta=min(0,min(pl_coordinate(:,2)));
normalize_polar(:,1) = (pl_coordinate(:,1)- min_d) ./ (max_d-min_d);
normalize_polar(:,2) = (pl_coordinate(:,2)- min_theta) ./ (max_theta-min_theta);

%%%%%%%%%%%%%%%%%% technique 2 %%%%%%%%%%%%%%%%
% [h,w,n] = size(im);
% idiag = norm([h w]);
% normalize_polar(:,1) = pl_coordinate(:,1)./idiag ;
% normalize_polar(:,2) = pl_coordinate(:,2)./360;
% if normalize_polar(:,2)==0
	% normalize_polar(:,2)==1;
% end	

%%%%%%%%%%%%%%% technique 3 %%%%%%%%%%%%%%%%
% cv=cov(pl_coordinate);
% Icv=inv(cv);
% [hpc wpc]=size(pl_coordinate);
% %%for l=1:hpc
% l=1:hpc;
% normalize_polar(l,1:2)=pl_coordinate(l,1:2)*Icv;
% %%end	


fid1 = fopen('normalize_polar.txt', 'wt'); % Open for writing
	for i=1:size(normalize_polar,1)
		fprintf(fid1, '%d ', normalize_polar(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
fid1 = fopen('pl_coordinate.txt', 'wt'); % Open for writing
	for i=1:size(pl_coordinate,1)
		fprintf(fid1, '%d ', pl_coordinate(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
fid1 = fopen('line_position1.txt', 'wt'); % Open for writing
	for i=1:size(line_position1,1)
		fprintf(fid1, '%d ', line_position1(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	

im1(1:4,:,1)=im(1:4,:,1);
im1(1:4,:,2)=im(1:4,:,2);	
im1(1:4,:,3)=im(1:4,:,3);

im1(h-4:h,:,1)=im(h-4:h,:,1);
im1(h-4:h,:,2)=im(h-4:h,:,2);	
im1(h-4:h,:,3)=im(h-4:h,:,3);

im1(:,1:4,1)=im(:,1:4,1);
im1(:,1:4,2)=im(:,1:4,2);
im1(:,1:4,3)=im(:,1:4,3);

im1(:,w-4:w,1)=im(:,w-4:w,1);	
im1(:,w-4:w,2)=im(:,w-4:w,2);	
im1(:,w-4:w,3)=im(:,w-4:w,3);	

figure(Hf);
imshow(im1);
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%5 test for image 2%%%%%%%%%%%%%%%%%%%%5
% lineLength = 600;
% angle = 157;
% xt(1) = 190;
% yt(1) = 80;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 87;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);
% lineLength = 600;

% angle = 157;
% xt(1) = 180;
% yt(1) = 89;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 90;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 91;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 92;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 93;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

% lineLength = 600;
% angle = 157;
% xt(1) = 180;
% yt(1) = 94;
% xt(2) = xt(1) + lineLength * cosd(angle);
% yt(2) = yt(1) + lineLength * sind(angle);
% hold on; % Don't blow away the image.
% plot(xt, yt, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


[Zsin1,H,T,PREM,mem,cluster_xy] = show_dendrogram(normalize_polar,line_position1,small_line,Hdendro,Hf);
%%save mem;
[variance]=variance_calculation(mem,normalize_polar,pl_coordinate);

[hv wv]=size(mem);

[cluster_confidence]=confidence_assignment(variance,wv);
percentage=20;
% hndl.s2=uicontrol('parent', HtopCls,'Style', 'slider',...
         % 'Min',0,'Max',100,'Value',20,...
         % 'Position', [810 40 120 20],'Tag', 'thresholdCls','Callback', {@threshold_cluster});   % Uses cell array function handle callback
                                    % % % Implemented as a subfunction with an argument
show_top_clusters(cluster_confidence,mem,line_position1,im,percentage,HtopCls,pl_coordinate);
click_dendro(mem,cluster_confidence,line_position1,small_line,cluster_xy,Hdendro,Hf,Zsin1);
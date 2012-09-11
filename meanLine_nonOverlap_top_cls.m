function meanLine_nonOverlap_top_cls(im,nonOvr_mem,len,pl_coordinate,line_position1,color,HtopCls)

% for j=1:len
	% nonOvr_add = cell2mat(nonOvr_mem(j));
	% polar_dis=(pl_coordinate(nonOvr_add,1));
	% polar_ang=(pl_coordinate(nonOvr_add,2));
	% dis_avg=round(mean(polar_dis));
	% ang_avg=round(mean(polar_ang));
	% if ang_avg<90
		% line_ang=ang_avg+90;
	% else
		% line_ang=ang_avg-90;
	% end	
	% ang_avg_rad = degtorad(ang_avg);
	% [X(1),Y(1)] = pol2cart(ang_avg_rad,dis_avg);
	% figure(HtopCls);
	% lineLength = 1000;
	% X(2) = X(1) + lineLength * cosd(line_ang);
	% Y(2) = Y(1) + lineLength * sind(line_ang);
	% plot(X, Y,'Color',color(j,1:3), 'LineWidth',2);
	% %%cl=color(j);
	% %%line(X,Y,'Color',cl,'LineWidth',2);
% end

% for j=1:len
	% nonOvr_add = cell2mat(nonOvr_mem(j));
	% x=(line_position1(nonOvr_add,1));
	% y=(line_position1(nonOvr_add,2));
	% %%figure(f);
	% %%plot(x,y,'*');
	% l=length(x);
	% for i=1:l
		% XY(1,i)=x(i);
		% XY(2,i)=y(i);
	% end
	% iterNum=5;thDist=.71;thInlrRatio=.5;[ theta,rho ] = ransac( XY,iterNum,thDist,thInlrRatio );
	% y=1:300;
	% x(y)=(rho-(cos(theta)*y))/sin(theta);
	% figure(HtopCls);
	% line(x,y,'Color',color(j,1:3),'LineWidth',2);
	% %%plot(X, Y,'Color',color(j,1:3), 'LineWidth',2);
	% %%cl=color(j);
	% %%line(X,Y,'Color',cl,'LineWidth',2);
% end

for j=1:len
	nonOvr_add = cell2mat(nonOvr_mem(j));
	x=(line_position1(nonOvr_add,1));
	y=(line_position1(nonOvr_add,2));
	check_ang=(line_position1(nonOvr_add,5));
	if(check_ang(1)~=0)
		iterNum=5;thDist=5;thInlrRatio=.5;
		l=length(x);
		for i=1:l
			XY(1,i)=x(i);
			XY(2,i)=y(i);
		end
		[ theta,rho ] = ransac( XY,iterNum,thDist,thInlrRatio );
		min_y=min(y);
		max_y=max(y);
		lim=max_y-min_y+1;
		i=1:lim;
		p_y=min_y:max_y;
		p_x=(rho-(cos(theta)*p_y))/sin(theta);
		figure(HtopCls);
		line(p_x,p_y,'Color',color(j,1:3),'LineWidth',2);
		min_x=(rho-(cos(theta)*min_y))/sin(theta);
		max_x=(rho-(cos(theta)*max_y))/sin(theta);
		LineEndPoints(j,1:4)=[min_x min_y max_x max_y];
		% LineEndPoints(j,1)=min_x;
		% LineEndPoints(j,2)=min_y;
		% LineEndPoints(j,3)=max_x;
		% LineEndPoints(j,4)=max_y;
	
	else  %% for horizontal line
		min_y=y(1); 
		max_y=y(1);
		min_x=min(x);
		max_x=max(x);
		LineEndPoints(j,1:4)=[min_x min_y max_x max_y];
		% LineEndPoints(j,2)=min_y;
		% LineEndPoints(j,3)=max_x;
		% LineEndPoints(j,4)=max_y;
	end	
end

fid1 = fopen('LineEndPoints.txt', 'wt'); % Open for writing
	for i=1:size(LineEndPoints,1)
		fprintf(fid1, '%d ', LineEndPoints(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	

checkPerspective(im);	
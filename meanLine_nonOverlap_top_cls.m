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
	i1=1;
	if(check_ang(1)~=0)
		i1=1;
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
		
		x0=0;
		y0=0;
		xw=293;
		yh=220;

		y_x0=round((rho-(sin(theta)*x0))/cos(theta));
		x_y0=round((rho-(cos(theta)*y0))/sin(theta));
		y_xw=round((rho-(sin(theta)*xw))/cos(theta));
		x_yh=round((rho-(cos(theta)*yh))/sin(theta));
		rh_th(j,1:2)=[rho theta];
		
		if y_x0>0 & y_x0<yh
			endpoints(j,i1)=x0;
			endpoints(j,i1+1)=y_x0;
			i1=i1+2;
			
		end

		if x_y0>0 & x_y0<xw
			%%if y_x0~=0 & x_y0~=0
				endpoints(j,i1)=x_y0;
				endpoints(j,i1+1)=y0;
				i1=i1+2;
			%%end
			
		end

		if y_xw>0 & y_xw<yh
			endpoints(j,i1)=xw;
			endpoints(j,i1+1)=y_xw;
			i1=i1+2;
			
		end
		
		if x_yh>0 & x_yh<xw
			
			endpoints(j,i1)=x_yh;
			endpoints(j,i1+1)=yh;
			i1=i1+2;
			
		end
		
		if y_x0==0 | x_y0==0
			endpoints(j,i1)=x0;
			endpoints(j,i1+1)=y_x0;
			i1=i1+2;
		end
		
		if x_y0==293 | y_xw==0
			endpoints(j,i1)=x_y0;
			endpoints(j,i1+1)=y0;
			i1=i1+2;
		end
		
		if x_yh==0 | y_x0==220
			endpoints(j,i1)=x_yh;
			endpoints(j,i1+1)=yh;
			i1=i1+2;
		end
		
		if x_yh==293 | y_xw==220
			endpoints(j,i1)=x_yh;
			endpoints(j,i1+1)=yh;
			i1=i1+2;
		end
			
		%%meanLineRhoTh(j,1:2)=[rho theta];
		% LineEndPoints(j,1)=min_x;
		% LineEndPoints(j,2)=min_y;
		% LineEndPoints(j,3)=max_x;
		% LineEndPoints(j,4)=max_y;
	
	elseif (check_ang(1)==0)  %% for horizontal line
		i1=1;
		min_y=y(1); 
		max_y=y(1);
		min_x=min(x);
		max_x=max(x);
		LineEndPoints(j,1:4)=[min_x min_y max_x max_y];
		%%meanLineRhoTh(j,1:2)=[0 0];
		% LineEndPoints(j,2)=min_y;
		% LineEndPoints(j,3)=max_x;
		% LineEndPoints(j,4)=max_y;
		endpoints(j,i1)=0;
		endpoints(j,i1+1)=0;
		endpoints(j,i1+2)=0;
		endpoints(j,i1+3)=0;
	end	
end

fid1 = fopen('rh_th.txt', 'wt'); % Open for writing
	for i=1:size(rh_th,1)
		fprintf(fid1, '%d ', rh_th(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
fid1 = fopen('LineEndPoints.txt', 'wt'); % Open for writing
	for i=1:size(LineEndPoints,1)
		fprintf(fid1, '%d ', LineEndPoints(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);		
fid1 = fopen('endpoints.txt', 'wt'); % Open for writing
	for i=1:size(endpoints,1)
		fprintf(fid1, '%d ', endpoints(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	

checkPerspective(im);	
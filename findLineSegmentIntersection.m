 function [state,intersection]=findLineSegmentIntersection(x0,y0,x1,y1,x2,y2,x3,y3)
    %%// TODO: Make limit depend on input domain
    LIMIT    = 1e-5;
    INFINITY = 1e10;
    flag=0;
    %%// Slope of the two lines
	if sqrt((x0-x1)^2)<=LIMIT
		a0=INFINITY;
	else
		a0=(y0 - y1) / (x0 - x1);
	end

	if sqrt((x2-x3)^2)<=LIMIT
		a1=INFINITY;
	else
		a1=(y2 - y3) / (x2 - x3);
	end	
    b0 = y0 - a0 * x0;
    b1 = y2 - a1 * x2;
    
   %% // Check if lines are parallel
    if  (a0== a1) 
	
      if (b0~=b1)
        %%return -1; // Parallell non-overlapping
		state=-1;
		flag=1;
		intersection(1:2)=0;
		return ;
      else 
        if (x0==x1) 
			if (min (y0, y1) < max (y2, y3) | max (y0, y1) > min (y2, y3)) 
				twoMiddle = y0 + y1 + y2 + y3 -min (min(y0, y1), min(y2, y3)) - max (max(y0, y1), max(y2, y3));
				y = (twoMiddle) / 2.0;
				x = (y - b0) / a0;
          
			else 
				%%return -1;  // Parallell non-overlapping
				state=-1;
				intersection(1:2)=0;
				return ;
			end	
        
        else 
			if (min (x0, x1) < max (x2, x3) | max (x0, x1) > min (x2, x3)) 
				twoMiddle = x0 + x1 + x2 + x3 - min (min(x0, x1),min( x2, x3)) - max (max(x0, x1),max( x2, x3));
            x = (twoMiddle) / 2.0;
            y = a0 * x + b0;
          
			else 
				%%return -1;
				state=-1;
				intersection(1:2)=0;
				return ;
			end
        end
        
		intersection(1) = x;
		intersection(2)= y;
		%%return -2;
		state=-2;
		return ;
      end
    end
    
    %%// Find correct intersection point
    if (a0==INFINITY)
      x = x0;
      y = a1 * x + b1;
    
    elseif (a1==INFINITY) 
      x = x2;
      y = a0 * x + b0;
    
    else 
      x = - (b0 - b1) / (a0 - a1);
      y = a0 * x + b0; 
    end
    
    intersection(1) = x;
    intersection(2)= y;
    distanceFrom1=-1;
	distanceFrom2=-1;
    %%// Then check if intersection is within line segments 
    if  (x0==x1) 
      if (y0 < y1)
        
		if y < y0 
			[distanceFrom1] =getDistance2Pts (x, y, x0, y0) ;
		else
			if y > y1 
				[distanceFrom1]=getDistance2Pts (x, y, x1, y1);
			else
				distanceFrom1=0;
			end
		end	
		% distanceFrom1 = y < y0 ? getDistance2Pts (x, y, x0, y0) :
                        % y > y1 ? getDistance2Pts (x, y, x1, y1) : 0.0;
      else
		if y < y1
			[distanceFrom1]=getDistance2Pts (x, y, x1, y1);
		else
			if y > y0
				[distanceFrom1]=getDistance2Pts (x, y, x0, y0);
			else
				distanceFrom1=0;
			end	
        % distanceFrom1 = y < y1 ? getDistance2Pts (x, y, x1, y1) :
                     % y > y0 ? getDistance2Pts (x, y, x0, y0) : 0.0;
		end	
	  end 	
    else 
      if (x0 < x1)
		if x < x0
			[distanceFrom1]=getDistance2Pts (x, y, x0, y0);
		else
			if x > x1
				[distanceFrom1]=getDistance2Pts (x, y, x1, y1);
			else
				distanceFrom1=0;
			end	
		end	
        % distanceFrom1 = x < x0 ? getDistance2Pts (x, y, x0, y0) :
                        % x > x1 ? getDistance2Pts (x, y, x1, y1) : 0.0;
      else
        if x < x1
			[distanceFrom1]=getDistance2Pts (x, y, x1, y1);
		else
			if x > x0
				[distanceFrom1]=getDistance2Pts (x, y, x0, y0);
			else
				distanceFrom1=0;
			end
		end		
		% distanceFrom1 = x < x1 ? getDistance2Pts (x, y, x1, y1) :
                    % x > x0 ? getDistance2Pts (x, y, x0, y0) : 0.0;
      end
	end
    
    if (x2==x3) 
      if (y2 < y3)
		if y < y2
			[distanceFrom2]=getDistance2Pts (x, y, x2, y2);
		else
			if y > y3
				[distanceFrom2]=getDistance2Pts (x, y, x3, y3);
			else
				distanceFrom2=0;
			end
		end		
        % distanceFrom2 = y < y2 ? getDistance2Pts (x, y, x2, y2) :
                        % y > y3 ? getDistance2Pts (x, y, x3, y3) : 0.0;
      else
        if y < y3
			[distanceFrom2]=getDistance2Pts (x, y, x3, y3);
		else
			if y > y2
				[distanceFrom2]=getDistance2Pts (x, y, x2, y2);
			else
				distanceFrom2=0;
			end
		end
	  end	
		% distanceFrom2 = y < y3 ? getDistance2Pts (x, y, x3, y3) :
                        % y > y2 ? getDistance2Pts (x, y, x2, y2) : 0.0;
    
    else 
      if (x2 < x3)
		if x < x2 
			[distanceFrom2]=getDistance2Pts (x, y, x2, y2);
		else
			if x > x3
				[distanceFrom2]=getDistance2Pts (x, y, x3, y3);
			else
				distanceFrom2=0;
			end
		end
        % distanceFrom2 = x < x2 ? getDistance2Pts (x, y, x2, y2) :
                        % x > x3 ? getDistance2Pts (x, y, x3, y3) : 0.0;
      else
		if x < x3 
			[distanceFrom2]=getDistance2Pts (x, y, x3, y3);
		else
			if x > x2
				[distanceFrom2]=getDistance2Pts (x, y, x2, y2);
			else
				distanceFrom2=0;
			end
		end
        % distanceFrom2 = x < x3 ? getDistance2Pts (x, y, x3, y3) :
      end                 % x > x2 ? getDistance2Pts (x, y, x2, y2) : 0.0;
    end
    
    if distanceFrom1==0 & distanceFrom2==0
		%%return 1
		state=1;
	elseif  distanceFrom1~=-1 & distanceFrom2~=-1
		%%return 0;
		state=0;
	end	
	% return equals (distanceFrom1, 0.0) &&
      % equals (distanceFrom2, 0.0) ? 1 : 0;
  
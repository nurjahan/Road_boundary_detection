function checkPerspective(im)

	LineEndPoints=load('LineEndPoints.txt');
	[imageH imageW n]=size(im);
	flag=0;
	imageBottomLn_x1=0;
	imageBottomLn_y1=imageH;
	imageBottomLn_x2=imageW;
	imageBottomLn_y2=imageH;
    %%Point perspectiveVec = new Point(0, 1); //take upward vector
	perspectiveVec_x = 0;
	perspectiveVec_y= 1;
	numLine=length(LineEndPoints);	
	p_add=1;
	for pair1=1:numLine
		for pair2=1:numLine
			pair_add1=pair1;
			pair_add2=pair2;
            l1_x1=LineEndPoints(pair_add1,1);
			l1_y1=LineEndPoints(pair_add1,2);
			l1_x2=LineEndPoints(pair_add1,3);
			l1_y2=LineEndPoints(pair_add1,4);
			
			l2_x1=LineEndPoints(pair_add2,1);
			l2_y1=LineEndPoints(pair_add2,2);
			l2_x2=LineEndPoints(pair_add2,3);
			l2_y2=LineEndPoints(pair_add2,4);
			
            [length1]=getDistance2Pts(l1_x1, l1_y1, l1_x2, l1_y2);
			[length2]=getDistance2Pts(l2_x1, l2_y1, l2_x2, l2_y2);
			if (length1 > length2) 
                tmp = length2;
                length2 = length1; %%// line 2 should be big one
                length1 = tmp;
            end
			[state, intesectPt] = findLineSegmentIntersection(l1_x1, l1_y1, l1_x2, l1_y2, l2_x1, l2_y1, l2_x2, l2_y2);
			XIntersectionPoint(pair1,pair2)=(intesectPt(1));
			YIntersectionPoint(pair1,pair2)=(intesectPt(2));
                %%// check direction
			if (state == 0 | state == 1)  %%intersection exist
                [tt,gPt1]=findLineSegmentIntersection(l1_x1, l1_y1, l1_x2, l1_y2, imageBottomLn_x1,imageBottomLn_y1, imageBottomLn_x2, imageBottomLn_y2);
                [tt,gPt2]=findLineSegmentIntersection(l2_x1, l2_y1, l2_x2, l2_y2, imageBottomLn_x1,imageBottomLn_y1, imageBottomLn_x2, imageBottomLn_y2);
                if (gPt1(1) < gPt2(1)) 
                    pair_groundLeft_x =gPt1(1);
					pair_groundLeft_y =gPt1(2);
					pair.groundRight_x =gPt2(1);
					pair.groundRight_y =gPt2(2);
                    
				else 
					pair_groundLeft_x =gPt2(1);
					pair_groundLeft_y =gPt2(2);
					pair.groundRight_x =gPt1(1);
					pair.groundRight_y =gPt1(2);
                end

                x = 0;
                y = -1;
                [d1]=getDistance2Pts(l1_x1, l1_y1, intesectPt(1), intesectPt(2));
				[d2]=getDistance2Pts(l1_x2, l1_y2, intesectPt(1), intesectPt(2));
				if d1<d2  
                    x = l1_x2 - intesectPt(1);
                    y = l1_y2 - intesectPt(2);
                else 
                    x = l1_x1 - intesectPt(1);
                    y = l1_y1 - intesectPt(2);
                end
				if y<=.5
					y=0;
				end	
                if ((x*perspectiveVec_x+ y*perspectiveVec_y) > 0) 
					[d1]=getDistance2Pts(l2_x1, l2_y1, intesectPt(1), intesectPt(2));
					[d2]=getDistance2Pts(l2_x2, l2_y2, intesectPt(1), intesectPt(2));
                    if d1< d2
                        x = l2_x2 - intesectPt(1);
                        y = l2_y2 - intesectPt(2);
                    else 
                        x = l2_x1 - intesectPt(1);
                        y = l2_y1 - intesectPt(2);
                    end
                    if y<=.5
						y=0;
					end	
					if ((x*perspectiveVec_x+y*perspectiveVec_y) > 0) 
						flag=1;
						%%disp('Yes');
                        %%pair.vanishingPt = new Point((int) intesectPt[0], (int) intesectPt[1]);
						pair_vanishingPt = [intesectPt(1) intesectPt(2)]; 
                        persepectiveList_add(p_add,1)=pair_add1;
						persepectiveList_add(p_add,2)=pair_add2;
						p_add=p_add+1;
					end	
                end
            end
		end	
    end
    
if flag==1
	fid1 = fopen('persepectiveList_add.txt', 'wt'); % Open for writing
	for i=1:size(persepectiveList_add,1)
		fprintf(fid1, '%d ', persepectiveList_add(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
end	

fid1 = fopen('XIntersectionPoint.txt', 'wt'); % Open for writing
	for i=1:size(XIntersectionPoint,1)
		fprintf(fid1, '%d ', XIntersectionPoint(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
fid1 = fopen('YIntersectionPoint.txt', 'wt'); % Open for writing
	for i=1:size(YIntersectionPoint,1)
		fprintf(fid1, '%d ', YIntersectionPoint(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
disp('Total Number of perspective pairs');
disp(p_add-1);
%%%%%%%%%% to show perspetive lines %%%%%%%%%%%%%%%%%%%%
perspetiveLine = unique(persepectiveList_add);
l=length(perspetiveLine);
f=figure;
figure(f);
imshow(im);
hold on;
for i=1:l
	figure(f);
	line([LineEndPoints(perspetiveLine(i),1) LineEndPoints(perspetiveLine(i),3)],[LineEndPoints(perspetiveLine(i),2) LineEndPoints(perspetiveLine(i),4)],'LineWidth',2);
end
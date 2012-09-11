function show_top_clusters (cluster_confidence,mem,line_position1,im,percentage,HtopCls,pl_coordinate)
%%global mem;
im2=im;
[hCl wCl]=size(cluster_confidence);

top_ranked=floor(hCl*percentage/100);
[sortedValues,sortIndex] = sort(cluster_confidence(:),'descend');

fid1 = fopen('sortedValues.txt', 'wt'); % Open for writing
	for i=1:size(sortedValues,1)
		fprintf(fid1, '%d ', sortedValues(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
fid1 = fopen('sortIndex.txt', 'wt'); % Open for writing
	for i=1:size(sortIndex,1)
		fprintf(fid1, '%d ', sortIndex(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
maxIndex = sortIndex(1:top_ranked);

fid1 = fopen('maxIndex.txt', 'wt'); % Open for writing
	for i=1:size(maxIndex,1)
		fprintf(fid1, '%d ', maxIndex(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
cls_address=mem(maxIndex);

top_cls_address = cell2mat(cls_address);
%%disp(cls_address);
top_mem_x=(line_position1(top_cls_address,1));
top_mem_y=(line_position1(top_cls_address,2));
%disp('cls');
% disp(top_members_x);
% disp('y:');
% disp(top_members_y);
x=top_mem_x;
y=top_mem_y;
[h w]=size(x);
%disp(top_cls_address );
%im2(y,x,:)=im1(y,x,:);
 HOvrCls =figure('position', [50 50 1550 900],...
 'resize', 'on', 'toolbar', 'none',...
  'name', 'Overlaping clusters','numbertitle', 'off',...
  'backingstore', 'off', 'doublebuffer', 'on');
  pl_coordinate=load('pl_coordinate.txt');
nonOverlap_top_clusters(im,line_position1,cls_address,top_ranked,HtopCls,HOvrCls,pl_coordinate);

 % figure(HtopCls);
 % imshow(im);
 % hold on;
 % figure(HtopCls);
 % plot(x,y,'*');





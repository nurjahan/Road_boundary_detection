function nonOverlap_top_clusters(im,line_position1,cls_address,top_ranked,HtopCls,HOvrCls)

clf(HOvrCls);
[nrows, ncols] = cellfun(@size, cls_address);
[sortElem,sortIndx] = sort(ncols(:));
n=top_ranked;
k=1:n;
parent(k)=0;
child(k)=0;
for i=1:n-1
	j=i+1;
	while j<=n
 		loc=ismember(cls_address{sortIndx(i)},cls_address{sortIndx(j)});
		TF=(sum(loc)==numel(cls_address{sortIndx(i)}));
		if TF==1
			parent(i)=j;
			child(i)=1;
 			%%j=n+1;
			break;
		else
 			j=j+1;
		end
	end	
end

%%%%%%%%% Non overlaping top clusters %%%%%%%%%%%%%
nonOvr_top_cls=find(child(k)~=1);
length(nonOvr_top_cls);
len=length(nonOvr_top_cls);
l=1:len;
nonOvr_add=sortIndx(nonOvr_top_cls(l));
nonOvr_mem=cls_address(nonOvr_add); %% need to draw line for each non overlaping clusters
nonOvr_mem1 = cell2mat(nonOvr_mem);
x=(line_position1(nonOvr_mem1,1));
y=(line_position1(nonOvr_mem1,2));

%%%%%%%%%%% Overlaping top clusters %%%%%%%%%%%%%%%%
Ovr_top_cls=find(child(k)~=0);
length(Ovr_top_cls);
len1=length(Ovr_top_cls);
l1=1:len1;
Ovr_add=sortIndx(Ovr_top_cls(l1));
Ovr_mem=cls_address(Ovr_add);
Ovr_mem1 = cell2mat(Ovr_mem);
x1=(line_position1(Ovr_mem1,1));
y1=(line_position1(Ovr_mem1,2));

%%%%%%%%% show all top clusters %%%%%%%%%%%%%%%%
%%HOvrCls=figure;
figure(HOvrCls);
imshow(im);
hold on;
figure(HOvrCls);
plot(x,y,'.');
hold on;
figure(HOvrCls);
plot(x1,y1,'ro');
hold on;

%%%%%%%%% show non overlaping top clusters by connect each one with line%%%%%%%%%%%%%
figure(HtopCls);
imshow(im);
hold on;
%%figure(HtopCls);
%%plot(x,y,'.');
for j=1:len
	%%j=1:len;
	nonOvr_mem1 = cell2mat(nonOvr_mem(j));
	x2=(line_position1(nonOvr_mem1,1));
	y2=(line_position1(nonOvr_mem1,2));
	[sortx2,x2Indx]=sort(x2);
	sorty2=y2(x2Indx);
	figure(HtopCls);
	%%figure(HNonOvrCls);
	line(sortx2,sorty2,'Color',rand(1,3),'LineWidth',1.5);
	hold on;
end	

fid1 = fopen('nonOverlap_parent.txt', 'wt'); % Open for writing
	for i=1:size(parent,1)
		fprintf(fid1, '%d ', parent(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
fid1 = fopen('nonOverlap_child.txt', 'wt'); % Open for writing
	for i=1:size(child,1)
		fprintf(fid1, '%d ', child(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
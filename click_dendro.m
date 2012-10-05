function click_dendro(mem,normalize_clsCon,line_position,cluster_xy,Hdendro,Hf,Zsin1)

[nh nw]=size(Zsin1);
h_dendro=max(Zsin1(:,3));
y_interval=h_dendro/nh;
x_interval=1;
k=0;
i=1;
%%keypress='y';
keypress = input('click dendrogram (y/n)? ','s');
while  keypress=='y'
	figure(Hdendro);
	in=i-k;[click_x click_y] = ginput(in);
	k=k+1;
	figure(Hf);
	if i>1
		%%unplot(h2);
	end
	%%nm_click_x=(click_x-cluster_min_x)/ (cluster_max_x-cluster_min_x); 
	%%nm_click_y=(click_y-cluster_min_y)/ (cluster_max_y-cluster_min_y);
	%%dif_click=abs((nm_cluster_xy(:,1)-nm_click_x)+(nm_cluster_xy(:,2)-nm_click_y)); 

	%%min_dif=find(dif_click==min(dif_click));%% address of the minimum diffurence among all dif_click
	
	min_dif=find(abs(cluster_xy(:,1)-click_x)<x_interval & abs(cluster_xy(:,2)-click_y)<y_interval)
	clusterMem_x=line_position(mem{min_dif},1); %%first find the corresponding cluster of minimum diference,then find x of each cluster member
	clusterMem_y=line_position(mem{min_dif},2);%%find y of each cluster membe

	x1=line_position(mem{min_dif},1);
	y1=line_position(mem{min_dif},2);
	%%x2=small_line(mem{min_dif},1);
	%%y2=small_line(mem{min_dif},2);
	
	%%top_clsAdd=find(normalize_clsCon==1)
	%%top_clusterX=line_position(mem{top_clsAdd},1);
	%%top_clusterY=line_position(mem{top_clsAdd},2);
	%%figure(Hf);
	%%plot(top_clusterX, top_clusterY,'Marker','p','Color',[0 1 1],'MarkerSize',15);
	%%hold on;
	[h2 w2]=size(x1);
	%for j=1:h2
		j=1:h2;
		%%X=[x1(j) x2(j)];
		%%Y=[y1(j) y2(j)];
		figure(Hf);
		%%line(X,Y,'Color','w','LineWidth',2); %% work
		plot(x1(j), y1(j),'*','Color',rand(1,3));
		%%plot([X(2),Y(2)],[X(1),Y(1)],'Color','r','LineWidth',2)
	%end
	figure(Hdendro);
	plot(click_x, click_y,'Marker','p','Color',[0 1 1],'MarkerSize',15);
	i=i+1;
	click_confidence=normalize_clsCon(min_dif);
	disp('confidence of the clicked cluster:');
	disp(click_confidence);
	keypress = input('click dendrogram (y/n)? ','s');
end



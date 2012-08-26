function [Zsin1,H,T,PREM,mem,cluster_xy] = show_dendrogram(normalize_polar,line_position,small_line,Hdendro,Hf)

D1 = pdist(normalize_polar,'euclidean');
Zsin1 = linkage(D1,'average');
p=0; 
clf(Hdendro);
figure(Hdendro);
[H,T,PREM] = dendrogram(Zsin1,p,'colorthreshold','default');
hold on;

[nh nw]=size(Zsin1);
n=nh+1;
%%%%%%%%%%%%%% find x and y coordinate of each cluster head %%%%%%%%%%%%
for i=1:nh
	count=0;
	if Zsin1(i,1)<=n & Zsin1(i,2)<=n
 		first_mem=find(PREM==Zsin1(i,1));
		sec_mem=find(PREM==Zsin1(i,2));
		cluster_xy(i,1)=(first_mem+sec_mem)/2;
	elseif Zsin1(i,1)>n & Zsin1(i,2)>n
		first_mem=cluster_xy(Zsin1(i,1)-n,1);
		sec_mem=cluster_xy(Zsin1(i,2)-n,1);
		cluster_xy(i,1)=(first_mem+sec_mem)/2;
	elseif Zsin1(i,1)>n & Zsin1(i,2)<=n
		first_mem=cluster_xy(Zsin1(i,1)-n,1);
		sec_mem=find(PREM==Zsin1(i,2));
		cluster_xy(i,1)=(first_mem+sec_mem)/2;
	elseif Zsin1(i,2)>n & Zsin1(i,1)<=n
		first_mem=find(PREM==Zsin1(i,1));
		sec_mem=cluster_xy(Zsin1(i,2)-n,1);
		cluster_xy(i,1)=(first_mem+sec_mem)/2;
	end
end
cluster_xy(:,2)=Zsin1(:,3);
plot(cluster_xy(:,1),cluster_xy(:,2),'*');%% plot * to each cluster head

%%%%%%%%%%%%%%%%% find members of each clusters %%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nh
	count=0;
	if Zsin1(i,1)<=n & Zsin1(i,2)<=n
		clster(i)=count+2;
		mem{i}=[Zsin1(i,1) Zsin1(i,2)];
	elseif Zsin1(i,1)>n & Zsin1(i,2)>n
		count=clster(Zsin1(i,1)-n);
		count=clster(Zsin1(i,2)-n)+count;
		clster(i)=count;
		mem{i}=[mem{(Zsin1(i,1)-n)} mem{(Zsin1(i,2)-n)}];
	elseif Zsin1(i,1)>n & Zsin1(i,2)<=n
		count=clster(Zsin1(i,1)-n)+1;
		clster(i)=count;
		mem{i}=mem{(Zsin1(i,1)-n)};
		mem{i}=[mem{(Zsin1(i,1)-n)} Zsin1(i,2)];
	elseif Zsin1(i,2)>n & Zsin1(i,1)<=n
		count=clster(Zsin1(i,2)-n)+1;
		clster(i)=count;
		mem{i}=[mem{(Zsin1(i,2)-n)} Zsin1(i,1)];
	end
end

for_mem(mem);
%%variance(mem);

%%%%%%%%%%%%%%%%%%%%%
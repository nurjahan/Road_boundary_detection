function [normalize_clsCon]= confidence_assignment(variance,wv)

% for i=1:wv
	% v=variance(i,2);
	% n=variance(i,3);
	% [con_dis]=confidence(v,n);
	% v=variance(i,5);
	% [con_ang]=confidence(v,n);
	% total_confidence=con_dis*con_ang;
	% %%total_confidence=con_dis;
	% cluster_confidence(i)=total_confidence;
% end
v1=variance(:,2);
n1=variance(:,3);
[con_dis]=confidence(v1,n1,wv);
v2=variance(:,5);
[con_ang]=confidence(v2,n1,wv);
total_confidence=con_dis.* con_ang;
cluster_confidence=total_confidence;

%%%%%%%%%%%%% normalize %%%%%%%%%%%%%%%
 max_con=max(cluster_confidence);
 min_con=min(0,min(cluster_confidence));
 normalize_clsCon = (cluster_confidence- min_con) ./ (max_con-min_con);



%%cluster_confidence=cluster_confidence';
	fid1 = fopen('cluster_confidence.txt', 'wt'); % Open for writing
	for i=1:size(cluster_confidence,1)
		fprintf(fid1, '%d ', cluster_confidence(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);

	fid1 = fopen('normalize_clsCon.txt', 'wt'); % Open for writing
	for i=1:size(normalize_clsCon,1)
		fprintf(fid1, '%d ', normalize_clsCon(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	fid1 = fopen('con_ang.txt', 'wt'); % Open for writing
	for i=1:size(con_ang,1)
		fprintf(fid1, '%d ', con_ang(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);	
	


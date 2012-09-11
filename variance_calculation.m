function [variance]=variance_calculation(mem,normalize_polar,pl_coordinate)

[h w]=size(mem);
[update_mem]=update_mem_cluster(mem,w,pl_coordinate);
for i=1:w
	variance(i,1)=var(normalize_polar(update_mem{i},1));
	if variance(i,1)<=1e-10
		variance(i,1)=0;
	end	
	if variance(i,1)~=0
		variance(i,2)=1/variance(i,1);
	else
		variance(i,1)=1e-33;
		variance(i,2)=1/variance(i,1);
	end	
	[hm wm]=size(mem{i});
	variance(i,3)=wm;
	variance(i,4)=var(normalize_polar(mem{i},2));
	if variance(i,4)<=1e-10
		variance(i,4)=0;
	end	
	if variance(i,4)~=0
		variance(i,5)=1/variance(i,4);
	else
		variance(i,4)=1e-33;
		variance(i,5)=1/variance(i,4);
	end	
end
%%j=1:w;
%%variance(j,6)=(variance(j,3).^6)./variance(j,1);
fid1 = fopen('variance.txt', 'wt'); % Open for writing
	for i=1:size(variance,1)
		fprintf(fid1, '%d ', variance(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	

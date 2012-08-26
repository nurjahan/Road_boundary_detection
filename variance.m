function [variance]=variance_calculation(mem,normalize_polar)

[h w]=size(mem);

for i=1:w
	variance(i,1)=var(normalize_polar(mem{i},1));
	variance(i,2)=1/variance(i,1);
	[hm wm]=size(mem{i});
	variance(i,3)=wm;
end
	fid1 = fopen('variance.txt', 'wt'); % Open for writing
	for i=1:size(variance,1)
		fprintf(fid1, '%d ', variance(i,:));
		fprintf(fid1, '\n');
	end
	fclose(fid1);
	

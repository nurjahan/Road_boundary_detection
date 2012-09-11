function [update_mem]=update_mem_cluster(mem,w,pl_coordinate)

for i=1:w
	elm=mem{i};
	[hm wm]=size(elm);
	pc=pl_coordinate(elm,1);
	sort_pc=sort(pc);
	dif(1,1)=0;
	pc_ang=pl_coordinate(elm,2);
	
	k=2:wm;
	dif(k,1)=sort_pc(k)-sort_pc(k-1);
	[sortElem,sortIndx] = sort(pc);
	update_elem=[];
	update_elem(1,1)=sortIndx(1);
	for j=2:wm
		if (dif(j,1)<= .3170) %%& (pc_ang(sortIndx(j)))==pc_ang(sortIndx(j-1))) %%.7071  %%.3170 
			update_elem(j,1)=update_elem(j-1,1);
		else
			update_elem(j,1)=sortIndx(j);
		end
	end
	address=elm(update_elem);
	update_mem{i}=address;
end

save update_mem;
%%var=var(normalize_polar(update_mem));

%%if var_116<=1e-20
	%%var_116=0;


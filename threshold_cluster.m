function threshold_cluster(cbo,eventdata,im, Hf, Hdendro,HtopCls) 
%%global mem;
%%global img_name;
%%im=imread(img_name);
disp('slider selected');
s2 = findobj(0, 'Tag', 'thresholdCls');
b=get(s2, 'Value');
f=b(1);
disp(b(1));
tf = iscell(b);	
cluster_confidence=load('cluster_confidence.txt');
line_position1=load('line_position1.txt');
%%max_theta_degree=load('max_theta_degree.txt');
%%no_of_orient=8;
%%[h w]=size(probability_i);
if tf==1
	percentage=f{1};
else
	percentage=f;
end	

load('mem.MAT');
disp('mem:');
disp('image:');
disp(im(1,1,1));
show_top_clusters(cluster_confidence,mem,line_position1,im,percentage,HtopCls,Hf)

%%[probability_i4,im_th,small_line,line_position1,normalize_polar,pl_coordinate]=polar_coordinate(im,no_of_orient,max_Or,max_theta_degree,probability_th,h,w,Hf,Hdendro,HtopCls);

%%figure(Hf);
%%imshow(im_th);


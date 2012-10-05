function thresholded_Image(cbo, eventdata,im, Hf, Hdendro,HtopCls) 

disp('slider selected');
sl = findobj(0, 'Tag', 'threshold');
b=get(sl, 'Value');
f=b(1);
disp(b(1));
tf = iscell(b);	
probability_i=load('probability_i.txt');
max_Or=load('max_Or.txt');
max_theta_degree=load('max_theta_degree.txt');
no_of_orient=8;
[h w]=size(probability_i);
if tf==1
	probability_th=(probability_i>f{1});
else
	probability_th=(probability_i>f);
end	


[probability_i4,im_th,line_position1,normalize_polar,pl_coordinate]=polar_coordinate(im,no_of_orient,max_Or,max_theta_degree,probability_th,h,w,Hf,Hdendro,HtopCls);

%%figure(Hf);
%%imshow(im_th);


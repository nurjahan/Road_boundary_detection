function [probability,probability_i1,max_theta_degree,im1] = pr_G(cbo, eventdata,im,feature,Hf,Hdendro,HtopCls)
% 
 %	INPUT
 %		im				given image
 %		feature			given feature like any combination of brightness, color and texture
 %
 %	OUTPUT
 %		probability		size [h,w] containg probability of pixel boundary 

[h,w,n] = size(im);
idiag = norm([h w]);
radius=0.04*idiag;
no_of_orient=8; 
no_of_bin=32;

switch feature,
	case{'b'}, [probability]=pr_B(im,radius,no_of_orient,no_of_bin);  
	case{'c'}, [probability]=pr_C(im,radius,no_of_orient,no_of_bin);  
	case{'t'}, [probability]=pr_T(im,radius,no_of_orient,no_of_bin); 
	case{'bc','cb'},[probability]=pr_BC(im,radius,no_of_orient,no_of_bin);  
	case{'bt','tb'},[probability]=pr_BT(im,radius,no_of_orient,no_of_bin); 
	case{'ct','tc'},[probability]=pr_CT(im,radius,no_of_orient,no_of_bin);
	case{'bct','btc','cbt','ctb','tbc','tcb'}, [probability,probability_i1,max_theta_degree,im1]=pr_BCT(im,radius,no_of_orient,no_of_bin,Hf,Hdendro,HtopCls); 
end


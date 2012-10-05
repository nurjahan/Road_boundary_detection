function [total_area]=confidence(v1,n1,wv);


%%%%%%%%%%%%%%%% for testing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%%function [total_area]=confidence(v,n);
%%v1=[.2 .5 .7 .3 .8 .11 .10 .6 .4 .9];
%%n1=[9 6 4 8 3 2 2 5 7 3];

%%v1=[.2 .2 .2 .2 .2 .2 .2 .2 .2 .2];
%%n1=[9 6 4 8 3 2 2 5 7 3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i=1:wv;
v=v1(i);
n=n1(i);

mean = 0;
alpha0 = mean - 0.05 * (sqrt(v ./ n));
alpha1 = mean + 0.05 * (sqrt(v ./ n));
epsilon0 = mean - 0.05 *(sqrt(v));
epsilon1 = mean + 0.05 * (sqrt(v));
beta0 = (n - 1);
beta1 = 1.21 *(n - 1);
x = beta0;
stepChi = (beta1 - beta0) ./ 100;
stepT = (alpha1 - alpha0) ./ 100;
stepNormal = (epsilon1 - epsilon0) ./ 100;

area1 = 0;
x = beta0;
total_area = 0;
deg_fr=n-1;
while x < beta1
	%5x=beta0:stepChi:beta1;
	t = x;
	y = 0;
	if t ~= 0
		y =  ((v) .* (n - 1))./ chi2pdf(x,deg_fr);
	end
	area1=area1+y;
	x=x+stepChi;
end
area1 = area1.*stepChi;
     
area = 0;      
x = alpha0;
while x < alpha1 & v ~= 0
	%%x=alpha0:stepT:alpha1;
	t = (x - mean) ./ (sqrt(v ./ n));
	y = tpdf(t,deg_fr);        
	area= area+ (y);        
	x =x+ stepT;
end
area =area.*stepT;
       
% area2 = 0;        
% x = epsilon0; %% x=X in matlab
% while x < epsilon1
	% y = normpdf(x);        
	% area2 =area2+ (y);        
	% x =x+stepNormal;
% end
% normal_x=area2;
% area2 =area2.* stepNormal;

total_area_=(area .* area1); %%.* area2;
total_area=total_area_;
%%total_area=area1;
%%%%%%%%%%%%% for plotting %%%%%%%%%%%%%%

% han=figure;
% figure(han);
% errorbar(n1,total_area,v1,'*');
% hold on;
% xlabel('Number of element')
% ylabel('Ranking')
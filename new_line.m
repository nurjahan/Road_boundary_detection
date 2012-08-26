%% I need x1,y1; x2,y2; x,y; m,c
%% don't need x0,y0; xw,yw; xh,yh;

x1=31;
y1=0;
theta1=((180-22)*pi/180);
m=tan(theta1);
c=y1-m*x1;
%%x=0
x0=0;
y0=m*x0+c;
%%x=w
w=293;
xw=w;
yw=m*xw+c;
%%y=0
y2=0;
x2=(y2-c)/m;
%%y=h
h=220;
yh=h;
xh=(yh-c)/m;
a=imread('336.jpg');
imshow(a);
hold on;
plot([xh x0 x2 xw] , [yh y0 y2 yw])
%%plot([x1 x2] , [y1 y2])
% center point
xc=0;yc=0;
y=c/(m^2+1);
x=-(m*c/(m^2+1));
% orthogonal distance upon line from centre point
d=sqrt(x^2+y^2);
if y< (-1.2246e-012)
	d=-d;
end
% angle with x axis to the orthogonal distance
theta2=acos(d/x2);
theta2=theta2*180/pi;


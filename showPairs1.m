function showPairs1(pairElem1)

persepectiveList_add=load('persepectiveList_add.txt');
LineEndPoints=load('LineEndPoints.txt');
endpoints=load('endpoints.txt');

%%rho=meanLineRhoTh(pairElem1,1);
%%theta=meanLineRhoTh(pairElem1,2);

pairElem1Add=find(persepectiveList_add(:,1)==pairElem1);
disp('Total pairs:');
len=length(pairElem1Add);
%%pairElem2=persepectiveList_add(pairElem1Add,2);
disp(len);
pairElem2=persepectiveList_add(pairElem1Add,2);
Elem2_x1=(LineEndPoints( pairElem2,1));
Elem2_x1=Elem2_x1';
Elem2_y1=(LineEndPoints( pairElem2,2));
Elem2_y1=Elem2_y1';
Elem2_x2=(LineEndPoints( pairElem2,3));
Elem2_x2=Elem2_x2';
Elem2_y2=(LineEndPoints( pairElem2,4));
Elem2_y2=Elem2_y2';
% x0=0;
% y0=0;
% xw=293;
% yh=220;

% y_x0=(rho-(cos(theta)*x0))/sin(theta);
% x_y0=(rho-(cos(theta)*y0))/sin(theta);
% y_xw=(rho-(cos(theta)*xw))/sin(theta);
% x_yh=(rho-(cos(theta)*yh))/sin(theta);
% i=1;
% if y_x0>=0 & y_x0<=yh
	% endpoints(i)=x0;
	% endpoints(i+1)=y_x0;
	% i=i+2;
% end

% if x_y0>=0 & x_y0<=xw
	% endpoints(i)=x_y0;
	% endpoints(i+1)=y0;
	% i=i+2;
% end

% if y_xw>=0 & y_xw<=yh
	% endpoints(i)=xw;
	% endpoints(i+1)=y_xw;
	% i=i+2;
% end
	
% if x_yh>=0 & x_yh<=yh
	% endpoints(i)=x_yh;
	% endpoints(i+1)=yh;
	% i=i+2;
% end
		
	
f=figure;
i=imread('1.jpg');
figure(f);
imshow(i);
hold on;

perspetiveLine = unique(persepectiveList_add);
l=length(perspetiveLine);

for i=1:l
    figure(f);
	line([LineEndPoints(perspetiveLine(i),1) LineEndPoints(perspetiveLine(i),3)],[LineEndPoints(perspetiveLine(i),2) LineEndPoints(perspetiveLine(i),4)],'Color','y','LineWidth',2);
end

figure(f);
line([LineEndPoints( pairElem1,1) LineEndPoints( pairElem1,3)],[LineEndPoints( pairElem1,2) LineEndPoints( pairElem1,4)],'Color','b','LineWidth',2);


for i=1:length(pairElem1Add)
	figure(f);
	line([Elem2_x1(i) Elem2_x2(i)],[Elem2_y1(i) Elem2_y2(i)],'Color','r','LineWidth',2);
end
disp(endpoints(pairElem1,1));
disp(endpoints(pairElem1,2));
disp(endpoints(pairElem1,5));
disp(endpoints(pairElem1,6));
figure(f);
line([endpoints(pairElem1,1) endpoints(pairElem1,3)],[endpoints(pairElem1,2) endpoints(pairElem1,4)],'Color','y','LineWidth',2);


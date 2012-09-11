function showPairs(pairElem1)

persepectiveList_add=load('persepectiveList_add.txt');
LineEndPoints=load('LineEndPoints.txt');

pairElem1Add=find(persepectiveList_add(:,1)==pairElem1);
disp('Total pairs:');
len=length(pairElem1Add);
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




function showSingleCluster(clNumber)

line_position1=load('line_position1.txt');
load('nonOvr_mem.mat');
nonOvr_mem1 = cell2mat(nonOvr_mem(clNumber));
x=(line_position1(nonOvr_mem1,1));
y=(line_position1(nonOvr_mem1,2));

HsingleCl=figure;
figure(HsingleCl);
i=imread('340.jpg');
figure(HsingleCl);
imshow(i);
hold on;
plot(x,y,'.');
function show_top_clusters (cluster_confidence,mem,line_position1,im,percentage,HtopCls)
%%global mem;
im2=im;
[hCl wCl]=size(cluster_confidence);

top_ranked=floor(hCl*percentage/100);
[sortedValues,sortIndex] = sort(cluster_confidence(:),'descend');
maxIndex = sortIndex(1:top_ranked);
cls_address=mem(maxIndex);

top_cls_address = cell2mat(cls_address);
%%disp(cls_address);
top_mem_x=(line_position1(top_cls_address,1));
top_mem_y=(line_position1(top_cls_address,2));
%disp('cls');
% disp(top_members_x);
% disp('y:');
% disp(top_members_y);
x=top_mem_x;
y=top_mem_y;
[h w]=size(x);
%disp(top_cls_address );
%im2(y,x,:)=im1(y,x,:);
HOvrCls =figure('position', [50 50 1550 900],...
'resize', 'on', 'toolbar', 'none',...
 'name', 'Overlaping clusters','numbertitle', 'off',...
 'backingstore', 'off', 'doublebuffer', 'on');
nonOverlap_top_clusters(im,line_position1,cls_address,top_ranked,HtopCls,HOvrCls);

% figure(HtopCls);
% imshow(im);
% hold on;
% figure(HtopCls);
% plot(x,y,'*');





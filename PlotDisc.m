function PlotDisc
    thetas=(0:5:360)'*pi/180;
%     r=(0:0.1:1)';
    r = 1;
    [x,y]=pol2cart(thetas,r);
    colMap = GetColMap();
    for i=1:numel(x)-1
        X = [0 x(i) x(i+1) 0];
        Y = [0 y(i) y(i+1) 0];
        col = i / (numel(x)-1) * numel(colMap);
        patch(X,Y,col,'EdgeAlpha',0);
    end
    axis equal
end

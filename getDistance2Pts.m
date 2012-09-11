function [distance]= getDistance2Pts(x1, y1, x2, y2)
        distance= sqrt((y2 - y1)^2+(x2 - x1)^2);
    
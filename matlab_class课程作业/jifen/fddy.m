function [dy]=fy(t,y)
dy=t.^2-y+y.*sin(t);

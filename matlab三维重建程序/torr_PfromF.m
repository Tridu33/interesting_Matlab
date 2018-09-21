%	By Philip Torr 2002
%	copyright Microsoft Corp.

%gets two P matrcies from an F
function [P1,P2] = torr_PfromF(FMat,m3)

t = torr_get_right_epipole(FMat,m3);

T = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];
M = T * FMat;


P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];

P2 =  [M';t']';






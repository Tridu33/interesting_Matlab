%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this function will convert an fundamental matrix to a rotation and translation martix
%then establish a suitable frame eliminating the spurious solutions using constraints
%as set out in Hartley and Zisserman.
%and a suitable self calibration method!

%note E + T_x R
%%%
%F is the fundamental matrix, C is the calibration matrix
% C = 1 0 x_0
%     0 1 y_0
%     0 0 1/f
%where 1/f is the best estimate so far of the focal length

%also returns the structure

function [P1,P2,X] = torr_FtoP(F,C, matches)

focal_lenth = torr_self_calib_f(F,C);

[Tx,R1,R2] = torr_EtoRt(E)

%next correct the matches to make them lie on the optimal epipolar lines


 
%next solve for one of the four possible solutions:
 
 
 Tx
 R1
 R2
 
 
 P1 = ones(3,4);
 P2 = ones(3,4);
 
 
 %next we need to look at a single point to determine if it is front of both cameras;
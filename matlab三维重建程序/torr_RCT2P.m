%	By Philip Torr 2002
%	copyright Microsoft Corp.
function [P1, P2] = torr_RCT2P(C,R,t)


%next establish the four possible camera matrix pairs as points out in Maybank, Hartley & zisserman etc
%first camera is 3x4 at origin of the world system.
P1 = [C'; 0,0,0]' * sign(det(C));

%given this there are four choices for the second, we normalize them so that the
%determinant of the first 3x3 is greater than zero, this is useful for determining chierality later
P2 = C * [ R'; t']' * sign(det(C)) * sign(det(R));
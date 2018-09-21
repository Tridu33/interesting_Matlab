% This function is used by torr_nonlinG and provides the sum of squared error for a 
% particular g by converting to F and measuring Sampson's distance.

function [sseC] = torr_errg_sse(g, nx1,ny1,nx2,ny2, m3, C)
%first convert the 6 parameters of g to a fundamental matrix

 f = torr_g2F(g,C);

 e = torr_errf2(f, nx1,ny1,nx2,ny2, length(nx1), m3);
 sseC = norm(e,1); % sum of squares
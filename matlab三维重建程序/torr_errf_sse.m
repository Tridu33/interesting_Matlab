%for nonlinear methods...


function [sseC] = torr_errf_sse(f, nx1,ny1,nx2,ny2, m3)
%disp('estimating error on f')

e = torr_errf2(f, nx1,ny1,nx2,ny2, length(nx1), m3);
sseC = norm(e,1); % sum of squares
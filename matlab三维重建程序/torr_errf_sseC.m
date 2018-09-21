%	By Philip Torr 2002
%	copyright Microsoft Corp.

%this function is used only by the nonlinear minimizer, it reutrns the sse and constraints of F



function [sseC, g] = torr_errf_sseC(f, nx1,ny1,nx2,ny2, m3)
%disp('estimating error on f')

e = torr_errf2(f, nx1,ny1,nx2,ny2, length(nx1), m3);
sseC = norm(e,1); % sum of squares
g(1) = norm(f) -1.0;
g(2) = f(1) * (f(5) * f(9) - f(6) * f(8)) - f(2) * (f(4) * f(9) - f(6) * f(7)) + f(3) * (f(4) * f(8) - f(5) * f(7));

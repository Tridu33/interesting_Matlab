%	By Philip Torr 2002
%	copyright Microsoft Corp.
% estimate fundamental matrix from perfect points??
% so plan is:----
%disp('estimating error on f')
%f = fmins('sseff',f,[], [],nx1,ny1,nx2,ny2, no_matches, m3);

%global nx1 ny1 nx2 ny2 no_matches m3
function f = nonlinf(f_init, nx1,ny1,nx2,ny2, no_matches, m3)

% stage 1 est F using linear methods
%f_init = estf(nx1,ny1,nx2,ny2, no_matches,m3);

%stage 2 estimate f non-linearly

%options(1) = 0;
%display results
options(13) = 2; 
%number of equality constraints
% option(14) = 300;
% number of iterations
f = constr('torr_errf_sseC', f_init, options, [],[],[], nx1, ny1, nx2, ny2, m3);



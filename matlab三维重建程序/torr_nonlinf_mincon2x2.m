%	By Philip Torr 2002
%	copyright Microsoft Corp.
%minimize, subject  to the upper 2x2 norm is 1 as described in Torr and Firzgibbon

function f = torr_nonlinf_mincon2x2(f_init, nx1,ny1,nx2,ny2, no_matches, m3)

%make sure it is normalized
f_init = f_init / sqrt(f_init(1)^2 + f_init(2)^2 + f_init(4)^2 + f_init(5)^2);
options = optimset('Display','off','Diagnostics','off');

%the function torr_errf_sse takes as input f and all the extra parameters nx1,ny1,nx2,ny2, m3
f = fmincon('torr_errf_sse',f_init,[],[],[],[],[],[],@torr_nonlcon_f2x2,options,nx1,ny1,nx2,ny2, m3);
%f = fmincon('torr_errf_sse',f_init,[],[],[],[],[],[],[],options,nx1,ny1,nx2,ny2, m3)




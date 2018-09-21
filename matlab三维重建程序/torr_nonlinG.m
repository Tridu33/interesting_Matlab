%	By Philip Torr 2002
%	copyright Microsoft Corp.

% 
% %here p is the set of paramets such that
% g(1) = focal length
% g(2-3) sperical coordinates of rotation axis
% g(4) rotation angle
% g(5-6) is the translation vector


function [g,f] = torr_nonlinG(g_init,nx1,ny1,nx2,ny2, no_matches, m3, C)

%options = optimset('Display','iter','Diagnostics','off');
options = optimset('Display','off','Diagnostics','off');
g = fminunc('torr_errg_sse',g_init,options,nx1,ny1,nx2,ny2, m3, C);

%generate F matrix (in vector form)
f = torr_g2F(g,C);

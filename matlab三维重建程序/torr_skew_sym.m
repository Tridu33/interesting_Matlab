%	By Philip Torr 2002
%	copyright Microsoft Corp.
function T = torr_skew_sym(t)

T = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];
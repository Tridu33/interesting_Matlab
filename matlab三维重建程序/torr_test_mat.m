%	By Philip Torr 2002
%	copyright Microsoft Corp.
%a script to display synthetic matches.

%generate synthetic data
[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_t, true_E] = torr_gen_2view_matches;
no_matches = length(nx1);
matches = [nx1,ny1,nx2,ny2];

%displayes matches
torr_display_matches(matches)

%	By Philip Torr 2002
%	copyright Microsoft Corp.
%a script to display the results of the F matrix...

%third homogeneous coordinare
m3 = 256;

%decide display method
compare = 0;

%choose your method here
method = 2
set_rank2 = 0;


%generate synthetic data
[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_t, true_E] = torr_gen_2view_matches;
no_matches = length(nx1);
matches = [nx1,ny1,nx2,ny2];


%first estimate F
[f, e1, n_inliers,inlier_index,estimateF] = torr_estimateF( matches, m3, [], method, set_rank2);

%check errors
e = torr_errf2(f, nx1,ny1,nx2,ny2, no_matches, m3);

%display the result
if compare
    torr_compare_epipoles(true_F,estimateF,matches, m3)
else
    torr_display_epipoles(estimateF,matches, m3)
end



%	By Philip Torr 2002
%	copyright Microsoft Corp.
%torr_test_correct_sc.m

%torr_test_correct_sc.m
m3 = 256;
method = 2;


[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_t, true_E] = torr_gen_2view_matches;

no_matches = length(nx1);

matches = [nx1,ny1,nx2,ny2];
set_rank2 = 0;


%first estimate F
[f, e1, n_inliers,inlier_index,nF] = torr_estimateF( matches, m3, [], method, set_rank2);


%next correct the points so that they lie on a fundamental matrix
[corrected_matches error2] = torr_correctx4F(f, nx1,ny1,nx2,ny2, no_matches, m3);

%check errors (should be near zero)
e = torr_errf2(f, corrected_matches(:,1), corrected_matches(:,2), corrected_matches(:,3), corrected_matches(:,4),no_matches, m3)

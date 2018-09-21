%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this is a script to test the self calibration stuff
%torr_test_SFMsc.m.m
%main()
%profile on
clear all;
m3 = 256;
method = 'mapsac';
method = 'linear';


% %  do we want the same result each time
% randn('state',0)
% rand('state',0)
no_test = 1;
%     [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2] = ...
%         torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
%         rotation_multplier, min_Z,Z_RAN,m3);
[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_TX, true_E, true_X, true_t] = torr_gen_2view_matches;


[true_P1, true_P2] = torr_RCT2P(true_C,true_R, true_t);
torr_display_structure(true_X, true_P1, true_P2,1);

no_matches = length(nx1);

%if we set this to one then the result should be the same as the groundtruth...
no_noise = 0;
if (no_noise)
    nx1 = x1;
    nx2 = x2;
    ny1 = y1;
    ny2 = y2;
end



matches = [nx1,ny1,nx2,ny2];
perfect_matches = [x1,y1,x2,y2];
set_rank2 = 1;


%first estimate F
[f, e1, n_inliers,inlier_index,nF] = torr_estimateF( matches, m3, [], method, set_rank2);

%now guess the camera calibration matrix
CC = diag(ones(3,1),0);
CC(3,3) = 1;

%next self calibrate for focal length
[focal_length, nE,CCC] = torr_self_calib_f(nF,CC);

%next correct the points so that they lie on the fundamental matrix
[corrected_matches error2] = torr_correctx4F(f, nx1,ny1,nx2,ny2, no_matches, m3);

%corrected matches should have zero error:
e2 = torr_errf2(f, corrected_matches(:,1), corrected_matches(:,2), corrected_matches(:,3),corrected_matches(:,4), length(nx1), m3);
 
%now we have an Essential matrix we can establish the camera frame...
[P1,P2,R,t,srot_axis,rot_angle,g]  = torr_linear_EtoPX(nE,corrected_matches,CCC,m3);

%non linear estimation of g (and hence f)
[g,f] = torr_nonlinG(g ,nx1,ny1,nx2,ny2, no_matches, m3, CCC);

%next convert the 6 parameters of g to a fundamental matrix
f2 = torr_g2F(g,CCC);

%next correct the points so that they lie on the fundamental matrix
[corrected_matches error2] = torr_correctx4F(f2, nx1,ny1,nx2,ny2, no_matches, m3);

%next we need to obtain P1 & P2
[P1, P2] = torr_g2FP(g,CCC);

%now use P matrices and corrected matches to get structure:
X = torr_triangulate(corrected_matches, m3, P1, P2);

torr_display_structure(X, P1, P2, 1);

%inlier_index = torr_robust_chieral(X,P1,P2);
%this can be used to remove outliers, see torr_tool


%test
XX = [X(1,:) ./ X(4,:) ; X(2,:)  ./ X(4,:) ; X(3,:)  ./ X(4,:) ];

disp('ratio of estimated and true X');
XX ./true_X



show_result = 0;
if show_result
    disp('look at reprojection error to groundtruth points')
    x1_rp = P1 * X;
    x1_rp(1,:) = x1_rp(1,:) ./ x1_rp(3,:) * m3;
    x1_rp(2,:) = x1_rp(2,:) ./ x1_rp(3,:) * m3;
    (x1 - x1_rp(1,:)')'
    (y1 - x1_rp(2,:)')'
    
    x2_rp = P2 * X;
    x2_rp(1,:) = x2_rp(1,:) ./ x2_rp(3,:) * m3;
    x2_rp(2,:) = x2_rp(2,:) ./ x2_rp(3,:) * m3;
    (x2 - x2_rp(1,:)')'
    (y2 - x2_rp(2,:)')'
end
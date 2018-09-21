%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this is a script to test the self calibration stuff
%torr_test_calib_sc.m
%main()
%profile on
clear all;
m3 = 256;
method = 'mapsac';
method = 'linear';


% % do we want the same result each time
% randn('state',0)
% rand('state',0)
no_test = 1;
for(i = 1:no_test)

%     [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2] = ...
%         torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
%         rotation_multplier, min_Z,Z_RAN,m3);
[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_TX, true_E] = torr_gen_2view_matches;

no_matches = length(nx1);

%if we set this to one then the result should be the same as the groundtruth...
no_noise = 1;
if (no_noise)
    disp('just using noise free points');
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

%now we have an Essential matrix we can establish the camera frame...
[P1,P2,R,t,srot_axis,rot_angle,g]  = torr_linear_EtoPX(nE,matches,CCC,m3);

%next convert the 6 parameters of g to a fundamental matrix
f2 = torr_g2F(g,CCC);
disp('error before non-linear minimization')
e = torr_errf2(f2, nx1,ny1,nx2,ny2, length(nx1), m3);
norm(e)

[g,f] = torr_nonlinG(g ,nx1,ny1,nx2,ny2, no_matches, m3, CCC)


disp('error after')
 e2 = torr_errf2(f, nx1,ny1,nx2,ny2, length(nx1), m3);
norm(e2)


%the question now arises: how good is the fit? compare to groundtruth
true_rot_axis = [true_R(3,2)-true_R(2,3), true_R(1,3) - true_R(3,1), true_R(2,1) - true_R(1,2)]';
true_rot_axis = true_rot_axis /norm(true_rot_axis);
true_rot_angle = acos( (trace(true_R)-1)/2);

true_t(1) = -true_TX(2,3);
true_t(2) = true_TX(1,3);
true_t(3) = -true_TX(1,2);
true_t = true_t/norm(true_t);


disp('true camera parameters')
true_t
true_rot_axis
true_rot_angle
true_C


rot_axis = torr_sphere2unit([g(2) g(3)]);
tt = torr_sphere2unit([g(5) g(6)]);
rot_angle = g(4);

CCC(3,3) = 1/g(1);

disp('estimated camera parameters')
tt
rot_axis
rot_angle
CCC
end

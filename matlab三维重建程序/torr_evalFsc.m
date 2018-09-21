%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this is a script to test the self calibration stuff

%main()
%profile on

m3 = 256;
%user chooses the appropriate nmethod
method = 3;
total_sse = 0;
epipole_distance = 0;
% 
% randn('state',0)
% rand('state',0)
no_tests = 1;
for(i = 1:no_tests)
%     [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2] = ...
%         torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
%         rotation_multplier, min_Z,Z_RAN,m3);
    [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_t, true_E] = torr_gen_2view_matches;
    true_epipole = torr_get_right_epipole(true_F,m3);
    
    no_matches = length(nx1);
    
    matches = [nx1,ny1,nx2,ny2];
    perfect_matches = [x1,y1,x2,y2];
    set_rank2 = 0;
    
    %first estimate F
    [f, e1, n_inliers,inlier_index,nF] = torr_estimateF( matches, m3, [], method, set_rank2);
    
    %check errors vs the true (noise free) points
    groundtrutherrors = torr_errf2(f, x1,y1,x2,y2, no_matches, m3);
    total_sse = total_sse + sum(groundtrutherrors);
    
    
    %calc noisy epipole
    noisy_epipole = torr_get_right_epipole(nF,m3);
    epipole_distance = epipole_distance + sqrt(norm(true_epipole -noisy_epipole));
end

disp(' the average sse vs the noise free points is')
total_sse/no_tests
%profile off

disp('RMS distance between true and estimated right epipole is')
epipole_distance




%torr_display_matches(matches)





%        e = fm_error_hs(F, n1, n2, nowarn);
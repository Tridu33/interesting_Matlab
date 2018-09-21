%this is a script to test the self calibration stuff
%torr_test_calib_sc.m
%main()
%profile on
clear all;
m3 = 256;
method = 'mapsac';
%method = 'linear';


% % do we want the same result each time
% randn('state',0)
% rand('state',0)
no_test = 1;
for(i = 1:no_test)

%     [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2] = ...
%         torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
%         rotation_multplier, min_Z,Z_RAN,m3);
[true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_TX, true_E] = torr_gen_2view_matches;

% m3 = 256
x_a       = [x1,y1,repmat(m3,length(x1),1)];
x_a_prime = [x2,y2,repmat(m3,length(x1),1)];

err_calc_a = [];
for k = 1:length(x1),
    err_calc_a = [err_calc_a; (x_a_prime(k,:)) * true_F * (x_a(k,:)')];
end

%total sum of error
disp('======================================================================');
disp(sprintf('Sum of squared error for true_F:  x_prime*F*x = %d',sum(err_calc_a.^2)));
disp('======================================================================');

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
%disp('First Match');
%matches(1,:)
[f, e1, n_inliers,inlier_index,nF] = torr_estimateF( perfect_matches, m3, [], method, set_rank2);

x_b       = [x1,y1,repmat(m3,length(x1),1)];
x_b_prime = [x2,y2,repmat(m3,length(x1),1)];

err_calc_b = [];
for k = 1:length(x1),
    err_calc_b = [err_calc_b; (x_a_prime(k,:)) * nF * (x_a(k,:)')];
end

%total sum of error
disp('======================================================================');
disp(sprintf('Sum of squared error for mapsac nF: x_prime*nF*x = %d',sum(err_calc_b.^2)));
disp('======================================================================');

end


method = 'linear';
%first estimate F
%disp('First Match');
%matches(1,:)
[f, e1, n_inliers,inlier_index,nF] = torr_estimateF( perfect_matches, m3, [], method, set_rank2);

x_b       = [x1,y1,repmat(m3,length(x1),1)];
x_b_prime = [x2,y2,repmat(m3,length(x1),1)];

err_calc_b = [];
for k = 1:length(x1),
    err_calc_b = [err_calc_b; (x_a_prime(k,:)) * nF * (x_a(k,:)')];
end

%total sum of error
disp('======================================================================');
disp(sprintf('Sum of squared error for linear nF: x_prime*nF*x = %d',sum(err_calc_b.^2)));
disp('======================================================================');

%	By Philip Torr 2002
%	copyright Microsoft Corp.
%main()

%this script compares two methods for estimating F
%select the two methods and place their ID's in the array methods_used
%

%methods_used = [4,3]

%comparing non-linear method with Sampson
%methods_used = [4,2]

%compare sampson and Hegel
methods_used = [4,7];

%compare bundle and Hegel
methods_used = [6,7];

%comparing linear and Hegel
methods_used = [2,7];



m3 = 256;
sse2t = 0;
% 
% randn('state',0)
% rand('state',0)

no_methods = 7;
foc = 256;
best_method_array = zeros(no_methods,1);
method_sse = zeros(no_methods,1);
method_n_sse = zeros(no_methods,1);
epipole_distance = zeros(no_methods,1);
oo_vicar = 0;

no_matches =100;
noise_sigma = 1;
translation_mult = foc * 10;
translation_adder = 20;

%max number of degrees to rotate
rotation_multplier = 40;
min_Z = 1;
Z_RAN = 10;




no_tests =1;


min_noise = 1;
max_noise = 1;
percent_gain = zeros(1,max_noise);
ep_percent_gain = zeros(1,max_noise);

for(noise_sigma = min_noise:max_noise)
    for(i = 1:no_tests)
        
        
        best_sse = 10000000000;
        best_method = 5;
        
        %generate a load of stuffs
        %F
        
        ave_fa_e  = 0.0;
        while ave_fa_e < 0.5          
             [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_TX, true_E, true_X, true_t]  = ...
                torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
                rotation_multplier, min_Z,Z_RAN,m3);
            [FA, fa] = torr_estfa(x1,y1,x2,y2, no_matches,m3);
            fa_e = torr_errfa(fa, x1,y1,x2,y2, no_matches, m3);
            
            %see what average match looks like
            
            ave_fa_e = norm(fa_e,1)/no_matches;
            if no_tests == 1
                ave_fa_e;
            end
            
        end
        %     
        %     if ssse_fa <6.0
        %         disp('ooo vicar');
        %         oo_vicar = oo_vicar + 1;
        %     end
        %         %calc true epipole
        true_epipole = torr_get_right_epipole(true_F,m3);
        
        % for method = 2:6
        
        
        for method = methods_used
            
            set_rank2 = 1;
           [nf, f_sq_errors, n_inliers,inlier_index,nF] ...
               = torr_estimateF( [nx1,ny1,nx2,ny2], m3, [], method,set_rank2);
            
            %calc noisy epipole
            noisy_epipole = torr_get_right_epipole(nF,m3);
            epipole_distance(method) = epipole_distance(method) + sqrt(norm(true_epipole -noisy_epipole));
            
            
                pe = torr_errf2(nf,x1,y1,x2,y2, no_matches, m3);
                n_e = torr_errf2(nf,nx1,ny1,nx2,ny2, no_matches, m3);
  
                sse_n = norm(pe);
            
            if (sse_n < best_sse)
                best_method = method;
                best_sse = sse_n;
            end
            
            method_sse(method) =  method_sse(method) + sse_n;
            method_n_sse(method) =  method_sse(method) + norm(n_e);
            
        end %method = 1:4
        best_method_array(best_method) = best_method_array(best_method)+1;
    end
    
    
    
    best_method_array(methods_used)';
    (method_sse(methods_used)/(no_tests*length(x1)))';
    (method_n_sse(methods_used)/(no_tests*length(x1)))';
    
    percent_gain(noise_sigma) = method_sse(methods_used(1))/method_sse(methods_used(2));
    
    
    
    
    %disp('distance to true epipole');
    (epipole_distance(methods_used)/no_tests)';
    
    ep_percent_gain(noise_sigma) = epipole_distance(methods_used(1))/epipole_distance(methods_used(2));
    
    %oo_vicar
    %display_mat(perfect_matches, x1,y1, u1, v1)
    % 
    
    %        e = fm_error_hs(F, n1, n2, nowarn);
    
    
    %torr_display_epipoles(nF,nF,perfect_matches, x1,y1, u1, v1)
end

disp('ratio of first to second method average error on noise free points');
100 * percent_gain

disp('ratio of first to second method average epipole error');
100 * ep_percent_gain

disp('number of times gets lowest errors')
best_method_array

disp('average error for each method')
method_sse
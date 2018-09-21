%	By Philip Torr 2002
%	copyright Microsoft Corp.
%main()

m3 = 256;
sse2t = 0;
% 
% randn('state',0)
% rand('state',0)

no_methods = 6;
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




no_tests = 20;
%methods_used = [4,3]

%comparing non-linear method with Sampson
methods_used = [4,2]

min_noise = 1;
max_noise = 20;
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
            
            [true_F,x1,y1,x2,y2,u1,v1,nx1,ny1,nx2,ny2] = ...
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
            
            X1 = [x1,y1, ones(length(x1),1) * m3];
            X2 = [x2,y2, ones(length(x2),1) * m3];
            
            
            %error on perfect data (should be zero)
            %f = estf(nx1,ny1,nx2,ny2, no_matches,m3);
            %f = estf(x1,y1,x2,y2, no_matches,m3);
            %         
            %         [F , f]= fm_linear(X1, X2, eye(3), method);
            %         e = torr_errf2(f,x1,y1,x2,y2, no_matches, m3);
            %         disp('noise free error (sanity check)')
            %         ssep = e' * e
            %         
            % %error on noisy data
            % f = fm_linear(nx1,ny1,nx2,ny2, no_matches,m3);
            % e = torr_errf2(f,nx1,ny1,nx2,ny2, no_matches, m3);
            % ssen = e * e'
            
            nX1 = [nx1,ny1, ones(length(x1),1) * m3];
            nX2 = [nx2,ny2, ones(length(x2),1) * m3];
            
            %        [nF , nf]= fm_linear(nX1, nX2, eye(3), method);
            set_rank2 = 1;
            [nf, nF ] = torr_estimateF(nx1,ny1,nx2,ny2, no_matches, m3, method,set_rank2);
            
            %calc noisy epipole
            noisy_epipole = torr_get_right_epipole(nF,m3);
            epipole_distance(method) = epipole_distance(method) + sqrt(norm(true_epipole -noisy_epipole));
            
            
            torr_error = 1;
            if torr_error
                pe = torr_errf2(nf,x1,y1,x2,y2, no_matches, m3);
                n_e = torr_errf2(nf,nx1,ny1,nx2,ny2, no_matches, m3);
            else
                CC = eye(3);
                CC(3,3) = m3;
                nF2 = CC * nF * CC;
                
                n1  = [x1 y1];
                n2= [x2 y2];
                nowarn = 0;
                
                ne = fm_error_hs(nF, n1, n2, nowarn);
            end
            %       ne = torr_errf2(nf,nx1,ny1,nx2,ny2, no_matches, m3);
            
            %       disp('trimmed noisy error on noise free points')
            %        sse_n = ne' * ne
            
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
    
    
    % %mine
    % f_torr = estf(nx1,ny1,nx2,ny2, no_matches,m3);
    % ne = torr_errf2(f_torr,x1,y1,x2,y2, no_matches, m3);
    % disp('noisy error on noise free points')
    % sse_n = norm(ne(20:no_matches-20))
    
    %disp('trace = 1, trace =0, ls, det = 1, 2x2 = 1, 2x2 =1')
    
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

disp('ratio of error');
100 * percent_gain

disp('ratio of epipole error');
100 * ep_percent_gain
%	By Philip Torr 2002
%	copyright Microsoft Corp.

%this is a set of functions for minimizing F

function [f, f_sq_errors, n_inliers,inlier_index,F] = torr_estimateF( matches, m3, f_optim_parameters, method, set_rank2, f_init)

no_matches = length(matches);
x1 = matches(:,1);
y1 = matches(:,2);
x2 = matches(:,3);
y2 = matches(:,4);


if nargin <5
    set_rank2 = 0;
end

switch lower(method)
        %as in ransac and torr mlesac/mapsac papers
case {'mlesac',0}
    no_samp = f_optim_parameters(1);
    T = f_optim_parameters(2);
    f = torr_mlesac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T);
    %function f = mlesac_F(x1,y1,x2,y2, n_matches, m3, no_samp, f_threshold)
    %as in ransac and torr mlesac/mapsac papers
    
    
case {'mapsac',1}
    if isempty(f_optim_parameters)
        no_samp =1000;
        T = 4;
    else
        no_samp = f_optim_parameters(1);
        T = f_optim_parameters(2);
    end        
    [f,f_sq_errors, n_inliers,inlier_index] = torr_mapsac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T);
    
    
case {'linear',2}
    f = torr_estf(x1,y1,x2,y2, no_matches,m3);
    
    %as in Torr & Fitzgibbon paper
case {'bookstein',3}
    f = torr_estf_bookstein(x1,y1,x2,y2, no_matches,m3);
    
 
    
case {'b+sampson','boosam',4}
    f = torr_estf_bookstein_sampson(x1,y1,x2,y2, no_matches,m3);
    
case {'non_linear',5}
    f = torr_nonlinf_mincon2x2(f_init, x1,y1,x2,y2, no_matches, m3);
    
case {'lin+non_lin',6}
    set_rank2 = 1;
    f = torr_estimateF(matches, m3, [], 'linear',set_rank2);
    f = torr_estimateF(matches, m3, [], 'non_linear',set_rank2,f);
    
case {'hegel1',7}
   f = torr_estimateF(matches, m3, [], 'linear');
   f = ant_fnsf(x1,y1,x2,y2,m3,f);
    
otherwise
    disp('Unknown method.')
end



F = reshape(f, 3, 3);
%make it my way round
F = F';



%the F matrix is defined like:
   % (nx2, ny2, m3) f(1 2 3) nx1 
   %                 (4 5 6) ny1  
   %                 (7 8 9) m3

% disp('before rank 2')
% F
if set_rank2
    [U,S,V] = svd(F);
    S(3,3) = 0;
    F = U*S*V';
    f = reshape(F',9,1);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('after rank 2')
% F

% % Unit fro-norm F:
% fn = norm(F(:));
% fn = 2^(-floor(log(fn) / log(2)));
% F = F * fn;

F = F/norm(F,'fro');
f = f/norm(f);

switch lower(method)
case {'bookstein',3,'linear',2,'bookstein',3,'b+sampson','boosam',4,'non_linear',5,'lin+non_lin',6, ...
        'hegel1',7}
    %f = reshape(F',9,1);   %calculate squared errors (distance to manifold of F)
    f_sq_errors = torr_errf2(f,x1,y1,x2,y2, no_matches, m3);
    %next generate index set of inliers
    T = 10; 
    inlier_index = find((f_sq_errors < T) == 1);
    n_inliers = length(inlier_index);
    

end


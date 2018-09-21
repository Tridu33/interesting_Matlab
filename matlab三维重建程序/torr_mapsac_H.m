%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr 
% copyright Philip Torr and Microsoft Corp 2002
% linear estimation of H
% 
% @article{Torr99c,
%         author = "Torr, P. H. S.   and Zisserman, A",
%         title ="MLESAC: A New Robust Estimator with Application to Estimating Image Geometry ",
%         journal = "CVIU",
%         Volume = {78},
%         number = 1,
%         pages = {138-156},
%         year = 2000}
% 
% %MAPSAC is the Bayesian version of MLESAC, and it is easier to pronounce!
% it is described in:
% 
% @article{Torr02d,
%         author = "Torr, P. H. S.",
%         title ="Bayesian Model Estimation and  Selection for Epipolar Geometry and
% Generic Manifold Fitting",
%         journal = "IJCV",
%         Volume = {?},
%         number = ?,
%         pages = {?},
%         url = "http://research.microsoft.com/~philtorr/",
%         year = 2002}
% 

function [h,h_sq_errors, n_inliers,inlier_index]  = torr_mapsac_H(x1,y1,x2,y2, no_matches,m3, no_samp, T)

%disp('mapsac-ing H')
%bestsse = T * no_matches + 1;

%%%%%%%%%%debug
%used for debugging:
no_trials = 1;
max_inliers = 0;
%%%%%%%%%%end debug



for(i = 1:no_samp)
   
    choice = randperm(no_matches);
    
    %set up local design matrix
    for (j = 1:4)
        tx1(j) = x1( choice(j));   
        tx2(j) = x2( choice(j));   
        ty1(j) = y1( choice(j));   
        ty2(j) = y2( choice(j));   
        
    end
    
     %generate trial h 
    ht = torr_esth(tx1,ty1,tx2,ty2,4,m3);
    
    %get squared errors
    et = torr_errh(ht,x1,y1,x2,y2, no_matches, m3);
    
    %capped residuals
    cet = min(et,T);
    sse = cet' * cet; 
   
    
    if i ==1 
        h = ht;
      bestsse = sse;
   elseif bestsse > sse
      h = ht;
      bestsse = sse;
   end
   
       %monitor progress %debug
    inlier_index = find((et < T) == 1);
    mapsac_inliers(no_trials) = length(inlier_index);
    if mapsac_inliers(no_trials) > max_inliers
        max_inliers = mapsac_inliers(no_trials);
    else
        mapsac_inliers(no_trials) = max_inliers;
    end
    no_trials = no_trials + 1;
    %%%%%%%%end debug
    
    
end
%calculate squared errors (distance to manifold of F)
h_sq_errors = torr_errh(h,x1,y1,x2,y2, no_matches, m3);
%next generate index set of inliers
inlier_index = find((h_sq_errors < T) == 1);
n_inliers = length(inlier_index);





%%%%%%%%%%debug
%for NAPSAC paper
no_matches
n_inliers
no_trials

mapsac_inliers(1:30)
%find out how many it took to get to n_inliers
perc = n_inliers;
map_index = find((mapsac_inliers < perc) == 1);
perc100 = length(map_index)+1
%find out how many it took to get to n_inliers

perc = n_inliers * 0.9;
map_index = find((mapsac_inliers < perc) == 1);
perc90 = length(map_index)+1

perc = n_inliers * 0.8;
map_index = find((mapsac_inliers < perc) == 1);
perc80 = length(map_index)+1



perc = n_inliers * 0.7;
map_index = find((mapsac_inliers < perc) == 1);
perc70 = length(map_index)+1



perc = n_inliers * 0.6;
map_index = find((mapsac_inliers < perc) == 1);
perc60 = length(map_index)+1

n_inliers

disp('Mapsac');

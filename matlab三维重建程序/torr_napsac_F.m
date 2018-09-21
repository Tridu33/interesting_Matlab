%	By Philip Torr 2002
%	copyright Microsoft Corp.
%MAPSAC is the Bayesian version of MLESAC, and it is easier to pronounce!
% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 
% [f,f_sq_errors, n_inliers,inlier_matches] = torr_mapsac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T)
% f is fundamentalmatrix in 9 vector
% f_sq_errors are non robust errors on each match
% n_inliers is the no of inliers
% inlier_index is a vector with index no  of each inlier
% 
% x1,y1,x2,y2 are column vectors of the data no_matches by 4
% m3 is the 3rd homogeneous coordinate (256)
% no_samp is the number of samples to be taken (set to 0 if jump out required, at the moment jump out not implemented
% T is the threshold on the residuals, derived from MLESAC?MAPSAC paper
% 
% at the moment it is assumed all is normalized so that Gaussian noise has sigma 1

% /*
% 
% @inproceedings{Torr93b,
%         author = "Torr, P. H. S.  and Murray, D. W.",
%         title  = "Outlier Detection and Motion Segmentation",
%         booktitle = "Sensor Fusion VI",
%         editor = "Schenker, P. S.",
%         publisher = "SPIE volume 2059",
%         note = "Boston",
% 	pages = {432-443},
%         year = 1993 }
% 
%     
% @phdthesis{Torr:thesis,
%         author="Torr, P. H. S.",
%         title="Outlier Detection and Motion Segmentation",
%         school=" Dept. of  Engineering Science, University of Oxford",
%         year=1995}
% 
% 
% 
% @article{Torr97c,
%         author="Torr, P. H. S.  and Murray, D. W. ",
%         title="The Development and Comparison of Robust Methods for Estimating the Fundamental Matrix",
%         journal="IJCV",
%         volume = 24,
%         number = 3,
%         pages = {271--300},
%         year=1997
% }
% 
% 
% 
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

%threshold is the maximum squared  value of the residuals
%no_matches is the number of matches
%no_samp is the number of random samples to be taken
%m3 is the estimate of the 3rf projective coordinate (f in pixels)

%the F matrix is defined like:
% (nx2, ny2, m3) f(1 2 3) nx1 
%                 (4 5 6) ny1  
%                 (7 8 9) m3



%we minimize a robust function min(e^2,T) see mapsac paper.


function [f,f_sq_errors, n_inliers,inlier_index] = torr_napsac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')
%f = rand(9);


%%%%%%%%%%debug
%used for debugging:
no_trials = 1;
max_inliers = 0;
%%%%%%%%%%end debug

for(i = 1:no_samp)
    
    %NAPSAC frenzyoid! first pick one point then take 6 nearest, described in thesis/china paper
    choice = randperm(no_matches);    
    %set up local design matrix, here we estimate from 7 matches
    distance_xyxy = (x1 - x1(choice(1))).^2 + (x2 - x2(choice(1))).^2 + (y1 - y1(choice(1))).^2 + (y2 - y2(choice(1))).^2;
    [sorted_distance_xyxy, index_distance_xyxy] = sort(distance_xyxy);
    
    
    %next randomly permute the best 50 matches
    choice2 = randperm(60);
    
       for (j = 1:7)
        tx1(j) = x1( index_distance_xyxy(choice2(j)));   
        tx2(j) = x2( index_distance_xyxy(choice2(j)));   
        ty1(j) = y1( index_distance_xyxy(choice2(j)));   
        ty2(j) = y2( index_distance_xyxy(choice2(j)));    
    end %    for (j = 1:7)
    
%         tx1 = x1( index_distance_xyxy(1:7));   
%         tx2 = x2( index_distance_xyxy(1:7));   
%         ty1 = y1( index_distance_xyxy(1:7));   
%         ty2 = y2( index_distance_xyxy(1:7));    
    
    %produces 1 or 3 solutions.
    [no_F big_result]= torr_F_constrained_fit(tx1,ty1,tx2,ty2,m3);
    
    for j = 1:no_F
        ft = big_result(j,:);
        
        %get squared errors
        et = torr_errf2(ft,x1,y1,x2,y2, no_matches, m3);
        
        

        
        %capped residuals
        cet = min(et,T);
        sse = cet' * cet;
        % use sse 0 to bring it to a reasonable value
        if ((i ==1) & (j ==1))
            f = ft;
            bestsse = sse;
        elseif bestsse > sse
            f = ft;
            bestsse = sse;
            bestcet = cet; %store best set of residuals
        end %if
        
        
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
    
    
    
end %for(i = 1:no_samp)


%calculate squared errors (distance to manifold of F)
f_sq_errors = torr_errf2(f,x1,y1,x2,y2, no_matches, m3);
%next generate index set of inliers
inlier_index = find((f_sq_errors < T) == 1);
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

disp('Napsac');
% 
% figure
% hold on
% for i = 1:no_trials-1
%     plot(i, mapsac_inliers(i),'rs');
% end
% hold off
%     %%%%%%%%%%%%end debug
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
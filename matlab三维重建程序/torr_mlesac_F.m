%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 


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

%threshold is the maximum squared  value of the residuals
%no_matches is the number of matches
%no_samp is the number of random samples to be taken
%m3 is the estimate of the 3rf projective coordinate (f in pixels)

%the F matrix is defined like:
   % (nx2, ny2, m3) f(1 2 3) nx1 
   %                 (4 5 6) ny1  
   %                 (7 8 9) m3


   
%we minimize a robust function min(e^2,T) see MLESAC paper.
   
   
function f = torr_mlesac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')
%f = rand(9);


for(i = 1:no_samp)
    choice = randperm(no_matches);    
    %set up local design matrix, here we estimate from 7 matches
    for (j = 1:7)
        tx1(j) = x1( choice(j));   
        tx2(j) = x2( choice(j));   
        ty1(j) = y1( choice(j));   
        ty2(j) = y2( choice(j));    
    end %    for (j = 1:7)
    
    
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
        end
        
    end
     
end %for(i = 1:no_samp)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


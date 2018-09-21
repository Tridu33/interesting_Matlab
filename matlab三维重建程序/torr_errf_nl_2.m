%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 
%returns the first order approx to the reprojection error  as defined in:
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
% %         number = 3,
% %         pages = {271--300},
% %         year=1997
% 
% %the F matrix is defined like:
%    % (nx2, ny2, m3) f(1 2 3) nx1 
%    %                 (4 5 6) ny1  
%    %                 (7 8 9) m3
% 
% %returns the square of the error
% 
% %this one does a non linear estimate of the exact point location!   
% 
% 
% function [e, cx1,cy1,cx2,cy2] = torr_errf_nl_2(f, nx1,ny1,nx2,ny2, no_matches, m3)
% %disp('estimating squared errors on f')
% f = f /norm(f);
% 
% for (i = 1:no_matches)
%     [cx1(i,1),cy1(i,1),cx2(i,1),cy2(i,1), e(i,1)] =    torr_correct_point(f, nx1(i),ny1(i),nx2(i),ny2(i),  m3);
% end
% 
% 
% function [cx1,cy1,cx2,cy2, sq_err] = torr_correct_point(f, nx1,ny1,nx2,ny2,  m3)
% 
% 
% options = optimset('Display','off');
% init_point = [nx1,ny1,ny2];
% 
% [est_point, sq_err] = fminsearch('torr_f_reprojection_error', init_point, options, nx1,ny1,nx2,ny2,f, m3);
% 
% cx1 = est_point(1);
% cy1 = est_point(2);
%    cy2 = est_point(3);
%    cx2 =  -(f(4) * cx1* cy2 +   f(5) * cy1* cy2+   f(6) * m3* cy2 + f(7) * cx1* m3+   f(8) * cy1* m3+   f(9) * m3* m3);
%    cx2 = cx2 / (  f(1) * cx1 +   f(2)* cy1  + f(3) * m3 );
%    
%   
%    
%    
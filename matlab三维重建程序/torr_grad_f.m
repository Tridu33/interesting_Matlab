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
%         number = 3,
%         pages = {271--300},
%         year=1997

%the F matrix is defined like:
   % (nx2, ny2, m3) f(1 2 3) nx1 
   %                 (4 5 6) ny1  
   %                 (7 8 9) m3

%returns the square of the error
function g = torr_grad_f(f, nx1,ny1,nx2,ny2, no_matches, m3)
%disp('estimating squared errors on f')
   
   fdx1 =  f(1) .* nx2(:) + f(4) .* ny2(:) +   f(7) .* m3;
   fdx2 =  f(1) .* nx1(:) + f(2).* ny1(:) + f(3) .* m3;
   fdy1 =  f(2).* nx2(:) + f(5) .* ny2(:)+ f(8) .* m3;
   fdy2 = f(4) .* nx1(:) + f(5) .* ny1(:)+ f(6) .* m3;
   
   g = (fdx1 .* fdx1 +fdx2 .* fdx2 +fdy1 .* fdy1 +fdy2 .* fdy2);
   
% for non squared error
%   g = sqrt(fdx1 .* fdx1 +fdx2 .* fdx2 +fdy1 .* fdy1 +fdy2 .* fdy2);
%   g = sqrt(g);
   
   

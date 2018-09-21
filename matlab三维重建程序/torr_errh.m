%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr 
% copyright Philip Torr and Microsoft Corp 2002
% linear estimation of H


%this uses a costly but accurrate 1st order approximation to the optimal reprojection error
%as described in 
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

function e = torr_errh(h, x1,y1,x2,y2, no_matches,m3)
%disp('estimating error on h')
%this is transfer error from nx1 y1 to nx2 y2


   A(:,1) = x1(:) .*m3;
   A(:,2) = y1(:) .*m3;
   A(:,3) = m3 *m3;
   
   A(:,4) = 0;
   A(:,5) = 0;
   A(:,6) = 0;
   
   A(:,7) = x1(:) .* x2(:);
   A(:,8) = y1(:) .* x2(:);
   A(:,9) = m3    .* x2(:);
   

   
   B(:,4) = x1(:) .*m3;
   B(:,5) = y1(:) .*m3;
   B(:,6) = m3 *m3;
   
      B(:,1) = 0;
   B(:,2) = 0;
   B(:,3) = 0;
   
   B(:,7) = x1(:) .* y2(:);
   B(:,8) = y1(:) .* y2(:);
   B(:,9) = m3    .* y2(:);
   
   
   r1 = A * h;
   r2 = B * h;
   
   
   %dx
   dA1 =    h(1)* m3 + h(7) * x2(:);
   %dy
   dA2 =      h(2) * m3  + h(8) * x2(:);
   %dx2
   dA3  =    h(7) * x1(:) +   h(8) * y1(:) +   h(9) * m3;
   %dy2
   dA4 = 0;
   
   
   %x1
   dB1 =  h(4)*m3 + h(7)*y2(:);
   %y1
   dB2 =  h(5)*m3 + h(8)*y2(:);
   %x2
   dB3 =  0.0;
   %y2
   dB4 = h(7)*x1(:)+h(8)*y1(:)+h(9) * m3;
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%should compare this to one below %%%%%%%%%%
   magG1 = sqrt(dA1.^2 + dA2.^2 + dA3.^2 + dA4.^2);
   magG2 = sqrt(dB1.^2 + dB2.^2 + dB3.^2 + dB4.^2);
   magG1G2 = dA1 .* dB1 + dA2 .* dB2 + dA3 .* dB3 + dA4 .* dB4;
   
   angle = acos(magG1G2 ./ (magG1 .* magG2));

%    r1
%    magG1
   D1 = r1 ./ magG1;
   D2 = r2 ./ magG2;
   
   sina = sin(angle);
   %remove divide by zero
   sina(find(sina == 0)) = 0.00000001;
   
   r = (D1 .* D1 + D2 .* D2 - 2 *  D1 .* D2 .* cos (angle)) ./ sina;
   e = r;
   % this is squared residual?
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%should compare this to one below %%%%%%%%%%
   
   
%   C = [dA; dB];
%   G = C * C';
%   H = G^-1;	%Inverse Hessian to get covariance matrix
%   rv = [ r1 r2];
%   r = rv * H * rv';
%   e(i) = sqrt(r);

   
   %e(i) = sqrt((tx2(i) - x2(i))^2 + (ty2(i) - y2(i))^2);
%sse = norm(e);
%disp('finished estimating error on f')







%	By Philip Torr 2002
%	copyright Microsoft Corp.

%this function corrects all the points in an optimal (first order) manner so that they lie on the manifold
%getting the signs right is a bit tricky but basically the 1st order correction is 
% x = x - (grad r) * (r / ( norm(grad r)^2 )

function [corrected_matches,e] = torr_correctx4F(f, nx1,ny1,nx2,ny2, no_matches, m3)


%disp('estimating squared errors on f')
f = f /norm(f);

   r =    f(1) .* nx1(:).* nx2(:) +   f(2).* ny1(:).* nx2(:) + f(3) .* m3.* nx2(:);
   r = r +   f(4) .* nx1(:).* ny2(:) +   f(5) .* ny1(:).* ny2(:)+   f(6) .* m3.* ny2(:);
   r = r +   f(7) .* nx1(:).* m3+   f(8) .* ny1(:).* m3+   f(9) .* m3.* m3;
   r2 = r.^2;
   
   fdx1 =  f(1) .* nx2(:) + f(4) .* ny2(:) +   f(7) .* m3;
   fdx2 =  f(1) .* nx1(:) + f(2).* ny1(:) + f(3) .* m3;
   fdy1 =  f(2).* nx2(:) + f(5) .* ny2(:)+ f(8) .* m3;
   fdy2 = f(4) .* nx1(:) + f(5) .* ny1(:)+ f(6) .* m3;
   
   g = (fdx1 .* fdx1 +fdx2 .* fdx2 +fdy1 .* fdy1 +fdy2 .* fdy2);
   

   
   e = r2./g;
   
   g = sqrt(g);
   e = -r./g;
%    
   corrected_matches(:,1) = nx1(:) + e(:) .* (fdx1(:) ./ g(:));
   corrected_matches(:,2) = ny1(:) + e(:) .* (fdy1(:) ./ g(:));
   corrected_matches(:,3) = nx2(:) + e(:) .* (fdx2(:) ./ g(:));
   corrected_matches(:,4) = ny2(:) + e(:) .* (fdy2(:) ./ g(:));
%    
%    corrected_matches(:,1) = nx1(:) + e(:) .* fdx1(:);
%    corrected_matches(:,2) = ny1(:) + e(:) .* fdy1(:);
%    corrected_matches(:,3) = nx2(:) + e(:) .* fdx2(:);
%    corrected_matches(:,4) = ny2(:) + e(:) .* fdy2(:);
   
   e = e.^2;
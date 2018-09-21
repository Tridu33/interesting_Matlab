% 
% %designed for the good of the world by Philip Torr 
% copyright Philip Torr and Microsoft Corp 2002
% linear estimation of H

function h = torr_esth(x1,y1,x2,y2,no_matches,m3)
% estimate homography

   A(:,1) = x1(:) *m3;
   A(:,2) = y1(:) *m3;
   A(:,3) = m3 *m3;
   
   A(:,4) = 0;
   A(:,5) = 0;
   A(:,6) = 0;
   
   A(:,7) = x1(:) .* x2(:);
   A(:,8) = y1(:) .* x2(:);
   A(:,9) = m3    * x2(:);

   
   B(:,4) = x1(:) *m3;
   B(:,5) = y1(:) *m3;
   B(:,6) = m3 *m3;
   
   B(:,7) = x1(:) .* y2(:);
   B(:,8) = y1(:) .* y2(:);
   B(:,9) = m3    * y2(:);
   
   
   B(:,1) = 0;
   B(:,2) = 0;
   B(:,3) = 0;


C = [A; B];

% we want to call least squares for C

h = torr_ls(C);

%C * v

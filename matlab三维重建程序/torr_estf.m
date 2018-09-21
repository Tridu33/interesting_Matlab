%	By Philip Torr 2002
%	copyright Microsoft Corp.
% estimate fundamental matrix from perfect points??

function f = torr_estf(x1,y1,x2,y2, no_matches,m3)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')

%for(i = 1:no_matches)
   
   A(:,1) = x1(:).* x2(:);
   A(:,2) = y1(:).* x2(:);
   A(:,3) = m3* x2(:);
   
   A(:,4) = x1(:).* y2(:);
   A(:,5) = y1(:).* y2(:);
   A(:,6) = m3* y2(:);
   
   A(:,7) = x1(:).* m3;
   A(:,8) = y1(:).* m3;
   A(:,9) = m3* m3;
   
   
%end


% (x2 y2 m3) F (x1 y1 m3)'
%  (image 2) F ( image 1)'


%est_F = [v(1) v(2) v(3); v(4) v(5) v(6); v(7) v(8) v(9)];

f = torr_ls(A);

%algebraic residuals
%r = A * v;


%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')

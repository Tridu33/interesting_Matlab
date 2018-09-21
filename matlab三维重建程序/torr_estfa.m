%	By Philip Torr 2002
%	copyright Microsoft Corp.
% estimate fundamental matrix from perfect points??

function [ FA, fa] = torr_estfa(x1,y1,x2,y2, no_matches,m3)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')

for(i = 1:no_matches)
   
   A(i,1) = x1(i);
   A(i,2) = y1(i);
   A(i,3) = x2(i);
   A(i,4) = y2(i);
   
end

% centre data
centroid = mean(A);
B = A - ones(no_matches,1) * centroid;

%est_F = [v(1) v(2) v(3); v(4) v(5) v(6); v(7) v(8) v(9)]
% need to check all this for whether it is right
v = torr_ls(B);
constant = - ( centroid * v)/m3;
fa = [v' constant] ;
%need to add constant term


FA = [ 0 ,0, fa(3); 0, 0, fa(4); fa(1), fa(2), fa(5)];
%algebraic residuals
%r = A * v;


%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')

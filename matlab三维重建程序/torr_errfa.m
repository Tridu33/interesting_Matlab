
function e = torr_errfa(fa, x1,y1,x2,y2, no_matches, m3)
%disp('estimating error on f')

normfa = fa(1) * fa(1) + fa(2) * fa(2) + fa(3) * fa(3) + fa(4) * fa(4);
normfa = sqrt(normfa);

   e =fa(1) .* x1(:) + fa(2).*y1(:) + fa(3).*x2(:) +fa(4) .* y2(:) + fa(5) .* m3; 
   e = e ./ normfa;


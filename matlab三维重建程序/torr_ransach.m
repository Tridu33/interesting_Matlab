%	By Philip Torr 2002
%	copyright Microsoft Corp.
function [f,f_sq_errors, n_inliers,inlier_index] = torr_mapsac_F(x1,y1,x2,y2, no_matches, m3, no_samp, T)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')
%f = rand(9);% estimate fundamental matrix from perfect points??

function f = torr_mapsach(x1,y1,x2,y2, no_matches,m3, no_samp, T)
%disp('This just does calculation of perfect data,for test')
%disp('Use estf otherwise')
f = rand(9);
no_samp = 200;
ptot = 0.0;

   et = errh(f,x1,y1,x2,y2, no_matches, m3);
   bestsse = norm(et) * norm(et);

for(i = 1:no_samp)
   
   choice = randperm(no_matches);
   
   %set up local design matrix
   for (j = 1:4)
      tx1(j) = x1( choice(j));   
      tx2(j) = x2( choice(j));   
      ty1(j) = y1( choice(j));   
      ty2(j) = y2( choice(j));   
      
   end
   
   ft = esth(tx1,ty1,tx2,ty2,4,m3);
   et = errh(ft,x1,y1,x2,y2, no_matches, m3);
   sse(i) = norm(et) * norm(et);
   % use sse 0 to bring it to a reasonable value
   
   if i ==0
      f = ft;
      bestsse = sse(i);
   elseif bestsse > sse(i)
      f = ft;
      bestsse = sse(i);
   end
   
   
   
   p(i) = exp( -sse(i));
   ptot = ptot + p(i);
   
end


%bayes factor
bf = 0.0;
logptot = log(ptot);
for(i = 1:no_samp)
   sse2(i) = - sse(i) - logptot;
   %integrate p(D|R)p(R)
   p(i) =p(i)*  exp( sse2(i) );
   bf = bf + p(i);
end

%ptot
bf
logbf = log(bf)
%log(p)
%maybe do  a better fit after
